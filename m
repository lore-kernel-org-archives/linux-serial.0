Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5920263F5E;
	Fri, 23 Jan 2026 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206415; cv=none; b=kv4ZLOQ20hlgK1r1OcmpuP+hTQwcyW/+++Vc88IRVMnZE6HRDlBkon8rfb5HDB3oGGB4BTyNXwfXfNfuKgeIsl1jKaJQXYUZhVi9Sg5e6LiXB7DZfmzMCVFVVDqF6XZ0lX8oEiI4t4RgATdfVB6Tck3pc3uentUaqJGtNfuU9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206415; c=relaxed/simple;
	bh=9VnspifS8nsU2HzElpoe/IYvKsTGMIwZ36X4cZoiaic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAMiMgk3GCDLrluwDvu7vSZ2vQ6vFMEXiFMPH7kgAQeNjvhlyshuzuCWWWXiztj3TkrLxfxivu+980LVHg1ebLzra/iUW9ySO2sIR58ZjM5xIbITp7RAumSPduOs/3h07UkG8do687+fqPSZkA/CAKFG6Z02ZAxSh/Det6CrvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYlRRSKa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYlRRSKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769206414; x=1800742414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9VnspifS8nsU2HzElpoe/IYvKsTGMIwZ36X4cZoiaic=;
  b=JYlRRSKaG+fGH8QAKGYVcoovezs5DWxX5VkZioM6Ol0CJzkK4AvuUL0d
   OcEjGwEjEePy96b8RpTZyfEm+ViCM+QR/Z+XvB765tdQMcGtJgZQcT/lx
   EIaJUq2f2OsUjF+rQcHi3R5BMm/xXbJt+nh7n15Lx5IHbutoHCTJhi0ak
   CqGfLtn+Fk//gyiRBYk6LdiKlU0gSfNuUa/BHeLanDfBcj/jW7HgYJp24
   7a/EwbXJeHItA8drzLiy2h6LLYSZC3UXfFpgCwrH2Sn9Gw+mkU/HagWxB
   36LKLyICUHwFBXYMVZgSWr1o25EPyXg3ZWUbkiGneUz9KjjVgLBs54Q8x
   g==;
X-CSE-ConnectionGUID: 1PwX11iVQiW6cySXSCRH2w==
X-CSE-MsgGUID: zXroaTRsQruFxD5tv1P7ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="58035183"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="58035183"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:13:33 -0800
X-CSE-ConnectionGUID: zV+odf6wQE6h7fGtaK/EPA==
X-CSE-MsgGUID: AOdJk9f2Te6rXUr5GLCEfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="211589727"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:13:30 -0800
Date: Sat, 24 Jan 2026 00:13:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 4/6] serial: 8250_dw: Rework IIR_NO_INT handling to stop
 interrupt storm
Message-ID: <aXPyiOMxClprdOQM@smile.fi.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
 <20260123172739.13410-5-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123172739.13410-5-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 07:27:37PM +0200, Ilpo Järvinen wrote:
> INTC10EE UART can end up into an interrupt storm where it reports
> IIR_NO_INT (0x1). If the storm happens during active UART operation, it
> is promptly stopped by IIR value change due to Rx or Tx events.
> However, when there is no activity, either due to idle serial line or
> due to specific circumstances such as during shutdown that writes
> IER=0, there is nothing to stop the storm.
> 
> During shutdown the storm is particularly problematic because
> serial8250_do_shutdown() calls synchronize_irq() that will hang in
> waiting for the storm to finish which never happens.
> 
> This problem can also result in triggering a warning:
> 
>   irq 45: nobody cared (try booting with the "irqpoll" option)
>   [...snip...]
>   handlers:
>     serial8250_interrupt
>   Disabling IRQ #45
> 
> Normal means to reset interrupt status by reading LSR, MSR, USR, or RX
> register do not result in the UART deasserting the IRQ.
> 
> Add a quirk to INTC10EE UARTs to enable Tx interrupts if UART's Tx is
> currently empty and inactive. Rework IIR_NO_INT to keep track of the
> number of consecutive IIR_NO_INT, and on third one perform the quirk.
> Enabling Tx interrupts should change IIR value from IIR_NO_INT to
> IIR_THRI which has been observed to stop the storm.

...

> +	u64			no_int_count;

Why so big?

...

> +		d->no_int_count++;
> +		if (d->no_int_count > 2 && quirks & DW_UART_QUIRK_IER_KICK)
> +			dw8250_quirk_ier_kick(p);

Usual way is to use modulo. And perhaps use 4 for the sake of avoiding
division:

		if (d->no_int_count == 3 && quirks & DW_UART_QUIRK_IER_KICK)
			dw8250_quirk_ier_kick(p);

		d->no_int_count = (d->no_int_count + 1) % 4;

where 4 may be defined with meaningful name. With that u8 is more than enough.

>  		return 0;

-- 
With Best Regards,
Andy Shevchenko


