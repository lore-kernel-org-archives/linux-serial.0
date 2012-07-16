From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 06/12] 8250: use the 8250 register interface not the
 legacy one
Date: Mon, 16 Jul 2012 14:29:22 -0700
Message-ID: <20120716212922.GA28072@kroah.com>
References: <20120714142740.26945.98609.stgit@localhost.localdomain>
 <20120714143300.26945.64185.stgit@localhost.localdomain>
 <20120716200950.GB15662@kroah.com>
 <20120716212911.77c996ad@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42162 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754081Ab2GPV3Z (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Jul 2012 17:29:25 -0400
Content-Disposition: inline
In-Reply-To: <20120716212911.77c996ad@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Mon, Jul 16, 2012 at 09:29:11PM +0100, Alan Cox wrote:
> On Mon, 16 Jul 2012 13:09:50 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > On Sat, Jul 14, 2012 at 03:33:13PM +0100, Alan Cox wrote:
> > > From: Alan Cox <alan@linux.intel.com>
> > > 
> > > The old interface just copies bits over and calls the newer one.
> > > In addition we can now pass more information.
> > > 
> > > Updated to fix the cases reported by Stephen Rothwell and those found
> > > by Fegguang's nifty new 0 day build tester. In particular it now builds
> > > correctly for openfirmware and for OLPC.
> > > 
> > > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > 
> > I already applied an older version of this, so it doesn't apply
> > properly.
> > 
> > can you redo this patch series based on my tty-next branch now, and
> > resend these last 6 patches, if they are still needed?
> 
> I can do but that will simply be a series of reverts of the old stuff
> followed by the patches I sent... we need to rewind to before the lock
> change patch or it all ends up impossible to bisect.

Ok, that's fine with me.

greg k-h
