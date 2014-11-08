From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for handling modem signals
Date: Sat, 8 Nov 2014 12:22:05 +0100
Message-ID: <201411081222.05722.marex@denx.de>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl> <201411071548.58044.marex@denx.de> <545CF36D.3060501@elproma.com.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:59957 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbaKHLzd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Nov 2014 06:55:33 -0500
In-Reply-To: <545CF36D.3060501@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Huang Shijie <shijie8@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>

On Friday, November 07, 2014 at 05:29:33 PM, Janusz U=C5=BCycki wrote:
> W dniu 2014-11-07 o 15:48, Marek Vasut pisze:
> > On Friday, November 07, 2014 at 02:23:23 PM, Janusz U=C5=BCycki wro=
te:
> > [...]
> >=20
> >>>> Hardware RTS/CTS lines can be occupied by RX/TX of other AUART p=
ort
> >>>> in order to obtain as much uarts as possible using i.mx283.
> >>>> Therefore gpios can be used for "hardware" flow control.
> >>>=20
> >>> Your logic is outright flawed here, the first sentence doesn't
> >>> implicate the second sentence. In fact, those two are completely
> >>> unrelated.
> >>=20
> >> I didn't write MUST but CAN. There is a choice. Is flexibility of =
the
> >> driver disadvantage?
> >=20
> > If the flexibility brings in known problems, then yes, it is a prob=
lem.
> > Not because of the flexibility, but because it brings in bugs.
>=20
> New features new bugs :) Does it mean to stop development?

You shouldn't push code which is known to be defective by design into m=
ainline.

> >>>>>>      If we change them to gpio.  Could the DMA still
> >>>>>>=20
> >>>>>> works fine?
> >>>>>> did you test the DMA with this patch?
> >>>>>>=20
> >>>>>> Add Marek for this patch too.
> >>>>>=20
> >>>>> I didn't look too deep into the patch, so here's just my experi=
ence:
> >>>>>=20
> >>>>> 1) The AUART block signals and GPIO block signals are not sychr=
onised
> >>>>> using the
> >>>>>=20
> >>>>>       same clock. Therefore, the latency between toggling of th=
e
> >>>>>       AUART lines and the GPIO-driven pins will not be determin=
istic
> >>>>>       and will vary. There might be a way to approximate that, =
but
> >>>>>       that's definitelly not a reliable solution.
> >>>>>      =20
> >>>>>       This is very bad for example if you drive RS485 DIR line =
with
> >>>>>       the RTS pin as a GPIO ; the RTS pin will toggle at
> >>>>>       non-deterministic time compared to the end of UART
> >>>>>       transmission. This will trigger bit-loss on the RS485 lin=
e and
> >>>>>       you just don't want that.
> >>>>>=20
> >>>>> 2) Speaking of RS485, there's [1] and [2]. which I believe appl=
y to
> >>>>> any combo
> >>>>>=20
> >>>>>       of UART+GPIO toggling.
> >>>>>=20
> >>>>> So I hate to bring the bad news , but UART+GPIO combo toggling =
is
> >>>>> really a bad bad idea.
> >>>>=20
> >>>> Unfortunately if hardware is limited there is no choice and UART=
+GPIO
> >>>> is necessary.
> >>>=20
> >>> You will run into timing problems (see above).
> >>=20
> >> A lot of 8250-compatible devices has no hardware flow control and =
in
> >> most cases
> >> they works and it is enough even for 115200 speed if CTS is handle=
d by
> >> irq. So it depends on your needs.
> >=20
> > I presume that in such a case , the 8250 still handles the CTS line=
, not
> > some external GPIO block, yes ?
>=20
> Yes. However mxs includes both GPIO and AUART. Clocks differs but it =
is
> still the same silicon.
> External GPIO block is extreme example highly not recommended here.

The way you implemented this particular change, it is possible to use a=
rbitrary
GPIO pin. There is no way you can guarantee anything about the latency =
of the
GPIO toggling (I am repeating myself).

> >>> What you're proposing here is a workaround for broken hardware, w=
hich
> >>> was proven to be a bad idea and NAK'd already multiple times in t=
he
> >>> past (please see the links I posted in my last email).
> >>=20
> >> It is not broken  hardware - rather limited to lower speeds but st=
ill
> >> very useful solution.
> >=20
> > What exact "lower speed" are you talking about here and why ?
>=20
> For example not more than 115200 but it depends on CPU load of course=
,
> FIFO size
> and device on the opposite site. RTS/CTS via GPIO require to know the=
 limit
