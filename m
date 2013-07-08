From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad
	name
Date: Mon, 8 Jul 2013 08:50:04 +0100
Message-ID: <20130708075004.GR24642@n2100.arm.linux.org.uk>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com> <1373004752-21302-5-git-send-email-b32955@freescale.com> <20130706050803.GC30164@S2101-09.ap.freescale.net> <20953.22066.706534.773272@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36070 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3GHHvN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Jul 2013 03:51:13 -0400
Content-Disposition: inline
In-Reply-To: <20953.22066.706534.773272@ipc1.ka-ro>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Huang Shijie <b32955@freescale.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org

On Sun, Jul 07, 2013 at 01:51:14PM +0200, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Shawn Guo writes:
> > On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
> > > There is something wrong with the RTS/CTS pads:
> > >   The RTS pad is assigned with the CTS's value;
> > >   while the CTS pad is assigned with the RTS's value.
> > >=20
> >=20
> > So basically, you are saying that select_input should be set up for=
 CTS
> > rather than RTS.  It seems that the people who generated the macro =
got
> > the wrong input from developer.
> >=20
> programming 'select_input' only makes sense for inputs, not outputs.
> Since CTS is an output signal, select_input only makes sense for the
> RTS function of the pads.

Note: If you are a DTE, then RTS is an output, CTS is an input.  If you
are a DCE, then RTS is an input and CTS is an output (normally on a
standard UART, you just swap the wiring for RTS and CTS but really that=
's
all that is going on.)  So swapping them in software should be acceptab=
le
too, provided you're not having to disable any auto flow control facili=
ties.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
