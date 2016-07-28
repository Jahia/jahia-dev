#!/bin/sh

./checkout-all.sh;

./update-all.sh;

if [ "$1" = "" ] ; then
  MAVEN_SITE_PATH="/tmp"
else
  MAVEN_SITE_PATH="$1"
fi
if [ "$2" = "" ] ; then
  USE_MAVEN_REPO=""
else
  USE_MAVEN_REPO="-Dmaven.repo.local=$2"
fi
mvn clean -P all $USE_MAVEN_REPO
mvn -Pdocumentation -Ddocumentation -DgenerateReports=false site:site $USE_MAVEN_REPO
mvn -Pdocumentation -Ddocumentation -Djahia.site.path=$MAVEN_SITE_PATH site:deploy $USE_MAVEN_REPO
current_path=`pwd`
cd $MAVEN_SITE_PATH
tar czf $current_path/target/jahia_site_doc.tar.gz .
