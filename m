From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] SERIAL: discover PNP ports before PCI, etc
Date: Thu, 10 Feb 2005 09:43:18 -0700
Message-ID: <1108053798.29578.12.camel@eeyore>
References: <1107979967.27371.42.camel@eeyore>
	 <20050210021652.GA594@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from atlrel7.hp.com ([156.153.255.213]:3226 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262170AbVBJQnX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Feb 2005 11:43:23 -0500
In-Reply-To: <20050210021652.GA594@neo.rr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, shaohua.li@intel.com

On Wed, 2005-02-09 at 21:16 -0500, Adam Belay wrote:
> On Wed, Feb 09, 2005 at 01:12:47PM -0700, Bjorn Helgaas wrote:
> > PNP ports tend to be built-in, and discovering them after
> > PCI ports means the names of the built-in ports can change
> > if you add or remove PCI ports.
> > 
> > (And yes, we should look at getting rid of 8250_acpi.c
> > now that we have PNPACPI, but that's for another patch.)
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>>
> 
> I think this used to be the old behavior.  It was changed because some
> of the resources reserved by pnp would also be reserved by pci, causing
> pci to fail.  We should see if this is still the case.

That must be before the 2.5 series ...  Everything in the BK
history (which admittedly only goes back to 7/21/2002) has
PCI before PNP.

Wouldn't it be a bug if PNP described a resource that can be
discovered by standard PCI discovery?

I think we should move PNP before PCI and fix whatever resource
problems crop up.

