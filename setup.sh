#!/bin/bash

# create symlinks from all to my dotfiles
for file in "$(pwd)/dot"/*
do
	dot_name=.$(basename $file)
	echo "Creating symlink ~/$dot_name -> $file"
	echo "Confirm with [ENTER]"
	read
	ln -sf $file ~/$dot_name
done

