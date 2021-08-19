ARM and ARM64 Github Actions Runner
===================================

This repository makes it simple to run a self-hosted GitHub Actions runner on a Raspberry Pi 3 or Raspberry Pi 4.

Since GitHub doesn't provide arm Actions runners, using a Raspberry Pi is one of the simplest methods for testing on arm.

This repository was inspired by https://github.com/myoung34/docker-github-actions-runner.

## Architecture

This repo requires:

 - A Raspberry Pi 3 or Raspberry Pi 4 with Linux armhf or arm64
 - python3 and docker be installed on the Raspberry Pi

*Technically the project supports x86_64 Linux/Mac hosts also, which would
result in an x64 Ubuntu runner, however those are available from GitHub.*

The overall architecture of the system is:

 - Docker is used to run a self-host GitHub runner in a container
 - The container is a bare-bones environment that can be customized to your
   tooling needs
 - The container runs Ubuntu 20.04, armhf, arm64 or amd64 depending on the
   host machine architecture
 - The user `ubuntu` runs jobs, with password-less `sudo` access
 - The container is persisted between runs so any changes to the OS are not
   wiped at the end of a job
 - *You should probably follow GitHub's advice about using self-hosted runners
   for private projects.* You may be able to use them on public projects if
   you restrict GitHub Actions access to require approval so you can approve
   known contributors.

## Setup

For setting up a runner, you need to have:

 - Linux installed on a Raspberry Pi 3 or Raspberry Pi 4
 - python3 and docker installed

Personally, I like to run the Ubuntu 20.04.

*The one thing to be aware of with Ubuntu 20.04 on armhf is that Docker
currently doesn't provide packages for 20.04. To get docker working, the
`focal` text in the Docker debian repository needs to be replaced with
`bionic`.*

Once you have your base OS installed, ensure your user is configured to be
part of the `docker` group.

Next, you will want to customize the `Dockerfile` to install system packages
your CI runs will require.

Once you've customized the `Dockerfile`, build the docker image:

```bash
./build
```

## Starting a Runner

Starting a runner consists of providing the GitHub username and repo as
positional args to the `./start` script. Additionally, an env var named
`GITHUB_ACCESS_KEY` must contain your GitHub Person Access Token.

```bash
GITHUB_ACCESS_TOKEN=examplekey ./start GITHUB_USER GITHUB_REPO
```

## Base Image

*This section is primarily documentation about how I build
`wbond/pi-github-runner-base`. Users will not run this, and an error will
occur if they do, since it will try to push to my Docker Hub account.*

The base image is built for amd64, arm64 and armhf, using the following
command:

```bash
./build-base
```

If the command produces an error such as `multiple platforms feature is
currently not supported for docker driver`, then create a different builder:

```bash
docker buildx create --use --name build --node build --driver-opt network=host
```
