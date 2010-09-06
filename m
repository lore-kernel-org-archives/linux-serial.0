From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/5] hsu, earlyprintk: add early printk for hsu_port2
 console
Date: Mon, 6 Sep 2010 15:15:42 +0100
Message-ID: <20100906151542.2b155adf@linux.intel.com>
References: <20100906123843.1328.3930.stgit@localhost.localdomain>
	<20100906123908.1328.3598.stgit@localhost.localdomain>
	<20100906141746.GB29291@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60137 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096Ab0IFO62 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Sep 2010 10:58:28 -0400
In-Reply-To: <20100906141746.GB29291@elte.hu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-serial@vger.kernel.org, greg@kroah.com, the arch/x86 maintainers <x86@kernel.org>, feng.tang@intel.com

> Please Cc: x86 patches to the x86 maintainers.

Sure - I should probably have also cc'd Feng - I've forwarded it and
added Feng so it doesn't get missed.

> > +static int hsu_inited;
> 
> 'initialized' is the proper English word i think.

Then we should probably run /sbin/initialize in future ;) inited is
perfectly fine computerspeak and much less typing.

> > +static void early_hsu_init(void)
> > +{
> > +	u8 lcr;
> > +
> > +	if (phsu && hsu_inited)
> > +		return;
> 
> Surely one of those will suffice as a "have we initialized" flag?
> 
> Also, under what circumstances can we call early_hsu_init() twice?

Don't think we can

> > +	/* GPIO workaround */
> > +	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE,
> > MFD_GPIO_HSU_REG);
> > +	phsu = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
> > +			(MFD_GPIO_HSU_REG & (PAGE_SIZE - 1)));
> > +
> > +	*((u32 *)phsu) = 0x55465;
> 
> What does 0x55465 stand for?

It's a firmware fixup. Its a magic value (even to most of us who work
here ;)). Feng - am I right in thinking we don't need that anyway with
the current firmware ?

> > +{
> > +	unsigned int timeout = 10000; /* 10ms*/
> > +	u8 status;
> > +
> > +	while (timeout--) {
> > +		status = readb(phsu + UART_LSR);
> > +		if (status & BOTH_EMPTY)
> > +			break;
> > +
> > +		udelay(1);
> > +	}
> > +
> > +	if (timeout == 0xffffffff)
> > +		return;
> 
> Using the -1 literal will dtrt too, and will be slightly clearer to
> the potentially overworked reader of such patches.

If they have a degree in C sign propagation. Better is probably 

	while (--timeout) {..
	}

