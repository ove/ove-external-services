# Open Visualisation Environment

Open Visualisation Environment (OVE) is an open-source software stack, designed to be used in large high resolution display (LHRD) environments like the [Imperial College](http://www.imperial.ac.uk) [Data Science Institute's](http://www.imperial.ac.uk/data-science/) [Data Observatory](http://www.imperial.ac.uk/data-science/data-observatory/).

We welcome collaboration under our [Code of Conduct](https://github.com/ove/ove/blob/master/CODE_OF_CONDUCT.md).

## Build Instructions

The build system is based on Bash, Docker and docker-compose. This works well with node-based services.

### Build an external service

Clone the desired repository e.g. Tuoris https://github.com/oserban/tuoris.git then run:

```sh
./build.sh -s tuoris -p 7080 --chrome
```
The -s option represents the service name (which has to match the folder name) and -p represents the port number the service exposes.

**Note:** Tuoris requires a valid chrome install, so the --chrome flag needs to be passed.

This tool generates a Dockerfile and a docker-compose.yml file for each service. These files can be found in the **generated** folder.