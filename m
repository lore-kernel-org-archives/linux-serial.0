From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/5] hsu, earlyprintk: add early printk for hsu_port2
 console
Date: Mon, 6 Sep 2010 18:18:20 +0200
Message-ID: <20100906161820.GA6241@elte.hu>
References: <20100906123843.1328.3930.stgit@localhost.localdomain>
 <20100906123908.1328.3598.stgit@localhost.localdomain>
 <20100906141746.GB29291@elte.hu>
 <20100906151542.2b155adf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:48466 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790Ab0IFQSc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Sep 2010 12:18:32 -0400
Content-Disposition: inline
In-Reply-To: <20100906151542.2b155adf@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, greg@kroah.com, the arch/x86 maintainers <x86@kernel.org>, feng.tang@intel.com


* Alan Cox <alan@linux.intel.com> wrote:

> > Please Cc: x86 patches to the x86 maintainers.
> 
> Sure - I should probably have also cc'd Feng - I've forwarded it and
> added Feng so it doesn't get missed.

thx.

> > > +static int hsu_inited;
> > 
> > 'initialized' is the proper English word i think.
> 
> Then we should probably run /sbin/initialize in future ;) [...]

Fortunately there's no /sbin/inited.

> [...] inited is perfectly fine computerspeak and much less typing.

It's a distinctly annoying grammar mistake (to me at least) and it only 
comes up very rarely in the kernel - which has its fair share of 
annoying grammar otherwise.

As per a quick & dirty 'git grep' run we have 4267 (96%) instances of 
'initialized' and only 174 (4%) 'inited' instances usage right now.

hsu_init_done might be a compromise?

But ... no strong feelings in any case. If you the native speaker are 
not annoyed by reading 'inited' then i guess i'm in the minority.

> > > +static void early_hsu_init(void)
> > > +{
> > > +	u8 lcr;
> > > +
> > > +	if (phsu && hsu_inited)
> > > +		return;
> > 
> > Surely one of those will suffice as a "have we initialized" flag?
> > 
> > Also, under what circumstances can we call early_hsu_init() twice?
> 
> Don't think we can
> 
> > > +	/* GPIO workaround */
> > > +	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE,
> > > MFD_GPIO_HSU_REG);
> > > +	phsu = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
> > > +			(MFD_GPIO_HSU_REG & (PAGE_SIZE - 1)));
> > > +
> > > +	*((u32 *)phsu) = 0x55465;
> > 
> > What does 0x55465 stand for?
> 
> It's a firmware fixup. Its a magic value (even to most of us who work 
> here ;)). Feng - am I right in thinking we don't need that anyway with 
> the current firmware ?

If it's some magic number it's worth symbolizing it - keeping future 
generations of happy mrst hackers from wondering at that incantation.

> 
> > > +{
> > > +	unsigned int timeout = 10000; /* 10ms*/
> > > +	u8 status;
> > > +
> > > +	while (timeout--) {
> > > +		status = readb(phsu + UART_LSR);
> > > +		if (status & BOTH_EMPTY)
> > > +			break;
> > > +
> > > +		udelay(1);
> > > +	}
> > > +
> > > +	if (timeout == 0xffffffff)
> > > +		return;
> > 
> > Using the -1 literal will dtrt too, and will be slightly clearer to
> > the potentially overworked reader of such patches.
> 
> If they have a degree in C sign propagation.

My 8yo son knows it that the next number below zero is -1, and he 
distinctly has no degree in C sign propagation rules. But you are right 
to point out the correct solution:

> [...] Better is probably 
> 
> 	while (--timeout) {..
> 	}

indeed.

Thanks,

	Ingo
