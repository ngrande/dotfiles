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
	ln -sfT $file ~/$dot_name
done

echo "Installing .config files..."
echo "in case a dir with the same name already exists
a backup with suffix .bak will be created. No worries."
mkdir -p ~/.config
for file in "$(pwd)/config"/*
do
	dirfile=$(basename $file)
	# check if is symlink with -L
	if [ -L ~/.config/"$dirfile" ]; then
		echo "Symlink already exists ~/.config/$dirfile"
		continue
	elif [ -d ~/.config/"$dirfile" ]; then
		# create a backup of the existing file
		mv ~/.config/"$dirfile" ~/.config/"${dirfile}.bak"
	fi
	echo "Creating symlink ~/.config/$dirfile -> $file"
	read
	ln -sf $file ~/.config/$dirfile
done

echo "Installing pacman hooks..."
echo "This requires sudo!"
echo "Confirm that you can read... [ENTER]"
read
if ! [ -d /etc/pacman.d/hooks ];
then
	sudo mkdir -p /etc/pacman.d/hooks
fi
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

echo "Enabling redshift service"
systemctl --user enable redshift-gtk.service

echo "Finished."
