#!/bin/bash


function doTheSort {
	echo -ne "\nSorting files, please wait... "

	for FILE in `ls $SOURCE_FOLDER`
	do
		full_file_path=${SOURCE_FOLDER}/${FILE}
		date_folder=`stat -c %y ${full_file_path} | cut -d' ' -f 1`
		file_year=`echo $date_folder | cut -d'-' -f 1`
		file_month=`echo $date_folder | cut -d'-' -f 2`
		file_day=`echo $date_folder | cut -d'-' -f 3`
		
		#echo $date_folder
		#echo "$file_year,$file_month,$file_day"

		full_dest=${DEST_BASE_FOLDER}/${file_year}/${file_month}/${file_day}/
		if [[ ! -d "${full_dest}" ]]
		then
			#echo "Creating folder..."
			mkdir -p ${full_dest}
		fi

		cp --preserve=timestamps ${full_file_path} ${full_dest}/

		if [ $? -eq 0 ]
		then
			rm ${full_file_path}
		fi

	done

	echo -ne "OK!\n"
}

function usage {
	echo -e "\nUsage:"
	echo -e "\t./ordering.sh --source,-s <source_folder> --dest,-d <destination_folder> [--version,-v]\n"

	exit 1
}

function readParams {

	if [ $# -eq 0 ];
	then
		usage
		exit -1
	fi

	PARSED_OPTIONS=$(getopt -n "$0"  -o s:d:h --long "source:,dest:,help"  -- "$@")
	 
	if [ $? -ne 0 ];
	then
	  usage
	fi
	 
	eval set -- "$PARSED_OPTIONS"

	while true;
	do
	  case "$1" in
	 
	    -h|--help)
		usage
		;; 
	    -s|--source)
		if [ -n "$2" ]
		then
			SOURCE_FOLDER=$2
		fi
		
	        echo "SOURCE_FOLDER=$SOURCE_FOLDER"
	        shift 2;;
	 
	    -d|--dest)
                if [ -n "$2" ]
                then
                        DEST_BASE_FOLDER=$2
                fi

                echo "DEST_BASE_FOLDER=$DEST_BASE_FOLDER"
                shift 2;;
	 
	    --)
	      shift
	      break;;
	  esac
	done
}


### MAIN ###
echo -e "Sorting script\n"

readParams $@
doTheSort

### EOF ###
