## Deploy image
cd darknet && ./darknet detector train data/obj.data yolo-obj.cfg build/darknet/x64/darknet53.conv.74 -dont_show -gpus 0,1,2,3
