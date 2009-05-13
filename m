From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: Don't restore NS16550 mode when console suspend
 is disabled
Date: Wed, 13 May 2009 16:35:07 +0100
Message-ID: <20090513163507.556c3832@lxorguk.ukuu.org.uk>
References: <20090512210015.GA25540@plexity.net>
	<alpine.LFD.2.01.0905121452190.3343@localhost.localdomain>
	<20090513011842.22d9cd6c@lxorguk.ukuu.org.uk>
	<20090513002850.GA28422@plexity.net>
	<20090513094409.50c2409f@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.01.0905130755090.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36428 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759847AbZEMPfy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 May 2009 11:35:54 -0400
In-Reply-To: <alpine.LFD.2.01.0905130755090.3343@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dsaxena@plexity.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> So we _could_ just save the mode, but that isn't really what this patch is 
> all about. The patch in question is about a total hack to avoid touching a 
> piece of hardware that we simply don't consider normal.

The driver knows and assumes the chip is stuck back into the right
configuration. Things like ttyS0 shared as console and tty won't work
right if we simply pray the configuration comes back sane. It may well do
on OLPC but on a standard generic PC we can't bet on it. If the user has
a high console speed set this patch will do the wrong thing.

No suspend console meaning "I'd like to debug suspend/resume" is only
useful if we actually put the bits back into a sane state coming out of
suspend to ram (and in some cases suspend to disk)

Deepak's original patch from 2008 is actually much better. He puts the
chip back in the right hardware configuration for the speed. He doesn't
randomly regress other platforms and configurations and he does it by
calling the standard methods in the driver to do the job.

http://dev.laptop.org/~dsaxena/patches/console_suspend_old.patch

It also has another advantage - it fixes the behaviour for almost
everything in drivers/serial not just a specific uart. Technically he
should take tty->termios_mutex before state->mutex in that code path as
the upstream code has changed but in every other respect its the proper
solution.

So can we apply Deepak's original correct 2008 patch instead please ?

Alan
