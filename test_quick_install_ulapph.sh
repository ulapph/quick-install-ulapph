#!/bin/bash
#A test install script for testing certain installs
#A script for installing or upgrading multiple ULAPPH sites in one script
#For each target project ID, execute configure and install

#!!!! EDIT THIS !!!!
#Home Directory where this script is located
#Under this directory, we should find the following folders
# quick-install-ulapph - the quick installer
# ULAPPH-Cloud-Desktop-Configs/ - contains configurations for each project
# ULAPPH-Cloud-Desktop-1/ - contains the source codes of ULAPPH Cloud Desktop
HOME=/home/ulapph/ulapph

#!!!! EDIT THIS !!!!
#Admin Email
EMAIL=ulapph@gmail.com

#!!!! EDIT (optional) !!!!
#Verbosity {error, info, warning, debug}
VERBOSITY=debug

#!!!! EDIT THIS !!!!
#Directory where source codes are located 
ULAPPH_SOURCES=ULAPPH-Cloud-Desktop-1

#!!!! EDIT THIS !!!!
#Directory where YAML configurations are located
ULAPPH_CONFIGS=ULAPPH-Cloud-Desktop-Configs

#!!!! EDIT THIS !!!!
#List ulapph to be deployed or installed
array=(
#"christine-cunanan" \
#"golang-programming" \
#"ulapph-1" \
#"ulapph-2" \
#"ulapph-3" \
#"ulapph-4" \
#"ulapph-5" \
#"ulapph-cloud-desktop" \
#"ulapph-corporation" \
#"ulapph-demo" \
#"ulapph-infostream" \
"ulapph-installer" \
#"ulapph-methods" \
#"ulapph-portal" \
#"ulapph-public-1" \
#"ulapph-sites" \
#"ulapph-ves" \
#"ulapph-videoke" \
#"ulapph-work" \
)

#!!!!! STOP EDITS HERE !!!!!!!
echo 'Installing all ulapph sites...'
echo "Number of sites: ${#array[*]}"
for ix in ${!array[*]}
do
    	printf "Installing [$ix/${#array[*]}]...  %s\n" "${array[$ix]}"
	echo '======================================'

	#Install Project
	#----------------
	PROJECT_ID=${array[$ix]}
	echo "Backing up main.go"
	cd $HOME/$ULAPPH_SOURCES/
	cp main.go main.go.backup
	cp main.go main.go.dev

	echo "Configuring project: " $PROJECT_ID
	cd $HOME/$ULAPPH_CONFIGS/
	ulapphctl --config $PROJECT_ID.yaml configure

	echo "Preparing project: " $PROJECT_ID
	cd $HOME/$ULAPPH_SOURCES/
	mv main2.go main.go

	echo "Installing via gcloud: " $PROJECT_ID
	gcloud --project=$PROJECT_ID --account=$EMAIL --verbosity=$VERBOSITY --quiet app deploy app.yaml
	echo "Cleaning up project: " $PROJECT_ID
	ulapphctl devstart
	echo '======================================'

done
echo


