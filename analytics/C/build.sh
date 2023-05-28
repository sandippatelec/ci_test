#!/bin/bash

Usage()
{
	echo -e ""
	echo "Parameter is incorrect...!!!"
	echo "Please provide correct parameter!"
	echo "Supported parameter :"
	echo "	Arguments 1 : all, clean, release xxversion"
	echo -e ""
	echo "Ex. ./build.sh all "
	echo -e ""
}

APP_Build()
{
	echo -e ""
	echo "------------------------"
	echo "| Application Building |"
	echo "------------------------"
	echo -e ""
	cd "app"
	# make clean
	make -j8
	if [ "$?" -eq "0" ]; then
		echo -e ""
		echo "----------------------"
		echo "| TCP Build successfully |"
		echo "----------------------"
		echo -e ""
	fi
	cd ..
	cd "ip"
	# make clean
	make -j8
	if [ "$?" -eq "0" ]; then
		echo -e ""
		echo "----------------------"
		echo "| IP_NIP Build successfully |"
		echo "----------------------"
		echo -e ""
	fi
	cd ..
	cd "udataDatabase"
	# make clean
	make -j8
	if [ "$?" -eq "0" ]; then
		echo -e ""
		echo "----------------------"
		echo "| Udata to Database Build successfully |"
		echo "----------------------"
		echo -e ""
	fi
	cd ..
}

TCP_Build()
{
	cd "app"
	make clean
	make -j8
	if [ "$?" -eq "0" ]; then
		echo -e ""
		echo "----------------------"
		echo "| TCP Build successfully |"
		echo "----------------------"
		echo -e ""
	fi
	cd ..
}

IPNIP_Build()
{
	cd "ip"
	make clean
	make -j8
	if [ "$?" -eq "0" ]; then
		echo -e ""
		echo "----------------------"
		echo "| IP_NIP Build successfully |"
		echo "----------------------"
		echo -e ""
	fi
	cd ..
}

udataDatabase_Build()
{
	cd "udataDatabase"
	make clean
	make -j8
	if [ "$?" -eq "0" ]; then
		echo -e ""
		echo "----------------------"
		echo "| Udata to Database Build successfully |"
		echo "----------------------"
		echo -e ""
	fi
	cd ..
}
ALL_Build()
{
	echo -e ""
	echo "------------------------"
	echo "| Application Building |"
	echo "------------------------"
	echo -e ""
	TCP_Build
	IPNIP_Build
	udataDatabase_Build

}

TSN_Build()
{
	echo -e ""
	echo "------------------------"
	echo "| Application Building |"
	echo "------------------------"
	echo -e ""
	cd "app"
	make clean
	make -j8
	if [ "$?" -eq "0" ]; then
		echo -e ""
		echo "----------------------"
		echo "| Build successfully |"
		echo "----------------------"
		echo -e ""
	fi
	cd ../utils
	bash tsn.sh
	cd ..
}

ALL_clean()
{
	echo -e ""
	echo "------------------------"
	echo "| Cleaning all modules |"
	echo "------------------------"
	echo -e ""
	cd "app"
	make clean
	cd ..
	cd "ip"
	make clean
	cd ..
	cd "udataDatabase"
	make clean
	cd ..
	# cd "data/processed/outbound/"
	# rm -v !".bitpush.txt"
	# cd ../../../
	# cd "logs"
	# rm -r -v !".bitpush.txt"
	# cd ..
	# cd "release"
	# rm -r -v !(".bitpush.txt")
	# cd ..

	# ./build.sh "clean"
	# cd ..
}

GIT_clean()
{
	echo -e ""
	echo "------------------------------------"
	echo "| Cleaning all modules and outputs |"
	echo "------------------------------------"
	echo -e ""
	pwd
	cd "app"
	make clean
	cd "../ip"
	make clean
	cd "../udataDatabase"
	make clean
	cd ../utils
	bash gitclean.sh
	cd ..
	
}

TSN_clean()
{
	echo -e ""
	echo "------------------------------------"
	echo "| Cleaning all modules and outputs |"
	echo "------------------------------------"
	echo -e ""
	cd utils/
	bash tsnclean.sh
	cd ..
	
}


if [ "$#" -gt 0 ]; then

	if [ "$1" = "clean" ];then
	{
		ALL_clean
	}
	elif [ "$1" = "gitclean" ];then
	{
		GIT_clean
	}	
	elif [ "$1" = "all" ];then
	{
		ALL_Build
	}
	elif [ "$1" = "app" ];then
	{
		APP_Build
	}
	elif [ "$1" = "tsn" ];then
	{
		TSN_Build
	}	
	elif [ "$1" = "tsnclean" ];then
	{
		TSN_clean
	}	
	elif [ "$1" = "tcp" ];then
	{
		TCP_Build
	}	
	elif [ "$1" = "ipnip" ];then
	{
		IPNIP_Build
	}	
	elif [ "$1" = "udataDatabase" ];then
	{
		udataDatabase_Build
	}	
	elif [ "$1" = "release" ];then
	{
		ALL_Build
        if [ -d "release" ];then
        {
			:
        }
        else
        {
            mkdir release
        }
        fi
		cd release
        
		if [ -d "C" ];then
        {
			if [ -d "C/data" ];then
			{
				if [ -d "C/data/processed" ];then
				{
					if [ -d "C/data/processed/outbound" ];then
					{
						:
					}
					else
					{
						mkdir C/data/processed/outbound/
					}
					fi
				}
				else
				{
					mkdir C/data/processed/
					mkdir C/data/processed/outbound/
				}
				fi
			}
			else
			{
				mkdir C/data/
				mkdir C/data/processed/
				mkdir C/data/processed/outbound/

			}
			fi
			if [ -d "C/logs" ];then
			{
				:
			}
			else
			{
				mkdir C/logs/
			}
			fi
        }
        else
        {
            mkdir C/
			# mkdir C/bin/
			mkdir C/data/
			mkdir C/data/processed/
			mkdir C/data/processed/outbound/
			# mkdir C/config/
			mkdir C/logs/
			# mkdir C/test/
			# mkdir C/utils/

        }
        fi		
		cd ..

        cp -r bin/ release/C
		cp -r config/ release/C
		cp -r test/ release/C
		cp -r utils/ release/C
		cp utils/update.sh release/C

		cd release
		tar -czvf C_$2.tar.gz C
		# cp -r TestApp/ Release/
	}	
	else
	{
		Usage
	}
	fi
else
	Usage
fi
