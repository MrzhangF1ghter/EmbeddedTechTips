/*
 * Copyright (c) 2006-2018, RT-Thread Development Team
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Change Logs:
 * Date           Author       Notes
 * 2018-11-06     SummerGift   first version
 */

#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>

/* defined the LED4 pin: PB1 */
#define LED4_PIN    GET_PIN(B, 1)

int main(void)
{
    int count = 0;
    /* set LED0 pin mode to output */
    rt_pin_mode(LED4_PIN, PIN_MODE_OUTPUT);

    while (1)
    {
        rt_pin_write(LED4_PIN, PIN_HIGH);
        rt_thread_mdelay(500);
        rt_pin_write(LED4_PIN, PIN_LOW);
        rt_thread_mdelay(500);
        count++;
    }

    return RT_EOK;
}
