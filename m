From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] SERIAL: discover PNP ports before PCI, etc
Date: Thu, 10 Feb 2005 10:49:22 -0700
Message-ID: <1108057762.29578.29.camel@eeyore>
References: <1107979967.27371.42.camel@eeyore>
	 <20050210021652.GA594@neo.rr.com> <1108053798.29578.12.camel@eeyore>
	 <20050210173725.GA380@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from atlrel7.hp.com ([156.153.255.213]:2284 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262175AbVBJRta (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Feb 2005 12:49:30 -0500
In-Reply-To: <20050210173725.GA380@neo.rr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, shaohua.li@intel.com

On Thu, 2005-02-10 at 12:37 -0500, Adam Belay wrote:
> > Wouldn't it be a bug if PNP described a resource that can be
> > discovered by standard PCI discovery?
> 
> Maybe.  It's usually one of these:
> 
> pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:09: ioport range 0xcf8-0xcff could not be reserved
> pnp: 00:0b: ioport range 0x800-0x87f has been reserved
> 
> The "could not be reserved" was touched by pci.  From memory, I think
> it's the pci configuration range.

Right.  0xcf8-0xcff is reserved in pci_direct_init(), which is
part of the arch PCI core, not part of a driver.  So I don't
think the 8250 PCI/PNP order should make a difference for this
particular range (the arch PCI init happens long before either
8250 PCI or PNP claim).

> > I think we should move PNP before PCI and fix whatever resource
> > problems crop up.
> 
> We could always add this change to -mm and see what effect it has.  Let me
> know if you still think this makes sense.

Yeah, I think that's Russell's plan, which I think is the right one.

