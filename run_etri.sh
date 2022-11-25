echo "Launch jtop logger"
python3 jtop_logger.py &

echo "Launch FLIR IR Camera ROS Package"
roslaunch flir_boson_usb flir_boson.launch & 
P1=$!
sleep 5s

#echo "RUN ROSBAG"
#rosbag record -o rosbag.bag /etri/rgb_ir_input &
P3=$!

echo "RUN YOLOv5 in Docker Container"
docker run -it --rm  --network host -v ~/:/server/ --runtime nvidia -v /dev/v4l/by-id:/dev/v4l/by-id  --privileged godhj93/etri_rescue:221027
P2=$!
sleep 5s

wait $P1 $P2 $P3



