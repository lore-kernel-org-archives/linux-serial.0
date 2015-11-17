From: Andrey Vostrikov <av.linux.dev@gmail.com>
Subject: Re: MFD device driver on top of UART/RS232
Date: Tue, 17 Nov 2015 15:45:26 +0300
Message-ID: <564B2166.2030209@gmail.com>
References: <564A035A.3050108@gmail.com>
 <20151117075330.GJ8526@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20151117075330.GJ8526@pengutronix.de>
Sender: linux-embedded-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-embedded@vger.kernel.org, NeilBrown <neil@brown.name>, hns@goldelico.com
List-Id: linux-serial@vger.kernel.org

Hi Sascha,

Sascha Hauer wrote:
> Hi Andrey,
>
> +Cc NeilBrown <neil@brown.name>
>
> On Mon, Nov 16, 2015 at 07:24:58PM +0300, Andrey Vostrikov wrote:
>> Hi,
>>
>> I have an embedded system with microcontroller connected via
>> UART/RS232 port. This microcontroller implements several low-level
>> functions that need to be exposed as device drivers in other
>> subsystems (watchdog, LEDs, HWMON, firmware read/write).
>>
>> I checked many drivers implemented in the kernel, searched through
>> mail list archives and it looks like there are three different ways to
>> solve this task:
>> A) most of the devices that are connected using UART have user space
>> program that configures and manages it (either directly or with help
>> of dedicated line discipline, SLIP, SL-CAN, etc)
>> B) serio - mostly used for input devices
>> C) direct use of UART port taking control from serial_core.
>>
>> The best match I have found so far is MFD driver for Atmel
>> Microcontroller on iPaq h3xxx (drivers/mfd/ipaq-micro.c) that follows
>> concept "C)"
>
> There's also D) TTY slave device support: https://lkml.org/lkml/2015/3/18/40
>
> Unfortunately this hasn't made it to mainline yet and it seems the
> parties lost interest after some lengthy discussion of device tree phandles
> vs. subnodes, but I think this is what you're looking for.

Thank you for pointing out to another option. Looks like it was developed a little further and was submitted as patch by "H. Nikolaus Schaller",
https://lkml.org/lkml/2015/10/16/729

But I see no further traces of it.
Cc'ed Nikolaus, may be he could comment on state of UART slave patch.


Best regards,
Andrey

>
> Sascha
>
