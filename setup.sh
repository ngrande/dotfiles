#!/bin/bash

# create symlinks from all to my dotfiles
echo "Installing dot files..."
for file in "$(pwd)/dot"/*
do
	dot_name=.$(basename $file)
	if [ -L ~/$dot_name ]; then
		echo "Symlink already exists ~/$dot_name"
		continue
	fi
	echo "Creating symlink ~/$dot_name -> $file"
	echo "Confirm with [ENTER]"
	read
	ln -sf $file ~/$dot_name
done

echo "Installing .config files..."
mkdir -p ~/.config
for file in "$(pwd)/config"/*
do
	dirfile=$(basename $file)
	# check if is symlink with -L
	if [ -L ~/.config/"$dirfile" ]; then
		echo "Symlink already exists ~/.config/$dirfile"
		continue
	fi
	echo "Creating symlink ~/.config/$dirfile -> $file"
	read
	ln -sf $file ~/.config/$dirfile
done

echo "Installing pacman hooks..."
echo "This requires sudo!"
echo "Confirm that you can read... [ENTER]"
read
sudo mkdir -p /etc/pacman.d/hooks
# here we want to copy, because having a symlink in a system wide path
# to a user home directory is ugly as fu
for hook in "$(pwd)/pacman/hooks"/*
do
	hook_name=$(basename $hook)
	echo "Copying hook $hook_name to /etc/pacman.d/hooks"
	echo "Confirm with [ENTER]"
	read
	sudo cp $hook /etc/pacman.d/hooks/
done

echo "Finished."
