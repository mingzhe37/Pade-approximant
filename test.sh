  exec docker run \
 	  --name test \
          --user=root \
	  --detach=false \
	  -e DISPLAY=${DISPLAY} \
	  -v /tmp/.X11-unix:/tmp/.X11-unix\
	  --rm \
	  -v `pwd`:/mnt/shared \
	  -v /home/mingzhe/Downloads/Buildings:/usr/local/JModelica/ThirdParty/MSL/Buildings \
	  -i \
          -t \
	  jmodelica14023:v1 /bin/bash
    exit $
