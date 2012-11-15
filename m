From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: Comments requested: driver for Quatech PCI serial cards
Date: Thu, 15 Nov 2012 10:41:10 +1030
Message-ID: <20121115001110.GE4505@marvin.atrad.com.au>
References: <20121114060724.GN30156@marvin.atrad.com.au>
 <20121114121222.3e42860f@pyramind.ukuu.org.uk>
 <20121114231054.GC4505@marvin.atrad.com.au>
 <20121114235719.794a9bdc@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server.atrad.com.au ([150.101.241.2]:48576 "EHLO
	server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933000Ab2KOAL1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 19:11:27 -0500
Content-Disposition: inline
In-Reply-To: <20121114235719.794a9bdc@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, jwoithe@just42.net

On Wed, Nov 14, 2012 at 11:57:19PM +0000, Alan Cox wrote:
> > our upcoming system.  I'm guessing that the difficulties with the driver as
> > it's currently structured may have been the reason it was never pushed to
> > mainline by the original author in 2007.
> 
> There are not many difficulties I can see. You just add the identifiers
> to the 8250_pci tables and a couple of small bits of code and everything
> but the RS422/485 stuff just works.
> 
> If you need the RS422 stuff then yes its a bit more work.

Unfortunately we need the RS422 stuff - that's the reason for using the
DSC-200/300 card.

Thanks for the comments and feedback - I'll take another look at things in
the light of the information.  If the functionality we require requires a
significant amount of new code to be written, I suspect that the work will
be deemed too time consuming by those who call the shots.  We'll see.

Regards
  jonathan
