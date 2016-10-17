From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Mon, 17 Oct 2016 11:41:40 -0500
Message-ID: <20161017164140.GA35950@stormcage.americas.sgi.com>
References: <20161017144951.GA235535@stormcage.americas.sgi.com>
 <20161017151906.GA19082@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161017151906.GA19082@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Nathan Zimmer <nzimmer@sgi.com>, linux-kernel@vger.kernel.org, linux-serial@vgr.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

Ok I'll get that sometime tomorrow.  Right now they pulled it down maintenance...

On Mon, Oct 17, 2016 at 04:19:07PM +0100, Sean Young wrote:
> On Mon, Oct 17, 2016 at 09:49:51AM -0500, Nathan Zimmer wrote:
> > A cluster client recently tried to update from Sles11 to Sles12 and found in
> > some cases the boxes would hang in early boot.  It came down to console=ttyS1
> > on the command line.  After a bisection I found it happended in here:
> > 
> > commit 835d844d1a28efba81d5aca7385e24c29d3a6db2
> > Author: Sean Young <sean@mess.org>
> > Date:   Fri Sep 7 19:06:23 2012 +0100
> > 
> >     8250_pnp: do pnp probe before legacy probe
> > 
> > 
> > I found I can revert the part of the patch in 8250.c (now 8250_core.c) and
> > the hangs do not happen.
> > 
> > Bios of the offending box ( I don't know if there a bios update )
> > Version 2.15.1234. Copyright (C) 2012 American Megatrends, Inc.
> > BIOS Date: 02/05/2014 13:45:09
> > Ver: ma2e2054.16I
> > 
> > I don't have much more info but will collect anything that is asked.
> > Any help would be appeciated.
> 
> The console output would be helpful (both before 3.6 and with 3.6). It 
> could be that what the bios provides in pnp does not match the actual
> config.
> 
> The output of:
> 
> cat /sys/bus/pnp/drivers/serial/*/resources
> 
> Would be helpful, thanks.
> 
> 
> Sean
