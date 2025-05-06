Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175827D77E;
	Tue,  6 May 2025 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532838; cv=none; b=u+pwIr8G0OlnsuxdOmBpmmlZk8QC43cz80xaCtzoZSHvSDkwdGwT8paE2Jjye2jHoxt2CGZZC8UTmrRpoeYFh9s45x85t3XCEV+8F5R9zOd/iSth8wNlEa/9vuTs5E9Ubw+A1UO07bqYtXvnOm+ineXotfqf4jV4kNawpvw0yq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532838; c=relaxed/simple;
	bh=I/RDgY0bkQF81lF3O3auo+izugUDSU30xMIrYYNzkwI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qh3hq2N+nyXAcWnPJWBKH330cYPZGYb1OFLGOk5+dm27d9JonugauBFmBWzpUSSP6PWBohlOpePRjZUX1x62a8BHQB/zq0HhdQKgKZsv5wRFZL8zHgRc4Z6klGjCZ/Myrd6/FworTpEUEMGRwggxOn1c2+hcraQ7N+GFkqx5NVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+DXdSVq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+DXdSVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746532836; x=1778068836;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I/RDgY0bkQF81lF3O3auo+izugUDSU30xMIrYYNzkwI=;
  b=Q+DXdSVqNsqRH9u+QCUYGomLhnR2N2PpVCpzKT6vR8iM3cAqvERP9VRC
   IZEpLrEpWEA56BQE+c405dVwAdoCOJugjSHfq6wYBL+OtU6/nzcJs6R0m
   W/gb9CsE7DggyFHzoNoHSOmGjUPDdyP92WW+qopIfqI+jdAKG/K191BRY
   R2ur//Fdg5Gi51n9hajA7aNxN+QXN4OuUlEGbGSfU/l75UJiCw5PBwvDI
   PUFkpAw7AKj0n2o12dTKS1Y+CkjpcMMzkv1trsMlCqbv7oSk+aNYGlZi6
   DjUzKpcsPJvgqkJCIZIe5y1ZuZJRG+O1adltlvrgS1PHpzizCfXQeRo11
   Q==;
X-CSE-ConnectionGUID: aI771yEuSAaxh8ziHbmO+Q==
X-CSE-MsgGUID: 1QNZgYySSKGPhZS5v/Mfjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48105311"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="48105311"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:00:35 -0700
X-CSE-ConnectionGUID: YwAXDTVoQZ2NiHQUYPaizw==
X-CSE-MsgGUID: nWh3ECRFTLmiVlkRw/K74w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="136534519"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.207])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:00:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 May 2025 15:00:25 +0300 (EEST)
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: arnd@arndb.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    benjamin.larsson@genexis.eu, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    heikki.krogerus@linux.intel.com, Jiri Slaby <jirislaby@kernel.org>, 
    jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, markus.mayer@linaro.org, 
    matt.porter@linaro.org, namcao@linutronix.de, paulmck@kernel.org, 
    pmladek@suse.com, schnelle@linux.ibm.com, sunilvl@ventanamicro.com, 
    tim.kryger@linaro.org
Subject: Re: [PATCH v5 2/4] serial: 8250: avoid potential PSLVERR issue
In-Reply-To: <20250506112321.61710-2-cuiyunhui@bytedance.com>
Message-ID: <6801686d-a0b3-7093-1293-cdac6ad055e4@linux.intel.com>
References: <20250506112321.61710-1-cuiyunhui@bytedance.com> <20250506112321.61710-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 May 2025, Yunhui Cui wrote:

> Failure to check the UART_LSR_DR before reading UART_RX, or the
> non-atomic nature of clearing the FIFO and reading UART_RX, poses
> potential risks that could lead to PSLVERR.

Don't expect reader to know the condition how PSLVERR is triggered. I know 
it's worded out in the other patch but also explain it here.

You're only explaining problem and missing what this patch does to solve 
the problem.

> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250.h      | 13 +++++++++
>  drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++--------------
>  2 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index b861585ca02a..6f97ff3a197d 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -162,6 +162,19 @@ static inline u16 serial_lsr_in(struct uart_8250_port *up)
>  	return lsr;
>  }
>  
> +/*
> + * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
> + * reading UART_RX.
> + */
> +static inline void serial8250_discard_data(struct uart_8250_port *up)
> +{
> +	u16 lsr;
> +
> +	lsr = serial_in(up, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		serial_in(up, UART_RX);
> +}
> +
>  /*
>   * For the 16C950
>   */
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index a913135d5217..1666b965f6a0 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1357,9 +1357,8 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  	/* Synchronize UART_IER access against the console. */
>  	uart_port_lock_irq(port);
>  	serial_out(up, UART_IER, UART_IER_ALL_INTR);
> +	serial8250_discard_data(up);
>  	uart_port_unlock_irq(port);
> -	serial_in(up, UART_LSR);
> -	serial_in(up, UART_RX);
>  	serial_in(up, UART_IIR);
>  	serial_in(up, UART_MSR);
>  	serial_out(up, UART_TX, 0xFF);
> @@ -2137,25 +2136,22 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>  static int serial8250_get_poll_char(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> -	int status;
> +	int status = NO_POLL_CHAR;
>  	u16 lsr;
> +	unsigned long flags;
>  
>  	serial8250_rpm_get(up);
>  
> +	uart_port_lock_irqsave(port, &flags);
>  	lsr = serial_port_in(port, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		status = serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);
>  
> -	if (!(lsr & UART_LSR_DR)) {
> -		status = NO_POLL_CHAR;
> -		goto out;
> -	}
> -
> -	status = serial_port_in(port, UART_RX);
> -out:
>  	serial8250_rpm_put(up);
>  	return status;

Not a problem that originates from you, but IMO calling this variable 
"status" is quite misleading when it is the character (or NO_POLL_CHAR 
is no character is present).

>  }
>  
> -
>  static void serial8250_put_poll_char(struct uart_port *port,
>  			 unsigned char c)
>  {
> @@ -2264,13 +2260,17 @@ int serial8250_do_startup(struct uart_port *port)
>  	 * Clear the FIFO buffers and disable them.
>  	 * (they will be reenabled in set_termios())
>  	 */
> +	uart_port_lock_irqsave(port, &flags);
>  	serial8250_clear_fifos(up);
>  
>  	/*
> -	 * Clear the interrupt registers.
> +	 * Read UART_RX to clear interrupts (e.g., Character Timeout).
> +	 * No data on UART_IIR_RX_TIMEOUT, UART_LSR_DR won't set.
> +	 * FIFO disabled, read UART_RX without LSR check, no PSLVERR.

I don't understand what the last two lines mean and I don't see the 
connection to the code that is below the comment either, could you try to 
rephrase the comment.

>  	 */
>  	serial_port_in(port, UART_LSR);
>  	serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
>  
> @@ -2429,15 +2429,14 @@ int serial8250_do_startup(struct uart_port *port)
>  	}
>  
>  dont_test_tx_en:
> -	uart_port_unlock_irqrestore(port, flags);
>  
>  	/*
>  	 * Clear the interrupt registers again for luck, and clear the
>  	 * saved flags to avoid getting false values from polling
>  	 * routines or the previous session.
>  	 */
> -	serial_port_in(port, UART_LSR);
> -	serial_port_in(port, UART_RX);
> +	serial8250_discard_data(up);
> +	uart_port_unlock_irqrestore(port, flags);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
>  	up->lsr_saved_flags = 0;
> @@ -2519,7 +2518,6 @@ void serial8250_do_shutdown(struct uart_port *port)
>  		port->mctrl &= ~TIOCM_OUT2;
>  
>  	serial8250_set_mctrl(port, port->mctrl);
> -	uart_port_unlock_irqrestore(port, flags);
>  
>  	/*
>  	 * Disable break condition and FIFOs
> @@ -2527,6 +2525,14 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	serial_port_out(port, UART_LCR,
>  			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
>  	serial8250_clear_fifos(up);
> +	/*
> +	 * Read data port to reset things, and then unlink from
> +	 * the IRQ chain.
> +	 * Since reading UART_RX clears interrupts, doing so with
> +	 * FIFO disabled won't trigger PSLVERR.
> +	 */
> +	serial_port_in(port, UART_RX);
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  #ifdef CONFIG_SERIAL_8250_RSA
>  	/*
> @@ -2535,11 +2541,6 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	disable_rsa(up);
>  #endif
>  
> -	/*
> -	 * Read data port to reset things, and then unlink from
> -	 * the IRQ chain.
> -	 */
> -	serial_port_in(port, UART_RX);
>  	serial8250_rpm_put(up);
>  
>  	up->ops->release_irq(up);
> 

-- 
 i.

