From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 15 Jan 2016 20:16:14 +0100
Message-ID: <14EFA4A2-C691-41C7-B89F-38C14081DE77@goldelico.com>
References: <20150511013540.5709.93626.stgit@notabene.brown> <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com> <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160113191542.GA12086@leverpostej> <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com> <20160115161229.GN3262@leverpostej>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160115161229.GN3262@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


Am 15.01.2016 um 17:12 schrieb Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>:

> On Fri, Jan 15, 2016 at 04:05:45PM +0100, H. Nikolaus Schaller wrote:
>> Hi Mark,
>> 
>> Am 15.01.2016 um 12:01 schrieb Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>:
>> 
>>> On Fri, Jan 15, 2016 at 10:34:51AM +0100, H. Nikolaus Schaller wrote:
>>>> Hi Mark,
>>>> 
>>>> Am 13.01.2016 um 20:15 schrieb Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>:
>>>> 
>>>>> On Tue, Jan 12, 2016 at 02:28:00PM +0100, H. Nikolaus Schaller wrote:
>>>>>> There is one point still to be solved: the exact style of the DT bindings.
>>>>>> 
>>>>>> We have an idea how a driver can implement two different styles (child node AND phandle)
>>>>>> so that it is up to the DTS developer to use the one that best fits into the existing DTS.
>>>>> 
>>>>> From my perspective as a binding maintainer, and as I stated before, the
>>>>> child node approach made the most sense and was most consistent with the
>>>> 
>>>>> way we handle other devices.
>>>> 
>>>> I simply don't see that this is the most common way other devices are handled.
>>>> 
>>>> I find many counter-examples which use phandles:
>>>> * gpios
>>>> * regulators
>>>> * iio channels used by other drivers (e.g. iio-hwmon)
>>>> * phy devices
>>>> * timers
>>>> * pwms
>>>> * interrupts
>>>> * dma
>>> 
>>> As was previously described to you, in these cases phandles are used
>>> when these are _resources_ used by another device, not for the main
>>> programmer-visible interface to the device.
>> 
>> Ah, I think I finally begin to understand the rule you are following:
>> 
>> 	If a device's data interface can be seen in user space, this interface
>> 	is sort of a "main interface" and must be modelled in DT by a
>> 	parent-child relationship.
> 
> No, you have misunderstood. This has _nothing_ to do with userspace.

Obviously.

> 
> This has everything to do with the "programmer's interface" as you would
> find documented in a TRM -- effectively where a driver would communicate
> with the device (e.g. MMIO/SPI/I2C registers).

What does that have to do with DT descriptions?

I think we agree that as long as the driver can acquire a handle to the interface
chip (UART, I2C controller etc.) through some driver API, it can communicate
(and encapsulate) everything described by the TRM.

I may have a special case that my devices have no programming interface.

GPS simply starts to send NMEA records (ASCII) and Bluetooth protocol is
a user-space daemon.

So the driver does not want to touch the data. Or generate/consume it. Or write
commands (although it could, since it knows the UART driver instance).

For a typical I2C driver this is different. It reads/writes specific registers by telling
the I2C controller (master / parent) to do that on an address specified by the
child DT node.

> 
> [...]
> 
>> Now I also think I better understand what you meant by "main interface"
>> a while ago.
>> 
>> For me, when looking into a chip data sheet, the main interface is a sometimes
>> arbitrary. Or when viewing it through device driver implementors glasses
>> I may end up with a different main interface.
>> 
>> From the hardware schematics, I can't read which interface is "main". I can
>> only read which components and signals are connected. So the information
>> what is "main" must come from somewhere else, but not the hardware.
>> 
>> You appear to have a definition based on Linux user space interfaces
>> which is distinct from mine and at least explains why the discussion takes
>> so long and we don't come to a common view.
> 
> This is nothing to do with userspace.
> 
> Admittedly, on a device which has multiple slave interfaces, "main" is
> arbitrary. If I've followed correctly, that's not the cae here.

No, we have a single data path and a single power control line.

So the power control line is the "main" interface (described in the TRM of the chip).

And the driver just needs to know that data is coming out of the chip. It does not
need to know which data.

As said, the purpose of this driver is to control power of the chip by monitoring data
stream, controlling the power control input through a gpio and not to modify or use
the data channel like it would be for SPI or I2C.

For example for a touch screen controller the driver sends commands over I2C
and receives position data. This is translated into input events. Power on/off
is usually another I2C command.

It is a completely different situation and supports my view that devices
connected to UARTs should not necessarily be modeled like I2C and SPI
slaves (where there are explicit master / slave roles).

> 
>>> Conceptually, A UART slave is far closer to SPI or I2C, where the slave
>>> is represented as a sub-node.
>> 
>> Only if you have the goal to describe the data/command path ("main interface")
>> in DT.
> 
> This is the way devices are described in DT -- walking from the root to
> a leaf you follow the path from the CPU to a slave interface.

Ok, that is a new piece of DT design guidelines.

But again which path do you exactly mean? User-Data path? Address path?
Command path? Electrical paths? Power enable path? They may not be the same.

> 
> Some things don't have slave interfaces (e.g. fixed-clocks), but still
> need to be referred to, so those still get placed in the DT. There are
> arguments to be had w.r.t. their placement, but that's another
> discussion entirely.
> 
>> I mentioned it several times: USB-PHYs use the phandle approach to attach
>> a single PHY to the usb controller, although there is usually some ULPI-"bus"
>> interface (12 parallel wires) between. And the PHY is clearly more "slave" than
>> the usb controller, isn't it?
> 
> Some PHYs have additional interfaces, so their CPU-visible slave
> interface is described. This necessitates the phandle reference in the
> general case.

> 
>> But with phandle, the usb controller is a _resource_ for the PHY. So would
>> you say this is wrong?
> 
> Not entirely.
> 
>> This is the design pattern (for DT and drivers) we have copied for our tty-slave
>> proposal.
> 
> We have plenty of other ways of describing relationships today. The
> existence of one style (and its continued support for ABI reasons) does
> not mean that it's a style we want to proliferate.

Is there a description about all these style rules? It is really difficult to get them
written down by such lengthy discussions.

> 
>> 
>>> I wasn't aware of any instances of timers being referred to by phandle
>>> by other devices -- that seems distinctly odd. Where do you see that
>>> happening.
>> 
>> I found it in connection with dmtimer / pwm on OMAP3. May be a rare exception
>> and that may be a special type of OMAP timers.
> 
> I took a quick look and couldn't spot where that happened. I take it
> the timer was a "ti,omap3430-timer"? Or have I misunderstood?
> 
> What referenced it by phandle? In which dt?

Ah, it is "ti,timer" and not general "timer" introduced recently:

<https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt>

My flaw.

> 
>>>> * mcbsp (see e.g. http://lxr.free-electrons.com/source/arch/arm/boot/dts/omap3-n900.dts#L127)
>>> 
>>> Subsystem type bindings are more of a special case, and regardless the
>>> components have nodes in the relevant portions of the DT.
>> 
>>> 
>>>> * mmc-pwr-seq-simple (which does not even describe a physical piece of hardware)
>>> 
>>> If this is so different, how is it relevant?
>> 
>> It could as well be subnode of the affected mmc interface or mmc-slave, but obviously it
>> isn't grouped there, and uses a phandle to refer to its &mmc "master".
>> 
>> Its function is quite similar what we need for our GPS chip: control power sequences
>> of a remote device.
> 
> That may fit your one particular use-case, but for UART slaves generally
> we should have a kernel driver (which can do more than a trivial
> power-up), at which point you need a node, and the separate sequence
> node is useless.

What we need is similar, the solution is of course not exactly the same.

But why does the DT node have to move (except adding properties)
if the kernel driver does more complex things? It already needs to know
the relationship to the remote device for trivial tasks.

> 
>>>> All of them define the provider in one node. And refer to it by a phandle in another node
>>>> where they are used.
>>>> 
>>>> So I see a lot of provider-consumer relationships modeled by phandles but not by child nodes.
>>> 
>>> I agree that provider-consumer type relationships are typically
>>> described in this manner.
>> 
>> Ok.
>> 
>>> 
>>> However, master-slave relationships are not.
>> 
>> It looks as if you see a significant difference between provider-consumer and master-slave
>> relationship which I was not sure of which applies to what and where you make the distinction.
>> 
>> By the way: what exactly makes the UART on the SoC side "master" and the UART on the connected
>> device a "slave" (except the user-space view)?
> 
> Typically a "slave" accepts commands, and won't send commands of its own
> accord. This case is admittedly fuzzier given that a UART slave could
> send a stream of bytes at any point, but that's data.

It could not only, it does in our case. Which is the main reason why we need a dedicated
driver.

And there are no standardized UART slave commands. Well, GSM07.07 to some extent.
But that is a protocol handled by user space daemons. And commands are completely
mixed with data so that there are escape characters etc.

> 
> The distinction is really that the UART slave won't control other
> devices -- you can think of the entire path of the CPU to the UART as
> the master.

What if there is a plain old terminal device hard wired to the UART?

Here, I would see the user typing commands as "the master" :)
And the data flow is from device to UART to CPU.

Or if the device is an MCU that is connected to a getty login port?

So IMHO we have introduced much of the problem by thinking in "UART slave" categories.

UART seems indeed to be a different beast, because it is more a "partner" thing.

More like a subsystem (maybe audio/sound?) connected to the main CPU by means
of the UART.

> 
>> UARTs per se have no master-slave roles and are symmetrical (contrary to SPI and I2C where it
>> is well defined). Rather, both are formally DTE connected by a null-modem.
>> 
>> This is another substantial difference between UART and I2C/SPI besides addressability.
> 
> Sure, except for the fact that the device attached to the UART logically
> follows a "slave" role. The rest of the system would be usable without
> it, and it assert no control over anything else.

Ok, if you take this view, it is indeed sort of a subordinate. Nothing happens if the
user does not press the power-on button :)

Also to be considered is that the UART is also unusable without the device being
powered on or a partner device being connected.

But we are back to discuss solutions and details and not requirements which makes
this a non-ending story because it is more confusing than bringing it to the key factors.

And please give me some links where all these DT styles and rules are written down.
It would make it easier to develop something that fits, without lengthy discussions.

Or to separately discuss rules.

And, may I repeat my question what I can do to convince you to accept a practical
solution? What could go wrong if you would accept the phandle approach? Which
known UART topic would it not solve or make impossible to solve?

BR and thanks,
Nikolaus


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
