#!/bin/sh
#A script for installing or upgrading multiple ULAPPH sites in one script
#For each target project ID, execute configure and install

#Home Directory where this script is located
#Under this directory, we should find the following folders
# ULAPPH-Cloud-Desktop-Configs/ - contains configurations for each project
# /ULAPPH-Cloud-Desktop-1/ - contains the source codes of ULAPPH Cloud Desktop
HOME=/home/edwin_d_vinas/ulapph

#Admin Email
EMAIL=edwin.d.vinas@gmail.com

#Verbosity {error, info, warning, debug}
VERBOSITY=debug

echo 'Installing all ulapph sites...'

#Install Project
#----------------
PROJECT_ID=edwin-daen-vinas
echo "Backing up main.go"
cd $HOME/ULAPPH-Cloud-Desktop-1/
cp main.go main.go.backup
cp main.go main.go.dev

echo "Configuring project: " $PROJECT_ID
cd $HOME/ULAPPH-Cloud-Desktop-Configs/
ulapphctl --config $PROJECT_ID.yaml configure

echo "Preparing project: " $PROJECT_ID
cd $HOME/ULAPPH-Cloud-Desktop-1/
#cp main2.go main.go.install
mv main2.go main.go

echo "Installing project via gcloud: " $PROJECT_ID
gcloud --project=$PROJECT_ID --account=$EMAIL --verbosity=$VERBOSITY --quiet app deploy app.yaml
echo "Cleaning up project: " $PROJECT_ID
ulapphctl devstart

