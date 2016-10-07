From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCHv4 2/3] tty/serial: at91: fix hardware handshake with
 GPIOs
Date: Fri, 7 Oct 2016 17:26:14 +0200
Message-ID: <20161007172614.5e6748ae@lnx-rg>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
 <20160930085801.21497-3-richard.genoud@gmail.com>
 <20160930091230.qzd42qnelylmkqxe@pengutronix.de>
 <CACQ1gAgE+BvteH9y62PcRx_tA9_e2X11RCJ12PC98FK+5z98QQ@mail.gmail.com>
 <20161004072525.josgoglunmvufcn2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161004072525.josgoglunmvufcn2@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Le Tue, 4 Oct 2016 09:25:25 +0200,
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> a =C3=A9crit :

> On Fri, Sep 30, 2016 at 01:04:28PM +0200, Richard Genoud wrote:
> > 2016-09-30 11:12 GMT+02:00 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de>:
> > > Hello Richard,
> > >
> > > On Fri, Sep 30, 2016 at 10:58:00AM +0200, Richard Genoud wrote:
> > >> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management
> > >> when hardware handshake is enabled") broke the hardware
> > >> handshake when GPIOs were used.
> > >>
> > >> Hardware handshake with GPIOs used to work before this commit
> > >> because the CRTSCTS flag (termios->c_cflag) was set, but not the
> > >> ATMEL_US_USMODE_HWHS flag (controller register) ; so hardware
> > >> handshake enabled, but not handled by the controller.
> > >
> > > What does the HWHS flag control? What if only RTS is a gpio and
> > > CTS is not? Or the other way round?
> > First, HWHS flag is used only in SAMA5D2. (if I correctly understood
> > Atmel HW guys,
> > all other platforms (sam9, sam9x5, sama5d3...) have this flag, but
> > it is unusable,
> > because they don't have Fifos nor PDC).
> > So, on SAMA5D2, the HWHS flag tells the controller to drive the RTS
> > pin according to
> > the number of char present in the rx fifo (cf Figure 44-29
> > =C2=A744.7.3.15 p.1438 of
> > http://www.atmel.com/Images/Atmel-11267-32-bit-Cortex-A5-Microcontrolle=
r-SAMA5D2_Datasheet.pdf).
> > The controller will also start/stop the transmission on CTS
> > changes. But, as I haven't got this hard, I couldn't test it. (but
> > Cyrille did I guess). With this flag set, It's mandatory to have
> > CTS and RTS not handled via GPIO, because if they were, the
> > controller couldn't, well, control them.
>=20
> Assuming the respective pin doesn't reach the hardware both are no
> problem though. And it would keep the driver simpler to just ignore
> this. There would be no need for patch 1 and also this patch could be
> dropped. So I guess there is really something to fix, otherwise you
> wouldn't start patching the driver. But I don't understand the issue,
> so I'd like to have a better picture.
>=20
> Best regards
> Uwe
>=20
Ok, so I'll try to explain what's going on.

I'm sure you're familiar with hardware handshaking (aka flow control),
but anyway, it doesn't hurt to explain it for the big picture
understanding.

On RS232, flow control is handled by 2 pins: RTS and CTS.
CTS is an input. When it's high (ttl), it indicates that we should stop
transmitting.
RTS is an output, we drive it at high level (ttl) to indicate that we
can't receive anymore data for now (because the rx buffer is full, or
the device is closed for instance).

The RTS and CTS management is done in serial_core.c which calls
atmel_set/get_mctrl to set/get RTS/CTS pin state.
And CTS changes are detected via an interrupt in atmel_interrupt().

Now, the atmel USART controller has a feature that can handle part of
the flow control job:
- disabling the transmitter when the CTS pin gets high
- drive the RTS pin high when the DMA buffer transfer is completed or
  PDC rx buffer full or rx FIFO is beyond threshold. (depending on the
  controller version).
This feature is enabled by setting the flag ATMEL_US_USMODE_HWHS.
And to be clear, this feature is *not* mandatory for the flow control to
work !

[ The fun part is that according to atmel designers, this feature is
broken for platforms with no PDC and no FIFO.
(source: https://lkml.org/lkml/2016/9/7/598 ) ]

Before commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management
when hardware handshake is enabled"), this flag was never set.
Thus, the CTS/RTS where only handled by serial_core (and everything
worked just fine).

This commit introduced the use of the ATMEL_US_USMODE_HWHS (among other
things).
The logic introduced was to set the flag ATMEL_US_USMODE_HWHS for all
boards when the user space enables flow control.
This was clearly wrong because this feature can only be used when PDC
or FIFO are in use.

If ATMEL_US_USMODE_HWHS is enabled and PDC/FIFO/DMA are not used, the
RTS pin stays at high level no matter what, preventing any data to be
received.

Then, commit 5be605ac9af9 ("tty/serial: atmel: fix hardware handshake
selection") did something completely wrong:
Instead of removing the flag ATMEL_US_USMODE_HWHS for platforms with
no PDC nor FIFOs, and let serial_core happily handle the CTS/RTS, it
refused to set the flow control when the user space asked for it.
This was because of a misunderstanding:
It's not that platforms without PDC and FIFO can't do flow control at
all, they just can't enable the USART controller feature relative to
flag ATMEL_US_USMODE_HWHS.
And, again, this feature is *not* mandatory for the flow control to
work.

So, now, all atmel platforms with no PDC and no FIFO (SAM9G35, SAMA5D3,
etc.) can't use flow control anymore.


That's the reason of this patch series.


And as the controller flow control feature only works with PDC and
FIFOs, the logic would be to set the ATMEL_US_USMODE_HWHS like that:
if ((termios->c_cflag & CRTSCTS) &&
    !mctrl_gpio_use_rtscts(atmel_port->gpios) &&
    (atmel_use_pdc_rx(port) || atmel_use_fifo(port))) {
    mode |=3D ATMEL_US_USMODE_HWHS;
}

I added the mctrl_gpio_use_rtscts() test, because:
- There's no point using the ATMEL_US_USMODE_HWHS feature when CTS/RTS
  are driven by GPIOs, it doesn't make any sense.
- And it simply doesn't work because the transmitter is shut down.
(and that's the other reason of this patch series)

For the mctrl_gpio_use_rtscts() function, I agree that it may be atmel
specific, and I could implement as something like
atmel_use_{c,r}ts_gpio().

I'll have soon other hardware to test this on, and I'll resend a series
after that.

regards,
Richard
