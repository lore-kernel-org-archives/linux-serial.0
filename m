From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [PATCH] 8250: Don't restore NS16550 mode when console suspend
	is disabled
Date: Wed, 13 May 2009 00:28:50 +0000
Message-ID: <20090513002850.GA28422@plexity.net>
References: <20090512210015.GA25540@plexity.net> <alpine.LFD.2.01.0905121452190.3343@localhost.localdomain> <20090513011842.22d9cd6c@lxorguk.ukuu.org.uk>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plexity.net ([206.123.115.38]:40876 "EHLO plexity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbZEMA3o (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 May 2009 20:29:44 -0400
Content-Disposition: inline
In-Reply-To: <20090513011842.22d9cd6c@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On May 13 2009, at 01:18, Alan Cox was caught saying:
> > Hmm. I already applied this, but then after looking closer, I undid that. 
> > Why? It looks buggy:
> 
> I'm a bit suprised that as tty and serial maintainer this is the first
> time I see the patch.

I looked in MAINTAINERS and 8250 is listed as unmaintained. :)

> > Isn't that second test wrong? Should it not be
> > 
> > 	if ((up->capabilities & UART_NATSEMI) &&
> > 		(console_suspend_enabled || !uart_console(&up->port)) {
> > 
> > instead?
> 
> The patch seems totally bogus anyway. If the console was in a high speed
> mode it should be resumed in a high speed mode. What are the actual
> details here.
> 
> Surely if my console is at 230Kbits/sec then resuming it at a totally
> different speed is going to break things for people even if it happens to
> help XO debug ?

The console is not in high speed mode when we suspend. The original 
commit (b5b82df6) just assumes that if it is a NATSEMI device, we 
should set it to high speed mode at resume w/o checking if that 
was the mode we were in when we suspended. 

~Deepak


-- 
In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht

