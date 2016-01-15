From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 15 Jan 2016 22:24:26 +0100
Message-ID: <A83214D4-9965-415B-9EBF-C4A722229735@goldelico.com>
References: <20150511013540.5709.93626.stgit@notabene.brown> <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com> <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160113191542.GA12086@leverpostej> <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com> <569913A1.80606@cogentembedded.com> <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com> <56992959.2020204@hurleysoftware.com> <572D2BBD-1CB4-4048-87AE-23DE16AC2AD4@goldelico.com> <56992FCB.3030101@hurleysoftware.com> <69FAE2F5-25D1-4E5E-9FED-FC86773269D6@goldelico.com> <5699471E.3010702@hurleysoftware.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5699471E.3010702@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net, NeilBrown <neil@brown.name>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

Am 15.01.2016 um 20:23 schrieb Peter Hurley <peter@hurleysoftware.com>:

> On 01/15/2016 09:58 AM, H. Nikolaus Schaller wrote:
>> 
>> Am 15.01.2016 um 18:43 schrieb Peter Hurley <peter@hurleysoftware.com>:
>> 
>>> On 01/15/2016 09:32 AM, H. Nikolaus Schaller wrote:
>>>> Hi Peter,
>>>> 
>>>> Am 15.01.2016 um 18:16 schrieb Peter Hurley <peter@hurleysoftware.com>:
>>>> 
>>>>> On 01/15/2016 08:08 AM, H. Nikolaus Schaller wrote:
>>>>>> Hi Andrey,
>>>>>> ah that is fine to learn about another project that needs some solution (however it will look like).
>>>>>> 
>>>>>> Am 15.01.2016 um 16:43 schrieb Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>:
>>>>>> 
>>>>>>> Hi Nikolaus,
>>>>>>> 
>>>>>>> H. Nikolaus Schaller wrote:
>>>>>>>> And IMHO nobody has described that he/she needs a solution to model the*data*  relationship
>>>>>>>> for devices connected behind a tty port.
>>>>>>> 
>>>>>>> I am not sure if my case fits *data* relationship or not in this case. Some time ago I asked about state of your patches.
>>>>>>> In my case I have supervising microcontroller unit (MCU) that is connected to one of UARTs on SoC.
>>>>>>> 
>>>>>>> This MCU implements several functions that will be implemented as MFD driver:
>>>>>>> - watchdog and system reset
>>>>>>> - NVMEM EEPROM
>>>>>>> - HWMON sensors
>>>>>>> - Input/power button
>>>>>>> - and similar low level functions
>>>>>>> 
>>>>>>> So in my case DTS binding looks like:
>>>>>>> 
>>>>>>> &uart3 {
>>>>>>> 	mcu {
>>>>>>> 		line-speed = <baud rate>;
>>>>>>> 		watchdog {
>>>>>>> 			timeout = <ms>;
>>>>>>> 			...other params...
>>>>>>> 		};
>>>>>>> 		eeprom {
>>>>>>> 			#address-cells
>>>>>>> 			#size-cells
>>>>>>> 			cell1 : cell@1 {
>>>>>>> 				reg = <1 2>;
>>>>>>> 			};
>>>>>>> 			cell2 : cell@2 {
>>>>>>> 				reg = <2 1>;
>>>>>>> 			};
>>>>>>> 		};
>>>>>>> 		hwmon {
>>>>>>> 			sensors-list = "voltage", "current", etc...;
>>>>>>> 		}
>>>>>>> 	}
>>>>>>> }
>>>>>> 
>>>>>> With my proposal it would just become
>>>>>> 
>>>>>> / {
>>>>>> 	themcu: mcu {
>>>>>> 		uart = <&uart3>;
>>>>>> 		line-speed = <baud rate>;
>>>>>> 		watchdog {
>>>>>> 			timeout = <ms>;
>>>>>> 			...other params...
>>>>>> 		};
>>>>>> 		eeprom {
>>>>>> 			#address-cells
>>>>>> 			#size-cells
>>>>>> 			cell1 : cell@1 {
>>>>>> 				reg = <1 2>;
>>>>>> 			};
>>>>>> 			cell2 : cell@2 {
>>>>>> 				reg = <2 1>;
>>>>>> 			};
>>>>>> 		};
>>>>>> 		hwmon {
>>>>>> 			sensors-list = "voltage", "current", etc...;
>>>>>> 		}
>>>>>> 	}
>>>>>> };
>>>>>> 
>>>>>> Which is almost the same. Except that it allows to move your mcu node whereever you like and easily allows to change the interface to connect to a different device by
>>>>>> 
>>>>>> &themcu {
>>>>>> 	uart = <&uart1>;
>>>>>> };
>>>>>> 
>>>>>> With the subnode style you would need some tricks to get the driver instance for uart3 disabled, although it is possible (everything is possible - just easier or more difficult).
>>>>>> 
>>>>>>> 
>>>>>>> This MCU receives commands and notifies MFD driver about events via UART protocol.
>>>>>>> It looks like not really a slave though, more like a partnership from data flow point of view.
>>>>>> 
>>>>>> Yes!. That is why I started to question the term "slave".
>>>>>> 
>>>>>> And yes, this is the second use case I am aware of: a device that just *uses" the UART to do its works and there is no /dev/tty involved.
>>>>>> 
>>>>>>> 
>>>>>>> There is no user space code involved in this case as whole interactions are between drivers (just a kick to open /dev/ttyXXX using sys_open, as there is no way to start probe on uart_slave bus and assign line discipline).
>>>>>> 
>>>>>> Exactly this is what we want to provide as API for the drivers by our patches to serial-core.c. 
>>>>>> 
>>>>>> We want to allow such a "partner" device to take a line-speed property e.g. from its DT node (or a 9600 constant as for our GPS chip) and ask the UART driver to set the required clocks. Or to get the driver notified that someone has opened the /dev/tty* etc. So make it possible to use some UART from another driver.
>>>>>> 
>>>>>> In the long run it should be possible to use the UART even if there is no /dev/tty client or interface in user-space but that is something not perfectly working (there is some initialization race in the tty/serial subsystem we have not yet understood).
>>>>>> 
>>>>>> As you see, I have a driver-specific standpoint (and not coming from user space).
>>>>>> 
>>>>>> Thanks for sharing this example.
>>>>> 
>>>>> 
>>>>> I'd like to see the exemplar slave driver be something more complicated than
>>>>> trivial on-off, before hacking in junk into the serial core.
>>>>> 
>>>>> As it stands, this gps could be supported on any uart driver that implements
>>>>> mctrl gpios (which is trivial with the serial mctrl gpio helpers).
>>>> 
>>>> in the GPS case basic mctrl is not enough because the "partner" driver must get meta-data
>>>> that there is data activity. This is something mctrl can't provide.
>>> 
>>> A binary state is hardly "meta-data". What is the purpose of the rx notification?
>> 
>> the GPS chip can send data when it is not expected.
> 
> So?

Yes. It is simply not possible for a driver to know if the chip is enabled
or disabled at boot time. So the chip might or might not send data
when the driver is being probed.

And sending a turn-on/off impulse does just change the state, but the
driver still can't know.

It can only detect this state if the chip sends data when the driver
does not expect. So it knows that its assumption about the power
state is wrong. Then it can effectively skip one impulse and the
driver's assumption and the chip are in sync.

> 
>> The bit tells that there is data activity on the data line (RX). Hence I call this "meta-data"
>> because it is condensed information about other data..
> 
> Again, why does it matter? What do you do with it?
> To workaround defective h/w design missing power sense?

It is not defective. It is designed that way. Probably for a standalone
use case where a real push button allows the operator to turn it on
or off. And she can see if NMEA records are received and push the
button if needed.

And our driver must essentially do the same. Monitor the RX line
and push the button if there is data when nobody wants to have it
("ah, that thing has not been turned off by the previous crew"). 

The designers probably didn't think that monitoring the RX line is
a problem for an MCU.

> 
> I'd rather see a more fully-featured exemplar, to prove that this interface is
> sufficiently complete.

Which features are you missing?

> 
> 
>>>> And the GPS chip does not need a simple gpio state to power on/off but an on/off toggle impulse.
>>> 
>>> Genericity. If this chip needs such a state mechanism, then that should be reflected
>>> generically in gpio support, and we're back to trivial mctrl.
>> 
>> Argh... Sorry.
>> 
>> Should a swiss army knife GPIO driver be the solution for everything that a driver can do by simply
>> *using* a GPIO?
> 
> If gpio can support heartbeat, certainly it can support momentary switch?

Yes it can. Could even simplify the driver implementation a little. But it does not solve
the unknown power state issue.

> 
>> BTW: we did have a proposal back tree years that made the GPS driver present itself as
>> a gpio controller with a single gpio.
>> 
>> We called that "virtual gpio". Then we would simply connect the gps driver's
>> virtual power control gpio to a gpio-mctrl (or dtr-gpio).
>> 
>> This was rejected because a virtual gpio is not a piece of hardware. And the device/driver
>> is *not* a gpio.
> 
> I don't care about things not related to uart.

? me = puzzled

You just explained to me that I should use a gpio to connect to the mctrl to control the device.
Then I tell that we have proposed that and it was rejected. And you answer that you don't care
about it.

> 
> 
>>>> In our case there are no mctrl gpios (omap) but part of our driver proposal is just to
>>>> forward changes of the mctrl bits to the partner driver.
>>> 
>>> Please feel free to submit patches for mctrl gpios for the omap-serial driver.
>> 
>> Well, I don't necessarily need mctrl gpios. I need to get RX data activity notifications in addition.
>> 
>> BTW: with our patch you can easily add a generic mctrl driver that works for all serial
>> drivers. A sketch implementation (tied to a specific gpio based RS232 device) is here:
>> 
>> <http://git.goldelico.com/?p=gta04-kernel.git;a=blob;f=Documentation/devicetree/bindings/misc/ti%2Ctrs3386.txt;h=0e39ed1a47df9bb7bc747fca66548ff982b19cc5>
>> 
>> Then it is not necessary to implement mctrl for different uart drivers.
> 
> Not really. Look at how the imx driver uses mctrl gpios.

Yes, I know there is serial_mctrl_gpio.c but it is to be called by the device specific UART
driver and not by the general serial-core layer.

But I didn't find it being used by drivers/tty/serial/imx.c

> Generic support would need to allow the gpio state to vary from the mctrl state.

Maybe I need a little more explanation when this should happen.
If a gpio is to represent the RTS or DTR line, why should it not be set as defined by mctrl
which is changed by tcsetattr/ioctl?

