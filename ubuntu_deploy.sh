#!/bin/bash
#/***********************************************
# Copyright (c) 2018, Wuhan
# All rights reserved.
#
# @Filename: ubuntu_deploy.sh
# @Version：V1.0
# @Author: Frank Liu - frankliu624@gmail.com
# @Description: 史上最伟大Ubuntu14.04+ 开发办公环境一键部署方案
# @Create Time: 2018-11-04 15:15:28
# @Last Modified: 2018-11-04 15:15:28
#***********************************************/

# 要求使用root权限运行脚本
ROOT_UID=0
if[ `id -u` -ne $ROOT_UID ]
then
    echo "执行权限不够!请使用sudo运行！"
    exit 1
fi

echo -e "############ 安装部署前的准备工作 #############"

# 记录工作目录`Ubuntu_deploy/`
workDir=$PWD
# 当前用户
cur_user=`whoami`
# 安装日志文件
logfile="$workDir/deploy.log"
touch ${logfile}
echo -e "****************Ubunt_deploy 日志记录：******************\n" > $logfile
date >> $logfile   # time
# 在当前目录下创建packages目录存储下载的安装包
if [ ! -d packages ]; then  
　　mkdir packages
fi
# 在当前user的主目录下创建dev目录作为开发目录
mkdir ~/dev

# 判断是否是ubuntu18.04LTS版本
function is_ubuntu1804()
{
    version=$(cat /etc/lsb-release | grep "DISTRIB_RELEASE")
    if [ ${version} == "DISTRIB_RELEASE=18.04" ]; then
        echo 1
    else
        echo 0
    fi
}

echo -e "################### 1. 首先安装一些必要的命令行工具 ##################"
#为便于后续安装步骤需要，首先安装一些必要的命令行工具: git, ssh, g++, cmake, npm, zip, unzip, rar, unrar, tar, curl, wget等
sudo apt-get install git ssh g++ cmake npm zip unzip rar unrar tar curl wget ffmpeg

################# 2. 双系统启动grub2主题美化：`Griffin-Grub-Remix` ###################
# 主题安装包的URL
cd $workDir/packages/
if [ ! -f Griffin-Grub-Remix.zip ];then
    url_grubtheme="https://github.com/FLHonker/fl-bash/raw/master/Ubuntu_deploy/packages/Griffin-Grub-Remix.zip"
    wget ${url_grubtheme}
fi
# 解压
unzip -o Griffin-Grub-Remix.zip
# 进入目录安装
cd Griffin-Grub-Remix
sudo ./install.sh
if [ $? -eq 0 ];then
    echo -e "Griffin-Grub-Remix主题安装成功!" | tee -a $logfile
fi

echo -e "#################### 3. 卸载自带不常用软件包 ####################"
# 卸载libreoffices
sudo apt-get remove libreoffice-common
# 删除Amazon广告图标
sudo rm -f /usr/share/applications/com.canonical.launcher.amazon.desktop
sudo rm -f /usr/share/applications/ubuntu-amazon-default.desktop
# 删除多余的软件
sudo apt-get remove unity-webapps-common empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines gnome-orca webbrowser-app gnome-sudok onboard deja-dup landscape-client-ui-install

echo -e "################### 4. 设置右键新建常用模板文件 ###################"
# *.docx, *.xlsx, *.pptx这些会在安装wps后自动创建，这里我们只帮您创建文本文件模板
# 根据系统语言进入模板文件存放目录
if [ -d ~/Templates ];then
    cd ~/Templates
    touch txt.txt
    touch markdown.md
elif [ -d ~/模板 ];then
    cd ~/模板
    touch txt.txt
    touch markdown.md
fi

