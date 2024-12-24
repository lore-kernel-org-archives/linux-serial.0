Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EED8836;
	Tue, 24 Dec 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055956; cv=none; b=LiGyM5jllo/y74+brdpkjzuHPDHF5D+KDK5webs7wuzRNYm47iKLYytsSWNxmAmaocL3bGrzxecdbbpmFhBzmSmYdiPdhkJ2Ue7GKM8Se5psQLZ2phfqoOuxfDCjBclv8+IY02CTDod98t22QzqAstQX95SgjIpL1UEojmuZjHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055956; c=relaxed/simple;
	bh=8v5yLbLIGTe3kVGayuc7pj+GZe8ZDuE4DgDXUfp6lwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbcmyOby9nbT0Qo5ybC8MfjuaHQdR8vpmh9z6c2BCxdRzrva7ZYfqFbN/32gUvXbmUmpvR2TZhKYDQh9NEK81qsmaTdLIZMmzWvJS5DtdjGWFcKFca3Md0UO1eenqGc76WadsDVhN+B4Lh9UV4Iv2ExCShUUnPJ5ezSqGyBeQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpyMH4Ka; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpyMH4Ka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735055954; x=1766591954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8v5yLbLIGTe3kVGayuc7pj+GZe8ZDuE4DgDXUfp6lwE=;
  b=jpyMH4Kap7Q85+E4lFMOa9aC+SQeot/5uvDPk3DMRxfEndJ8LUh9B7+w
   bF7FuSlUfPePHD4tXW1m2T4oPIaGvqEhFsnxObxSrxTQI/IkvPZWhXtk9
   XpIBKdPFK5rGQGmTk0Mddx4RQO6WVXFTPz8jEhWJ72iMEh/Aa2zYZ42Bz
   mKKZdWtRXwSV2QUtpbc/wvzIECs28N/RnXK0o1SzapylEvvF+OQg504jG
   6kSxlWP1G7svk5veBwrZzexpoV0u0p7TyLESvKAgkpjJ84u9prRdls/QP
   UQYX/Ewh/cfaGQNqfUrTdrLlFCsXbmq74YOzwxJ8p23EBsmMX2Ia+zpjx
   Q==;
X-CSE-ConnectionGUID: KjD5RSU+Ts61oijjE7Kr7w==
X-CSE-MsgGUID: m0L5rYRTQi+uEgpdPFVCTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="34800493"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="34800493"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 07:59:14 -0800
X-CSE-ConnectionGUID: APtv6tCkSCO9aj32w2zhBw==
X-CSE-MsgGUID: jpbpfLE3T1mUbZ5gq+vrLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="99604002"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 07:59:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tQ7JK-0000000BlNa-3lzm;
	Tue, 24 Dec 2024 17:59:06 +0200
Date: Tue, 24 Dec 2024 17:59:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH tty-next v1 1/4] serial: 8250: Use @ier bits to determine
 if Rx is stopped
Message-ID: <Z2raSoNcj0xlbiWF@smile.fi.intel.com>
References: <Z2CQ8NvNhIOpPcBn@smile.fi.intel.com>
 <84ed22h8u0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ed22h8u0.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 20, 2024 at 12:56:31PM +0106, John Ogness wrote:
> On 2024-12-16, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> > Use the UART_IER_RLSI and UART_IER_RDI bits in @ier instead, as
> >> > this is already common in 8250-variants and drivers.
> >> 
> >> Hmm... IER is Interrupt Enable Register, so it has been programmed to the value
> >> we control, on the opposite the LSR is Line Status Register and defines status
> >> on the line at the moment of reading. Can you elaborate how your change is correct
> >> substitute?
> 
> The change subsitutes @ier usage for @read_status_mask usage. Both are
> programmed values that we control. Note that the code being replaced
> does _not_ care about the Line Status Register. It is only looking at
> the bit in the mask.
> 
> Everywhere that UART_LSR_DR is set/cleared in @read_status_mask,
> UART_IER_RLSI and UART_IER_RDI are also set/cleared in @ier.
> 
> Also, there are plenty of examples where the RLSI and RDI bits of @ier
> are used to determine if Rx is enabled. Here are the examples from the
> 8250 variants...

Okay, so perhaps a small summary to the commit message that both values are of
our control and hence there is no real event parsing is done in the original
case.

...

> > Additionally the common IRQ handler may be called at last in the custom ones
> > and hence potentially the value of saved IER might be different to what the
> > actual register is programmed to.
> 
> There is only 1 place where they do not match: serial8250_do_startup()
> 
>         /*
>          * Set the IER shadow for rx interrupts but defer actual interrupt
>          * enable until after the FIFOs are enabled; otherwise, an already-
>          * active sender can swamp the interrupt handler with "too much work".
>          */
>         up->ier = UART_IER_RLSI | UART_IER_RDI;
> 
> The IER hardware register contains 0 here.
> 
> This comes from commit ee3ad90be5ec ("serial: 8250: Defer interrupt
> enable until fifos enabled").
> 
> But since IER is 0, there will be no interrupt to land in any handlers
> leading to serial8250_handle_irq().

It's still possible to get into the handler, note, we may be working with
shared IRQs. There is a bit 0 in IIR that has to be checked to see if the
interrupt from the UART in question or something else.

...

> > Besides that I don't remember all of the mysterious ways of DMA. May it affect
> > the value of IER and when we swtich from DMA to PIO and vice versa we get an
> > incorrect value in the saved variable?
> 
> The change being made in this patch is only related to the Rx FIFO
> throttling when hardware flow control is enabled. The "feature" was
> added by commit f19c3f6c810 ("serial: 8250_port: Don't service RX FIFO
> if throttled").
> 
> For the omap variant this worked because the omap variant also updates
> the @read_status_mask when unthrottling (no other variant does that).
> 
> What confuses me is in 8250_omap.c:__dma_rx_complete() where there is:
> 
>         __dma_rx_do_complete(p);
>         if (!priv->throttled) {
>                 p->ier |= UART_IER_RLSI | UART_IER_RDI;
>                 serial_out(p, UART_IER, p->ier);
>                 if (!(priv->habit & UART_HAS_EFR2))
>                         omap_8250_rx_dma(p);
>         }
> 
> I would expect to see:
> 
>         __dma_rx_do_complete(p);
>         if (!priv->throttled) {
>                 p->ier |= UART_IER_RLSI | UART_IER_RDI;
>                 p->port.read_status_mask |= UART_LSR_DR;
>                 serial_out(p, UART_IER, p->ier);
>         }
> 
> But perhaps that is a bug. In fact, it would be exactly the bug that
> this patch is fixing because there are many places where
> @read_status_mask does not mirror Rx enable/disable status (because that
> is not the correct use of @read_status_mask).

Yeah, it may be that somebody (Tony?) cam shed a bit of light here...

-- 
With Best Regards,
Andy Shevchenko


