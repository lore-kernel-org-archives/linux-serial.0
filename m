From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: MFD device driver on top of UART/RS232
Date: Tue, 17 Nov 2015 15:16:50 +0100
Message-ID: <9142F329-3D2D-4B4F-9C18-91CC5B6E3923@goldelico.com>
References: <564A035A.3050108@gmail.com> <20151117075330.GJ8526@pengutronix.de> <564B2166.2030209@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <564B2166.2030209@gmail.com>
Sender: linux-embedded-owner@vger.kernel.org
To: Andrey Vostrikov <av.linux.dev@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-serial@vger.kernel.org, linux-embedded@vger.kernel.org, NeilBrown <neil@brown.name>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Hi Andrey,

Am 17.11.2015 um 13:45 schrieb Andrey Vostrikov <av.linux.dev@gmail.com>:

> Hi Sascha,
> 
> Sascha Hauer wrote:
>> Hi Andrey,
>> 
>> +Cc NeilBrown <neil@brown.name>
>> 
>> On Mon, Nov 16, 2015 at 07:24:58PM +0300, Andrey Vostrikov wrote:
>>> Hi,
>>> 
>>> I have an embedded system with microcontroller connected via
>>> UART/RS232 port. This microcontroller implements several low-level
>>> functions that need to be exposed as device drivers in other
>>> subsystems (watchdog, LEDs, HWMON, firmware read/write).
>>> 
>>> I checked many drivers implemented in the kernel, searched through
>>> mail list archives and it looks like there are three different ways to
>>> solve this task:
>>> A) most of the devices that are connected using UART have user space
>>> program that configures and manages it (either directly or with help
>>> of dedicated line discipline, SLIP, SL-CAN, etc)
>>> B) serio - mostly used for input devices
>>> C) direct use of UART port taking control from serial_core.
>>> 
>>> The best match I have found so far is MFD driver for Atmel
>>> Microcontroller on iPaq h3xxx (drivers/mfd/ipaq-micro.c) that follows
>>> concept "C)"
>> 
>> There's also D) TTY slave device support: https://lkml.org/lkml/2015/3/18/40
>> 
>> Unfortunately this hasn't made it to mainline yet and it seems the
>> parties lost interest after some lengthy discussion of device tree phandles
>> vs. subnodes, but I think this is what you're looking for.
> 
> Thank you for pointing out to another option. Looks like it was developed a little further and was submitted as patch by "H. Nikolaus Schaller",
> https://lkml.org/lkml/2015/10/16/729
> 
> But I see no further traces of it.

Well, I was still missing a technical discussion of our proposals and a real
evaluation of the benefits of subnode vs. phandle. In my view it was very
ideologic and it was not an exchange of arguments.

> Cc'ed Nikolaus, may be he could comment on state of UART slave patch.

And we are currently working on a compromise. So that the DT developer can
simply choose if he prefers subnode or phandle. And the driver is capable of
handling both. This is not yet finished, so we have not yet submitted an update.

BR,
Nikolaus