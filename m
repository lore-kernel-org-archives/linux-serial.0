From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [PATCH] 8250: Don't restore NS16550 mode when console suspend
	is disabled
Date: Wed, 13 May 2009 00:34:51 +0000
Message-ID: <20090513003451.GB28422@plexity.net>
References: <20090512210015.GA25540@plexity.net> <alpine.LFD.2.01.0905121452190.3343@localhost.localdomain>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plexity.net ([206.123.115.38]:35621 "EHLO plexity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756809AbZEMAfo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 May 2009 20:35:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0905121452190.3343@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On May 12 2009, at 15:00, Linus Torvalds was caught saying:
> 
> Hmm. I already applied this, but then after looking closer, I undid that. 
> Why? It looks buggy:
> 
> > -	if (up->capabilities & UART_NATSEMI) {
> > +	if ((up->capabilities & UART_NATSEMI) && 
> > +	     (!uart_console(&up->port) && console_suspend_enabled)) {
> >  		unsigned char tmp;
> 
> Isn't that second test wrong? Should it not be
> 
> 	if ((up->capabilities & UART_NATSEMI) &&
> 		(console_suspend_enabled || !uart_console(&up->port)) {
> 
> instead?

Yep, thinko on my end.

> 	/*
> 	 * Suspend the uart port unless it's a console. 
> 	 *
> 	 * But suspend even consoles if "console_suspend_enabled"
> 	 * is set.
> 	 */
> 	static inline int do_suspend_uart(struct uart_port *port)
> 	{
> 		return console_suspend_enabled || !uart_console(port);
> 	}
> 
> and then make all these things (including the _existing_ cases in 
> uart_suspend_port() use that helper function, rather than writing it out.

Sounds good. Alan?

~Deepak

-- 
In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht

