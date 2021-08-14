ARM and ARM64 Github Actions Runner
===================================

This repository makes it simple to run a self-hosted GitHub Actions runner on a Raspberry Pi 3 or Raspberry Pi 4.

Since GitHub doesn't provide arm Actions runners, using a Raspberry Pi is one of the simplest methods for testing on arm.

This repository was inspired by https://github.com/myoung34/docker-github-actions-runner.

## Customization

In order to make the runner useful for your Actions, you will likely need to cusomtize the file `Dockerfile` to install necessary system packages.

## Creating the Docker Image

Once you've customized the `Dockerfile`, build a docker image to use for the runner:

```bash
./build
```

## Starting a Runner

Starting a runner consists of providing the GitHub username and repo as positional args to the `./start` script. Additionally, an env var named `GITHUB_ACCESS_KEY` must contain your GitHub Person Access Token.

```bash
GITHUB_ACCESS_TOKEN=examplekey ./start GITHUB_USER GITHUB_REPO
```

## Base Image

*This section is primarily documentation about how I build `wbond/pi-github-runner-base`. Users will not run this, and an error will occur if they do, since it will try to push to my Docker Hub account.*

The base image is built for amd64, arm64 and armhf, using the following command:

```bash
./build-base
```

If the command produces an error such as "multiple platforms feature is currently not supported for docker driver", then create a different builder:

```bash
docker buildx create --use --name build --node build --driver-opt network=host
```