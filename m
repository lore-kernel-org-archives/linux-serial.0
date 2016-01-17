From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Sun, 17 Jan 2016 09:53:48 +0100
Message-ID: <3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160113191542.GA12086@leverpostej> <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com> <569913A1.80606@cogentembedded.com> <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com> <56992959.2020204@hurleysoftware.com> <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com> <744620565.20160116103445@cogentembedded.com> <20160116233157.GA7774@rob-hp-laptop>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160116233157.GA7774@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi,

Am 17.01.2016 um 00:31 schrieb Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> On Sat, Jan 16, 2016 at 10:34:45AM +0300, Vostrikov Andrey wrote:
>> What would be best implementation in following use case:
>> - there are several microcontrollers/devices that use same protocol on top of UART (<STX>-<DATA>-<CRC>-<ETX>)
>> - microcontoller could provide several functions to system, e.g. watchdog, HWMON etc., that not require user space interaction
>> - there are several implementations of firmware that use different commands/events transferred as <DATA> and different <CRC> algorithms installed on several HW variants
> 
> Yes, and combo chips with BT, FM radio and/or NFC muxed on UART port are 
> quite common.

Indeed. Which raises another DT modelling question: should each component
have its own node (and individual compatible string) or should there be a node
for the whole combo chip. And is it the child of MMC/SDIO or of the UART?

But let's postpone this difficult thing.

> 
>> If we take picture from Nikolaus's email:
>> device <--> uart <--> serial-core <-- new hooks ---> device driver <---> protocol interfaces
>> 
>>> +1 on that. We need a proper subsystem for in kernel drivers of
>>> connected UART devices.
>> 
>> Yes, such implementation will help. There is a need for interface like UART BUS that will probe devices without user space.
>> Serial I/O for input subsystem defines new type of bus and uses dedicated line discipline, but it still unable to start driver by itself and requires call from 'inputattach' to open port, assign line discipline and go to forever wait on 'read'.
> 
> I looked at serio a bit to see if it could be used or expanded. There is 
> the line discipline, but then there are serial drivers which connect to 
> serio (or tty layer) directly. The SUN serial ports and keyboard are an 
> example IIRC. That may have been the only one... I found that serio is 
> pretty limited and doesn't provide much of a starting point. It's 
> functionality could be rolled into some new though.

I think the best location is serial-core.c. It connects the tty layer with the SoC
specific uart drivers.

So the picture of data/control flow looks like:

user-space <-> /dev/TTY* <-> tty layer <-+
                                         +--> serial-core.c  <-> UART hardware driver <-> null-modem <-> UART <-> peer MCU
peer device driver <---------------------+

This needs a new peer device API for device drivers which is provided
by the serial core.

When translating the system requirements you have provided and mixing
with mine, I think we need:

1. mechanism to receive characters sent by the peer MCU
2. mechanism to send characters to the peer (or a block for firmware download)
3. mechanism to open/close the UART (even if there is no user space/tty client)
4. mechanism to set the struct termios of the UART (baud rate etc.)
5. mechanism to be notified that user space has opened/closed the tty port or changes mctrl
6. mechanism to prevent the tty layer to present a /dev/tty* to user space at all

Then, we just need a normal device driver for the peer device (you can call
it "plugin"). This driver module can implement all needed state engines
I am aware of (power control, packetization, multiplexing).

Is anything missing?

Our implementation proposal from October already solves parts of this (1, 3, 4, 5)
and I have now some ideas how the missing ones could easily be added.

So please give me some days to develop it a little to post a patch set
which includes sketches for the extensions. And I want to add a blueprint for
a driver for the more complex situation with firmware download & protocol engine.

But please note that I will not be able to test sending of characters, since
none of my drivers or peer devices needs that or can handle.

Therefore the code will not be tested and sometimes just a sketch to
transport the idea. It will need quite some work and help to get it stabilized.

Regards and thanks,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
