#!/bin/bash

# create symlinks from all to my dotfiles
echo "Installing dot files..."
for file in "$(pwd)/dot"/*
do
	dot_name=.$(basename $file)
	echo "Creating symlink ~/$dot_name -> $file"
	echo "Confirm with [ENTER]"
	read
	ln -sf $file ~/$dot_name
done

echo "Installing ssh configs..."
for file in "$(pwd)/ssh"/*
do
	config_name=$(basename $file)
	echo "Creating symlink ~/.ssh/$config_name -> $file"
	echo "Confirm with [ENTER]"
	read
	ln -sf $file ~/.ssh/$config_name
done

echo "Finished."
