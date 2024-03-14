# STM32 inside Apple products
# 前言
笔者为苹果用户已经有十余年，从攒钱购买第一款苹果设备--(iPod Shuffle)到配齐全家桶，对设计理念非常的欣赏，每次发布新产品都会去[ifixit](us.ifixit.com)看其拆解，其内在设计真的贯彻了乔布斯的设计哲学，在用户看不到的电路板上都有美学考究。作为嵌入式从业者，对其mcu(微控制器)选型和功能实现是非常好奇的，看了这么多拆解发现，苹果对我日常使用的stm32单片机似乎非常的有感情，几乎每款设备都有其身影，接下来就看看这些设备的拆解吧！   
*下文关于mcu功能猜测并非全部准确，欢迎纠正。*  
# 1.耳机
## AirPods
<!-- https://www.ifixit.com/Teardown/AirPods+Teardown/75578 -->
<img src="https://guide-images.cdn.ifixit.com/igi/5ZZqSfTPLZxD5mVE.huge" width = "800" alt="AirPods" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/Ako31WBL4HHaYt3F.huge" width = "800" alt="AirPods" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/iQGyIcLZcIscjUsD.full" width = "800" alt="AirPods" align=center />

$\color{#C0221B}{●}$ [STM32L072VZ](https://www.st.com/content/st_com/en/products/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus/stm32-ultra-low-power-mcus/stm32l0-series/stm32l0x2/stm32l072vz.html) ARM Cortex-M0+ MCU   
这是一款超低功耗的m0内核单片机，带usb,adc,dac,i2c等外设。   
实现充电仓功能，如dfu(usb),指示灯(pwm),舱门检测(霍尔+adc),电源管理(adc),耳机通讯(i2c/私有协议？)   
**架构:** ARM Cortex-M0+  
**主频:** 32MHz  
**RAM:** 20KB  
**Flash:** 192KB  
**IOs:** 84   
**价格:** 2.682$ (10ku)

## AirPods Pro
<!-- https://www.ifixit.com/Teardown/AirPods+Pro+Teardown/127551 -->

<img src="https://guide-images.cdn.ifixit.com/igi/HYVeTq11VFBl5wex.huge" width = "800" alt="AirPods Pro" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/51ZpQOKRPfCnH1Pe.huge" width = "800" alt="AirPods Pro" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/dnF1BDawUGufVJW2.full" width = "800" alt="AirPods Pro" align=center />

$\color{#B82617}{●}$ [STM32L476MG](https://www.st.com/en/microcontrollers-microprocessors/stm32l476mg.html) ARM Cortex-M4 MCU
*与1代耳机相比，升级为M4内核，该mcu有更高的主频，可能用于处理无线充电协议相关内容？还带内存读保护，防止代码被窃取*   
**架构:** ARM Cortex-M4  
**主频:** 80MHz  
**RAM:** 128KB  
**Flash:** 1024KB   
**IOs:** 65   
**价格:** 5.094$ (10ku)

## AirPods Max
<!-- https://www.ifixit.com/Teardown/AirPods+Max+Teardown/139369 -->

<img src="https://guide-images.cdn.ifixit.com/igi/TQMxmOVY6H2KCWAZ.full" width = "800" alt="AirPods Max" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/PUwJ1KuG5n344MMe.full" width = "800" alt="AirPods Max" align=center /> 
<img src="https://guide-images.cdn.ifixit.com/igi/GUJQpHTJI3PovuEf.full" width = "800" alt="AirPods Max" align=center /> 

$\color{#B82617}{●}$ [STM32L496QG](https://www.st.com/content/st_com/en/products/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus/stm32-ultra-low-power-mcus/stm32l4-series/stm32l4x6/stm32l496qg.html) ARM Cortex-M4 MCU
这是一款m4内核的mcu，带完整的dsp指令集，带usb2.0全速,音频sai,i2c,spi,adc,dac等接口。   
实现耳机功能，如dfu(usb),指示灯(pwm),陀螺仪（i2c/spi),佩戴检测(霍尔，光感，adc/i2c),电源管理(adc),音频数据处理？（mcu作解码，然后把pcm通过sai送到外挂codec。但看板上还有自家音频处理的H1,大概率是都在H1上做了）。   
**架构:** ARM Cortex-M4  
**主频:** 80MHz  
**RAM:** 320KB  
**Flash:** 1024KB   
**IOs:** 108   
**价格:** 6.389$ (10ku)

# 2.配件
## iPod 配件
在配件中意法半导体算是战略合作伙伴了，从iPod时期到现今，几乎每种外设都能看到stm32的身影。第三方申请MFi，意法半导体提供iAP库实现与iPod的通信。

<img src="./assert/1.png" width = "800" alt="ipod" align=center />
<img src="./assert/2.png" width = "800" alt="ipod" align=center />

## MagSafe charger
<img src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MHXH3_AV4_GEO_CN?wid=1000&hei=1000&fmt=jpeg&qlt=95&.v=1602981186000" width = "800" alt="MagSafe charger" align=center />
<img src="http://bbs.chongdiantou.com/data/attachment/forum/202010/23/112711n4be1v71k0q4yl1w.jpeg" width = "800" alt="MagSafe charger" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/ClWKiJNGDDIYHAb4.full" width = "800" alt="MagSafe charger" align=center />

$\color{#B82617}{●}$ [STM32F446MEY6](https://www.st.com/content/st_com/en/products/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus/stm32-high-performance-mcus/stm32f4-series/stm32f446/stm32f446me.html) ARM Cortex-M4 MCU
*估计是用于充电检测，协议等。ps：为啥用这么高主频？*  
这是一款m4内核的mcu，带完整的dsp指令集，带usb2.0全速,音频sai,i2c,spi,adc,dac,cec等接口。   
实现无线充电器相关功能，如dfu(usb)，无线握手协议等，充电监测等。  
**架构:** ARM Cortex-M4   
**主频:** 180MHz   
**RAM:** 128KB   
**Flash:** 512KB   
**IOs:** 63   
**价格:** 3.788$ (10ku)

## MagSafe 外接电池

<img src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MJWY3_AV4?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1631213468000" width = "800" alt="MagSafe charger" align=center />
<img src="https://chongdiantou-images.oss-cn-shenzhen.aliyuncs.com/wp-content/uploads/2021/07/2021072106500228.jpeg" width = "800" alt="MagSafe charger" align=center />
<img src="https://chongdiantou-images.oss-cn-shenzhen.aliyuncs.com/wp-content/uploads/2021/07/2021072106503125.jpeg" width = "800" alt="MagSafe charger" align=center />

$\color{#B82617}{●}$ [STM32L4S5ZI](https://www.st.com/en/microcontrollers-microprocessors/stm32l4s5zi.html) ARM Cortex-M4 MCU
这是一款低功耗m4内核的mcu，带完整的dsp指令集，带usb2.0全速,音频sai,i2c,spi,adc,dac,cec等接口。   
实现无线充电宝相关功能，如dfu(usb)，无线握手协议等，充电监测等。  
**架构:** ARM Cortex-M4  
**主频:** 120MHz   
**RAM:** 640KB   
**Flash:** 2048KB    
**IOs:** 110   
**价格:** 8.026$ (10ku)

## MacBook充电器
### 140W 氮化镓充电器
<img src="https://www.apple.com.cn/macbook-pro-14-and-16/images/specs/in_the_box_14_inch__cla7biqzxe6a_large.jpg" width = "800" alt="charger" align=center />

<img src="./assert/charger.jpeg" width = "800" alt="charger" align=center />

$\color{#000000}{●}$ [STM32G071KB](https://www.st.com/content/st_com/en/products/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus/stm32-mainstream-mcus/stm32g0-series/stm32g0x1/stm32g071kb.html#sample-buy) ARM Cortex-M0+ MCU   
这是一款低功耗m0+内核的mcu，带type-c电源传输控制。    
*估计实现type-c协议栈，该充电器使用是刚发布的USB PD3.1快充协议   
**架构:** ARM Cortex-M0+   
**主频:** 64MHz   
**RAM:** 36KB   
**Flash:** 128KB    
**IOs:** 30   
**价格:** 1.481$ (10ku)

## Magic Keyboard
<img src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MK2A3CH?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1628010496000" width = "800" alt="Magic Keyboard" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/ESZPpdKxIpALlZDG.full" width = "800" alt="Magic Keyboard" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/vx4VX6ufMuUfyeuO.full" width = "800" alt="Magic Keyboard" align=center />

## Magic Mouse
<img src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MK2E3?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1626468075000" width = "800" alt="Magic Mouse" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/cAHx1iXblJikFAJx.full" width = "800" alt="Magic Mouse" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/uaBIaSxnHFHPNgYZ.full" width = "800" alt="Magic Mouse" align=center />

- ## Magic TrackPad
<img src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MK2D3?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1626390718000" width = "800" alt="Magic TrackPad" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/wdZKV42BMjsZteZW.full" width = "800" alt="Magic TrackPad" align=center />   
<img src="https://guide-images.cdn.ifixit.com/igi/FO1TtwmeEaEUMfWx.full" width = "800" alt="Magic TrackPad" align=center />

## MacBook中键盘与触控板
<img src="https://d3nevzfk7ii3be.cloudfront.net/igi/eIi44fP1clanGHWQ.huge" width = "800" alt="Magic TrackPad" align=center />
<img src="https://valkyrie.cdn.ifixit.com/media/2020/03/24183030/MBA_62-1-1200x800.jpg" width = "800" alt="Magic TrackPad" align=center />

$\color{#FF912D}{●}$ $\color{#21B5DF}{●}$ $\color{#FF8E2E}{●}$ [STM32F103VB ](http://www.st.com/web/en/catalog/mmc/FM141/SC1169/SS1031/LN1565/PF164493) ARM Cortex-M3 MCU

这款mcu相信嵌入式行业的朋友都不陌生了吧，就是我们熟悉的stm32f103系列，适用产品特别广，从消费电子，电机控制、逆变器、打印机到医疗、工控plc，都有它的身影。带usb2.0全速接口,adc,dac,spi,i2c,uart等外设。    
用于实现HID设备枚举(usb),与笔记本SMC通讯(spi),按键矩阵识别(gpio),触摸轨迹识别(adc),线性马达Taptic Engine(pwm),背光(pwm/dac),电源管理(adc)。    
*键盘、鼠标、触摸板包括macbook上的键盘及触控板/iPad键盘盖都使用同一款或近似MCU,利于bom归一；鼠标跟触控板功能几乎一致，估计这几个产品代码差异不大，有机会看看能在串口读出什么数据*   

**架构:** ARM Cortex-M3  
**主频:** 72MHz   
**RAM:** 20KB
**Flash:** 128KB   
**IOs:** 80   
**价格:** 3.343$ (10ku)

## Apple Pencil
<!-- https://www.ifixit.com/Teardown/Apple+Pencil+Teardown/52955 -->

<img src="https://guide-images.cdn.ifixit.com/igi/fv6M5oMXhMfkhQ4S.full" width = "800" alt="Apple pencil 1" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/5ibhjx6plRvgpqfU.full" width = "800" alt="Apple pencil 1" align=center />
<img src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MU8F2?wid=1000&hei=1000&fmt=jpeg&qlt=95&.v=1540596407165" width = "800" alt="Apple pencil 2" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/4qFI2FOIPtUKyCWY.full" width = "800" alt="Apple pencil 1" align=center />

$\color{#B82617}{●}$ [STM32L151UCY6](http://www.st.com/web/en/resource/technical/document/datasheet/DM00048356.pdf) ARM Cortex-M3 MCU
这款mcu为低功耗型号，flash和ram带ecc校验，包含高达23个电容感应通道，带i2c,spi等接口，可实现笔迹传感器识别(cap),姿态imu(i2c/spi)。  
**架构:** ARM Cortex-M3  
**主频:** 32MHz   
**RAM:** 32KB   
**Flash:** 256KB    
**IOs:** 51   
**价格:** 2.56$ (10ku)

$\color{#F1DB36}{●}$ [STM32L052T8](https://www.st.com/en/microcontrollers-microprocessors/stm32l052t8.html) ARM Cortex-M0+ MCU
这款mcu为低功耗型号，flash和ram带ecc校验，包含高达24个电容感应通道，带i2c,spi等接口，可实现笔迹传感器识别(cap),姿态imu(i2c/spi)。
*1代2代使用，估计用于其他不需耗ram的业务*   
**架构:** ARM Cortex-M0+  
**主频:** 32MHz   
**RAM:** 8KB   
**Flash:** 64KB    
**IOs:** 29   
**价格:** 1.855$ (10ku)

$\color{#000000}{●}$ [STM32L476JGY6](https://www.st.com/content/st_com/en/products/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus/stm32-ultra-low-power-mcus/stm32l4-series/stm32l4x6/stm32l476jg.html#sample-buy) ARM Cortex-M4 MCU
这款mcu为m4内核，包含高达24个电容感应通道，在二代笔中使用，性能及内存资源更加丰富，可以加入更多复杂的算法了。  
*2代使用，看配置估计这颗用于笔迹识别相关业务*    
**架构:** ARM Cortex-M4    
**主频:** 80MHz   
**RAM:** 128KB   
**Flash:** 1024KB    
**IOs:** 55   
**价格:** 4.965$ (10ku)
**双mcu架构，主从关系？之间通信走什么接口和协议呢？spi？**

## mac
电脑上也会使用mcu，用于驱动板载外设，如电源管理，电池，键盘等功能模块等等，也就是熟称的EC，mac中称作smc，在之前的机型中使用16位的单片机，如瑞萨的`F2117LP` 16位单片机。
<img src="https://raw.githubusercontent.com/MrzhangF1ghter/asset/master/mac_smc2.png" width = "800" alt="" align=center />   
在自研soc后直接集成在其中，毕竟自己做的soc，能高度集成化，相关接口也有。
<img src="https://pics4.baidu.com/feed/4b90f603738da9776fec2de431326a1e8418e3ad.jpeg?token=6d18a8962c0f00396f918f9e4ef688e8" width = "800" alt="" align=center />
<img src="https://pics2.baidu.com/feed/4a36acaf2edda3cccd7427978a8aab06203f9264.jpeg?token=06ebc91c6fee2b93641ec720d015cd85" width = "800" alt="" align=center />

## iPad
<img src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-select-202203?wid=1765&hei=2000&fmt=jpeg&qlt=95&.v=1645665079887" width = "800" alt="Apple pencil 2" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/4iYgeXlyMgtpYTjp.full" width = "800" alt="Apple pencil 1" align=center />
<img src="https://guide-images.cdn.ifixit.com/igi/ORvTOhGIbSOC3oRq.full" width = "800" alt="Apple pencil 1" align=center />

支持触控笔的iPad均含相关模块，其包含或类似型号：  
$\color{#B82617}{●}$ [STM32L476JGY6](https://www.st.com/content/st_com/en/products/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus/stm32-ultra-low-power-mcus/stm32l4-series/stm32l4x6/stm32l476jg.html#sample-buy) ARM Cortex-M4 MCU   
这款mcu为m4内核，包含高达24个电容感应通道，在二代笔中使用，iPad这端也使用，难道iPad这边触摸屏也参与运算？或者单独只是用来识别笔是否吸上？使用同一型号只是为了bom归一，估计用于触控笔识别，协议等业务。  
**架构:** ARM Cortex-M4   
**主频:** 80MHz   
**RAM:** 128KB   
**Flash:** 1024KB    
**IOs:** 55   
**价格:** 4.965$ (10ku)

## 总结
根据上面产品拆解可看出，产品主要使用L0,L1,L4,F1,F4系列的mcu,(L系列为低功耗)，这也是在情理之中，M3,M4内核足以应付大部分功能实现及算法的性能需求，够用就好；选用的型号通常都有多个pin2pin的型号可选，缺货可更换pin2pin的型号，减少因缺料带来的影响，毕竟这些产品出货量动不动就100kk级别的。  
st产品线相关介绍:  
<img src="https://www.st.com/content/ccc/fragment/product_related/class_information/class_level_diagram/group0/ba/ee/9d/e4/b9/7a/40/4b/OBN_stm32-mcu_class_cl1734/files/OBN_stm32-mcu_class_cl1734.jpg/jcr:content/translations/en.OBN_stm32-mcu_class_cl1734.jpg" width = "800" alt="airtag" align=center />

<img src="https://www.st.com/content/ccc/fragment/product_related/series_information/series_level_diagram/group0/df/7a/28/e1/72/9c/42/7d/obn_stm32f0_series_ss1574/files/obn_stm32f0_series_ss1574.jpg/jcr:content/translations/en.obn_stm32f0_series_ss1574.jpg" width = "800" alt="airtag" align=center />

<img src="https://www.st.com/content/ccc/fragment/product_related/series_information/series_level_diagram/group0/7c/17/73/74/ba/ae/4a/12/obn_stm32f1_series_ss1031/files/obn_stm32f1_series_ss1031.jpg/jcr:content/translations/en.obn_stm32f1_series_ss1031.jpg" width = "800" alt="airtag" align=center />

<img src="https://www.st.com/content/ccc/fragment/product_related/series_information/series_level_diagram/group0/6e/ab/f8/ba/9c/9a/4d/37/obn_stm32f4_series_ss1577/files/obn_stm32f4_series_ss1577.jpg/jcr:content/translations/en.obn_stm32f4_series_ss1577.jpg" width = "800" alt="airtag" align=center />


## 彩蛋
在苹果招聘网站，发现上海深圳也有嵌入式研发岗位，广州就无缘了，知乎上也有相关面经。如果能进入像苹果这样的行业天花板，无憾。
<img src="https://raw.githubusercontent.com/MrzhangF1ghter/asset/master/jobs.png" width = "800" alt="" align=center />

<img src="https://raw.githubusercontent.com/MrzhangF1ghter/asset/master/jobs2.png" width = "800" alt="" align=center />

在最近发布的AirTag定位标签中，发现国产芯片：
<img src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/airtag-double-select-202104?wid=445&hei=370&fmt=jpeg&qlt=95&.v=1617761672000" width = "800" alt="airtag" align=center />
<img src="https://valkyrie.cdn.ifixit.com/media/2021/05/03133816/AirTags_33-3-up-1536x864.jpg" width = "800" alt="airtag" align=center />
<img src="./assert/airtag1.jpg" width = "800" alt="airtag" align=center />

$\color{#FFD443}{●}$ [GD25LE32D](https://www.gigadevice.com/flash-memory/gd25le32d/)非易失闪存 32Mb
用于数据存储

在苹果公布的供应链清单中，的确找到了兆易创新
<img src="./assert/suppylist.png" width = "800" alt="airtag" align=center />

兆易创新也有做stm32的兼容产品--GD32 不知道未来有没有可能被苹果采用呢？


