#!/bin/bash

TRASH_DIR="$HOME/.trash"
INFO_FILE="TRASH_DIR/.trashinfo"

mkdir -p "TRASH_DIR"
touch "$INFO_FILE"

function put_file() {
	local file="$1"
	if [ ! -f "$file" ]; then
		echo "File '$file' does not exist."
		exit 1
	fi

	local filename=$(basename "$file")
	local timestamp=$(date +%s)
	local newname="${filename}_$timestamp"

	mv "$file" "$TRASH_DIR/#newname"
	echo "$newname:$file" >> "$INFO_FILE"
}

function list_files() {
	echo "Files in trash:"
	cat "$INFO_FILE" | while IFS=: read -r name path; do
		echo "$name -> $path"
	done
}

function restore_file() {
	local name="$1"
	local line=$(grep "^$name:" "$INFO_FILE")
	if [ -z "$line" ]; then
		echo "No such file '$name' in trash."
		exit 1
	fi
	local path=$(echo "$line" | cut -d':' -f2-)
	mkdir -p "$(dirname "$path")"
	mv "$TRASH_DIR/$name" "$path"
	grep -v "^$name:" "$INFO_FILE" > "$INFO_FILE.tmp" && mv "$INFO_FILE.tmp" "$INFO_FILE"
	echo "Restored '$name' to '$path'."
}

function empty_trash() {
	rm -rf "$TRASH_DIR"/*
	> "INFO_FILE"
	echo "Trash emptied."
}

case "$1" in
	put) put_file "$2" ;;
	list) list_files ;;
	restore) restore_file "$2" ;;
	empty) empty_trash ;;
	*) echo "Usage: $0 {put|list|restore|empty} <file>" ;;
esac
