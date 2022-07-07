#!/bin/bash

command="$1"
storage="<path to storage.sh>"

if [ -z "$command" ]; then
	echo "No command specified."
	exit 1
fi

if [ "$command" = "export" ] || [ "$command" = "e" ]; then 
	directory=$(readlink -f "$2")
	shorthand="$3"
	if [ -z "$directory" ] || [ -z "$shorthand" ]; then 
		echo "To export, specify both a directory and shorthand."
		exit 1
	fi
	if [ "$shorthand" = "export" ] || [ "$shorthand" = "e" ]; then
		echo "Cannot use reserved keywords for shorthand."
		exit 1
	fi
	echo "export $shorthand=$directory;" >> "$storage";
else
	shorthand="$command"
	source "$storage"; directory=$(printenv $shorthand)
	if [ -z "$directory" ]; then
		echo "Invalid shorthand provided. Valid shorthands are as follows -"
		cat "$storage"
		exit 1
	fi
	cd "$directory"
	vim `fzf`
fi

