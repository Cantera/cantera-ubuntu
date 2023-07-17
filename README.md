# Cantera Ubuntu Packages

This repository contains a Docker-based system for preparing and testing builds of
Cantera packages for the Ubuntu PPA.

## Prerequisites

- Check out a copy of the `cantera` repository that includes the Debian packaging info
  in `~/src/cantera`
- Make sure you have created a GPG key and registered it with
  [Launchpad](https://launchpad.net/), that you have membership in the `cantera-team`,
  that the key is not expired, and that it is stored in `~/.gnupg`.
  - Check for key expiration by running `gpg --list-keys`
  - If you have an expired key, the exiration date can be updated by running
    `gpg --quick-set-expire KEYID PERIOD`, where `PERIOD` can be something like `2y`.
  - Launchpad requires that your key is registered with `keyserver.ubuntu.com`. If you
    have not previously registered the key, or you have updated its expiration date,
    you will need to send it using the command:
    `gpg --keyserver keyserver.ubuntu.com --send-keys <yourkeyID>`
  - Then go through the process of updating the key on Launchpad.
- Check out a copy of this repository in `~/src/cantera-ubuntu`
- Install Docker in "rootless" mode, or otherwise set it up so your user can run the
  `docker build` command

## Preparing branches to build Ubuntu packages

### General ideas

- Keep a branch for each Ubuntu series and Cantera version that we currently support,
  e.g. `ubuntu20.04-ct2.6`. This branch contains the contents of the `debian`
  subdirectory, where all of the package-specific files live.
- For each new Ubuntu series, create new branches from the preceding series.
- For each new Cantera release, create new branches from the tagged commits for the
  last release that was along the `main` branch, i.e. not on a maintenance branch like
  `2.4`.
- Tag the commits for the versions that get uploaded to Launchpad and actually work
  (knowing that there will be failures)
- Delete the old branches when we stop publishing packages for a particular series or
  Cantera version - we'll still have the tagged commits to track the history.

### Steps for a new Cantera release branch

*Using Cantera 2.6.0 release as an example*

- Create the "pristine" tar file corresponding to the release
  - From the `cantera` repo, run:
    `git archive v2.6.0 --output=../cantera-ubuntu/cantera_2.6.0.orig.tar.gz --prefix=cantera-2.6.0/`
  - Note the trailing slash on the `prefix`
  - For pre-release versions, format the version as `2.6.0~b2`
  - Once this file has been uploaded to Launchpad for a particular version, that *exact*
    file must be used for all subsequent uploads (for example, for builds targeting
    different Ubuntu releases). If you lose this file, download it again from a
    different Launchpad build rather than trying to recreate it.
- Check out the branch for the most recent Ubuntu release supported by the previous
  Cantera release, e.g. `git checkout ubuntu20.04-ct2.6`
- Create a new branch for the new Cantera version, e.g.
  `git checkout -b ubuntu20.04-ct2.6`.
- Merge the release commit, e.g. `git merge v2.6.0`
- Add a new entry to `debian/changelog`
  - `dch -i` can be used to automatically generate a template for the Changelog message
  - replace `UNRELEASED` with the correct Ubuntu series name (e.g. `bionic`)
  - Delete the suffix `ubuntu1` in the version. The version should look like
    `2.5.0-1+focal0`, where:
    - `2.5.0` is the Cantera release
    - `-1` is an Ubuntu package version number, which should be incremented for any
      changes that affect the packages for any Ubuntu series
    - `focal0` names the series, with a suffix that is incremented for each build for
      that series. This number must be incremented each time the package is uploaded to
      Launchpad, even if the build fails.
    - For alpha/beta releases, a `~` needs to be inserted before the alpha/beta suffix
      so they will be seen as coming before the stable release, for example
      `2.5.0~b2-1+focal0`.
  - Add a message, e.g. `New upstream release`
  - If you create the Changelog entry manually, running `date --rfc-2822` will give you
    a correctly formatted date string.
- Commit all changes
- Create additional branches starting from the merge commit for each supported Ubuntu
  release. You may need to remove some `changelog` entries to make sure the versions
  are strictly increasing.

### Steps for adding a new Ubuntu version

- Update the list of Ubuntu versions in `build_images.sh`
- Create a new entry in `debian/changelog` following the above guidelines

### Deal with any patches needed

- Install `sudo apt install git-buildpackage`
- Create `.git/gbp.conf` with contents that look like the following:
  ```ini
  [DEFAULT]
  upstream-branch = main
  upstream-tag = v%(version)s
  debian-branch = ubuntu20.04-ct2.6
  ```
- Run `gbp pq import` to convert the existing patches into a new "patch queue" branch
  - If the patch queue branch already exists, run `gbp pq rebase` instead.
- Make any changes desired and commit them to this branch. This can include cherry-picking
  commits onto this branch.
- Run `gbp pq export`. This will create the patch files and return you to the `debian-branch`
- Run `git add debian/patches` and `git commit`.

## Create Docker images for each supported Ubuntu version

- Run `build_images.sh`

## Build & test packages

- Update `vars.sh` to specify the correct values for `SHORT_VERSION`, `FULL_VERSION`,
  `BASE_REF` and `PPA_TARGET`.
  - For stable releases, `PPA_TARGET=cantera-team/Cantera`
  - For alpha/beta releases, `PPA_TARGET=cantera-team/cantera-unstable`.
  - Also, remember that alpha/beta versions must include a tilde to maintain correct
    version order, for example `3.0.0~b1`.
- Launch a Docker container for an Ubuntu version, e.g. `./run.sh 21.10`
- To test the package build, run `./build.sh` from inside the container. Fix any errors
  by making additional commits in the `cantera` repo on the host system. Changes made
  at this stage do not require incrementing the build number.
- To install the generated packages locally and run some tests, run:
  - `./test-python-local.sh`
  - `./run-samples-local.sh`
- To just install the packages without running the tests directly, run `./install-python-local.sh` and/or `./install-dev-local.sh`

## Upload to Launchpad
- If the test build succeeds, upload to Launchpad by running `./put.sh`. This should
  prompt you for the passphrase on your GPG key in order to sign the package.
- If the Launchpad build succeeds, test installing and using the resulting package by running:
  - `./test-python-ppa.sh`
  - `./run-samples-ppa.sh`
  - Check that `ck2yaml` and any other binaries are available as expected
- To just install the packages without running the tests directly, run `./install-ppa.sh`
- If the build works, tag the relevant commit using the Ubuntu version string, e.g.
  `ubuntu-2.5.0-1+focal1`.
- Repeat this process for each supported Ubuntu series.

## Backporting dependencies

*Note: these instructions have not been updated for the Docker-based process*

We may need to backport some of our dependencies for older Ubuntu releases, and upload
them to the PPA as well. The approximate process for this is as follows:

```
apt install devscripts
export DEBEMAIL="you@somewhere.com"
export DEBFULLNAME="Your Name"
mkdir -p ~/src/somepackage-backport
cd ~/src/somepackage-backport
```

Go to the page for the version of the package you want on https://packages.ubuntu.com,
and get the url for the `'dsc'` file. Then, run:

```
dget -u http://archive.ubuntu.com/ubuntu/pool/main/blahblahblah.dsc
```

The `-u` flag is needed because I haven't figured out yet how to get it to verify
signatures correctly.

`cd` into the package directory, then run:

```
dch -i
```

And complete the new Changelog message.

- replace `UNRELEASED` with the correct Ubuntu release name (e.g. `bionic`)
- replace the suffix `ubuntu1` in the version with a correctly sequenced name including
  the release, like `bionic2`. This version should be greater than any version
  previously uploaded to the PPA.
- Add a message, e.g. "Backport to Bionic"

Save and close, then run:
```
debuild -S
```

Install any missing build dependencies that it yells about, if necessary. Cross fingers
and hope for the best. Finally, run:

```
cd ..
dput ppa:launchpad_username/ppa_name somepackage......._source.changes
```