echo -e "##################### 5. dev开发环境 #########W############"
# C++ dev
sudo apt install gcc g++ make build-essential
# Python, py的numpy、pyTorch、turtle等库和包默认都是安装使用Python3的
sudo apt install python python3 python-pip python3-pip
# numpy for python2-3 setup
sudo pip install numpy
sudo pip3 isntall numpy
# pyTorch-cpu for python3.6 setup
sudo pip3 install http://download.pytorch.org/whl/cpu/torch-0.4.1-cp36-cp36m-linux_x86_64.whl
sudo pip3 install torchvision
# turtle-0.0.2 for python2-3 setup
sudo pip install turtle
# for python3,需要下载源码手动修改setup.py文件后安装
cd $workDir/packages
url_turtle="https://github.com/FLHonker/fl-bash/raw/master/Ubuntu_deploy/packages/turtle-0.0.2.zip"
if [ ! -f turtle-0.0.2.zip ];then
    wget ${url_turtle}
fi
unzip turtle-0.0.2.zip
cd turtle-0.0.2
sudo pip3 install -e turtle-0.0.2
# caffe-cpu only for Ubuntu18.04，低版本的ubuntu请手动编译安装
if [ is_ubuntu1804 -eq 1 ];then
    sudo apt install caffe-cpu
else
    echo "目前，非Ubuntu18.04版本请手动编译安装caffe！"
fi

# golang
sudo apt install golang

# Oracle JDK-1.8   ?????????????????????????????????????????????????
url_jdk=""

echo -e "OpenCV3.4.2+contrib - 源码编译安装 for C++&python3"
cd $workDir/packages   # 下载到packages目录
url_opencv="https://github.com/opencv/opencv/archive/3.4.2.tar.gz"
url_contrib="https://github.com/opencv/opencv_contrib/archive/3.4.2.tar.gz"
# 下载opencv-3.4.2，并解压到～/dev/
wget ${url_opencv}
tar -zxvf opencv-3.4.2.tar.gz -C ~/dev/
# 下载contrib扩展模块，并解压到opencv目录
wget ${url_contrib}
tar -zxvf opencv_contrib-3.4.2.tar.gz -C ~/dev/opencv-3.4.2/
cd ~/dev/opencv-3.4.2/    # 进入opencv源码目录
mkdir build         # 创建编译生成目录
mv opencv_contrib-3.4.2 opencv_contrib #修改目录名
# 安装依赖，使用python3
sudo apt-get install build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev 
sudo apt-get install python3-dev python3-numpy qt5-default libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
# 选择性安装
sudo apt-get install libprotobuf-dev protobuf-compiler
sudo apt-get install libgoogle-glog-dev libgflags-dev
sudo apt-get install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen
# 进入build目录，准备编译生成makefile
cd build/
# cmake
# 在电脑上有多个版本的python时，可以通过-D PYTHON_DEFAULT_EXECUTABLE=$(which python3)来确定使用哪个版本的python
cmake -D CMAKE_BUILD_TYPE=Release \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
      -D WITH_TBB=ON \
      -D WITH_EIGEN=ON \
      -D WITH_QT=ON \
      -D WITH_V4L=ON \
      -D OPENCV_EXTRA_MODULES_PATH=~/dev/opencv-3.4.2/opencv_contrib/modules \
      ..

# 查看逻辑CPU的个数
nCPU=`cat /proc/cpuinfo| grep "processor"| wc -l`
echo -e "make -j: nCPU = $nCPU" >> $logfile
# 多核编译make
make -j$nCPU
# 如果编译成功，则进一步安装
if [ $? -ne 0];then
    sudo make install
    sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
    sudo ldconfig
    # 这一步关系到vim-plus-plus中能否自动提示opencv函数
    # 将opencv源码复制到/usr/include/，便于引用编译
    sudo cp -r /usr/local/include/opencv* /usr/include/
    echo -e "恭喜！OpenCV-3.4.2安装成功！" | tee -a $logfile
else
    echo -e "opencv编译出错!" | tee -a $logfile
    while true 
    do
        echo
        read -p "opencv编译出错，是否继续?[Y/n]:" cont
        if [ $cont == "Y" -o $cont == "y" ];then 
            echo "continue......" | tee -a $logfile
            break
        elif [ $cont == "n" ];then
            echo -e "退出安装..." | tee -a $logfile
            exit 1
        else
            echo -e "请输入正确的选项!"
        fi
    done
