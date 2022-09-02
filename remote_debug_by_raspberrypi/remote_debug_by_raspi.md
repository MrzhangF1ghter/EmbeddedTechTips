嵌入式远程调试小技巧
## *tricks of embedded device remote debug*

# 背景
在日常工作开发中，难免会遇到需要真机调试的时候，如果设备体积比较小，能直接在桌上调试那就还好，如果需要调试大型或已经装机不便移动的设备时，就不那么方便了，比如笔者在广州的夏天户外调试，暴晒+喂蚊，那叫一个酸爽。那有没有什么办法能优雅的在办公室内调试户外的设备呢？有！笔者想到了一个巧妙的办法，并验证可行，实现了远程下载/在线调试及串口，can口调试。接下来就来介绍一下吧！

# 准备
该方案是基于调试工具套件自带的远程调试功能+树莓派（低成本linux电脑）搭建的，同时使用树莓派的usb口做串口/can盒数据转发。支持远程调试的调试器如 **JLink**，本文章的示例为jlink。若你的调试器支持远程调试，也可尝试一下。 

材料清单：   
1. 树莓派 (2B+或以上,zero亦可可，测试过2B+和4B+)，建议选择带wifi连接的型号，方便连接网络。   
    <img src="https://assets.raspberrypi.com/static/raspberry-pi-4-labelled@2x-1c8c2d74ade597b9c9c7e9e2fff16dd4.png" width="50%">   
    Raspberry Pi 2B,3B,4B....都可以    
    <img src="https://assets.raspberrypi.com/static/51035ec4c2f8f630b3d26c32e90c93f1/2b8d7/zero2-hero.webp" width="50%">  
    Raspberry Pi Zero,Zero W,Zero 2W...也可以
2. JLink 调试器   
   <img src="https://c.a.segger.com/fileadmin/images/products/J-Link/J-Link_PRO/j-link_pro_500.png.webp" width="50%">  

3. 你的目标板

4. 内网穿透工具* 若你需要在外网（非同一个局域网下，去调异地的设备，如海外设备），请备好内网穿透工具，如蒲公英，4G网卡。

# 部署
## 1.树莓派环境部署
关于树莓派环境部署，本文不详细阐述，按照[官方文档](https://www.raspberrypi.com/documentation/computers/getting-started.html)安装好系统即可，无需特殊配置。进入系统后，请确认开启：  
 * 远程桌面(vnc server)
 * ssh登录
 * 连接至与你电脑同一网络
## 2.调试环境部署   
- ### 2.1 远程端配置
  - 我们需要在树莓派上安装jlink套件的驱动，多亏了官方提供的arm版linux驱动，让我们远程调试成为了可能。在jlink官网<https://www.segger.com/downloads/jlink/>下载`JLink Software and Documentation Pack(Linux ARM 32-bit DEB Installer)`
  到树莓派本地。

  - 在树莓派ssh执行安装指令：
  `sudo dkpg -i ./JLink_Linux_xxx_arm.deb`  
  jlink套件默认会安装到`/opt/SEGGER/JLink_xxx` 目录下。

  - 连接jlink及usb串口*(若需要)   
  <img src="https://raw.githubusercontent.com/MrzhangF1ghter/EmbeddedTechTips/master/remote_debug_by_raspberrypi/pic/11.jpeg" width="80%">   

  - 登录树莓派的远程桌面，打开jlink套件安装文件目录.
  <img src="https://raw.githubusercontent.com/MrzhangF1ghter/EmbeddedTechTips/master/remote_debug_by_raspberrypi/pic/1.png" width="80%">  

  -  双击运行`JLinkRemoteServerExe`，若显示ip，则显示jlink连接成功，若弹框提示无识别到jlink，请检查硬件连接。记录下该ip，该ip就是我们远程连接jlink的ip。
  <img src="https://raw.githubusercontent.com/MrzhangF1ghter/EmbeddedTechTips/master/remote_debug_by_raspberrypi/pic/2.png" width="80%">  

- ### 2.2 本地端配置
    在本地电脑启动ide/gdb server，本文以keil ide为例。
    - 打开options->Debug,选择Use J-LINK/J-TRACE Cortex,并点击settings
    <img src="https://raw.githubusercontent.com/MrzhangF1ghter/EmbeddedTechTips/master/remote_debug_by_raspberrypi/pic/4.png" width="80%">  

    - 在弹出的Driver Setup窗口中,找到interface,选择TCP/IP,并填入刚才远程端`JLinkRemoteServer`中显示的ip及端口。并点击ping按钮测试是否ping通。若无意外，device栏将会显示连接的目标设备。若无显示，请检查port选项是否选择对，适当降低时钟频率（特别是网络较差的环境下）。
    <img src="https://raw.githubusercontent.com/MrzhangF1ghter/EmbeddedTechTips/master/remote_debug_by_raspberrypi/pic/3.png" width="80%">  

    - 至此，我们已经完成了所有的配置，并可以愉快的调试和下载了！
- ## 3. 结果
  当我们配置完成后，就可以像本地连接设备一样轻松调试了，如下载，在线断点调试等等。。

  - 下载固件：  
  <img src="https://raw.githubusercontent.com/MrzhangF1ghter/EmbeddedTechTips/master/remote_debug_by_raspberrypi/pic/8.png" width="80%">   

  - 在线调试：  
  <img src="https://raw.githubusercontent.com/MrzhangF1ghter/EmbeddedTechTips/master/remote_debug_by_raspberrypi/pic/5.png" width="80%">  

  - 串口调试：   
  <img src="https://raw.githubusercontent.com/MrzhangF1ghter/EmbeddedTechTips/master/remote_debug_by_raspberrypi/pic/6.png" width="90%">  

    如果需要查看串口数据也很简单，我们只需要利用linux的命令行即可，只需将你的串口转usb工具接上，在树莓派上 ch340,cp21xx免驱，将会自动识别成ttyUSB设备。  
    在本地登录树莓派终端并执行： 
    - 配置打开串口波特率为115200：   
    `stty -F /dev/ttyUSB1 ispeed 115200 ospeed 115200 cs8 igncr`   
    - 打开串口：
    `cat /dev/ttyUSB0`

- ## 4.总结
- 