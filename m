From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 06/12] 8250: use the 8250 register interface not the
 legacy one
Date: Mon, 16 Jul 2012 13:09:50 -0700
Message-ID: <20120716200950.GB15662@kroah.com>
References: <20120714142740.26945.98609.stgit@localhost.localdomain>
 <20120714143300.26945.64185.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48601 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752797Ab2GPUJw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Jul 2012 16:09:52 -0400
Content-Disposition: inline
In-Reply-To: <20120714143300.26945.64185.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Sat, Jul 14, 2012 at 03:33:13PM +0100, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> The old interface just copies bits over and calls the newer one.
> In addition we can now pass more information.
> 
> Updated to fix the cases reported by Stephen Rothwell and those found
> by Fegguang's nifty new 0 day build tester. In particular it now builds
> correctly for openfirmware and for OLPC.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

I already applied an older version of this, so it doesn't apply
properly.

can you redo this patch series based on my tty-next branch now, and
resend these last 6 patches, if they are still needed?

thanks,

greg k-h
