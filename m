From: Greg KH <greg@kroah.com>
Subject: Re: [GIT PULL] tty: serial: imx changes for 3.3
Date: Wed, 4 Jan 2012 16:30:14 -0800
Message-ID: <20120105003014.GA5456@kroah.com>
References: <20120101010411.GB13061@S2100-06.ap.freescale.net>
 <20120105002826.GA2764@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:55307 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932294Ab2AEAbw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jan 2012 19:31:52 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 08E73206A3
	for <linux-serial@vger.kernel.org>; Wed,  4 Jan 2012 19:31:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120105002826.GA2764@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Wed, Jan 04, 2012 at 04:28:26PM -0800, Greg KH wrote:
> On Sun, Jan 01, 2012 at 09:04:12AM +0800, Shawn Guo wrote:
> > Hi Greg,
> > 
> > I collected a few imx tty/serial changes below for 3.3.  Can you please
> > take a look and consider to pull the branch for 3.3 if it looks all
> > good to you?
> > 
> > Regards,
> > Shawn
> > 
> > The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:
> > 
> >   Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)
> 
> Ugh, my tty-next tree is not based on this branch, and I don't see the
> need to cause the merge, so can you just send me the patches as emails
> so that I can apply them that way?

Nevermind, I've picked them out and applied them now.

thanks,

greg k-h
