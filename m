From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [parisc-linux] Console Kernel Panic
Date: Tue, 20 Dec 2005 09:42:29 -0700
Message-ID: <20051220164229.GX2361@parisc-linux.org>
References: <ce7b5dcee759.cee759ce7b5d@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:27871 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751125AbVLTQmb
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Dec 2005 11:42:31 -0500
Content-Disposition: inline
In-Reply-To: <ce7b5dcee759.cee759ce7b5d@shaw.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Keven Tipping <bytelogix@shaw.ca>
Cc: parisc-linux@lists.parisc-linux.org, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Mon, Dec 19, 2005 at 08:50:18PM -0700, Keven Tipping wrote:
> I am currently running Kernel version 2.6.15-rc6-pa1.
> 
> This problem, however, is evident in 2.6.14.3-pa0, and 2.6.15-rc5-pa5, as well as 2.6.12.2 (Gentoo 2005 LiveCD). Problem remains regardless of SMP or Uniprocessor kernels.
> 
> On the K Class (it appears it is limited to these machines?), if nothing is currently running on the ttyB0 Serial Console, if you press any key, the system burps up the following:
> 
> Kernel Panic: Kernel Fault
> Not Syncing...
> 
> What I mean by "nothing running" is if Agetty is NOT running, NOR is Bash. 

I really think you could have provided the useful bits from a kernel panic
here.  Please see http://www.parisc-linux.org/faq/kernelbug-howto.html

However, I've reproduced it myself.  Here's the relevant bits:

 IAOQ[0]: mux_read+0x4c/0x17c
 IAOQ[1]: mux_read+0x50/0x17c
 RP(r2): mux_poll+0x78/0x88

The instruction faulting is:

  4c:   48 94 02 28     ldw 114(,r4),r20

which corresponds to the load of flip.count:

                if (tty->flip.count >= TTY_FLIPBUF_SIZE)
			continue;

ie the 'tty' variable is NULL at this point.

Alan, you seem to have the tarbaby for ttys at the moment ... any idea
why port->info->tty would be NULL?  The corresponding routine in 8250.c
(receive_chars()) doesn't check for tty being NULL.  So is there
some non-obvious check the MUX driver is missing, or is this a latent
problem in 8250 too?

