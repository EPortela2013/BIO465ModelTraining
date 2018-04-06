#!/bin/bash
CAFFE_ROOT=/opt/caffe/distribute/bin

echo STARTING AT `date`
# if caffe compiled with GPU mode enabled, add -gpu all as argument
$CAFFE_ROOT/caffe train -solver solver.prototxt -weights models/bvlc_googlenet.caffemodel &> caffe.log

echo FINISHED at `date`
