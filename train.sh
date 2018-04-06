#!/bin/bash
CAFFE_ROOT=/opt/caffe/distribute/bin

echo STARTING AT `date`

$CAFFE_ROOT/caffe train -solver solver.prototxt -weights models/bvlc_googlenet.caffemodel -gpu all &> caffe.log

echo FINISHED at `date`
