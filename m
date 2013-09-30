From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: mxs auart timeout waiting for transmission with hw flow control
Date: Mon, 30 Sep 2013 18:20:44 +0200
Message-ID: <20130930162044.GG2548@pengutronix.de>
References: <5249A1B7.4000404@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51641 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab3I3QUq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Sep 2013 12:20:46 -0400
Content-Disposition: inline
In-Reply-To: <5249A1B7.4000404@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: linux-serial@vger.kernel.org, Huang Shijie <b32955@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>

Hi Hector,

On Mon, Sep 30, 2013 at 06:07:19PM +0200, Hector Palacios wrote:
> I saw your patch at
> http://www.spinics.net/lists/stable/msg12952.html and I believe I'm
> having a similar issue when not using the port as console.
>=20
> With hardware flow control enabled transmission fails at low
> baudrates (9600,38400). Apparently the transmitter closes the port
Which kernel are you using? I think there were some other fixes
concering flow control some time ago.

> before the data has been really shifted out (or even transferred by
> the DMA). While the console functions check the status of
> AUART_STAT_BUSY, the standard functions don't, and the AUART is busy
> when shutdown is called at low baudrates.
>=20
> I also see the function uart_wait_until_sent() of serial_core.c
> getting out with timeout expired. At 9600 baud, this function waits
> 2 or 4 jiffies. Increasing (a lot) the timeout of this function
> solves the problem. I monitored the time it takes for TX to be empty
> and it resulted in sometimes around 200 jiffies (@9600).
Again with flow control and another imx28 on the opposite side? Does it
work without flow control? Is CTS busy for some time? In that case a
simple timeout isn't appropriate. Using console and flow control on the
same port might be hairy, not sure though.
=20
> The issue can be reproduced using two iMX28 devices (transmitting
> between two ports on the same platform usually works fine),
> configuring a low baudrate (9600) and hardware flow enabled, and
> sending a file of 40K, for example. The last ~200 bytes or so are
> typically not sent over the line.
I currently don't have the time and machines to test, but maybe the
freescale guys (added Fabio to Cc, too) might want to test it.

Best regards from Freiburg
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
