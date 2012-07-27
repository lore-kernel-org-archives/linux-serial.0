From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: The new version of the driver MAX3107.
Date: Fri, 27 Jul 2012 16:29:09 +0100
Message-ID: <20120727162909.38244772@bob.linux.org.uk>
References: <1343401309-14862-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23611 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab2G0PMF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2012 11:12:05 -0400
In-Reply-To: <1343401309-14862-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


> +static void max3107_handle_rx(struct max3107_port *s, unsigned int
> rxlen) +{
> +	unsigned int status, ch, flag;
> +	struct tty_struct *tty = s->port.state->port.tty;

This all wants to be using tty_port_tty_get() and tty_kref_put - thats
a problem from the original of course. tty could also be NULL.

>
> +	tty = port->state->port.tty;
> +	if (!tty)
> +		return;

This seems to be a meaninless test ?

> +
> +	/* Word size */
> +	if ((termios->c_cflag & CSIZE) == CS7)
> +		lcr = MAX3107_LCR_WORD_LEN_7;
> +	else
> +		lcr = MAX3107_LCR_WORD_LEN_8;

Should also write back the word size actually used if we can't see that
which was requested (ie mask ~CSIZE and | CS8 in the CS5/6 case)


> +static volatile int driver_registered = 0;

Shouldn't need a volatile. Module load/unload are serialized for
obvious reasons.

Looks a very improved driver.

Alan
