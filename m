From: Rob Herring <robherring2@gmail.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 15 Jan 2016 16:40:51 -0600
Message-ID: <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com>
References: <20150511013540.5709.93626.stgit@notabene.brown>
 <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com>
 <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160113191542.GA12086@leverpostej>
 <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115110106.GA3262@leverpostej>
 <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com> <569913A1.80606@cogentembedded.com>
 <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com> <56992959.2020204@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56992959.2020204@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net, NeilBrown <neil@brown.name>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 15, 2016 at 11:16 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 01/15/2016 08:08 AM, H. Nikolaus Schaller wrote:
>> Hi Andrey,
>> ah that is fine to learn about another project that needs some solution (however it will look like).
>>
>> Am 15.01.2016 um 16:43 schrieb Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>:
>>
>>> Hi Nikolaus,
>>>
>>> H. Nikolaus Schaller wrote:

[...]

>>> There is no user space code involved in this case as whole interactions are between drivers (just a kick to open /dev/ttyXXX using sys_open, as there is no way to start probe on uart_slave bus and assign line discipline).
>>
>> Exactly this is what we want to provide as API for the drivers by our patches to serial-core.c.
>>
>> We want to allow such a "partner" device to take a line-speed property e.g. from its DT node (or a 9600 constant as for our GPS chip) and ask the UART driver to set the required clocks. Or to get the driver notified that someone has opened the /dev/tty* etc. So make it possible to use some UART from another driver.
>>
>> In the long run it should be possible to use the UART even if there is no /dev/tty client or interface in user-space but that is something not perfectly working (there is some initialization race in the tty/serial subsystem we have not yet understood).
>>
>> As you see, I have a driver-specific standpoint (and not coming from user space).
>>
>> Thanks for sharing this example.
>
>
> I'd like to see the exemplar slave driver be something more complicated than
> trivial on-off, before hacking in junk into the serial core.
>
> As it stands, this gps could be supported on any uart driver that implements
> mctrl gpios (which is trivial with the serial mctrl gpio helpers).
>
> Not that I'm against uart slave device support, just that I don't think hacks
> is the way to go about it.

I assume line disciplines seemed a good solution at the time, but they
seem like a hack to me.

> What I'd like to see is a split of the serial core into a tty driver and a
> standalone device abstraction. Anything else is just workarounds.

+1 on that. We need a proper subsystem for in kernel drivers of
connected UART devices.

The kernel is where all the work is, not the DT bindings, so we should
spend our time on the kernel side. There's already a fairly clean
split between serial core and tty layer, so it should be possible to
use serial core without too much surgery to all the UART drivers.

Rob
