link () {
	echo "This utility will symlink the files in this repo to the home directory"
	echo "Proceed? (y/n)"
	read resp
	if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
		for file in $( ls -A | grep -vE '\.git$|.*\.sh$|.*\.md$' ) ; do
		    if [ -f $file ]
                    then
                        read -p "${file} already exists, overwrite? (y/n)" yn
                        case $yn in
			    [yY]* )  rm "$HOME/$file"; echo "existing $file deleted"; ln -sv "$PWD/$file" "$HOME";;
			    [nN]* ) "existing $file was kept";;
		        esac
		    else
			ln -sv "$PWD/$file" "$HOME"
                    fi
		done
		echo "Symlinking complete"
	else
		echo "Symlinking cancelled by user"
		return 1
	fi
}

install_tools () {
	if [ $( echo "$OSTYPE" | grep 'darwin' ) ] ; then
		echo "This utility will install useful utilities using Homebrew"
		echo "Proceed? (y/n)"
		read resp
		if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
			echo "Installing useful stuff using brew. This may take a while..."
			sh brew.sh
		else
			echo "Brew installation cancelled by user"
		fi
	else
		echo "Skipping installations using Homebrew because MacOS was not detected..."
	fi
}

link
install_tools
