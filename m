From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] tty: add a DesignWare 8250 driver
Date: Fri, 26 Aug 2011 10:57:11 -0700
Message-ID: <20110826175711.GA15324@kroah.com>
References: <1314368925-13097-1-git-send-email-jamie@jamieiles.com>
 <201108261804.02784.arnd@arndb.de>
 <20110826162021.GC2802@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48992 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752182Ab1HZR65 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 13:58:57 -0400
Content-Disposition: inline
In-Reply-To: <20110826162021.GC2802@pulham.picochip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Fri, Aug 26, 2011 at 05:20:21PM +0100, Jamie Iles wrote:
> On Fri, Aug 26, 2011 at 06:04:02PM +0200, Arnd Bergmann wrote:
> > On Friday 26 August 2011, Jamie Iles wrote:
> > > The Synopsys DesignWare 8250 is an 8250 that has an extra interrupt that
> > > gets raised when writing to the LCR when busy.  To handle this we need
> > > special serial_out, serial_in and handle_irq methods.  Add a new
> > > platform driver that uses these accessors.
> > > 
> > > Cc: Alan Cox <alan@linux.intel.com>
> > > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > 
> > The driver looks good to me,
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Is the patch to export serial8250_handle_irq already in Greg's tree or is that
> > still missing?
> 
> No, and I really don't know how I missed it.  I was sure an allmodconfig 
> build worked, but perhaps 8250_dw wasn't selected.  Anyhow, here's the 
> patch that does that.
> 
> Apologies again for making such a mess out of this series!
> 
> Thanks,
> 
> Jamie
> 
> 8<---
> 
> From: Jamie Iles <jamie@jamieiles.com>
> Subject: [PATCH] tty: 8250: export serial8250_handle_irq
> 
> Allow modules to use the normal 8250 irq handler inside their own.

So this patch needs to be applied before the first one here, right?

Care to just resend the patches again, in the right order, so I am sure
to get it correct?

confused,

greg k-h
