#!/bin/bash
mvn clean test || { echo "Maven Clean Test Unsuccessful"; exit 1; }
mvn clean release:prepare || { echo "Maven release:prepare Unsuccessful"; exit 1; }
git push

#------CHECK LAST TAG-------

# Get new tags from remote
git fetch --tags

# Get latest tag name
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)

# Checkout latest tag
git checkout $latestTag

#--------------------------
mvn clean package



#--------------------------Back to head of master and clean--------
git checkout master
rm -f release.properties
rm -f pom.xml.releaseBackup
mvn clean
#----------------------------- --------