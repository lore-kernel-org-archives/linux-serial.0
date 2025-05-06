Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8722AE7B;
	Tue,  6 May 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534903; cv=none; b=r01t5wWWstxDXQBfxxbK6EmNrmox2B7wURFeOqmxbQZViJa4+E+CpHN92KGn6OGDHmqNuNZYJ8Gw+tUGFFQecsY3U6rpOpKV2knVQlbh5lJq64l3EwHfkoWw4tgOhdj9cDop1ELnmEV1wBAM5oDAaJ1ypoIs+KATk6s8xWhQMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534903; c=relaxed/simple;
	bh=mB39W3vRM3HnzoT1xR2N2MH3bxpGaTQzDJFoGxaHik8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YyXRpK4Y/BQ5mI62N5ZBNRBTsSLlrKw5CsV4Id0PC0/mu8qNQbd7oZgLGFoFi33tkgBdbJrXiBcXnatz3CHuakTZEF7SVnkyKCoWPWsvuDySOKk+dByy4H+2XHZfjNwF/KGafcwIMA3hawA3I9+zUPPUIhd5HBviUu1wiUQrCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StTKcyE6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StTKcyE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746534902; x=1778070902;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mB39W3vRM3HnzoT1xR2N2MH3bxpGaTQzDJFoGxaHik8=;
  b=StTKcyE6X+ynRyi/3fOaYfseDmI0SmRv8pur3kfN6jYC2N1lyQISGV2A
   RBuDGdujgAoTFjw2tnQ/6AbcCq66mLY6e+0mb3kNHxTlTcMhp+Vh9R6xO
   qtpXHJ7fXnw8HP6NSi4iMErNTPyQPWzDCt6MBRXs56UMjGFOewqiR/tXU
   bLZqi+KKZ4i0IM6zC2BjrPEQduHJWgyNaxvLA45V7i2OR5gWZC7dF8uR9
   XwMnwsbD0r/ptR9O0+RQXSf0jXg/EPLOkiH0zGqfHzJmpBzqX7sokSAXQ
   3TJ2a0ZD8PgHgjjup+heNn5B3z0txDlpRbrio+bcDYZ8P6feAhQ/xeisy
   g==;
X-CSE-ConnectionGUID: 2+ImJ3paQ2CwAIwMgrjNOg==
X-CSE-MsgGUID: v5yIglPoSneXT0Rioe+bmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59590566"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59590566"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:35:01 -0700
X-CSE-ConnectionGUID: 3XSTn5n9SQafhLOGTh3YaQ==
X-CSE-MsgGUID: nCkfWfkCRc6y/KceS7SlbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="139664592"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.207])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:34:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 May 2025 15:34:52 +0300 (EEST)
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
Subject: Re: [PATCH v5 1/4] serial: 8250: fix panic due to PSLVERR
In-Reply-To: <20250506112321.61710-1-cuiyunhui@bytedance.com>
Message-ID: <49865b06-c7c5-220b-aa01-0f1898d189f2@linux.intel.com>
References: <20250506112321.61710-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 May 2025, Yunhui Cui wrote:

> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
> 
> In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the dont_test_tx_en label:

Where is dont_test_tx_en label?

> ...
> serial_port_in(port, UART_RX);
> This satisfies the PSLVERR trigger condition.
> 
> Because another CPU(e.g., using printk()) is accessing the UART (UART

Because -> When ? 

missing space before (

> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> (lcr & ~UART_LCR_SPAR)

Add:

... in dw8250_check_lcr()

>, causing it to enter dw8250_force_idle().
> 
> Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
> to fix this issue.
> 
> Panic backtrace:
> [    0.442336] Oops - unknown exception [#1]
> [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> ...
> [    0.442416] console_on_rootfs+0x26/0x70
> 
> Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
> Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3f256e96c722..a913135d5217 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2380,9 +2380,10 @@ int serial8250_do_startup(struct uart_port *port)
>  	/*
>  	 * Now, initialize the UART
>  	 */
> -	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
>  
>  	uart_port_lock_irqsave(port, &flags);
> +	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> +
>  	if (up->port.flags & UPF_FOURPORT) {
>  		if (!up->port.irq)
>  			up->port.mctrl |= TIOCM_OUT1;
> 

-- 
 i.

