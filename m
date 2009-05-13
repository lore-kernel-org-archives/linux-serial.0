From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: Don't restore NS16550 mode when console suspend
 is disabled
Date: Wed, 13 May 2009 01:18:42 +0100
Message-ID: <20090513011842.22d9cd6c@lxorguk.ukuu.org.uk>
References: <20090512210015.GA25540@plexity.net>
	<alpine.LFD.2.01.0905121452190.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46870 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757718AbZEMASl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 May 2009 20:18:41 -0400
In-Reply-To: <alpine.LFD.2.01.0905121452190.3343@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Deepak Saxena <dsaxena@plexity.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> Hmm. I already applied this, but then after looking closer, I undid that. 
> Why? It looks buggy:

I'm a bit suprised that as tty and serial maintainer this is the first
time I see the patch.

> Isn't that second test wrong? Should it not be
> 
> 	if ((up->capabilities & UART_NATSEMI) &&
> 		(console_suspend_enabled || !uart_console(&up->port)) {
> 
> instead?

The patch seems totally bogus anyway. If the console was in a high speed
mode it should be resumed in a high speed mode. What are the actual
details here.

Surely if my console is at 230Kbits/sec then resuming it at a totally
different speed is going to break things for people even if it happens to
help XO debug ?