> 
> 
>>>>> Not that I'm against uart slave device support, just that I don't think hacks
>>>>> is the way to go about it.
>>>>> 
>>>>> What I'd like to see is a split of the serial core into a tty driver and a
>>>>> standalone device abstraction. Anything else is just workarounds.
>>> 
>>> I think you misunderstand what I mean by "standalone device abstraction"; let me
>>> be clearer: "standalone UART device abstraction".
>> 
>> Hm. Sorry, but I still don't understand what you mean and don't know what I should
>> abstract. Can you please give an example?
> 
> 1. How will this support a Bluetooth uart slave without a userspace tool?
> One that needs to load firmware.
> 
> 2. How will it support multiple channels over the same uart to different
> slaves (ala TI's Shared Transport)?
> 
> 3. A uart slave driver should load independently and open a serial device
> (optionally exclusively) and operate without userspace/tty at all.

Ok, this is a good list of additional requirements and of course finally, an acceptable
solution should cover them as well. Not necessarily in a first step but in a second.

So let's go through them an look how they fit into our proposed driver code.

First of all. the driver can get a handle to the struct uart_port by
calling devm_serial_get_uart_by_phandle().

1. It should be possible to export a wrapper for __uart_put_char() so that the
device driver can send bytes of the firmware to the UART it knows about.

2. the driver can already add a rx_notification function to handle received characters.
It can decide if they should go to the tty layer or not. 

In this case they should not go to the tty layer but should be queued up in the
individual rx transport queues.

If the tx transport queues have new data, the driver can send the characters through
the same mechanism as in 1.

So the driver can communicate with the connected device and it can implement and
encapsulate the shared transport (or other) protocols.

How it presents the multiple channels (another set of UARTs?) is completely up to the
driver and no influenced by the hooks into serial-core.

So lets try a drawing:

device <--> uart <--> serial-core <-- new hooks ---> device driver <---> protocol interfaces

The most complex part will probably be to handle locking correctly.

3. this needs a little more study and deeper rework of the tty/serial interaction.

It is an area that I do not completely understand and have not researched in
detail, because I do not (yet) have a need for it.

The main component is probably attaching some "do-not-present-as-tty" DT property
to the UART DT node and prevent the tty layer from presenting a /dev/tty*.

This may need patches for the tty layer. So far we do neither touch the tty layer driver
nor any of the SoC specific uart drivers. We just hook into serial-core.c

I just stumbled about this article which helps (certainly not you, but me and other readers)
to understand what we are talking about. 

http://www.linuxjournal.com/article/6331

> 
> 
>>>> Here (was rebased from what I had submitted to LKML a while ago):
>>>> 
>>>> 1. serial core (two patches add API for any such partner drivers)
>>>> 
>>>> http://git.goldelico.com/?p=gta04-kernel.git;a=commit;h=c75ab51483e56afe08f56de104b5ed3fa1d6b0e8
>>>> http://git.goldelico.com/?p=gta04-kernel.git;a=commit;h=f910d951fcf816fce3261814d7f8c46ac6b35e68
>>>> 
>>>> 2. standalone driver example (using the new API)
>>>> 
>>>> http://git.goldelico.com/?p=gta04-kernel.git;a=commit;h=4fd1dbd4e915d741dddd264d6f87396e72351b3a
>>>> 
>>>> BR and thanks,
>>>> Nikolaus
>>>> 
>>> 
>> 
>> Did you look into these patches to understand what we propose?
> 
> Yes.

Ok, and sorry for assuming anything else.

> 
> The open-coding of uart initialization in uart_register_rx_notification()
> was particularly ugly. That's a good example of what needs abstracting.

It is because I did not want to break anything in the serial-core driver
and therefore wanted to keep the patches as non-invasive as possible.

And some parts of UART-initialization are ugly before we added anything...
This just tries to copy the initialization sequence.

But discussing implementation details makes only sense if the general
principle is agreed on. Then I am happy to work on such improvements
and code can be refactored of course, if requested but is something
where I need help not to break existing things.

it also needs test cases and much more work which would IMHO hide
the basic concept if we do it upfront.

> And why does the generic concept of rx_notification() imply that the slave
> device does not expect shutdown when commanded?

If a driver is opened, and any notification is registered, the UART is opened.
And as soon as all notifications are removed it is shut down.

In between it should not be shutdown even if user-space does an open()
and close(). Therefore we have to disable the calls to shutdown in this
case.

The reason is that a protocol engine (and I see the GPS RX line monitoring
and gpio impulse generation as a very simple protocol engine) must keep
the connection to the device "alive".

> That seems very specific to
> the broken h/w design of this device, and not what most slave device drivers
> would expect. Not that I'm suggesting you refine this approach.

No, it is not specific. It is very general. As long as a driver needs the UART,
the UART is not shut down.

> And the whole idea of not performing device shutdown when commanded is broken.

As soon as neither the device driver nor a tty port needs the UART any more, it is shut down.

> 
> Maybe some of this design was outlined in the cover letter?

Yes it was.

If I remember correctly there was one occasion where the cover letter was lost by a
glitch.

I immediately recognized that this would create confusion but it was too late and
I could not do anything else than send it again:

https://lkml.org/lkml/2015/10/16/786

> 
> 
> On 10/16/2015 11:08 AM, H. Nikolaus Schaller wrote:
>> H. Nikolaus Schaller (3):
>>  tty: serial core: provide a method to search uart by phandle
>>  tty: serial_core: add hooks for uart slave drivers
>>  misc: Add w2sg0004 gps receiver driver
>> 
>> .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  18 +
>> .../devicetree/bindings/serial/slaves.txt          |  16 +
>> .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>> Documentation/serial/slaves.txt                    |  36 ++
>> drivers/misc/Kconfig                               |  18 +
>> drivers/misc/Makefile                              |   1 +
>> drivers/misc/w2sg0004.c                            | 443 +++++++++++++++++++++
>> drivers/tty/serial/serial_core.c                   | 214 +++++++++-
>> include/linux/serial_core.h                        |  25 +-
>> include/linux/w2sg0004.h                           |  27 ++
>> 10 files changed, 793 insertions(+), 6 deletions(-)
>> create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>> create mode 100644 Documentation/devicetree/bindings/serial/slaves.txt
>> create mode 100644 Documentation/serial/slaves.txt
>> create mode 100644 drivers/misc/w2sg0004.c
>> create mode 100644 include/linux/w2sg0004.h
> 
> 
> Hmmm, nope.
> 
> Regards,
> Peter Hurley

Best regards and thanks for the good comments,
Nikolaus
