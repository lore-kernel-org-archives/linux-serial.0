From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Sun, 17 Jan 2016 18:57:35 +0100
Message-ID: <1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160113191542.GA12086@leverpostej> <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com> <569913A1.80606@cogentembedded.com> <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com> <56992959.2020204@hurleysoftware.com> <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com> <744620565.20160116103445@cogentembedded.com> <20160116233157.GA7774@rob-hp-laptop> <3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com> <20160117141912.4aa2e46c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160117141912.4aa2e46c@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Rob Herring <robh@kernel.org>, Vostrikov Andrey <andrey.vostrikov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Hi Alan,

Am 17.01.2016 um 15:19 schrieb One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:

>> When translating the system requirements you have provided and mixing
>> with mine, I think we need:
>> 
>> 1. mechanism to receive characters sent by the peer MCU
> 
> Low level driver queue of some kind

Yes, could be useful. Depends on what the peer drivers need.

Some might just have a simple state engine so that they can
process each character as it is incoming and place it into
one of several receive queues managed by the driver. So they
do not need a central queue for incoming characters.

> 
>> 2. mechanism to send characters to the peer (or a block for firmware download)
> 
> Ditto (maybe even netlink)

I haven't yet coded anything for that requirement but the UART already appears to
have a TX queue. So it should suffice to append the characters to it and they are
queued up.

> 
>> 3. mechanism to open/close the UART (even if there is no user space/tty client)
> 
> So don't use the tty layer in the first place

For the implementation I propose, we aren't using the tty layer in the first place. We
use the struct uart_port which is a glue layer in serial-core.c

I think I should reformulate this requirement (we need it for our GPS chip driver):

3. mechanism to open/close the UART by the peer driver (for power management of the
UART), even if it there is a user-space tty client for the same UART which might or might
not be open at any time. Manage that in an optimal way.

For the GPS chip I am only interested in mctrl and if characters are received. But
I still want them to arrive at user space through a standard tty interface. So a solution
that does not interwork and cooperate with the tty layer is not a useable solution for
my requirements.

> 
>> 4. mechanism to set the struct termios of the UART (baud rate etc.)
> 
> Can be done without the tty layer.

Yes, our implementation does it without. A struct termios is passed down to the
UART hardware driver which translates it into clock divider settings etc. but
ignores some fields. This is the way it is already done today for tcsetattr() after
rippling down through higher level layers:

http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c#L458

> 
>> 5. mechanism to be notified that user space has opened/closed the tty port or changes mctrl
>> 6. mechanism to prevent the tty layer to present a /dev/tty* to user space at all
> 
> This sounds the wrong way up entirely.
> 
> Instead of trying to make the tty layer do weird stuff, make the driver
> present a tty that is only the things that it wants to be exposed as a
> tty if any. If there are none then don't use the tty layer at all.

The reason appears to sit here:

http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c#L2725

This means that as soon as some UART is successfully probed, a new tty
interface is created for it. So we simply have to optionally disable it. This is
described by requirement 6.

Sounds easier to me than rearranging the whole tty / serial-core stuff.
I prefer to leave that really big task as an exercise to someone else...

> 
> We have lots of interfaces to random MCUs. Many of them talk "serial"
> protocols, almost none of them pretend to be the tty layer.

If there are may devices (I assume you think of a serial mouse or touchscreen
for example) that can be implemented to talk "serial", they still can do,
should do and do not need to use this new API. It is not intended to be
a replacement for mature and good solutions.

But we have some cases where we need it because we can't get the
problems solved at higher layers.

This layer is also chosen with execution speed in mind. The closer to the
hardware driver, the faster it is. But it should not touch the ~50 different
UART drivers we have and work with any of them. This is why I think
serial-core and struct uart_port is the right level. Even if it looks like a hack.

So please wait until I have updated the patch set of our proposal. Then you
can see that we do not directly touch the tty layer.

Thanks,
Nikolaus
