#!/bin/bash

for f in packages/*; do
	if [[ -f "$f" ]]; then
		echo "Installing $f"
		$f
	fi
done
