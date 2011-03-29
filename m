From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Wrong GIT author ? also bugs: serial: Add uart driver for
 i.MX23/28
Date: Tue, 29 Mar 2011 10:33:35 +0100
Message-ID: <20110329103335.7a5ff37d@lxorguk.ukuu.org.uk>
References: <201103180302.p2I326tA020159@hera.kernel.org>
	<20110318112920.07148450@lxorguk.ukuu.org.uk>
	<20110329091456.GI30938@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34864 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751022Ab1C2Jd3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Mar 2011 05:33:29 -0400
In-Reply-To: <20110329091456.GI30938@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?ISO-8859-14?B?S2xlaW5lLUv2bmln?= <u.kleine-koenig@pengutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-serial@vger.kernel.org, torvalds@linux-foundation.org, kernel@pengutronix.de

> I don't understand how to do this and didn't find something like that in
> other drivers. (I checked amba-pl011.c and imx.c.) Also
> Documentation/serial/driver doesn't describe this. (It is also silent
> about CMSPAR and doesn't even advise to clear unsupported bits.)
> Can you be a bit more verbose here?

8250.c is the best place to look.

Basically on return from your routine the _hardware_ bits of the termios
struct should be the ones set.

So eg if you only supported 8bit characters you'd wipe the CSx bits and
set CS8.

For the speed there is a helper so you probably want

        /* Don't rewrite B0 */
        if (tty_termios_baud_rate(termios))
                tty_termios_encode_baud_rate(termios, baud, baud);

> @@ -286,6 +283,9 @@ static void mxs_auart_settermios(struct uart_port *u,
>  {
>  	u32 bm, ctrl, ctrl2, div;
>  	unsigned int cflag, baud;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&u->lock, flags);

Termios you don't need the lock - just the IRQ handler and you still
really want the tty_port_tty_get()/tty_kref_put() if that wasn't already
dealt with.

(You may not need it but its easier to put in than prove with the serial
layer at the moment)
