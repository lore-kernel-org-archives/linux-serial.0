From: Mayank Rana <mrana@codeaurora.org>
Subject: Re: [PATCH] serial: msm_serial_hs: Add MSM high speed UART driver
Date: Mon, 13 Dec 2010 12:38:20 +0530
Message-ID: <4D05C664.3030605@codeaurora.org>
References: <4CEE028B.1040701@codeaurora.org> <20101125170113.GB17686@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:47452 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab0LMHIa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Dec 2010 02:08:30 -0500
In-Reply-To: <20101125170113.GB17686@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, npelly@google.com

On 11/25/2010 10:31 PM, Greg KH wrote:
> On Thu, Nov 25, 2010 at 12:00:35PM +0530, Mayank Rana wrote:
>>   This driver supports UART-DM HW on MSM platforms. It uses the on
>> chip DMA to drive data transfers and has optional support for UART
>> power management independent of Linux suspend/resume and wakeup
>> from Rx.
>>
>> The driver was originally developed by Google. It is functionally
>> equivalent to the version available at:
>> http://android.git.kernel.org/?p=kernel/experimental.git
>> the differences being:
>> 1) Remove wakelocks and change unsupported DMA API.
>> 2) Replace clock selection register codes by macros.
>> 3) Fix checkpatch errors and add inline documentation.
>> 4) Add runtime PM hooks for active power state transitions.
>>
>> CC: Nick Pelly<npelly@google.com>
>> Signed-off-by: Sankalp Bose<sankalpb@codeaurora.org>
>> Signed-off-by: Mayank Rana<mrana@codeaurora.org>
>> ---
>>   drivers/serial/Kconfig               |   12 +
>>   drivers/serial/Makefile              |    1 +
>>   drivers/serial/msm_serial_hs.c       | 1680
>> ++++++++++++++++++++++++++++++++++
>
> Your patch is line-wrapped and can not be applid.
>
> Please fix your email client and try again.
>
>
>>   drivers/serial/msm_serial_hs_hwreg.h |  167 ++++
>>   include/linux/msm_serial_hs.h        |   49 +
>>   5 files changed, 1909 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/serial/msm_serial_hs.c
>>   create mode 100644 drivers/serial/msm_serial_hs_hwreg.h
>>   create mode 100644 include/linux/msm_serial_hs.h
>>
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index aff9dcd..0a935ee 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -1381,6 +1381,18 @@ config SERIAL_MSM_CONSOLE
>>       depends on SERIAL_MSM=y
>>       select SERIAL_CORE_CONSOLE
>>
>> +config SERIAL_MSM_HS
>> +    tristate "MSM UART High Speed: Serial Driver"
>> +    depends on ARM&&  ARCH_MSM
>> +    select SERIAL_CORE
>> +    help
>> +      If you have a machine based on MSM family of SoCs, you
>> +      can enable its onboard high speed serial port by enabling
>> +      this option.
>> +
>> +      Choose M here to compile it as a module. The module will be
>> +      called msm_serial_hs.
>> +
>>   config SERIAL_NETX
>>       tristate "NetX serial port support"
>>       depends on ARM&&  ARCH_NETX
>> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
>> index c570576..667de45 100644
>> --- a/drivers/serial/Makefile
>> +++ b/drivers/serial/Makefile
>> @@ -76,6 +76,7 @@ obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
>>   obj-$(CONFIG_SERIAL_ATMEL) += atmel_serial.o
>>   obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
>>   obj-$(CONFIG_SERIAL_MSM) += msm_serial.o
>> +obj-$(CONFIG_SERIAL_MSM_HS) += msm_serial_hs.o
>>   obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
>>   obj-$(CONFIG_SERIAL_OF_PLATFORM) += of_serial.o
>>   obj-$(CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL) += nwpserial.o
>> diff --git a/drivers/serial/msm_serial_hs.c
>> b/drivers/serial/msm_serial_hs.c
>> new file mode 100644
>> index 0000000..4fdc70e
>> --- /dev/null
>> +++ b/drivers/serial/msm_serial_hs.c
>> @@ -0,0 +1,1680 @@
>> +/* drivers/serial/msm_serial_hs.c
>> + *
>> + * MSM 7k/8k High speed uart driver
>> + *
>> + * Copyright (c) 2007-2010, Code Aurora Forum. All rights reserved.
>> + * Copyright (c) 2008 Google Inc.
>> + * Modified: Nick Pelly<npelly@google.com>
>
> I don't understand, Nick originally wrote it?  Or modified your version?
>
>> + *
>> + * All source code in this file is licensed under the following license
>> + * except where indicated.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> + * See the GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, you can find it at http://www.fsf.org
>> + */
>> +
>> +/*
>> + * MSM 7k/8k High speed uart driver
>> + *
>> + * Has optional support for uart power management independent of linux
>> + * suspend/resume:
>> + *
>> + * RX wakeup.
>> + * UART wakeup can be triggered by RX activity (using a wakeup GPIO on the
>> + * UART RX pin). This should only be used if there is not a wakeup
>> + * GPIO on the UART CTS, and the first RX byte is known (for example, with
>> the
>> + * Bluetooth Texas Instruments HCILL protocol), since the first RX byte
>> will
>> + * always be lost. RTS will be asserted even while the UART is off in this
>> mode
>> + * of operation. See msm_serial_hs_platform_data.rx_wakeup_irq.
>> + */
>> +
>> +#include<linux/module.h>
>> +
>> +#include<linux/serial.h>
>> +#include<linux/serial_core.h>
>> +#include<linux/slab.h>
>> +#include<linux/init.h>
>> +#include<linux/interrupt.h>
>> +#include<linux/irq.h>
>> +#include<linux/io.h>
>> +#include<linux/ioport.h>
>> +#include<linux/kernel.h>
>> +#include<linux/timer.h>
>> +#include<linux/clk.h>
>> +#include<linux/platform_device.h>
>> +#include<linux/pm_runtime.h>
>> +#include<linux/dma-mapping.h>
>> +#include<linux/dmapool.h>
>> +#include<linux/wait.h>
>> +#include<linux/workqueue.h>
>> +
>> +#include<asm/atomic.h>
>> +#include<asm/irq.h>
>> +#include<asm/system.h>
>> +
>> +#include<mach/hardware.h>
>> +#include<mach/dma.h>
>> +#include<linux/msm_serial_hs.h>
>
> Please put this file in include/platform_data/ instead.
Greg,

Thanks for reviewing the patch.
Is there any particular reason not allowing msm_serial_hs.h as part of 
include/linux and need of moving same into as part of 
include/platform_data? I am seeing multiple driver doing same.
Can you please suggest on this ?

Regards,
_-_Mayank Rana_-_

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
