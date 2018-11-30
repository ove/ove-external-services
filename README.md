# Open Visualisation Environment - External Services

This repository contains a collection of external services used by [Open Visualisation Environment (OVE)](https://github.com/ove/ove).

OVE is an open-source software stack, designed to be used in large high resolution display (LHRD) environments like the [Imperial College](http://www.imperial.ac.uk) [Data Science Institute's](http://www.imperial.ac.uk/data-science/) [Data Observatory](http://www.imperial.ac.uk/data-science/data-observatory/).

We welcome collaboration under our [Code of Conduct](https://github.com/ove/ove-apps/blob/master/CODE_OF_CONDUCT.md).

## Build Instructions

The build system is based on Bash, Docker and docker-compose. This works well with node-based services.

### Building a supported external service

Currently we support a number of external service as part of our infrastructure.

#### Clone/install

To clone and install all the supported services with the latest tested version you can execute:

```sh
scripts/execute.sh --command install
```

This will execute all the *install-stage* scripts available in the *scripts/install-stage/* folder.

If you want to install only a particular external service (e.g. tuoris) you can execute:

```sh
scripts/install-stage/tuoris.sh 
```

#### Test

To test all the supported services you can execute:

```sh
scripts/execute.sh --command test
```

This will execute all the *test-stage* scripts available in the *scripts/test-stage/* folder.

If you want to test only a particular external service (e.g. tuoris) you can execute:

```sh
scripts/test-stage/tuoris.sh 
```

#### Build

To build all the supported services you can execute:

```sh
scripts/execute.sh --command build
```

This will execute all the *build-stage* scripts available in the *scripts/build-stage/* folder.

If you want to build only a particular external service (e.g. tuoris) you can execute:

```sh
scripts/build-stage/tuoris.sh 
```

**Note:** This method pushes the built docker image by default, if you want to build without pushing please follow the **Build a new external service** steps.

### Build a new external service

Clone the desired repository e.g. Tuoris https://github.com/fvictor/tuoris.git then run:

```sh
scripts/build.sh -s tuoris -p 7080 --chrome
```
The -s option represents the service name (which has to match the folder name) and -p represents the port number the service exposes.

**Note:** Tuoris requires a valid chrome install, so the --chrome flag needs to be passed.

This tool generates a Dockerfile and a docker-compose.yml file for each service. These files can be found in the **generated** folder.
