From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/12] 8250: use the 8250 register interface not the
 legacy one
Date: Mon, 16 Jul 2012 21:29:11 +0100
Message-ID: <20120716212911.77c996ad@pyramind.ukuu.org.uk>
References: <20120714142740.26945.98609.stgit@localhost.localdomain>
	<20120714143300.26945.64185.stgit@localhost.localdomain>
	<20120716200950.GB15662@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36169 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab2GPUZa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Jul 2012 16:25:30 -0400
In-Reply-To: <20120716200950.GB15662@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

On Mon, 16 Jul 2012 13:09:50 -0700
Greg KH <greg@kroah.com> wrote:

> On Sat, Jul 14, 2012 at 03:33:13PM +0100, Alan Cox wrote:
> > From: Alan Cox <alan@linux.intel.com>
> > 
> > The old interface just copies bits over and calls the newer one.
> > In addition we can now pass more information.
> > 
> > Updated to fix the cases reported by Stephen Rothwell and those found
> > by Fegguang's nifty new 0 day build tester. In particular it now builds
> > correctly for openfirmware and for OLPC.
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> I already applied an older version of this, so it doesn't apply
> properly.
> 
> can you redo this patch series based on my tty-next branch now, and
> resend these last 6 patches, if they are still needed?

I can do but that will simply be a series of reverts of the old stuff
followed by the patches I sent... we need to rewind to before the lock
change patch or it all ends up impossible to bisect.

Alan
