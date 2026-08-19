Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99F3A1D14;
	Wed, 19 Aug 2026 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122222; cv=none; b=jGf+f7376vfYtRL7J9ticwfEWvPbIiTAYY1lMnjmHZwUMbu1wC0wIUAsEVPiITuH5g5T1ACnY+avoFHbRdwv4kFGXYAf6qlQbcY1Ud+Av3IaR7bDY8X6t0Ua+q5ArxnFPIFSIyMnG4mTHHwcQFIhJVGdq/WMtiSXhXtHVJSJ05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122222; c=relaxed/simple;
	bh=izjKXIFxi/rqtVADf2M0sBpedoa8cJQqW1TXF55iZ3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dqla9THKX6A51jJmgiAHWITUYRXSn01tGXVXtnzXyYXIumfbDZ6Wx+2XBUjTO52Oi8cFcEI37JKtCvuSV0t48rjG3yfyC7AeP++x/Ua6U+V9rxlCDwLnx1BxMQfAIXyRYN0a6s0meJTZohciGgQwdM7Q33Jw/FrwlzyN0Lf/tuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mM2knBFF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mM2knBFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787122220; x=1818658220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izjKXIFxi/rqtVADf2M0sBpedoa8cJQqW1TXF55iZ3A=;
  b=mM2knBFFGFqRysWIHnSptxhOBFC+LXIi80JPCfgkdfkKLIoEYPhmQ7GA
   6gWqROSJjYy++GloTHxBIgpIKpxkOz0ii+7nY7Uf1c7EdtAEgs8EgGjuy
   JpeLaiwhmYlMyVEwniPHJI5N49809VZZ//ObLiyKV2fGxHFPrIt/AqOBp
   LKqmLvcqYTXzaSn/iHok6jMvzJnCydtwQjV/n2QKskde23rJYr7BibVzj
   UzTekMdd2p/o2vqZ6CR3P4TOl+06D7slcgt7bNQPdCY7Nn6tgxVYIGuFi
   dc1KKRg06tnsKl/5/nuFzT5LrFSeJHFHDdCc9xfvF2OM0vLhQ+TtHXuM2
   g==;
X-CSE-ConnectionGUID: phjZPAoNQD6TRGLD3KInAw==
X-CSE-MsgGUID: BiFBqsA9SeeqCHfqNJ7V3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87829334"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87829334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:50:20 -0700
X-CSE-ConnectionGUID: H1XQ80vSTXqXbOh+BrnsQw==
X-CSE-MsgGUID: QSkiNZ14S62aTkp1BIOMog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="268965440"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:50:14 -0700
Date: Wed, 19 Aug 2026 09:50:11 +0300
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
Subject: Re: Re: [PATCH v5 10/12] serial: 8250: add Ambarella UART driver
Message-ID: <aoVSI4xcpRqUZIew@ashevche-desk.local>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-10-7bbb12f0360f@ambarella.com>
 <aoRpc2RK2_X3CdAi@ashevche-desk.local>
 <162c0385.2c076.1a018b82fa7.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162c0385.2c076.1a018b82fa7.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 02:31:59PM +0800, zl020895 wrote:

> This is Ambarella 8250-compatible IP, not Synopsys DesignWare. We
> first tried 8250_dw after Linus asked us to move to the 8250 library;
> you then told us not to touch 8250_dw and to use 8250_ambarella
> instead. That is what this patch is.
> Background:
> https://lore.kernel.org/r/CAD++jLm6HzEU1TM-c=Vtjv3FJEBecVP7TyxSgq_Q0zF-YwT6NA@mail.gmail.com/
> https://lore.kernel.org/linux-serial/an8KvvHWX0naH3Xw@ashevche-desk.local/
> https://lore.kernel.org/linux-serial/7E774305-3920-4BB7-BA46-E0772D6BED84@ambarella.com/
> I will also switch to uart_read_port_properties() and trim the
> 8250_dw-derived boilerplate.

But it has layout like Synopsys? Do you have a link to the datasheet?

> ---- Replied Message ----
> | From | Andy Shevchenko<andriy.shevchenko@linux.intel.com> |
> | Date | 08/18/2026 22:17 |
> On Tue, Aug 18, 2026 at 06:31:24PM +0800, Long Zhao via B4 Relay wrote:
> 
> > Add an 8250 platform driver for Ambarella CV75 instead of claiming
> > snps,dw-apb-uart compatibility.
> 
> This is a record from a changelog. There is nothing in the commit message.
> ...
> 
> The code seems like an almost blind copy of 8250_dw.c.
> 
> > +#define AMBARELLA_UART_USR        0x1f
> > +#define AMBARELLA_UART_USR_BUSY        BIT(0)
> 
> So, is it Synopsys IP-based design? How this gets into this platform? This
> whole story completely made me lost.
> 
> > +#define AMBARELLA_UART_IIR_IID        GENMASK(3, 0)
> > +#define AMBARELLA_UART_IIR_STATUS    GENMASK(5, 0)

...

> > +    of_property_read_u32(dev->of_node, "reg-shift", &reg_shift);
> > +    of_property_read_u32(dev->of_node, "reg-io-width", &reg_io_width);
> > +    uart.port.regshift = reg_shift;
> 
> > +    switch (reg_io_width) {
> > +    case 4:
> > +        uart.port.iotype = UPIO_MEM32;
> > +        uart.port.serial_in = ambarella_serial_in;
> > +        uart.port.serial_out = ambarella_serial_out;
> > +        break;
> > +    default:
> > +        return dev_err_probe(dev, -EINVAL,
> > +                     "unsupported reg-io-width %u\n",
> > +                     reg_io_width);
> > +    }
> 
> This is handled by uart_read_port_properties().

-- 
With Best Regards,
Andy Shevchenko


