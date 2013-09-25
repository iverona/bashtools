#!/bin/bash

SOURCE_FOLDER=/home/nacho/archive/unordered-archive/archive
DEST_BASE_FOLDER=/home/nacho/archive/ordered-v1/

echo "Starting sorting script..."
echo "SOURCE_FOLDER=$SOURCE_FOLDER"
echo "DEST_BASE_FOLDER=$DEST_BASE_FOLDER"

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

### EOF ###
