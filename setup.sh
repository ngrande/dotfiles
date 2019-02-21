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

echo "Installing pacman hooks..."
echo "This requires sudo!"
echo "Confirm that you can read... [ENTER]"
read
sudo mkdir -p /etc/pacman.d/hooks
for hook in "$(pwd)/pacman/hooks"/*
do
	hook_name=$(basename $hook)
	echo "Copying hook $hook_name to /etc/pacman.d/hooks"
	echo "Confirm with [ENTER]"
	read
	sudo cp $hook /etc/pacman.d/hooks/
done

echo "Finished."
