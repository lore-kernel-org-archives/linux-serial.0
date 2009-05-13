From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: Don't restore NS16550 mode when console suspend
 is disabled
Date: Wed, 13 May 2009 09:44:09 +0100
Message-ID: <20090513094409.50c2409f@lxorguk.ukuu.org.uk>
References: <20090512210015.GA25540@plexity.net>
	<alpine.LFD.2.01.0905121452190.3343@localhost.localdomain>
	<20090513011842.22d9cd6c@lxorguk.ukuu.org.uk>
	<20090513002850.GA28422@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43873 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753868AbZEMIoH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 May 2009 04:44:07 -0400
In-Reply-To: <20090513002850.GA28422@plexity.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dsaxena@plexity.net
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> > Surely if my console is at 230Kbits/sec then resuming it at a totally
> > different speed is going to break things for people even if it happens to
> > help XO debug ?
> 
> The console is not in high speed mode when we suspend. The original 
> commit (b5b82df6) just assumes that if it is a NATSEMI device, we 
> should set it to high speed mode at resume w/o checking if that 
> was the mode we were in when we suspended.

Then hard coding is no improvement either. It needs to restore the mode
that was present at suspend.

I'll update the 8250 Maintainers entry I suppose, I seem to have been
landed it as part of tty 8)
