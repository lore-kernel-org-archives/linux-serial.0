From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] make 8250_pnp use pnp_manual_config_dev()
Date: Wed, 11 May 2005 16:24:32 -0400
Message-ID: <20050511202432.GA2720@neo.rr.com>
References: <20050510121521.GB4676@cathedrallabs.org> <20050510135128.C3358@flint.arm.linux.org.uk> <20050510130715.GF3907@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:53959 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S262043AbVEKUab (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 May 2005 16:30:31 -0400
Content-Disposition: inline
In-Reply-To: <20050510130715.GF3907@cathedrallabs.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org

On Tue, May 10, 2005 at 10:07:15AM -0300, Aristeu Sergio Rozanski Filho wrote:
> > > Hi,
> > > 	this patch makes 8250_pnp use pnp_manual_config_dev() so
> > > 	pnp_reserve_{io,irq} option will be valid for serial ports too.
> > > 	Please consider applying

pnp_manual_config_dev is intented for drivers that use different
resource assignments than those automatically set by PnP.  It looks
like you're passing the same config back.

Could you please explain your rational here further.

Values already assigned by the BIOS are not checked against reserved
regions.  Is this what you're getting it?  If so, we could have double
detection issues between the PnP protocol and the legacy detection
mechanism.


> > 
> > Please copy this to Adam Belay.  There are some problems with PNP
> > serial ports because they can clash with with standard addresses
> > for x86 ports.

Ideally, I think we should avoid legacy probing if PnPBIOS or ACPI is
available.  When serial console is enabled we could have an exception.
What do you think?

> > 
> > We don't particularly want to reconfigure the standard x86 ports
> > to some other addresses just because we've already detected them
> > and claimed their resources external to PNP.
> OK, adding Adam Belay to CC and attaching the patch again.
> 
> --
> Aristeu

Thanks,
Adam

