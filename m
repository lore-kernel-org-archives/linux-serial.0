From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Add support for a no-name 4 ports multiserial card
Date: Fri, 6 Jun 2008 20:40:36 +0100
Message-ID: <20080606194036.GB18231@flint.arm.linux.org.uk>
References: <1212736393-6837-1-git-send-email-catab@embedromix.ro> <20080606111400.1eefc4fd@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55093 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376AbYFFTk6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jun 2008 15:40:58 -0400
Content-Disposition: inline
In-Reply-To: <20080606111400.1eefc4fd@core>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Catalin(ux) M BOIE" <catab@embedromix.ro>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Jun 06, 2008 at 11:14:00AM +0100, Alan Cox wrote:
> On Fri,  6 Jun 2008 10:13:13 +0300
> "Catalin(ux) M BOIE" <catab@embedromix.ro> wrote:
> 
> > It is a no-name PCI card. I found no reference to a producer so I
> > used the fake name "PDR".
> 
> We don't really want to get fake names into pci_ids. I'd rather
> 
> 
> >  		.vendor		= PCI_VENDOR_ID_PLX,
> > +		.device		= PCI_DEVICE_ID_PLX_9050,
> > +		.subvendor	= PCI_VENDOR_ID_PLX,
> > +		.subdevice	= PCI_SUBDEVICE_ID_PDR,
> 
> Either the hex or a local and obviously unknown name like ID_UNKNOWN_1
> 
> 
> > +	pbn_plx_pdr,
> 
> _unknown1
> 
> >  	pbn_oxsemi,
> >  	pbn_intel_i960,
> >  	pbn_sgi_ioc3,
> > @@ -1186,6 +1196,13 @@ static struct pciserial_board pci_boards[] __devinitdata = {
> >  		.base_baud	= 115200,
> >  		.uart_offset	= 8,
> >  	},
> > +	/* PDR */
> > +	[pbn_plx_pdr] = {
> 
> Ditto
> 
> > +	/* PDR */
> 
> Ditto
> 
> > +	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
> > +		PCI_VENDOR_ID_PLX,
> > +		PCI_SUBDEVICE_ID_PDR, 0, 0,
> 
> Ditto
> 
> 
> > +#define PCI_SUBDEVICE_ID_PDR		0x1584
> > +
> 
> And not in here at all.

And there's no need for half the patch either - which I tried to explain
in a previous reply to Catalin but I just got repeated "My email address
has changed to ..." responses... so I gave up.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
