Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E83DDDC0;
	Wed, 19 Aug 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124899; cv=none; b=QuS8eYemtQqMOeNrfzij39Tw1B+wKzkeBCnK6rmLk5Tba0rCsv1jr5hC0YilQit9+vDfoLXCmXapQj0TM6QNbb1KhJIwmenMdiOhNyi20FUAdWOU6t+/kjJrLTKV/DTm0loJOQqlMtJALEhJgKKXRv9p/7oGW3qW98Y5jkUFYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124899; c=relaxed/simple;
	bh=nJA0/6kYLHyEEZ/c1kClhKWe404ZhLpl/En2+SoLBHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqaRqIZb9Nt8xpPdLLXM0jU4bUjupQ7t4homsjTCgVrvDeqOrFN0SG7T+Tp+63L9Tcun2n5/D6XAnuT7vYCtiWl+vVUG7+TcNExYdAWxEEmnJHkh7Hkp48nqDPo9HzJayR3Lw6+ZjwNgKtObOuHIS3ydURmoGcNL9WH/c4MfAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMkm6g2K; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMkm6g2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787124897; x=1818660897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJA0/6kYLHyEEZ/c1kClhKWe404ZhLpl/En2+SoLBHk=;
  b=BMkm6g2K6LM+uSHZaDlQg5Qb7enQBovu59gNgRKJwL4rtTV4uZJq+Fy5
   2FImyFwdxQW25e8Y6mkPgOOcyOGmEDm+o3xS9jdfE5AW3qyx0i9SykHcL
   cfP+DI5bLB+Gx+BzmRlHOPF5ld6R0wXoiH9rghToiUXdFeuhKXnP2hqFU
   ztWs4UGr7Qx2fliYoyOTiIFsuCSMk9sUZXM/v7CPVK6VORgB9N1amKCrT
   tL75CwmtxJF1SWSQGrR4tNEb8U91KyUefQjQRPQA+klbH9BqUBd3Fu9Ca
   6yDoPTbM3bDn+kXzTaJyVpINaFN56BSrKQfW9OmVKN7xOcXIbIKG1hvUy
   w==;
X-CSE-ConnectionGUID: S7W+LFiWQPeZeZzJMzKjig==
X-CSE-MsgGUID: HrNvhSGnRWq6zTVljJ3vxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87693345"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87693345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:34:55 -0700
X-CSE-ConnectionGUID: FrUAUwlwRhKkJIHe3rcb5g==
X-CSE-MsgGUID: bIaQRPCcQDS7wWvNjTGJYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="295375262"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:34:49 -0700
Date: Wed, 19 Aug 2026 10:34:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: zl020895 <zl020895@163.com>
Cc: longzhao <longzhao@ambarella.com>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc <soc@lists.linux.dev>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-clk <linux-clk@vger.kernel.org>,
	linux-gpio <linux-gpio@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Brian Masney <bmasney@redhat.com>, Lee Jones <lee@kernel.org>,
	mfd <mfd@lists.linux.dev>
Subject: Re: Re: Re: [PATCH v5 10/12] serial: 8250: add Ambarella UART driver
Message-ID: <aoVclvO1eAV3TULu@ashevche-desk.local>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-10-7bbb12f0360f@ambarella.com>
 <aoRpc2RK2_X3CdAi@ashevche-desk.local>
 <162c0385.2c076.1a018b82fa7.Coremail.zl020895@163.com>
 <aoVSI4xcpRqUZIew@ashevche-desk.local>
 <4dfe3bbe.2c34f.1a018d297c3.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dfe3bbe.2c34f.1a018d297c3.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 03:00:49PM +0800, zl020895 wrote:
> 
> The register layout is 16550-compatible with reg-shift = 2, and it has a
> USR-style busy bit at a similar offset to DW APB UART. That is why it looks
> Synopsys-like and why we first tried 8250_dw.

I see.

> It is still Ambarella IP, not a Synopsys DesignWare license. Besides the
> common 8250 map it has Ambarella-specific pieces (e.g. IER ETOI, and DMA via
> DMAE/DMAF rather than the DW DMA path). DMA support is out of scope for this
> minimal bring-up series; the current driver is PIO / console only.

Okay, put the summary and the details of this discussion in the commit message
of the next version to make sure we have a justification for a new driver and
some pieces that looks like Synopsys DesignWare.

Also try to make the driver really bare minimum without any blindly copied
pieces or "features" that are not related to your HW or will be implemented
differently in the future.

> Sorry, I do not have a public datasheet URL I can post. 

If you can share register layout with small descriptions (even privately) it
would be helpful (some pages from your datasheet, for example).

> ---- Replied Message ----
> | From | Andy Shevchenko<andriy.shevchenko@linux.intel.com> |
> | Date | 08/19/2026 14:50 |
> On Wed, Aug 19, 2026 at 02:31:59PM +0800, zl020895 wrote:
> 
> > This is Ambarella 8250-compatible IP, not Synopsys DesignWare. We
> > first tried 8250_dw after Linus asked us to move to the 8250 library;
> > you then told us not to touch 8250_dw and to use 8250_ambarella
> > instead. That is what this patch is.
> > Background:
> > https://lore.kernel.org/r/CAD++jLm6HzEU1TM-c=Vtjv3FJEBecVP7TyxSgq_Q0zF-YwT6NA@mail.gmail.com/
> > https://lore.kernel.org/linux-serial/an8KvvHWX0naH3Xw@ashevche-desk.local/
> > https://lore.kernel.org/linux-serial/7E774305-3920-4BB7-BA46-E0772D6BED84@ambarella.com/
> > I will also switch to uart_read_port_properties() and trim the
> > 8250_dw-derived boilerplate.
> 
> But it has layout like Synopsys? Do you have a link to the datasheet?
> 
> > ---- Replied Message ----
> > | From | Andy Shevchenko<andriy.shevchenko@linux.intel.com> |
> > | Date | 08/18/2026 22:17 |
> > On Tue, Aug 18, 2026 at 06:31:24PM +0800, Long Zhao via B4 Relay wrote:
> >
> > > Add an 8250 platform driver for Ambarella CV75 instead of claiming
> > > snps,dw-apb-uart compatibility.
> >
> > This is a record from a changelog. There is nothing in the commit message.

...

> > The code seems like an almost blind copy of 8250_dw.c.
> >
> > > +#define AMBARELLA_UART_USR        0x1f
> > > +#define AMBARELLA_UART_USR_BUSY        BIT(0)
> >
> > So, is it Synopsys IP-based design? How this gets into this platform? This
> > whole story completely made me lost.
> >
> > > +#define AMBARELLA_UART_IIR_IID        GENMASK(3, 0)
> > > +#define AMBARELLA_UART_IIR_STATUS    GENMASK(5, 0)

-- 
With Best Regards,
Andy Shevchenko


