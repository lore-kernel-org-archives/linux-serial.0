From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Wrong GIT author ? also bugs: serial: Add uart driver for i.MX23/28
Date: Fri, 18 Mar 2011 11:29:20 +0000
Message-ID: <20110318112920.07148450@lxorguk.ukuu.org.uk>
References: <201103180302.p2I326tA020159@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42782 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752183Ab1CRL3j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 07:29:39 -0400
In-Reply-To: <201103180302.p2I326tA020159@hera.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

>     serial: Add auart driver for i.MX23/28
>     
>     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

You have a few things that need fixing, one of which is quite nasty

> + * Freescale STMP37XX/STMP378X Application UART driver
> + *
> + * Author: dmitry pervushin <dimka@embeddedalley.com>

So its signed off by one person and without a signature from the author ?
Is that intentional

And it git we have

Author:     Sascha Hauer <s.hauer@pengutronix.de>

which from the header block appears to be untrue ?

> +static void mxs_auart_rx_chars(struct mxs_auart_port *s)
> +{
> +	struct tty_struct *tty = s->port.state->port.tty;
> +	u32 stat = 0;

tty may be NULL at this point, in which case your code will try and push
bits through a NULL pointer and crash

A user can seek to make tty NULL at the right moment by judicious use of
vhangup, and a remote device can use carrier signals and bit timing to
mount an attack. See tty_port_tty_get() and/or hold the port lock over
the IRQ as other drivers do. For the uart stuff I'd hold the port lock as
the rest of the code in the uart layer sort of assumes that


> +static void mxs_auart_settermios(struct uart_port *u,
> +				 struct ktermios *termios,
> +				 struct ktermios *old)

Minor things here
- You need to set the termios bits to reflect the mode you actually set.
  So as you don't seem to support mark/space you need to clear the bit,
  ditto h/w flow control if not supported

- You also need to report back the actual baud rate


> +static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
> +{
> +	u32 istatus, istat;
> +	struct mxs_auart_port *s = context;
> +	u32 stat = readl(s->port.membase + AUART_STAT);

Your IRQ handler either needs to take the port lock or have the
underlying methods do that or their own full locking, you aren't doing
that.

