#!/bin/bash

LEAF_PREDICTION_DIR=../BIO465LeafPrediction
IMAGES_DIR=images

# Check directory to make sure directory where model information will be stored
# is present
if [ ! -d "$LEAF_PREDICTION_DIR" ]; then
  echo "It is necessary to have a directory where to store the models.
        It would also be useful to have the code to make a prediction once the models
        are trained.
        The best way to achieve this is to clone the leaf prediction repository
        by running the following command
        git clone https://github.com/EPortela2013/BIO465LeafPrediction.git $LEAF_PREDICTION_DIR"
  exit 1
fi

# Generate images.txt file
 find $IMAGES_DIR |  sed "s/$IMAGES_DIR\///g" | grep -E 'jpg|JPG' | sort > images.txt  && \
 # Assign labels to images
 python3 assign_labels_nums.py && \
 # Split images between training and validation sets
 python3 split_labeled_images.py && \
 # Create LMDB's
 bash create_lmdb.sh && \
 # Generate mean images
 bash make_image_mean.sh && \
 # Finally train models
 bash train.sh
