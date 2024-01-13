#!/bin/sh

LANG=$1
VERSION=$2
REPO_GO="https://github.com/lugobots/the-dummies-go"
REPO_JS="https://github.com/lugobots/the-dummies-js"
REPO_PY="https://github.com/lugobots/the-dummies-py"

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo "Lugo Bot Setup - Creates a brand new bot"
   echo
   echo "Syntax: LANGUAGE [version] "
   echo "Possible languages: go, js, py"
   echo ""
   echo "Go template repo: "$REPO_GO
   echo "Javascript template repo: "$REPO_JS
   echo "Python template repo: "$REPO_PY
   echo
}

REPO_TEMPLATE=""
PROJECT_NAME=""
PROJECT_PATH=$(pwd)
if [ "$1" = "go" ]; then
    REPO_TEMPLATE=$REPO_GO".git"
    PROJECT_NAME="The Dummies Go"
elif [ "$1" = "js" ]; then
    REPO_TEMPLATE=$REPO_JS".git"
    PROJECT_NAME="The Dummies JS"
elif [ "$1" = "py" ]; then
    REPO_TEMPLATE=$REPO_PY".git"
    PROJECT_NAME="The Dummies Py"
else
   Help
   exit 1
fi

if ! [ -z "$(ls -A .)" ]; then
  echo "The output directory must be empty"
else
  echo "Creating bot template from "$REPO_TEMPLATE

  if ! git clone -q $REPO_TEMPLATE . &>/dev/null
  then
   echo "fail to clone the repo :-("
   exit 1
  fi

  LATEST_VERSION=$(git tag --sort=-creatordate | grep -v rc | head -n 1)
  echo "Latest version: ""${LATEST_VERSION}"
   if [ -z "$VERSION" ]
   then
         INSTALL_VERSION=$LATEST_VERSION
   else
         INSTALL_VERSION=$VERSION
   fi
   git fetch --all --tags -q  &>/dev/null

   git checkout -q tags/"$INSTALL_VERSION" || { echo 'could not checkout that tag, does it actually exist?' ; exit 1; }
   echo "Installing $PROJECT_NAME Version ""$INSTALL_VERSION"
   cd ..
#   chmod -R 777 "$PROJECT_PATH"
   rm -rf "$PROJECT_PATH".git
   echo "All done!"
   echo ""
fi


