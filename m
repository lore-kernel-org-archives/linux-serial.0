Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C951A23A6;
	Mon, 14 Apr 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620465; cv=none; b=XJsbVlWiqQRYyFoZRvyk0KbE3lDQrFiryGTz+6EWLXOMYKnej0RY+bIHdIyA7FhDMYsHEkwK5RoDUmZo+GAhR8XPTA8lhPjWsKp6JH7XDj/xMAzt/Lxv+JCDq6Den8qOLA5EuiOtzqzNiPi5/8fVI3ZtptQlGCkoAEeJBYH/X0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620465; c=relaxed/simple;
	bh=8kckFmYJLavCSR35fPALPhq3CLgDQ8jmvjB+vic9bQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwzMxnJLMpEvPShiXeA/eXzIdsFTpUmz9EROhzAMtnco3idnp9oKEjhyVtt74L6lybxVsJFBVR7aIIeuloxIDc8nBff3nXNN881U6fihXNBrbXcYzyMaG9J6h5HdgfYKKC4YeeAqspb+070Crdj8TWpRsVyepMeEy7nFHShs42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDuUb3Uy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDuUb3Uy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744620465; x=1776156465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8kckFmYJLavCSR35fPALPhq3CLgDQ8jmvjB+vic9bQk=;
  b=IDuUb3Uyfs9egMIWvNdq4XTsibPB3dvwoFYC4jQcM7eq4RiAgkpRcb26
   HiqIk3DGLWb84NnUY2p4s1vfCy2fe/2ARki/BmkZEP6Qe2CbCreb1dEYc
   ChR5Mn6C+3+U5HQZNqtw8udLZ7ZZhM3IwAkfeOXSDRNdQZDdkVZxatTVF
   ziWm8TvFVLWOQb8fUQCkyH6400gYxF5jJoLB2Ye2MKa2YnSg/bQq549Oy
   OwX3X9UQdKY72XKDwZxhSZ9dB53h4jwjqamVDiHiETi8aDygQpviFjYtp
   L2qqD/7yK6jqi7/8vUWB24+ifFV1bC8FzdR2bKvXyYOb7CAXZj45PmfjA
   Q==;
X-CSE-ConnectionGUID: b30NKAGvSeSx8o1oks8PiA==
X-CSE-MsgGUID: bMYIWnNaTDy06fVmdgmPpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="56260452"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="56260452"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:47:44 -0700
X-CSE-ConnectionGUID: uhI6Qh+cT7qSV/X2E8qojQ==
X-CSE-MsgGUID: uyO/3hOgSM6gRD1Ta8zHzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="129519714"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:47:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4FTc-0000000CBKp-1ZEi;
	Mon, 14 Apr 2025 11:47:36 +0300
Date: Mon, 14 Apr 2025 11:47:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, john.ogness@linutronix.de, pmladek@suse.com,
	arnd@arndb.de, namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, heikki.krogerus@linux.intel.com,
	markus.mayer@linaro.org, tim.kryger@linaro.org,
	matt.porter@linaro.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250: fix panic due to PSLVERR
Message-ID: <Z_zLqH1Moavhi52x@smile.fi.intel.com>
References: <20250414031450.42237-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414031450.42237-1-cuiyunhui@bytedance.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 14, 2025 at 11:14:50AM +0800, Yunhui Cui wrote:

You forgot to rebase against latest tty-next or, if there is something
in the latter (but I don't see right now), even tty-testing.

> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
> 
> In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the dont_test_tx_en label:
> ...
> serial_port_in(port, UART_RX);
> This satisfies the PSLVERR trigger condition.
> 
> Because another CPU(e.g., using printk()) is accessing the UART (UART
> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> 
> To fix this, all calls to serial_out(UART_LCR) and serial_in(UART_RX)
> should be executed under port->lock. Additionally, checking the readiness
> via UART_LSR should also be done under port->lock.
> 
> Panic backtrace:
> [    0.442336] Oops - unknown exception [#1]
> [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> ...
> [    0.442416] console_on_rootfs+0x26/0x70

This patch seems need split to three. See below.

...

First of all, while everything looks better now, there is a chance in the
future to miss the same issue again. In order to avoid that I suggest to
introduce a new helper where you made this check _and_ add a comment why.

(Note that currently you have a mixture of serial_in()/serial_port_in() in
 some cases.)

static inline unsigned int serial8250_discard_data(struct uart_8250_port *up)
{
	u16 lsr;

	lsr = serial_in(up, UART_LSR);
	if (lsr & UART_LSR_DR)
		return serial_in(up, UART_RX);

	return 0;
}

And this can be one patch (patch 2).

...

> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c

Changes here deserve the separate patch (patch 1).

...

> +	/*
> +	 * Serial_in(p, UART_RX) should be under port->lock, but we can't add

serial_in()

> +	 * it to avoid AA deadlock as we're unsure if serial_out*(...UART_LCR)
> +	 * is under port->lock.
> +	 */
> +	lockdep_assert_held_once(&p->lock);

...

> +	uart_port_lock_irqsave(port, &flags);

And one patch (patch 3) about locking.

-- 
With Best Regards,
Andy Shevchenko


