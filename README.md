[![Build Status](https://travis-ci.org/joelchretien/obsidian-mm.svg?branch=master)](https://travis-ci.org/joelchretien/obsidian-mm)[![Maintainability](https://api.codeclimate.com/v1/badges/e1e6fce8e810198a0c3d/maintainability)](https://codeclimate.com/github/joelchretien/obsidian-mm/maintainability)

# README

## Install
### Docker
The docker-compose.yml file will allow you to run the image containing the web application as well as the postgres database required to run it.
```
git clone git@github.com:joelchretien/obsidian-mm.git
cd obsidian-mm
docker-compose build
docker-compose up -d
```
 
The image should then be running on your machine.  Connect to http://localhost:3000 to access the application.
 
## Tests
A convenience script is present to help run specs in docker.  It can be run using the following command.
```
./runTestsInDocker.sh
```
## Continuous Integration
CI is provided by TravisCI.  The current status of the build and log can be found at the following URL: https://travis-ci.org/joelchretien/obsidian-mm
 
 

