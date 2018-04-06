#!/bin/bash
# Compute the mean image from the training lmdb

# Set to the appropriate caffe installation folder
TOOLS=/opt/caffe/distribute/bin

# The path where the training lmdd are located
TRAIN_LMDB_DIR=~/data/lmdb/color-80-20/train_db

# The location and name where the mean image should be stored
MEAN_IMAGE_NAME=~/data/lmdb/color-80-20/mean.binaryproto

echo "Creating image mean from training set."

$TOOLS/compute_image_mean $TRAIN_LMDB_DIR $MEAN_IMAGE_NAME

echo "Done."
