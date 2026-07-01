Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94670481AB3;
	Wed,  1 Jul 2026 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909710; cv=none; b=ivyxAEnHYPo+DGX6nNVqqR+1++AHy2QZIfeS2hA9V22hrHYzQXTWR6BlDOB9Q4uqi1Hm30d7GJrwgvOJkI0++eR6xD0/SH73u5kB1xt5U09C9/HFdSzm8muY/yK9RiKJO30fSHhtEQESOvjcz6mVdeMs8ASL4aLOG2c/N56rx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909710; c=relaxed/simple;
	bh=nNA7d2h+aIQ2JqEojQ0WxusT0eE8O3Ga+SZNcf1F2ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMgf6LMyp2X3O7szkvQ91jdjpyL5z85PqiZNQqt7SktspWJLAg/0SDPJ8ncAI3KDGa8fH9TYS0tNvwvILO0gzAXEsjzD8rS/fZy02gKAGaY+zWuKaC+jsM1vX5LdOjbbxMxkEaX7mVd/sow86qxAAFkTvm3z9oQzGNUad1/zxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLdkInBD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLdkInBD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909709; x=1814445709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nNA7d2h+aIQ2JqEojQ0WxusT0eE8O3Ga+SZNcf1F2ms=;
  b=JLdkInBDgg+Zuz3aO6jn36KuXzr18AUq3moszWZvDNJx883/2Mk3vaJt
   XE/wOOo/yn9tPQH2JLE7ILxFh3z05l1i96SvjNWRlVEhlGiycjowDF14M
   s1tAgVlOl1RRWJ95r/HFSQwlROLEAe5YHltUHMNOThLsdnfxtIWr0JEg8
   1vvvBLY3VC5QM5J8+F0N7nH2ZAGOuWkbl7tmdBmKelcYBK/AQ9UlaA9Va
   /jz4FMv7/nMWZIQe9cDXl7sYqhgSx/X8Uiv1fe+shyaQBmxR3XNdwPQJz
   eQoGbB1EcxKnCXX3tjA6+k33Sv8SPpAAQVYan3rwyuQpLheDf/znKICUd
   Q==;
X-CSE-ConnectionGUID: A1aQ1XpBQTyjbAeMtSgT/g==
X-CSE-MsgGUID: GSUA6/KAQ+Sbk5xXl5CrvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83838925"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83838925"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:41:48 -0700
X-CSE-ConnectionGUID: +0pplUisR++2cP2pdVLwqA==
X-CSE-MsgGUID: 3s+JSaqWRDC8R8sRQ6tBwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="256137837"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:41:46 -0700
Date: Wed, 1 Jul 2026 15:41:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com
Subject: Re: [PATCH v2 06/15] serial: 8250_mxpcie: add custom handle_irq
 callback
Message-ID: <akULB0e1hih8KHf7@ashevche-desk.local>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
 <20260701034128.218569-7-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701034128.218569-7-crescentcy.hsieh@moxa.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 11:41:19AM +0800, Crescent Hsieh wrote:
> Add a mxpcie-specific handle_irq() implementation for Moxa PCIe serial
> ports.
> 
> This keeps the interrupt handling self-contained in the driver and
> provides a hook point for MUEx50-specific RX/TX paths added in subsequent
> patches. The handler processes RX, updates modem status, and handles TX
> when THRE is asserted.

...

> +static int mxpcie8250_handle_irq(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	unsigned long flags;
> +	u16 lsr;
> +	u8 iir;
> +
> +	iir = serial_in(up, UART_IIR);
> +	if (iir & UART_IIR_NO_INT)
> +		return 0;
> +
> +	uart_port_lock_irqsave(port, &flags);

> +	lsr = serial_lsr_in(up);
> +
> +	lsr = mxpcie8250_rx_chars(up, lsr);

Haven't checked each patch in the series, but can this be joined?

	lsr = mxpcie8250_rx_chars(up, serial_lsr_in(up));

> +	serial8250_modem_status(up);
> +
> +	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
> +		serial8250_tx_chars(up);

> +	uart_unlock_and_check_sysrq_irqrestore(port, flags);

So, in modern kernel we need to use guard()() instead, here it's

	guard(uart_port_lock_check_sysrq_irqsave)(port);

> +	return 1;
> +}

-- 
With Best Regards,
Andy Shevchenko


