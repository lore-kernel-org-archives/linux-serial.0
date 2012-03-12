From: "Kim, Jong-Sung" <neidhard.kim@lge.com>
Subject: RE: [PATCH] serial: PL011: clear pending interrupts
Date: Mon, 12 Mar 2012 20:28:56 +0900
Message-ID: <01e201cd0043$5010cea0$f0326be0$@lge.com>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com> <20120312083221.GW17370@n2100.arm.linux.org.uk> <20120312101100.GA8649@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:63748 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab2CLL27 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Mar 2012 07:28:59 -0400
In-Reply-To: <20120312101100.GA8649@n2100.arm.linux.org.uk>
Content-Language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Linus Walleij' <linus.walleij@stericsson.com>
Cc: linux-serial@vger.kernel.org, 'Chanho Min' <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, 'Linus Walleij' <linus.walleij@linaro.org>, stable@kernel.org, 'Shreshtha Kumar Sahu' <shreshthakumar.sahu@stericsson.com>

> On Mon, Mar 12, 2012 at 08:32:21AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 12, 2012 at 09:25:50AM +0100, Linus Walleij wrote:
> > > diff --git a/drivers/tty/serial/amba-pl011.c
> > > b/drivers/tty/serial/amba-pl011.c index 6800f5f..ff3fed0 100644
> > > --- a/drivers/tty/serial/amba-pl011.c
> > > +++ b/drivers/tty/serial/amba-pl011.c
> > > @@ -224,6 +224,11 @@ static int pl011_fifo_to_tty(struct
uart_amba_port
> *uap)
> > >  		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
> > >  	}
> > >
> >
> > What if we really do end up receiving some characters here?
> >
> > > +	/* RXIS but RXFE? Just clear the interrupt */
> > > +	if(unlikely(fifotaken == 0))
> > > +		writew(UART011_RTIS | UART011_RXIS,
> > > +		       uap->port.membase + UART011_ICR);
> 
> BTW, I don't see why we need any of this stuff.

Actually, I meant my patch applied alone, not with your patch. My thought
was the problem we're trying to handle is undocumented and is not guaranteed
not to happen again.



