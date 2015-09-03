#!/bin/bash
DIFF_CMD_SUMMARY='diff -ENwburq'
DIFF_CMD_FULL='diff -ENwbur'

function usage {
    echo "Usage: "
    echo -e  "\t./backup-diff.sh <old-backup> <new-backup>\n"
}

function show_details {
    echo "OLD backup file: $OLD_FILE"
    echo "NEW backup file: $NEW_FILE"
    echo "Temporal folder: $TEMP_FOLDER"
    echo ""
    echo "Results Summary: $SUMMARY_FILE"
    echo "Results Full   : $FULL_FILE"
}



# MAIN
echo -e "Backup diff script.\n"

if [ $# -lt 2 ]
then
    usage
    exit 1
fi

OLD_FILE=$1
NEW_FILE=$2
CUR_DATE=`date +%Y%M%d`
TEMP_FOLDER=${CUR_DATE}_$RANDOM
NEW_FOLDER=$TEMP_FOLDER/NEW
OLD_FOLDER=$TEMP_FOLDER/OLD

SUMMARY_FILE=results.summary.${CUR_DATE}
FULL_FILE=results.full.${CUR_DATE}

show_details

mkdir -p $NEW_FOLDER $OLD_FOLDER
tar xzf $OLD_FILE -C $OLD_FOLDER
tar xzf $NEW_FILE -C $NEW_FOLDER

$DIFF_CMD_SUMMARY $OLD_FOLDER $NEW_FOLDER > $SUMMARY_FILE
$DIFF_CMD_FULL $OLD_FOLDER $NEW_FOLDER > $FULL_FILE

rm -fr $TEMP_FOLDER

exit 0