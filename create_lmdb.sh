#!/bin/bash
# Create the image lmdb inputs
set -e

DATA=.

# Set this path to the appropriate caffe install get_folder_name
TOOLS=/opt/caffe/bin

# The path to the images to be used for the creation of the lmdb's
TRAIN_DATA_ROOT=$DATA/images/
VAL_DATA_ROOT=$DATA/images/

# The path where the lmdb's should be placed
TRAIN_LMDB_DIR=~/data/lmdb/color-80-20/train_db
VAL_LMDB_DIR=~/data/lmdb/color-80-20/val_db

# Set these to the path where you want to store the lmdb's

# Set RESIZE=true to resize the images to 256x256. All images provided in this
# repository have already been resized
RESIZE=false
if $RESIZE; then
  RESIZE_HEIGHT=256
  RESIZE_WIDTH=256
else
  RESIZE_HEIGHT=0
  RESIZE_WIDTH=0
fi

if [ ! -d "$TRAIN_DATA_ROOT" ]; then
  echo "Error: TRAIN_DATA_ROOT is not a path to a directory: $TRAIN_DATA_ROOT"
  echo "Set the TRAIN_DATA_ROOT variable in create_imagenet.sh to the path" \
       "where the ImageNet training data is stored."
  exit 1
fi

if [ ! -d "$VAL_DATA_ROOT" ]; then
  echo "Error: VAL_DATA_ROOT is not a path to a directory: $VAL_DATA_ROOT"
  echo "Set the VAL_DATA_ROOT variable in create_imagenet.sh to the path" \
       "where the ImageNet validation data is stored."
  exit 1
fi

echo "Creating train lmdb..."

GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    $TRAIN_DATA_ROOT \
    $DATA/train.txt \
    $TRAIN_LMDB_DIR

echo "Creating val lmdb..."

GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    $VAL_DATA_ROOT \
    $DATA/validate.txt \
    $VAL_LMDB_DIR

echo "Done."
