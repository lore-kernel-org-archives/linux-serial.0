From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Comments requested: driver for Quatech PCI serial cards
Date: Wed, 14 Nov 2012 23:57:19 +0000
Message-ID: <20121114235719.794a9bdc@pyramind.ukuu.org.uk>
References: <20121114060724.GN30156@marvin.atrad.com.au>
	<20121114121222.3e42860f@pyramind.ukuu.org.uk>
	<20121114231054.GC4505@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53214 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab2KNXwG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 18:52:06 -0500
In-Reply-To: <20121114231054.GC4505@marvin.atrad.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: linux-serial@vger.kernel.org

On Thu, 15 Nov 2012 09:40:54 +1030
Jonathan Woithe <jwoithe@just42.net> wrote:

> On Wed, Nov 14, 2012 at 12:12:22PM +0000, Alan Cox wrote:
> > >  - the name of the module.  Anything with "qt" in it will confuse people.
> > >    I'm thinking along the lines of serial-quatech or quatech-serial:
> > >    comments welcome.
> > 
> > qt is fine in kernel - just be careful of the qt usb module.
> 
> Ok.
> 
> > I think in the same place I'd start by just adding the needed identifiers
> > to the 8250_pci driver along with any needed init helper.
> 
> Is this in relation to the proposed signal routing API?

No in relation to throwing that driver away and doing it right.

> supplied by Quatech (which are not opensource unfortunately) will not be
> compatible with the new driver, necessitating the writing of new replacement
> userspace utilities.

tragedy 8)

> > As far as I can see the issues are
> > 
> > 1.	Clock multiplier feature
> > 
> > Supportable by flags in 8250.c and worst case by providing a custom
> > set_termios. No API needed.
> > 
> > 2.	RS485/RS422 options
> > 
> > Supportable by adding TIOCRS485 handling/callout to 8250.c (needs doing
> > anyway)
> 
> Based on this, is it fair to say that the driver in its current basic form
> (clean-ups notwithstanding) cannot be considered for inclusion in mainline?

It is.

> our upcoming system.  I'm guessing that the difficulties with the driver as
> it's currently structured may have been the reason it was never pushed to
> mainline by the original author in 2007.

There are not many difficulties I can see. You just add the identifiers
to the 8250_pci tables and a couple of small bits of code and everything
but the RS422/485 stuff just works.

If you need the RS422 stuff then yes its a bit more work.

Alan
