#!/bin/bash

extract_file() {
	echo "EXTRAINDO..."
	for arq in $(ls $1); do
		if [[ $arq =~ .*.tar.gz ]]; then
			tar -vzxf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tar.bz2 ]]; then
			tar -jxvf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tar.xz ]]; then
			tar -xvf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.zip ]]; then
			unzip -o $1/$arq -d $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.rar ]]; then
			unrar x $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tar ]]; then
			tar -xvf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.bz2 ]]; then
			bzip2 -d $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tar.zst ]]; then
			tar xaf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tgz ]]; then
			tar -xvzf $1/$arq -C $1
			rm -r $1/$arq
		fi
	done
	echo "CONCLUIDO!!!"
}

download_file() {
	if [ $1 = 'directory' ]; then
		wget -c -P "$3" "$2"
	elif [ $1 = 'directory_name' ]; then
		wget -c "$2" -O "$3"
	fi
}
