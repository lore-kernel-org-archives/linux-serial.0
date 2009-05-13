From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] 8250: Don't restore NS16550 mode when console suspend
 is disabled
Date: Tue, 12 May 2009 18:01:33 -0700
Message-ID: <1242176493.9718.76.camel@Joe-AcerAspire>
References: <20090512210015.GA25540@plexity.net>
	 <alpine.LFD.2.01.0905121452190.3343@localhost.localdomain>
	 <20090513011842.22d9cd6c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:1716 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbZEMBCz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 May 2009 21:02:55 -0400
In-Reply-To: <20090513011842.22d9cd6c@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Deepak Saxena <dsaxena@plexity.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2009-05-13 at 01:18 +0100, Alan Cox wrote:
> > Hmm. I already applied this, but then after looking closer, I undid that. 
> > Why? It looks buggy:
> 
> I'm a bit suprised that as tty and serial maintainer this is the first
> time I see the patch.

Perhaps the MAINTAINERS entry for TTY should include
file patterns?

Would this be reasonable?

TTY LAYER
P:      Alan Cox
M:      alan@lxorguk.ukuu.org.uk
L:      linux-kernel@vger.kernel.org
L:      linux-serial@vger.kernel.org
S:      Maintained
F:      drivers/char/tty_*
F:      drivers/serial/serial_core.c
F:      linux/serial_core.h
F:      linux/serial.h
F:      linux/tty.h


