From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] tty: serial: altera_uart: Check for NULL platform_data
 in probe.
Date: Fri, 30 Mar 2012 08:32:37 +0200
Message-ID: <20120330063237.GX21503@distanz.ch>
References: <1333007727-24045-1-git-send-email-tklauser@distanz.ch>
 <20120329193855.GW21503@distanz.ch>
 <20120329194711.GB12194@kroah.com>
 <2271072.B4UpndiPVz@hyrum>
 <20120329213957.GC15231@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:42673 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab2C3Gci (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 30 Mar 2012 02:32:38 -0400
Content-Disposition: inline
In-Reply-To: <20120329213957.GC15231@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yuriy Kozlov <ykozlov@ptcusa.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On 2012-03-29 at 23:39:57 +0200, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Thu, Mar 29, 2012 at 04:02:07PM -0400, Yuriy Kozlov wrote:
> > On Thursday, March 29, 2012 12:47:11 Greg Kroah-Hartman wrote:
> > > On Thu, Mar 29, 2012 at 09:38:55PM +0200, Tobias Klauser wrote:
> > > > On 2012-03-29 at 18:13:37 +0200, Greg Kroah-Hartman 
> > <gregkh@linuxfoundation.org> wrote:
> > > > > On Thu, Mar 29, 2012 at 09:55:27AM +0200, Tobias Klauser wrote:
> > > > > > From: Yuriy Kozlov <ykozlov@ptcusa.com>
> > > > > > 
> > > > > > Follow altera_jtag_uart.  This fixes a crash if there is a mistake in
> > > > > > the DTS.> > 
> > > > > Is this something you have seen in the wild?  Is this something to be
> > > > > backported to stable kernels?
> > > > 
> > > > Not that I know of. But nevertheless it might be worthwhile. Shall I
> > > > send the patch again with Cc: stable@kernel.org?
> > > 
> > > Nope, I can add it.
> > > 
> > > But, if this isn't something that you have seen, why is it needed to be
> > > checked for?  What is this making work properly that isn't working
> > > properly now?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > The driver is designed to use Device Tree to get hardware information, so 
> > platp (platform_data) is usually NULL.  platform_data is still used as a 
> > fallback mechanism.  The problem arises when the device is in the DT, but is 
> > missing a required property (address or irq).  The driver falls back to 
> > looking for it in the null platp and panics.  The function actually already 
> > checks platp for other properties later on, but under this condition it tried 
> > to dereference it before the null checks.
> 
> And again, does this happen today in the 3.4-rc1 kernel?  3.3?  3.2?
> 3.0?  Something else?

It's present in all of them, since 2.6.37 when devicetree support for
the driver was added. So it could potentially be triggered in all of
them.

> If not, then why make this change?  If so, it needs to go to older
> kernels, right?

If Yuriy has seen this in the wild, I'd suggest it should got in then.
Please let me know if I should redo the patch against the older version.

Thanks a lot
Tobias
