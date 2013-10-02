From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
Date: Wed, 2 Oct 2013 10:30:14 +0200
Message-ID: <20131002083014.GN2548@pengutronix.de>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
 <20131001194800.GL2548@pengutronix.de>
 <524BCBC4.5050708@digi.com>
 <20131002074436.GM2548@pengutronix.de>
 <524BD4A6.5060208@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50635 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab3JBIaX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 04:30:23 -0400
Content-Disposition: inline
In-Reply-To: <524BD4A6.5060208@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "marex@denx.de" <marex@denx.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "b32955@freescale.com" <b32955@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Hector,

On Wed, Oct 02, 2013 at 10:09:10AM +0200, Hector Palacios wrote:
> On 10/02/2013 09:44 AM, Uwe Kleine-K=F6nig wrote:
> >On Wed, Oct 02, 2013 at 09:31:16AM +0200, Hector Palacios wrote:
> >>On 10/01/2013 09:48 PM, Uwe Kleine-K=F6nig wrote:
> >>>On Tue, Oct 01, 2013 at 06:18:35PM +0200, Hector Palacios wrote:
> >>>>+		/* Wait enough time to flush DMA buffer completely */
> >>>>+		to =3D u->timeout * UART_XMIT_SIZE / u->fifosize;
> >>>u->timeout is the time needed to send one char, right? UART_XMIT_S=
IZE is
> >>>the size of the circular buffer, fifosize is the size of the fifo.=
 I
> >>>don't get what you get by dividing by the fifosize. I would have
> >>>expected something like:
> >>>
> >>>	u->timeout * min(UART_XMIT_SIZE, u->fifosize)
> >>>
> >>>Can you explain, maybe in a comment along the code for the next pe=
rson
> >>>not understanding?
> >>
> >>u->timeout is *not* the time needed to send one char but the time
> >>needed to flush the complete port fifo (see uart_update_timeout() i=
n
> >>serial_core.c where it is set).
> >Ah, right. (BTW, uart_update_timeout should better round up instead =
of
> >round down, i.e.
> >-	port->timeout =3D (HZ * bits) / baud + HZ/50;
> >+	port->timeout =3D DIV_ROUND_UP(HZ * bits, baud) + HZ/50;
> >)
> >
> >>UART_XMIT_SIZE is the number of bytes in the DMA buffer, so I divid=
e
> >>the max number of bytes in the FIFO by the FIFO size and multiply b=
y
> >>the FIFO timeout.
> >ditto here, better round up. Although I think using a completion cou=
ld
> >shorten the timeout considerably because there are often less than
> >UART_XMIT_SIZE chars in the buffer?!
>=20
> I'm not really waiting the full timeout. I'm checking for TX fifo
> empty every 1ms and for a maximum of 'to' ms.
Correct. Still using DIV_ROUND_UP would be better, right?

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
