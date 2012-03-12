From: "Kim, Jong-Sung" <neidhard.kim@lge.com>
Subject: RE: [PATCH] serial: PL011: clear pending interrupts
Date: Mon, 12 Mar 2012 20:22:07 +0900
Message-ID: <01e101cd0042$5bf692a0$13e3b7e0$@lge.com>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com> <20120312083221.GW17370@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:46784 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab2CLLWJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Mar 2012 07:22:09 -0400
In-Reply-To: <20120312083221.GW17370@n2100.arm.linux.org.uk>
Content-Language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Linus Walleij' <linus.walleij@stericsson.com>
Cc: 'Greg Kroah-Hartman' <gregkh@suse.de>, linux-serial@vger.kernel.org, 'Chanho Min' <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, 'Linus Walleij' <linus.walleij@linaro.org>, stable@kernel.org, 'Shreshtha Kumar Sahu' <shreshthakumar.sahu@stericsson.com>

> > diff --git a/drivers/tty/serial/amba-pl011.c
> > b/drivers/tty/serial/amba-pl011.c index 6800f5f..ff3fed0 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -224,6 +224,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port
> *uap)
> >  		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
> >  	}
> >
> 
> What if we really do end up receiving some characters here?

Maybe the character is handled on next upcoming RTIS or RXIS in normal.
However, I agree with you there is possibility of already asserted RXIS at
this point. (with debugger?) In such a case, we may lose Rx interrupts
forever because it's not level-triggered, and the ISR lacks error interrupt
handling. Correct me if something wrong.
Thank you for your comment, Russell.

> 
> > +	/* RXIS but RXFE? Just clear the interrupt */
> > +	if(unlikely(fifotaken == 0))
> > +		writew(UART011_RTIS | UART011_RXIS,
> > +		       uap->port.membase + UART011_ICR);

