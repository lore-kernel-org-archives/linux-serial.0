From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for handling modem signals
Date: Fri, 7 Nov 2014 12:02:16 +0100
Message-ID: <201411071202.16344.marex@denx.de>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl> <201411070903.11645.marex@denx.de> <545C992B.1070004@elproma.com.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44036 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbaKGLDP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Nov 2014 06:03:15 -0500
In-Reply-To: <545C992B.1070004@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Huang Shijie <shijie8@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>

On Friday, November 07, 2014 at 11:04:27 AM, Janusz U=C5=BCycki wrote:
> W dniu 2014-11-07 o 09:03, Marek Vasut pisze:
> > On Friday, November 07, 2014 at 02:34:31 AM, Huang Shijie wrote:
> >> why change them to gpio?

+CC Alexandre, since he might be interested :-)

> Hardware RTS/CTS lines can be occupied by RX/TX of other AUART port
> in order to obtain as much uarts as possible using i.mx283.
> Therefore gpios can be used for "hardware" flow control.

Your logic is outright flawed here, the first sentence doesn't implicat=
e the=20
second sentence. In fact, those two are completely unrelated.

> >>    If we change them to gpio.  Could the DMA still
> >>=20
> >> works fine?
> >> did you test the DMA with this patch?
> >>=20
> >> Add Marek for this patch too.
> >=20
> > I didn't look too deep into the patch, so here's just my experience=
:
> >=20
> > 1) The AUART block signals and GPIO block signals are not sychronis=
ed
> > using the
> >=20
> >     same clock. Therefore, the latency between toggling of the AUAR=
T
> >     lines and the GPIO-driven pins will not be deterministic and wi=
ll
> >     vary. There might be a way to approximate that, but that's
> >     definitelly not a reliable solution.
> >    =20
> >     This is very bad for example if you drive RS485 DIR line with t=
he RTS
> >     pin as a GPIO ; the RTS pin will toggle at non-deterministic ti=
me
> >     compared to the end of UART transmission. This will trigger bit=
-loss
> >     on the RS485 line and you just don't want that.
> >=20
> > 2) Speaking of RS485, there's [1] and [2]. which I believe apply to=
 any
> > combo
> >=20
> >     of UART+GPIO toggling.
> >=20
> > So I hate to bring the bad news , but UART+GPIO combo toggling is r=
eally
> > a bad bad idea.
>=20
> Unfortunately if hardware is limited there is no choice and UART+GPIO=
 is
> necessary.

You will run into timing problems (see above).

What you're proposing here is a workaround for broken hardware, which w=
as proven
to be a bad idea and NAK'd already multiple times in the past (please s=
ee the=20
links I posted in my last email).

> Your experience confirms the discussion [3] with Russell King. DMA
> should be disabled and
> the patch disables DMA support in mxs_auart_init_gpios() if RTS or CT=
S
> line is set as gpio.

DMA has nothing to do with those problems here. DMA can be safely ignor=
ed
for the purpose of the discussion altogether.

Like I explained already -- the problem is with the GPIO and AUART bloc=
k not
being synchronised by the same clock. It is therefore impossible to pre=
dict
and control when the GPIO signals and the AUART signals will toggle in =
relation
to one another.

> So I didn't test the patch with the DMA - I've just disabled it.

This would break the driver for pretty much everyone using higher baud =
rates.

> The question is different. The driver supports the cases for RTS/CTS:
> 1)  both RTS/CTS assigned to hardware AUART (pinmux configured by DT,
>       DT sets fsl,uart-has-rtscts)
>      a) settermios() sets CRTSCTS: DMA enabled, auto RTS/CTS is enabl=
ed
>      b) settermios() doesn't set CRTSCTS: DMA disabled, RTS/CTS
> controlled by get/set_mctrl()
> 2)  both RTS/CTS assigned to hardware AUART (pinmux configured by DT,
>       DT doesn't set fsl,uart-has-rtscts)
>      a) settermios() sets CRTSCTS: DMA disabled, auto RTS/CTS is enab=
led
>      b) settermios() doesn't set CRTSCTS: DMA disabled, RTS/CTS
> controlled by get/set_mctrl()
>=20
> and after the patch it is more complex (because of mixed cases):
> 3) both RTS/CTS assigned to gpios (DT sets or not fsl,uart-has-rtscts=
):
>      the patch cancels fsl,uart-has-rtscts flag to disable DMA suppor=
t,
>      settermios() sets or not CRTSCTS: DMA disabled, RTS/CTS controll=
ed
> by get/set_mctrl(),
>      both lines by gpios. In addition:
>      a) settermios() doesn't set CRTSCTS: RTS of hardware AUART is al=
so
> controlled but
>          the case assumes it is not selected by pinmux in DT
>      b) settermios() sets CRTSCTS: auto RTS of hardware AUART is also
> enabled but
>          the case assumes it is not selected by pinmux in DT
> 4) RTS assigned to hardware AUART (pinmux configured by DT,
> fsl,uart-has-rtscts set or not),
>      CTS assigned to gpio: the patch cancels fsl,uart-has-rtscts flag=
 to
> disable DMA support,
>      a) settermios() doesn't set CRTSCTS: DMA disabled, CTS (as gpio)
> read by get_mctrl(),
>          RTS of hardware AUART controlled by set_mctrl()
>      b) settermios() sets CRTSCTS: DMA disabled, CTS (as gpio) read b=
y
> get_mctrl(),
>         auto RTS is enabled
>     So case 4) is exactly 3) case with just different pinmux
> configuration and the patch
>     threats 3) and 4) as the same case.
> 5) CTS assigned to hardware AUART (pinmux configured by DT,
> fsl,uart-has-rtscts set or not),
>      RTS assigned to gpio: the patch cancels fsl,uart-has-rtscts flag=
 to
> disable DMA support,
>      a) settermios() doesn't set CRTSCTS: DMA disabled, CTS of hardwa=
re
> AUART read by
>          get_mctrl(), RTS (as gpio) controlled by set_mctrl(), in
> addition RTS of hardware AUART
>          is also controlled but the case assumes it is not selected b=
y
> pinmux in DT
>      b) settermios() sets CRTSCTS: DMA disabled, auto RTS/CTS is enab=
led
> but RTS is controlled by set_mctrl() as gpio because the case assumes=
 it
> is not selected
>          by pinmux in DT
>=20
> It is not nice description but I hadn't idea how to write it more cle=
ar.
> The mixed cases 4) and 5) are likely not so useful but possible and n=
ot
> so expensive
> to support.
> Now the question: "fsl,uart-has-rtscts" name seems to be misleading n=
ow,
> do you agree? It rather should include "dma" word in the name. Any
> suggestion?
>=20
> [3] http://thread.gmane.org/gmane.linux.serial/16069/focus=3D16077

The best suggestion I can give you is to fix your hardware early, befor=
e you
run into nasty deep s.....tuff. These workarounds do not work and they =
will
bit you later on, when it's hard to fix the hardware anymore.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
