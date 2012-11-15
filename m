From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: Comments requested: driver for Quatech PCI serial cards
Date: Fri, 16 Nov 2012 08:53:46 +1030
Message-ID: <20121115222346.GA28869@marvin.atrad.com.au>
References: <20121114060724.GN30156@marvin.atrad.com.au>
 <20121114121222.3e42860f@pyramind.ukuu.org.uk>
 <20121114231054.GC4505@marvin.atrad.com.au>
 <20121114235719.794a9bdc@pyramind.ukuu.org.uk>
 <20121115001110.GE4505@marvin.atrad.com.au>
 <20121115155347.4be3dce8@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server.atrad.com.au ([150.101.241.2]:53212 "EHLO
	server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab2KOWYB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 17:24:01 -0500
Content-Disposition: inline
In-Reply-To: <20121115155347.4be3dce8@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, jwoithe@just42.net

On Thu, Nov 15, 2012 at 03:53:47PM +0000, Alan Cox wrote:
> On Thu, 15 Nov 2012 10:41:10 +1030
> Jonathan Woithe <jwoithe@just42.net> wrote:
> 
> > On Wed, Nov 14, 2012 at 11:57:19PM +0000, Alan Cox wrote:
> > > > our upcoming system.  I'm guessing that the difficulties with the driver as
> > > > it's currently structured may have been the reason it was never pushed to
> > > > mainline by the original author in 2007.
> > > 
> > > There are not many difficulties I can see. You just add the identifiers
> > > to the 8250_pci tables and a couple of small bits of code and everything
> > > but the RS422/485 stuff just works.
> > > 
> > > If you need the RS422 stuff then yes its a bit more work.
> > 
> > Unfortunately we need the RS422 stuff - that's the reason for using the
> > DSC-200/300 card.
> > 
> > Thanks for the comments and feedback - I'll take another look at things in
> > the light of the information.  If the functionality we require requires a
> > significant amount of new code to be written, I suspect that the work will
> > be deemed too time consuming by those who call the shots.  We'll see.
> 
> First guess at what you need except for the RS422 registers is attached. To
> get the RS422 features working needs the tool tracing (or driver printks adding)
> to see what QMCR and QOPR bits map to which RS422 features.
> 
> Given that if you just force the bits you want in with the RS422 warning I expect
> it'll just work for your case and should then be trivial to add the ioctl.

Thanks very much for taking the time to do this.  I'm away from the office
today but will test it on Monday.  I have been given the go-ahead to spend a
small amount of time to see if I can get the DSC card working for our case;
with this patch as a starting point I think progress will be made.

jonathan
