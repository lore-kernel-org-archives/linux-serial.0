From: ambx1@neo.rr.com (Adam Belay)
Subject: Re: [PATCH] SERIAL: discover PNP ports before PCI, etc
Date: Wed, 9 Feb 2005 21:16:52 -0500
Message-ID: <20050210021652.GA594@neo.rr.com>
References: <1107979967.27371.42.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:49285 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S262014AbVBJCWX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Feb 2005 21:22:23 -0500
Content-Disposition: inline
In-Reply-To: <1107979967.27371.42.camel@eeyore>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, shaohua.li@intel.com

On Wed, Feb 09, 2005 at 01:12:47PM -0700, Bjorn Helgaas wrote:
> PNP ports tend to be built-in, and discovering them after
> PCI ports means the names of the built-in ports can change
> if you add or remove PCI ports.
> 
> (And yes, we should look at getting rid of 8250_acpi.c
> now that we have PNPACPI, but that's for another patch.)
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>

I think this used to be the old behavior.  It was changed because some
of the resources reserved by pnp would also be reserved by pci, causing
pci to fail.  We should see if this is still the case.

Thanks,
Adam

