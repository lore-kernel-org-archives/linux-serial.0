From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/8] n_gsm.c: Implement 3GPP27.010 DLC start-up procedure
 in MUX
Date: Thu, 16 Aug 2012 12:17:02 -0700
Message-ID: <20120816191702.GA15430@kroah.com>
References: <20120813124254.6125.70371.stgit@localhost.localdomain>
 <20120816190104.GA3160@kroah.com>
 <20120816201255.7303f38f@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57576 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754967Ab2HPTRE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Aug 2012 15:17:04 -0400
Content-Disposition: inline
In-Reply-To: <20120816201255.7303f38f@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Thu, Aug 16, 2012 at 08:12:55PM +0100, Alan Cox wrote:
> On Thu, 16 Aug 2012 12:01:04 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > On Mon, Aug 13, 2012 at 01:43:15PM +0100, Alan Cox wrote:
> > > From: xiaojin <jin.xiao@intel.com>
> > > 
> > > In 3GPP27.010 5.8.1, it defined:
> > > The TE multiplexer initiates the establishment of the multiplexer control channel by sending a SABM frame on DLCI 0 using the procedures of clause 5.4.1.
> > > Once the multiplexer channel is established other DLCs may be established using the procedures of clause 5.4.1.
> > > This patch implement 5.8.1 in MUX level, it make sure DLC0 is the first channel to be setup.
> > > 
> > > [or for those not familiar with the specification: it was possible to try
> > >  and open a data connection while the control channel was not yet fully
> > >  open, which is a spec violation and confuses some modems]
> > > 
> > > Signed-off-by: xiaojin <jin.xiao@intel.com>
> > > Tested-by: Yin, Fengwei <fengwei.yin@intel.com>
> > > [tweaked the order we check things and error code]
> > > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > > Cc: The Horsebox <stable@vger.kernel.org>
> > > ---
> > > 
> > >  drivers/tty/n_gsm.c |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > > index 7a4bf30..5c6c2e2 100644
> > > --- a/drivers/tty/n_gsm.c
> > > +++ b/drivers/tty/n_gsm.c
> > > @@ -2889,6 +2889,10 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
> > >  	gsm = gsm_mux[mux];
> > >  	if (gsm->dead)
> > >  		return -EL2HLT;
> > > +	/* If DLCI 0 is not yet fully open return an error. This is ok from a locking
> > > +	   perspective as we don't have to worry about this if DLCI0 is lost */
> > > +	if (gsm->dlci[0] && gsm->dlci[0]->state != DLCI_OPEN) 
> > > +		return -EL2NSYNC;
> > 
> > Odd, what tree did you make this against?
> > 
> > This applies in the gsmtty_init() function, not gsmtty_open(), is that
> > correct?  It also has a bunch of fuzz.
> 
> No it's not correct..  

Odd, git's 3-way merge thinks it figured it out as being ok.

> Ah its colliding with the tty_port changes - my bad. I'll rebase my tree.

Ok, I've applied it now, if there's a fixup needed, please send it
instead.

thanks,

greg k-h
