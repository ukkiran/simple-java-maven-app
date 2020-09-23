#!/usr/bin/env bash

echo 'installing jar'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'Setting the project name'
set -x
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
set +x

echo 'setting project version.'
set -x
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
set +x

echo 'runing application (which Jenkins built using Maven) to the Jenkins UI.'
set -x
java -jar target/${NAME}-${VERSION}.jar
