bashtools
=========

Useful bash scripts, most of them done quick&dirty, be careful!

ordering.sh
-----------

Simple bash script for ordering files in a folder by date. 

It will iterate over all the files in --source and create an ordered
tree under --dest following the <dest_folder>/year/month/day structure.


backup-diff.sh
-----------

Diff two .tar.gz files and generate a summary and full diff file.

Usage:
```
./backup-diff.sh <old-backup> <new-backup>
```
