From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
Date: Wed, 2 Oct 2013 11:59:21 +0200
Message-ID: <20131002095921.GP2548@pengutronix.de>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
 <20131001194800.GL2548@pengutronix.de>
 <524BCBC4.5050708@digi.com>
 <20131002074436.GM2548@pengutronix.de>
 <524BD4A6.5060208@digi.com>
 <20131002083014.GN2548@pengutronix.de>
 <524BDD64.70309@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56283 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab3JBJ72 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 05:59:28 -0400
Content-Disposition: inline
In-Reply-To: <524BDD64.70309@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "marex@denx.de" <marex@denx.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "b32955@freescale.com" <b32955@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Hector,

On Wed, Oct 02, 2013 at 10:46:28AM +0200, Hector Palacios wrote:
> On 10/02/2013 10:30 AM, Uwe Kleine-K=F6nig wrote:
> >On Wed, Oct 02, 2013 at 10:09:10AM +0200, Hector Palacios wrote:
> >>On 10/02/2013 09:44 AM, Uwe Kleine-K=F6nig wrote:
> >>>Ah, right. (BTW, uart_update_timeout should better round up instea=
d of
> >>>round down, i.e.
> >>>-	port->timeout =3D (HZ * bits) / baud + HZ/50;
> >>>+	port->timeout =3D DIV_ROUND_UP(HZ * bits, baud) + HZ/50;
> >>>)
> >>>
> >>>>UART_XMIT_SIZE is the number of bytes in the DMA buffer, so I div=
ide
> >>>>the max number of bytes in the FIFO by the FIFO size and multiply=
 by
> >>>>the FIFO timeout.
> >>>ditto here, better round up. Although I think using a completion c=
ould
> >>>shorten the timeout considerably because there are often less than
> >>>UART_XMIT_SIZE chars in the buffer?!
> >>
> >>I'm not really waiting the full timeout. I'm checking for TX fifo
> >>empty every 1ms and for a maximum of 'to' ms.
> >Correct. Still using DIV_ROUND_UP would be better, right?
>=20
> I think it is not really needed, after all the code is adding HZ/50
> of slop which acts like a round up, doesn't it?
>=20
> 	/*
> 	 * Figure the timeout to send the above number of bits.
> 	 * Add .02 seconds of slop
> 	 */
> 	port->timeout =3D (HZ * bits) / baud + HZ/50;
According to my understanding (which could well be wrong) the slop of
HZ/50 isn't there to fix rounding issues in the previous division. But
yes, if it's calculated generously there is no technical need to fix th=
e
rounding issue.

Still it might be worth to fix it to be a better reference. I don't car=
e
much.

Best regards
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
