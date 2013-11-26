#!/bin/sh

VENDOR=amazon
DEVICE=tate

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary

echo "Pulling $DEVICE files..."
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
mkdir -p $BASE/$DIR
    fi
adb pull /system/$FILE $BASE/$FILE
done

./setup-makefiles.sh

# Call up to tate-pvr
./extract-files-pvr.sh

# Call up to bowser-common
cd ../bowser-common
../bowser-common/extract-files.sh
