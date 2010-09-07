From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 2/5] hsu, earlyprintk: add early printk for hsu_port2
 console
Date: Tue, 7 Sep 2010 09:28:53 +0800
Message-ID: <20100907092853.1aa1aa24@feng-i7>
References: <20100906123843.1328.3930.stgit@localhost.localdomain>
	<20100906123908.1328.3598.stgit@localhost.localdomain>
	<20100906141746.GB29291@elte.hu>
	<20100906151542.2b155adf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11755 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755070Ab0IGBJM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Sep 2010 21:09:12 -0400
In-Reply-To: <20100906151542.2b155adf@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, the arch/x86 maintainers <x86@kernel.org>

On Mon, 6 Sep 2010 22:15:42 +0800
Alan Cox <alan@linux.intel.com> wrote:

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

Yes, it's a fixup for firmware, it set GPIO controller's register to correctly
configure the GPIO lines used by HSU. Latest firmware already fix that, and
it could be removed.

Thank you both for the comments, will try to address them and make a v2.

Thanks,
Feng  