> in an application.

OK, this is completely unreliable solution, which works just by sheer l=
uck.

> I googled even so exotic thing like:
> "8250: add support for DTR/DSR hardware flow control"

The fact that those perversions exists doesn't make them right. It does=
n't
even make them mainlinable.

> >>>> Your experience confirms the discussion [3] with Russell King. D=
MA
> >>>> should be disabled and
> >>>> the patch disables DMA support in mxs_auart_init_gpios() if RTS =
or CTS
> >>>> line is set as gpio.
> >>>=20
> >>> DMA has nothing to do with those problems here. DMA can be safely
> >>> ignored for the purpose of the discussion altogether.
> >>=20
> >> When gpios are used for RTS/CTS DMA is not used. However DMA is re=
lated
> >> due to the driver
> >> and "fsl,uart-has-rtscts". If you look into code of the driver you
> >> should agree.
> >=20
> > This makes me believe that the DMA introduces too many timing
> > fluctuations, so it's really not possible for you to keep toggling =
the
> > GPIOs such that the bus would work. Is that the case ?
>=20
> Yes, for RTS/CTS based on gpio DMA is not used. They are just toggled=
=2E
> So you probably misunderstood me.

I understand you -- in case DMA is enabled on the AUART block, your hac=
k
is no longer capable to working correctly, so everything falls apart.

> > [...]
> >=20
> >>>> Now the question: "fsl,uart-has-rtscts" name seems to be mislead=
ing
> >>>> now, do you agree? It rather should include "dma" word in the na=
me.
> >>>> Any suggestion?
> >>>>=20
> >>>> [3] http://thread.gmane.org/gmane.linux.serial/16069/focus=3D160=
77
> >>>=20
> >>> The best suggestion I can give you is to fix your hardware early,
> >>> before you run into nasty deep s.....tuff. These workarounds do n=
ot
> >>> work and they will bit you later on, when it's hard to fix the
> >>> hardware anymore.
> >>=20
> >> The speed is limited but why don't you accept SW-HW mixed solution=
s?
> >=20
> > Did you read up on the RS485 timing problems and why that solution =
was
> > never accepted for any driver ? I believe the threads explained tha=
t
> > quite clearly.
>=20
> Example of RS485 implementation where RTS is toggled by software:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/comm=
it/dri
> vers/tty/serial/omap-serial.c?id=3D4a0ac0f55b18dc297a87a85417fcf06865=
8bf103
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/=
tree/
> drivers/tty/serial/omap-serial.c

This is a question for Greg. I checked the discussion about this patch =
[1]
and I see this timing issue was brought up, but the patch was applied a=
nyway.
I cannot tell you why , I just know that this GPIO approach has problem=
s and
I wrestled those a couple of days ago (without success, it's not possib=
le to
get correct timing).

[1] http://www.spinics.net/lists/linux-serial/msg10574.html

> >> Exactly the same method is accepted for 8250.
> >=20
> > Can you point out this code please ?
>=20
> If 8250 doesn't support auto flow control RTS/CTS are also toggled by
> software,
> uart_trottle(), uart_untrothle(), uart_handle_cts_change():
> http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c=
#L635
> http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c=
#L2796
> Detected by irq (ms enabled when CRTSCTS) CTS change stops tx because
> UPF_HARD_FLOW flag is not set by the mxs-auart driver.

This doesn't use GPIO to toggle the RTS/CTS pins, it does toggle then v=
ia the
8250 IP block registers, right ?

> Of course timing problem exists but in many cases it is not critical =
-
> the toggle method was implemented many years ago and it seems to work=
=2E

Yes, it does seem to work initially, that's why so many hardware people
implement it, thinking the software people can fix those flubs. Problem
is, this is one of those nasty problems, which cannot be fixed in softw=
are.

> >> It is good to have choice than not. We can comment that speed is l=
imited
> >> for gpio-based hardware flow control. So please, rethink again.
> >=20
> > [...]
>=20
> The only problem for me is misleading "fsl,uart-has-rtscts" name beca=
use
> the flag
> only enables DMA if CRTSCTS is set and hardware flow control of AUART
> block is used.
>=20
> best regards
> Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
