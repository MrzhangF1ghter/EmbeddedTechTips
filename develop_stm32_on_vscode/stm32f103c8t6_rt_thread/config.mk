BSP_ROOT ?= C:/Users/zhang/Desktop/develop/Tech/develop_stm32_on_vscode/stm32f103c8t6_rt_thread
RTT_ROOT ?= C:/Users/zhang/Desktop/develop/Tech/develop_stm32_on_vscode/stm32f103c8t6_rt_thread/rt-thread

CROSS_COMPILE ?=C:\\Users\\zhang\\Desktop\\develop\\env_released_1.1.2\\env\\tools\\gnu_gcc\\arm_gcc\\mingw\\bin\\arm-none-eabi-

CFLAGS := -mcpu=cortex-m3 -mthumb -ffunction-sections -fdata-sections -Dgcc -O0 -gdwarf-2 -g
AFLAGS := -c -mcpu=cortex-m3 -mthumb -ffunction-sections -fdata-sections -x assembler-with-cpp -Wa,-mimplicit-it=thumb  -gdwarf-2
LFLAGS := -mcpu=cortex-m3 -mthumb -ffunction-sections -fdata-sections -Wl,--gc-sections,-Map=rt-thread.map,-cref,-u,Reset_Handler -T board/linker_scripts/link.lds
CXXFLAGS := -mcpu=cortex-m3 -mthumb -ffunction-sections -fdata-sections -Dgcc -O0 -gdwarf-2 -g

CPPPATHS :=-I$(BSP_ROOT) \
	-I$(BSP_ROOT)\applications \
	-I$(BSP_ROOT)\board \
	-I$(BSP_ROOT)\board\CubeMX_Config\Inc \
	-I$(BSP_ROOT)\libraries\HAL_Drivers \
	-I$(BSP_ROOT)\libraries\HAL_Drivers\config \
	-I$(BSP_ROOT)\libraries\STM32F1xx_HAL\CMSIS\Device\ST\STM32F1xx\Include \
	-I$(BSP_ROOT)\libraries\STM32F1xx_HAL\CMSIS\Include \
	-I$(BSP_ROOT)\libraries\STM32F1xx_HAL\STM32F1xx_HAL_Driver\Inc \
	-I$(RTT_ROOT)\components\drivers\include \
	-I$(RTT_ROOT)\components\finsh \
	-I$(RTT_ROOT)\include \
	-I$(RTT_ROOT)\libcpu\arm\common \
	-I$(RTT_ROOT)\libcpu\arm\cortex-m3 

DEFINES := -DHAVE_CCONFIG_H -DSTM32F103xB -DUSE_HAL_DRIVER -D__RTTHREAD__
