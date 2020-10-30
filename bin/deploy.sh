#!/bin/sh

GIT_SHA=$(git rev-parse --short HEAD)
VER=$1

if [ -z $VER ]; then
  echo "Missing argument VER, example: bin/deploy.sh version"
  exit 1
fi

git show HEAD

echo
echo

read -p "Release at this commit  [y/N]" YES_NO
YES_NO=$(echo $YES_NO | tr '[:upper:]' '[:lower:]')

if [ "$YES_NO" != "y" ]; then
  echo
  echo "Canceling release!"
  exit 1
fi

git tag ${VER}
echo
echo
echo "Tagged the release as ${VER}."
echo

git push origin master --tags

echo
echo "Pushed to github."
