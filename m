From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCHv4 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Fri, 30 Sep 2016 13:04:28 +0200
Message-ID: <CACQ1gAgE+BvteH9y62PcRx_tA9_e2X11RCJ12PC98FK+5z98QQ@mail.gmail.com>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
 <20160930085801.21497-3-richard.genoud@gmail.com> <20160930091230.qzd42qnelylmkqxe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160930091230.qzd42qnelylmkqxe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2016-09-30 11:12 GMT+02:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
> Hello Richard,
>
> On Fri, Sep 30, 2016 at 10:58:00AM +0200, Richard Genoud wrote:
>> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
>> hardware handshake is enabled") broke the hardware handshake when GPIOs
>> were used.
>>
>> Hardware handshake with GPIOs used to work before this commit because
>> the CRTSCTS flag (termios->c_cflag) was set, but not the
>> ATMEL_US_USMODE_HWHS flag (controller register) ; so hardware handshake
>> enabled, but not handled by the controller.
>
> What does the HWHS flag control? What if only RTS is a gpio and CTS is
> not? Or the other way round?
First, HWHS flag is used only in SAMA5D2. (if I correctly understood
Atmel HW guys,
all other platforms (sam9, sam9x5, sama5d3...) have this flag, but it
is unusable,
because they don't have Fifos nor PDC).
So, on SAMA5D2, the HWHS flag tells the controller to drive the RTS
pin according to
the number of char present in the rx fifo (cf Figure 44-29 =C2=A744.7.3.15 =
p.1438 of
 http://www.atmel.com/Images/Atmel-11267-32-bit-Cortex-A5-Microcontroller-S=
AMA5D2_Datasheet.pdf).
The controller will also start/stop the transmission on CTS changes.
But, as I haven't got this hard, I couldn't test it. (but Cyrille did I gue=
ss).
With this flag set, It's mandatory to have CTS and RTS not handled via
GPIO, because if
they were, the controller couldn't, well, control them.

The NORMAL flag, on the contrary, just tell the controller not to mess
with RTS/CTS,
and in this case, the driver will handle CTS changes and drive the RTS
pin, via GPIO or
via the CR register.

It's not a problem to have CTS as a GPIO and RTS controlled via the CR regi=
ster
(or CTS changes read in CSR register and RTS as a GPIO).
I just gave it a quick try, works the same.
( But I don't know if it will work with FIFOs

> What is the problematic setup? I guess it's RTS and CTS are gpios and
> with that setting ATMEL_US_USMODE_HWHS is wrong? What happens if that
> happens?

Yes, CTS/RTS as GPIOs + HWHS flag is clearly wrong.
If that happens, well, the controller will try to drive an RTS pin
that won't have been muxed
as RTS. It does not seems to be a problem, but instructing the
controller do drive pins it doesn't
have access doesn't really make sense.
And in the case of the SAMA5D2, well I don't know what the result will
be, but it could stop transmission
from the "ghost" CTS signal I guess.

Anyway, the problematics setups are all the setups with USMODE_HWHS
enabled on platform without Fifos or PDC,
i.e. all platforms but sama5d2 (Cyrille, correct me if I'm wrong).

For instance, on sam9x5, if DMA is used, USMODE_HWHS enabled and
RTS/CTS NOT muxed as GPIOS,
it's like there was no flow control at all (the CTS pin doesn't
disable the transmitter).

Since atmel HW guys said that USMODE_HWHS is broken for platforms !sama5d2,
(cfhttps://lkml.org/lkml/2016/9/7/598 ),  I honestly didn't dig any
further into that flag.


Regards,
Richard
