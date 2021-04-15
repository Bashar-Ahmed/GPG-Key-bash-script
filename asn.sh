#! /bin/bash

git config commit.gpgsign true

echo "Press 1 if you already have a key"
echo "Press 2 if you don't have a key"
read input 

if [[ $input -eq '1' ]];  
then 
  echo "Press 1 if you already have linked the key in .gitconfig and GitHub"
  echo "Press 2 if you haven't set"
  read input2
  if [[ $input2 -eq '2' ]];
  then
	gpg --list-keys
	echo "Enter your GPG key ID"
	read gpgkey
	gpg --armor --export $gpgkey
  	echo "Link this With your GitHub Profile"
  	git config --global user.signingkey $gpgkey
	fi
fi
if [[ $input -eq '2' ]];
then
  gpg --full-generate-key
  echo "Enter your GPG key ID"
  read gpgkey
  gpg --armor --export $gpgkey
  echo "Link this With your GitHub Profile"
  git config --global user.signingkey $gpgkey 
fi

echo "Enter commit message"
read message
git add .
git commit -m "$message"