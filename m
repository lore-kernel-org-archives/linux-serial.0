From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/5] altera_uart: Add support for polling mode
 (IRQ-less)
Date: Fri, 1 Oct 2010 17:24:27 +0400
Message-ID: <20101001132427.GA31865@oksana.dev.rtsoft.ru>
References: <20100928133526.GB8289@oksana.dev.rtsoft.ru>
 <20100928154539.GE3137@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65058 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462Ab0JANYd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 09:24:33 -0400
Content-Disposition: inline
In-Reply-To: <20100928154539.GE3137@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 28, 2010 at 05:45:39PM +0200, Tobias Klauser wrote:
[...]
> > -	ret = request_irq(port->irq, altera_uart_interrupt, IRQF_DISABLED,
> > -			DRV_NAME, port);
> > -	if (ret) {
> > -		pr_err(DRV_NAME ": unable to attach Altera UART %d "
> > -		       "interrupt vector=%d\n", port->line, port->irq);
> > -		return ret;
> > -	}
> > -
> >  	spin_lock_irqsave(&port->lock, flags);
> >  
> >  	/* Enable RX interrupts now */
> > @@ -300,6 +304,19 @@ static int altera_uart_startup(struct uart_port *port)
> >  
> >  	spin_unlock_irqrestore(&port->lock, flags);
> 
> Shouldn't we only enable the RX interrupt if we actually use interrupts?

Why would that matter if we don't use the interrupts? ;-)

But I made the change anyway.

> Also I would retain the order here (first register the interrupt handler
> and then enable the interrupts).

OK, fixed. Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