fi

echo -e "################### 6. Applications install ####################"
cd $workDir/packages/
# APP.deb统一下载与安装函数 #
function apps_installer()
{
    app_name=$1     # app名称
    deb_name=$2     # deb包名
    download_url=$3 # deb包下载地址
    cd $workDir/packages/  # 进入安装包下载目录
    if [ ! -f $deb_name ];then
        echo -e "Downloading $app_name deb package..."
        wget ${download_url}
        if [ $? -ne 0 ];then
            echo -e "$deb_name 下载失败!" | tee -a $logfile
        fi
    else
        # 如果已经下载成功，开始安装
        echo -e "开始安装$app_name ..."
        sudo dpkg -i ${deb_name}
        # 如果由于缺少依赖安装失败，则先解决依赖问题再重试
        if [ $? -ne 0 ];then
            sudo apt-get -f -y install
            sudo dpkg -i ${deb_name}
            if [ $? -ne 0 ];then
                echo -e "$app_name 安装成功！" | tee -a $logfile
            fi
        else
            echo -e "$app_name 安装成功！" | tee -a $logfile
        fi
    fi
}
echo -e "安装GUI应用软件:"

# VLC视频播放器, uGet
echo -e "installing VLC, uGet..."
sudo apt install vlc uget 

# Google Chrome 70: download, install
app_name="Chrome"
deb_name="google-chrome-stable_current_amd64.deb"
download_url="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
apps_installer $app_name $deb_name $download_url

# 网易云音乐：download, install
app_name="netease-cloud-music"
deb_name="netease-cloud-music_1.1.0_amd64_ubuntu.deb"
download_url="http://d1.music.126.net/dmusic/netease-cloud-music_1.1.0_amd64_ubuntu.deb"
apps_installer $app_name $deb_name $download_url

# GoLand2018: tar.gz解压安装
cd $workDir/packages/
# wget下载
wget https://download-cf.jetbrains.com/go/goland-2018.2.3.tar.gz
# 直接解压到/opt/就可以了
sudo tar -zxvf goland-2018.2.3.tar.gz -C /opt/
# 创建程序图标
sudo cp -f ./GoLand-2018.desktop /usr/share/applications/
echo -e "GoLand2018.2.3 安装成功！" | tee -a $logfile

# Eclipse
cd $workDir/packages/
wget http://eclipse.mirror.rafal.ca/oomph/epp/2018-09/Ra/eclipse-inst-linux64.tar.gz
tar -zxvf eclipse-inst-linux64.tar.gz   # 解压出 eclipse-installer/
cd eclipse-installer/
# 执行安装，需要交互
sudo ./eclipse-inst

# BaiduPCS-Go
# 进入目录安装
cd Griffin-Grub-Remix
cd $workDir/packages/
if [ ! -f BaiduPCS-Go-v3.5.6-linux-amd64.zip ];then
    wget https://github.com/iikira/BaiduPCS-Go/releases/download/v3.5.6/BaiduPCS-Go-v3.5.6-linux-amd64.zip
fi
# 解压，移动执行文件至bin
sudo unzip -o BaiduPCS-Go-v3.5.6-linux-amd64.zip
cd BaiduPCS-Go-v3.5.6-linux-amd64/
sudo cp BaiduPCS-Go /bin/

# MEGA




#################### 7. Shell优化 ###################
# autojump
cd $workDir/packages/
git clone https://github.com/joelthelion/autojump.git
cd autojump/
python3 ./install.py

# saferm
sudo wget https://github.com/lagerspetz/linux-stuff/blob/master/scripts/saferm.sh -P /bin
sudo chmod +x /bin/safrm.sh
echo -e "alias=saferm.sh" >> /etc/profile >> ~./bashrc

