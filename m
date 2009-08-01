From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] serial/pcmcia: add ID for Advantech card
Date: Sat, 1 Aug 2009 10:15:39 -0700
Message-ID: <20090801171539.GA15250@suse.de>
References: <1249133315-21142-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41508 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbZHAReQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Aug 2009 13:34:16 -0400
Content-Disposition: inline
In-Reply-To: <1249133315-21142-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-pcmcia@lists.infradead.org, KMoorman@transy.edu

On Sat, Aug 01, 2009 at 03:28:35PM +0200, Wolfram Sang wrote:
> Add ID as reported in:
> 
> http://lists.infradead.org/pipermail/linux-pcmcia/2009-May/006127.html
> 
> Reported-by: Kenneth Moorman <KMoorman@transy.edu>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Greg KH <gregkh@suse.de>
> ---
> 
> As this just adds an ID, it might be nice to have in 2.6.31 already. Greg, could
> you pick it up perhaps? Otherwise I'll queue it up in my pcmcia-l2-branch which
> Dominik hopefully pulls for 2.6.32.

I can queue it up for .31, if it missed it, I'll get it added to the
.31-stable tree.

thanks,

greg k-h
