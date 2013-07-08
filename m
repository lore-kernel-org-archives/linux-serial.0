From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad
	name
Date: Mon, 8 Jul 2013 10:03:49 +0200
Message-ID: <20954.29285.732132.959465@ipc1.ka-ro>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>
	<1373004752-21302-5-git-send-email-b32955@freescale.com>
	<20130706050803.GC30164@S2101-09.ap.freescale.net>
	<20953.22066.706534.773272@ipc1.ka-ro>
	<20130708075004.GR24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:51309 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab3GHIFa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Jul 2013 04:05:30 -0400
In-Reply-To: <20130708075004.GR24642@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Shawn Guo <shawn.guo@linaro.org>, Huang Shijie <b32955@freescale.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org

Hi,

Russell King - ARM Linux writes:
> On Sun, Jul 07, 2013 at 01:51:14PM +0200, Lothar Wa=C3=9Fmann wrote:
> > Hi,
> >=20
> > Shawn Guo writes:
> > > On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
> > > > There is something wrong with the RTS/CTS pads:
> > > >   The RTS pad is assigned with the CTS's value;
> > > >   while the CTS pad is assigned with the RTS's value.
> > > >=20
> > >=20
> > > So basically, you are saying that select_input should be set up f=
or CTS
> > > rather than RTS.  It seems that the people who generated the macr=
o got
> > > the wrong input from developer.
> > >=20
> > programming 'select_input' only makes sense for inputs, not outputs=
=2E
> > Since CTS is an output signal, select_input only makes sense for th=
e
> > RTS function of the pads.
>=20
> Note: If you are a DTE, then RTS is an output, CTS is an input.  If y=
ou
> are a DCE, then RTS is an input and CTS is an output (normally on a
> standard UART, you just swap the wiring for RTS and CTS but really th=
at's
> all that is going on.)  So swapping them in software should be accept=
able
> too, provided you're not having to disable any auto flow control faci=
lities.
>
=46reescale had decided to implement their UARTs on the i.MX SoCs as DC=
E
and later added a bit to switch between DCE and DTE mode. That's where
all the confusion comes from.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
