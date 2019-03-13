# 史上最伟大Ubuntu14.04+ 开发办公环境一键部署方案

Frank在历经3年的Linux开发和运维后，总结了Ubuntu版本下常用的易安装或者不易安装的好用的、好玩的、实用的、强力推荐的软件包和插件的安装步骤，并将其整合为一键化脚本，方便广大Linux爱好者和开发者在新装或者重装Ubuntu系统后一系列繁琐的环境搭建任务，以有助于把宝贵的时间用在开发和研究上面，避免一些不必要的麻烦。

**需要说明的是：** 本工具是Frank根据同行喜好和需求整合的一些常用软件包和插件的安装部署方案，开发环境适用于C\/C++、Python2、Python3、OpenCV3.4.x、Java1.8、Go1.10、Octave等，如果不太符合您的需要，可以自行进行选择和裁剪。另外，Frank一直以来使用Ubuntu版本，从`14.04LTS`一直用到`18.04LTS`，对于更低版本的Ubuntu或者其他的Linux分支可能有些不兼容，请您在确保自己有足够能力解决突发情况的前提下谨慎使用，如出现任何疑问或者难题，可以联系[Frank][1]帮您解决，也希望您有能力的话参与完善该项目为开源社区贡献力量：<frankliu624@gmail.com>。感谢您的使用和支持！

## 使用说明

* 系统要求：Ubuntu14.04及以上， 其他分支的Linux会多多少少有问题，后续优化。
* 适用对象：
  * 计算机相关专业学生、教师
  * Linux爱好者、运维工程师
  * 有Linux实用和开发经验者最佳
  * 科研人员
  * 软件工程师
* 完美服务领域：
  * C\/C++，Java，Go，Python软件开发
  * 使用Python、Octave、caffe等进行深度学习开发和研究
  * 使用OpenCV进行图像处理和计算机视觉
  * git版本控制
  * Linux运维
  * 博客写作

## 涵盖软件和优化方案

1. 双系统启动grub2主题美化：[Griffin-Grub-Remix][1]; 您也可以去[官网下载][2]自己喜欢的grub2主题安装。
2. 卸载自带不常用软件包：LibreOffice, unity-webapps-common(Amazon), empathy, brasero, simple-scan, gnome-mahjongg, aisleriot, gnome-mines, gnome-orca, webbrowser-app, gnome-sudoku, onboard, deja-dup, landscape-client-ui-install。
3. 设置右键新建常用模板文件: *.docx, *.xlsx, *.pptx, *.txt, *.md 等。
4. dev命令行工具：git, ssh, g++, cmake, npm, zip, unzip, rar, unrar, tar, curl, wget, ffmpeg 。
5. dev开发环境（C\/C++，Java，Python2，Python3,go,octave为主）: gcc, g++, make, build-essential, python2, python3, pip2, pip3, jdk1.8, go-1.10, [PyTorch][3], numpy, [caffe-cpu][4], turtle, [OpenCV3.4.2 + contrib][5] 。
6. 办公软件与IDE：VLC, uGet, [Chrome][6], [网易云音乐][7], [GoLand2018][8], [Eclipse][9], [BaiduPCS-Go][10], [MEGA][11], [VSCode][12], [WPS][13], [搜狗输入法][14] 。
7. shell命令行优化: [oh-my-zsh][15] + fonts + themes, [autojump][21], [saferm][22]， [lsix][25]， thefuck[26] 。
8. Frank独家超级Vim： [vim-plus-plus][16] 。
9.  SSR科学上网命令行工具： [ShadowsocksR Python][17], [ssr-helper][18] 。
    关于VPS-SSR服务器环境搭建请参考[这里][23].
10. [wine-QQ 2018解决方案（目前最完美）][19]
11. [Hugo][20]博客环境。
12. 安装完成之后的软件包清理工作。

## 注意事项

可能遇到的问题及解决方案:



## 关于和鸣谢

* 关于Frank，请访问博客: [frankliu624.me][24]
* email: <frankliu624@gmail.com>

感谢开源社区、各位大神总结的各种繁琐的软件安装教程和脚本工具，感谢所有开源项目、贡献者！
使用过程中如有问题，希望您及时反馈帮助改正，感谢您的理解和支持！
如果您觉得对本工具满意，继续支持Frank为开源社区贡献好用的工具，并愿意给予一定打赏，请扫描下面二维码：
<div align=center>
<img src="https://res.cloudinary.com/flhonker/image/upload/flhonker-hugo/logo/alipay.jpg" width=28% heigth=28% />
&nbsp&nbsp&nbsp&nbsp&nbsp
<img src="https://res.cloudinary.com/flhonker/image/upload/flhonker-hugo/logo/wechat_facetoface_collect_qrcode_1541664905560.png" width=28% heigth=28% />
</div>


[1]: https://www.gnome-look.org/p/1237117/
[2]: https://www.gnome-look.org/browse/cat/109/order/latest
[3]: https://pytorch.org/get-started/locally/
[4]: http://caffe.berkeleyvision.org/
[5]: https://github.com/opencv
[6]: https://www.google.cn/chrome/
[7]: https://music.163.com/#/download
[8]: https://www.jetbrains.com/go/
[9]: https://www.eclipse.org/downloads/
[10]: https://github.com/iikira/BaiduPCS-Go
[11]: https://mega.nz/
[12]: https://code.visualstudio.com/
[13]: http://www.wps.cn/product/wpslinux
[14]: https://pinyin.sogou.com/linux/?r=pinyin
[15]: https://github.com/robbyrussell/oh-my-zsh
[16]: https://github.com/FLHonker/vim-plus-plus
[17]: https://github.com/shadowsocksr-backup/shadowsocksr/tree/manyuser
[18]: https://github.com/noahziheng/ssr-helper
[19]: https://www.lulinux.com/archives/1319
[20]: https://github.com/gohugoio/hugo
[21]: https://github.com/joelthelion/autojump
[22]: https://blog.csdn.net/F8qG7f9YD02Pe/article/details/79543316
[23]: https://github.com/FLHonker/autoVPS-ssr
[24]: http://frankliu624.me
[25]: https://github.com/hackerb9/lsix
[26]: https://github.com/nvbn/thefuck
