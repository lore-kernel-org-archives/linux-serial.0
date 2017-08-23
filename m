From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3] serial: 8250_of: Add basic PM runtime support
Date: Wed, 23 Aug 2017 12:04:58 +0530
Message-ID: <f01c2644-3162-978e-9f8b-6a5973f08079@ti.com>
References: <20170816205536.19634-1-fcooper@ti.com>
 <1e3ad33d-882e-d4a0-6295-ac06397b11d2@ti.com>
 <1f92eeec-d1d4-1f84-299a-ddb5160869e2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1f92eeec-d1d4-1f84-299a-ddb5160869e2@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com, joel@jms.id.au, khoroshilov@ispras.ru, arnd@arndb.de, robert.jarzmik@free.fr, tthayer@opensource.altera.com
Cc: Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-serial@vger.kernel.org

On Monday 21 August 2017 10:29 PM, Franklin S Cooper Jr wrote:
> 
> 
> On 08/21/2017 07:20 AM, Sekhar Nori wrote:
>> On Thursday 17 August 2017 02:25 AM, Franklin S Cooper Jr wrote:
>>> 66AK2G UART instances are not apart of the ALWAYS_ON power domain.
>>> Therefore, pm_runtime calls must be made to properly insure the appropriate
>>> power domains needed by UART are on. Keep legacy clk api calls since other
>>> users of this driver may not support PM runtime.
> 
> There are a significant amount of users across a wide variety of
> architectures and boards that I have no means to properly test to insure
> I'm avoiding regressions. My current approach which I've seen other
> drivers in the past use when in similar situations allows things to work
> without regressions.

Since the users are all device-tree users, my hope is they can be
tracked by looking at the DT files and the maintainers be copied on this
patch to make sure nothing breaks for them. I understand its not a
trivial list, but its finite :)

>>
>> Do we really have users like that? And even if there are, cant they use
>> PM clock handling support available in drivers/base/power/clock_ops.c ?
> 
> I don't see any current defconfig that enables CONFIG_PM_CLK and only a

Thats because its a non-user-selectable def_bool. Most configs should
have it enabled after the 'make config' step.

> handful of instances where functions from clock_ops.c are actually used.
> I don't quite understand what your suggestion is but in general I'm
> concerned since any approach to move everyone to different apis is
> rather risky especially for a critical driver.
> 
> If I'm missing your point please let me know.

I do agree we dont want to break anyone. But at the same time, this
patch redundantly enables/disables clock for most known (and possible
future) users without no clear indication of who benefits from such
redundancy.

If we ignore this now, the problem will only get worse as time passes. I
suggest biting the bullet now, attempt to reach-out as many affected
parties as possible but switch to pm_runtime once and for all.

> 
>>
>> The clock enable support itself was added pretty "recently" - about 5
>> years back with 0bbeb3c3e84b ("of serial port driver - add
>> clk_get_rate() support"). So I doubt any really legacy platforms relied
>> on clock support being there. It was added by Murali, I assume for
>> Keystone devices. Keystone devices can work with runtime PM using the PM
>> clock support pointed to above.
> 
> You might be right but I can't be confident that it is indeed the case.
> But its possible that at some point people will start having problems if
> they try to use this driver for other UART instances. The currently
> could not be aware of an issue because of the bootloader powering things
> for them or even that different UART instances could be apart of a non
> always on power domain.

I dont think you got my point there. I have no disagreement that
pm_runtime support is needed. In fact, it should have been that way when
clock enable/disable was added. But thats history now.

>> Perhaps linux-arm-kernel list should be copied on this submission too,
>> since most users of this driver are likely to be there on that list.
>>
> 
> Looking at configs that enable CONFIG_SERIAL_OF_PLATFORM I see quite a
> bit of users from different arch. ARM, OpenRISC, MicroBlaze, Nios2,
> PowerPC, MIPS, Xtensa and Arc.>
> Looking at dts that enable some of the compatible it is still a
> combination of quite a bit of architectures.

Right, I do think there are quite a few users. But they should still be
reachable and provide testing inputs for the change.

> The current approach I've taken should be safe for all users of this
> driver which. I have no issue going another approach as long as its
> understood that I'm fairly limited in what I can test when you take into
> account the large number of users of this driver.

Understood that you are limited by hardware you possess. But we can
probably reach out to as many folks affected by this as possible so we
get a fair chance at doing the "right thing" without breaking anyone.

Thanks,
Sekhar
