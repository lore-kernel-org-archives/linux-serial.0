From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for handling modem signals
Date: Fri, 7 Nov 2014 15:48:57 +0100
Message-ID: <201411071548.58044.marex@denx.de>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl> <201411071202.16344.marex@denx.de> <545CC7CB.1010107@elproma.com.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:45274 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaKGPRH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Nov 2014 10:17:07 -0500
In-Reply-To: <545CC7CB.1010107@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Huang Shijie <shijie8@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>

On Friday, November 07, 2014 at 02:23:23 PM, Janusz U=C5=BCycki wrote:
[...]

> >> Hardware RTS/CTS lines can be occupied by RX/TX of other AUART por=
t
> >> in order to obtain as much uarts as possible using i.mx283.
> >> Therefore gpios can be used for "hardware" flow control.
> >=20
> > Your logic is outright flawed here, the first sentence doesn't impl=
icate
> > the second sentence. In fact, those two are completely unrelated.
>=20
> I didn't write MUST but CAN. There is a choice. Is flexibility of the
> driver disadvantage?

If the flexibility brings in known problems, then yes, it is a problem.=
 Not=20
because of the flexibility, but because it brings in bugs.

> >>>>     If we change them to gpio.  Could the DMA still
> >>>>=20
> >>>> works fine?
> >>>> did you test the DMA with this patch?
> >>>>=20
> >>>> Add Marek for this patch too.
> >>>=20
> >>> I didn't look too deep into the patch, so here's just my experien=
ce:
> >>>=20
> >>> 1) The AUART block signals and GPIO block signals are not sychron=
ised
> >>> using the
> >>>=20
> >>>      same clock. Therefore, the latency between toggling of the A=
UART
> >>>      lines and the GPIO-driven pins will not be deterministic and=
 will
> >>>      vary. There might be a way to approximate that, but that's
> >>>      definitelly not a reliable solution.
> >>>     =20
> >>>      This is very bad for example if you drive RS485 DIR line wit=
h the
> >>>      RTS pin as a GPIO ; the RTS pin will toggle at non-determini=
stic
> >>>      time compared to the end of UART transmission. This will tri=
gger
> >>>      bit-loss on the RS485 line and you just don't want that.
> >>>=20
> >>> 2) Speaking of RS485, there's [1] and [2]. which I believe apply =
to any
> >>> combo
> >>>=20
> >>>      of UART+GPIO toggling.
> >>>=20
> >>> So I hate to bring the bad news , but UART+GPIO combo toggling is
> >>> really a bad bad idea.
> >>=20
> >> Unfortunately if hardware is limited there is no choice and UART+G=
PIO is
> >> necessary.
> >=20
> > You will run into timing problems (see above).
>=20
> A lot of 8250-compatible devices has no hardware flow control and in
> most cases
> they works and it is enough even for 115200 speed if CTS is handled b=
y irq.
> So it depends on your needs.

I presume that in such a case , the 8250 still handles the CTS line, no=
t some=20
external GPIO block, yes ?

> > What you're proposing here is a workaround for broken hardware, whi=
ch was
> > proven to be a bad idea and NAK'd already multiple times in the pas=
t
> > (please see the links I posted in my last email).
>=20
> It is not broken  hardware - rather limited to lower speeds but still
> very useful solution.

What exact "lower speed" are you talking about here and why ?

> >> Your experience confirms the discussion [3] with Russell King. DMA
> >> should be disabled and
> >> the patch disables DMA support in mxs_auart_init_gpios() if RTS or=
 CTS
> >> line is set as gpio.
> >=20
> > DMA has nothing to do with those problems here. DMA can be safely i=
gnored
> > for the purpose of the discussion altogether.
>=20
> When gpios are used for RTS/CTS DMA is not used. However DMA is relat=
ed
> due to the driver
> and "fsl,uart-has-rtscts". If you look into code of the driver you
> should agree.

This makes me believe that the DMA introduces too many timing fluctuati=
ons,
so it's really not possible for you to keep toggling the GPIOs such tha=
t the
bus would work. Is that the case ?

[...]

> >> Now the question: "fsl,uart-has-rtscts" name seems to be misleadin=
g now,
> >> do you agree? It rather should include "dma" word in the name. Any
> >> suggestion?
> >>=20
> >> [3] http://thread.gmane.org/gmane.linux.serial/16069/focus=3D16077
> >=20
> > The best suggestion I can give you is to fix your hardware early, b=
efore
> > you run into nasty deep s.....tuff. These workarounds do not work a=
nd
> > they will bit you later on, when it's hard to fix the hardware anym=
ore.
>=20
> The speed is limited but why don't you accept SW-HW mixed solutions?

Did you read up on the RS485 timing problems and why that solution was =
never
accepted for any driver ? I believe the threads explained that quite cl=
early.

> Exactly the same method is accepted for 8250.

Can you point out this code please ?

> It is good to have choice than not. We can comment that speed is limi=
ted
> for gpio-based hardware flow control. So please, rethink again.
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
