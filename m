From: Rob Herring <robh@kernel.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Sat, 16 Jan 2016 17:31:57 -0600
Message-ID: <20160116233157.GA7774@rob-hp-laptop>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
 <20160113191542.GA12086@leverpostej>
 <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com>
 <20160115110106.GA3262@leverpostej>
 <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com>
 <569913A1.80606@cogentembedded.com>
 <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com>
 <56992959.2020204@hurleysoftware.com>
 <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com>
 <744620565.20160116103445@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <744620565.20160116103445@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vostrikov Andrey <andrey.vostrikov@cogentembedded.com>
Cc: Rob Herring <robherring2@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net, NeilBrown <neil@brown.name>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 16, 2016 at 10:34:45AM +0300, Vostrikov Andrey wrote:
> Hi, Rob.
> 
> > On Fri, Jan 15, 2016 at 11:16 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> >> On 01/15/2016 08:08 AM, H. Nikolaus Schaller wrote:
> >>> Hi Andrey,
> >>> ah that is fine to learn about another project that needs some solution (however it will look like).
> >>>
> >>> Am 15.01.2016 um 16:43 schrieb Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>:
> >>>
> >>>> Hi Nikolaus,
> >>>>
> >>>> H. Nikolaus Schaller wrote:
> 
> > [...]
> 
> >>>> There is no user space code involved in this case as whole interactions are between drivers (just a kick to open /dev/ttyXXX using sys_open, as there is no way to start probe on uart_slave bus and assign line discipline).
> >>>
> >>> Exactly this is what we want to provide as API for the drivers by our patches to serial-core.c.
> >>>
> >>> We want to allow such a "partner" device to take a line-speed property e.g. from its DT node (or a 9600 constant as for our GPS chip) and ask the UART driver to set the required clocks. Or to get the driver notified that someone has opened the /dev/tty* etc. So make it possible to use some UART from another driver.
> >>>
> >>> In the long run it should be possible to use the UART even if there is no /dev/tty client or interface in user-space but that is something not perfectly working (there is some initialization race in the tty/serial subsystem we have not yet understood).
> >>>
> >>> As you see, I have a driver-specific standpoint (and not coming from user space).
> >>>
> >>> Thanks for sharing this example.
> >>
> >>
> >> I'd like to see the exemplar slave driver be something more complicated than
> >> trivial on-off, before hacking in junk into the serial core.
> >>
> >> As it stands, this gps could be supported on any uart driver that implements
> >> mctrl gpios (which is trivial with the serial mctrl gpio helpers).
> >>
> >> Not that I'm against uart slave device support, just that I don't think hacks
> >> is the way to go about it.
> 
> > I assume line disciplines seemed a good solution at the time, but they
> > seem like a hack to me.
> What would be best implementation in following use case:
> - there are several microcontrollers/devices that use same protocol on top of UART (<STX>-<DATA>-<CRC>-<ETX>)
> - microcontoller could provide several functions to system, e.g. watchdog, HWMON etc., that not require user space interaction
> - there are several implementations of firmware that use different commands/events transferred as <DATA> and different <CRC> algorithms installed on several HW variants

Yes, and combo chips with BT, FM radio and/or NFC muxed on UART port are 
quite common.

> If we take picture from Nikolaus's email:
> device <--> uart <--> serial-core <-- new hooks ---> device driver <---> protocol interfaces
> 
> It would be nice to have a layer such as line discipline between serial core and device driver to use high level API to transfer data via UART.
> But current implementation of line disciplines is intended to be used from user space and via tty layer.

We'll probably need to support some sort of layers or plugins to 
provide both muxing and protocol support. Even in the single function 
case, we'll need to be able to have BT chip driver and generic BT HCI 
protocol modules.

> >> What I'd like to see is a split of the serial core into a tty driver and a
> >> standalone device abstraction. Anything else is just workarounds.
> 
> > +1 on that. We need a proper subsystem for in kernel drivers of
> > connected UART devices.
> 
> Yes, such implementation will help. There is a need for interface like UART BUS that will probe devices without user space.
> Serial I/O for input subsystem defines new type of bus and uses dedicated line discipline, but it still unable to start driver by itself and requires call from 'inputattach' to open port, assign line discipline and go to forever wait on 'read'.

I looked at serio a bit to see if it could be used or expanded. There is 
the line discipline, but then there are serial drivers which connect to 
serio (or tty layer) directly. The SUN serial ports and keyboard are an 
example IIRC. That may have been the only one... I found that serio is 
pretty limited and doesn't provide much of a starting point. It's 
functionality could be rolled into some new though.

Rob
