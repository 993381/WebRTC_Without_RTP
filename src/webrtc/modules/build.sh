#!/bin/bash

function PrintUsage()
{
	echo -e "Usage:"
	echo -e "./build.sh $ToolChain"
	echo -e "ToolChain: arm-linux/x86"
	echo -e "EGG:"
	echo -e "./build.sh arm-linux"
	echo -e " or ./build.sh x86"
}
function GenerateCmakeFile()
{
	mkdir -p build
	CmakeFile="./build/ToolChain.cmake"
	echo "SET(CMAKE_SYSTEM_NAME \"Linux\")" > $CmakeFile
	if [ $1 == x86 ]; then
		echo "SET(CMAKE_C_COMPILER \"gcc\")" >> $CmakeFile	
		echo "SET(CMAKE_CXX_COMPILER \"g++\")" >> $CmakeFile	
	else
		echo "SET(CMAKE_C_COMPILER \"$1-gcc\")" >> $CmakeFile
		echo "SET(CMAKE_CXX_COMPILER \"$1-g++\")" >> $CmakeFile
	fi
}
function BuildLib()
{
	echo -e "Start building ..."
	OutputPath="./build"
	if [ -e "$OutputPath" ]; then
		if [ -e "$OutputPath/lib" ]; then
			echo "/build/lib exit"
		else
			mkdir $OutputPath/lib
		fi
	else
		mkdir $OutputPath
		mkdir $OutputPath/lib
	fi	
	cd build
	cmake ..
	if [ -e "Makefile" ]; then	
		make -j4 > /dev/null
		if [ $? == 0 ]; then
			echo "make success! "
		else
			echo "make failed! "
			exit -1
		fi
	else
		echo "Makefile generated failed! "
		exit -1
	fi
	cd ..
}

function CopyLib()
{
	CurPwd = $PWD
	cd $1
	if [ -e "lib" ]; then
		echo "lib exit"
	else
		mkdir lib
	fi
	
	cd lib
	if [ -e "webrtc" ]; then
		echo "webrtc exit"
	else
		mkdir webrtc
	fi
	
	cd webrtc
	if [ -e "modules" ]; then
		echo "modules exit"
	else
		mkdir modules
	fi
	
	cd modules
	
	
}

if [ $# == 0 ]; then
	PrintUsage
	exit -1
else
	cd audio_coding
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..
	
	cd audio_device
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..
	
	cd media_file
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..
	
	cd utility
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..
	
	cd audio_mixer
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..	
	
	cd audio_processing
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..
	
	cd video_capture
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..	
	
	cd video_coding
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..	
	
	cd rtp_rtcp
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..	
	
	cd remote_bitrate_estimator
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..
	
	cd bitrate_controller
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..	
	
	cd congestion_controller
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..	
	
	cd pacing
	sh build.sh $1
	if [ $? -ne 0]; then
		exit -1
	fi
	cd ..	
fi



