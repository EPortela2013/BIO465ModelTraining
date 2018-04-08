# BIO465ModelTraining
Images and code necessary to train model

## Downloading images for training

In order to keep the size of this repository at a minimum, the images we used for training are not included.
The images need to be downloaded before training can be done. To get them run the following command:
```bash
bash get_images.sh
```

To create the training models, use the following command:
```bash
bash generate_caffe_models.sh
```

This is only necessary if you want to use models other than the ones provided
by the prediction [repository](https://github.com/EPortela2013/BIO465LeafPrediction "BIO465LeafPrediction").
