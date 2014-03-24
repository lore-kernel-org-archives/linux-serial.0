From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/8] tty/serial: add generic serial earlycon
Date: Mon, 24 Mar 2014 12:29:07 +0100
Message-ID: <9368307.RXEGmQia1C@wuerfel>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com> <1395436128-11244-5-git-send-email-robherring2@gmail.com> <20140324112203.GD3850@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61525 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbaCXL3R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Mar 2014 07:29:17 -0400
In-Reply-To: <20140324112203.GD3850@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Rob Herring <robherring2@gmail.com>, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Monday 24 March 2014 11:22:03 Catalin Marinas wrote:
> On Fri, Mar 21, 2014 at 09:08:44PM +0000, Rob Herring wrote:
> > diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> > new file mode 100644
> > index 0000000..241757a
> > --- /dev/null
> > +++ b/drivers/tty/serial/earlycon.c
> [...]
> > +static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
> > +{
> > +	void __iomem *base;
> > +#ifdef CONFIG_FIX_EARLYCON_MEM
> > +	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, paddr & PAGE_MASK);
> > +	base = (void __iomem *)__fix_to_virt(FIX_EARLYCON_MEM_BASE);
> > +	base += paddr & ~PAGE_MASK;
> > +#else
> > +	base = ioremap_nocache(paddr, size);
> > +#endif
> 
> Just curious why not set_fixmap_io (and plain ioremap)?

Good point. Note that ioremap_nocache() is the same as ioremap()
on *all* architectures.

	Arnd
