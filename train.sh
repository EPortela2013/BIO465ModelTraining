#!/bin/bash

echo STARTING AT `date`

caffe train -solver solver.prototxt -weights models/bvlc_googlenet.caffemodel -gpu all &> caffe.log

echo FINISHED at `date`
