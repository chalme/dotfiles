#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

CONFIG_HOME=~/init/

ALFRED_HOME=~/init/alfred/

ALFRED_WORKFLOW_HOME="$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/"

mkdir -p ${ALFRED_HOME};

echo ${ALFRED_HOME};
cd ${ALFRED_HOME};

git clone git@github.com:zenorocha/alfred-workflows.git;
git clone git@github.com:chalme/YoudaoTranslate.git

ln -s ${ALFRED_HOME}YoudaoTranslate/src/ ${ALFRED_WORKFLOW_HOME}YoudaoTranslate

cd alfred-workflows;

