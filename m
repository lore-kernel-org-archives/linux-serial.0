Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E423AB86;
	Wed, 11 Jun 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644402; cv=none; b=SD5IFdU+6skYMiq4VBkGRWqZhoKLSMnqfj4stBAcm4eBpQnb9XhsR2P1owLzVYqzky0UMAcx62u+r386cox79LsSLuUlrIdaAScH7EQgwIcUghaLF37Vqvy9w4eRxOFSAxe8nlFgW+nZHbapZJbCPnXuJSZqZ8jzwTHY8ODzMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644402; c=relaxed/simple;
	bh=kIMsLwtyPe2RpkBTRYeTgFDV+XfIPS8NmgXtBDjWRck=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GZEKCjKcWPaONQDvB5YQiu62/c4GQREGVQFzsN7QjvjTbv08vYkbfgBGM+Xc+1RrWk7dehniLXXa6z68FyspKQtJeyy7emralAtOgYVGw6jr1cA+aLcq+rltMv1t3R/ZsmmGtZZkFn1MRJMgy2Yl2UDHXXgn40IuWZiG6O1tUG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=my8lg8Ls; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="my8lg8Ls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749644401; x=1781180401;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kIMsLwtyPe2RpkBTRYeTgFDV+XfIPS8NmgXtBDjWRck=;
  b=my8lg8LsrU/ACYT1X0Nb44wob4b91+9lW0JUN5xqXV4Si4iUI/us2RQl
   k/pYNOXZ9C1K8EdM5l7zlELb11FjRus46s6Io9LQZOwq3PaqyxOCs7wRz
   nv8TdRVP7RSqYjjwtyj9EBT8KGpfECy38ST6wLRqsCQUrHRvQD6JYMNGD
   DqKpFvEjq5QZY4cOskFjHhWZz1RiYYcQx92A+gMo2wmIXOeEbPAXEhTI/
   hEd8s23XiKu0W/AAfxdEIbGq/cG4kY3wm7kVBLQuEKamZcQ3lvNVF5CdM
   dcEg3DPy/FXci33xbkBQjVxQQKuowFg+pb4FPpzt2LPziPExHtWZEhw1D
   w==;
X-CSE-ConnectionGUID: gjd5opGER+irkj+N6Jx2yg==
X-CSE-MsgGUID: LBs4cYFOTdeRGdu4/N3KJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62822468"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62822468"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:20:01 -0700
X-CSE-ConnectionGUID: qbL0aNa1QaKrcanKZnT4nw==
X-CSE-MsgGUID: D7i7iCliSHmPfTEDbn+S4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147057647"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:19:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:19:54 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/33] serial: 8250: extract serial8250_initialize()
In-Reply-To: <20250611100319.186924-17-jirislaby@kernel.org>
Message-ID: <49e23ee2-a432-5d0e-3185-e455c2d1ca8c@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-17-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> serial8250_do_startup() initializes the ports in the middle of the
> function. This code can be separated to serial8250_initialize(), so that
> serial8250_do_startup() can be readable again.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 103 ++++++++++++++--------------
>  1 file changed, 50 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 5466286bb44f..6851c197b31d 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2247,13 +2247,59 @@ static void serial8250_THRE_test(struct uart_port *port)
>  		up->bugs |= UART_BUG_THRE;
>  }
>  
> -int serial8250_do_startup(struct uart_port *port)
> +static void serial8250_initialize(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned long flags;
> -	unsigned char iir;
> +	bool lsr_TEMT, iir_NOINT;

Has the coding style guidance changed at some point to be more liberal 
about lower/uppercase? To me it looks entirely unnecessary to capitalize 
these.

> +	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> +
> +	uart_port_lock_irqsave(port, &flags);
> +	if (port->flags & UPF_FOURPORT) {
> +		if (!port->irq)
> +			port->mctrl |= TIOCM_OUT1;

I assume you're moving this too in some later patch.

I've no idea why drivers/tty/serial/sunsu.c checks for that flag as well.

> +	} else {
> +		/* Most PC uarts need OUT2 raised to enable interrupts. */
> +		if (port->irq)
> +			port->mctrl |= TIOCM_OUT2;
> +	}
> +
> +	serial8250_set_mctrl(port, port->mctrl);
> +
> +	/*
> +	 * Serial over Lan (SoL) hack:
> +	 * Intel 8257x Gigabit ethernet chips have a 16550 emulation, to be used for Serial Over
> +	 * Lan.  Those chips take a longer time than a normal serial device to signalize that a
> +	 * transmission data was queued. Due to that, the above test generally fails. One solution
> +	 * would be to delay the reading of iir. However, this is not reliable, since the timeout is

Ironically, you capitalized the variable names but here it still says 
"iir". IIRC, some comments in the other patches too have lowercased 
references to registers.

> +	 * variable. So, let's just don't test if we receive TX irq.  This way, we'll never enable
> +	 * UART_BUG_TXEN.
> +	 */
> +	if (!(port->quirks & UPQ_NO_TXEN_TEST)) {
> +		/* Do a quick test to see if we receive an interrupt when we enable the TX irq. */
> +		serial_port_out(port, UART_IER, UART_IER_THRI);
> +		lsr_TEMT = serial_port_in(port, UART_LSR) & UART_LSR_TEMT;
> +		iir_NOINT = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
> +		serial_port_out(port, UART_IER, 0);
> +
> +		if (lsr_TEMT && iir_NOINT) {
> +			if (!(up->bugs & UART_BUG_TXEN)) {
> +				up->bugs |= UART_BUG_TXEN;
> +				dev_dbg(port->dev, "enabling bad tx status workarounds\n");
> +			}
> +		} else {
> +			up->bugs &= ~UART_BUG_TXEN;

Is this necessary at all as the line above is the only place setting this 
flag (AFAICT)? Maybe you address this in some later patch, if that's the 
case, please ignore my comment. :-)

> +		}
> +	}
> +
> +	uart_port_unlock_irqrestore(port, flags);
> +}

-- 
 i.



> +
> +int serial8250_do_startup(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
>  	int retval;
> -	u16 lsr;
>  
>  	if (!port->fifosize)
>  		port->fifosize = uart_config[port->type].fifo_size;
> @@ -2310,56 +2356,7 @@ int serial8250_do_startup(struct uart_port *port)
>  
>  	up->ops->setup_timer(up);
>  
> -	/*
> -	 * Now, initialize the UART
> -	 */
> -	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> -
> -	uart_port_lock_irqsave(port, &flags);
> -	if (up->port.flags & UPF_FOURPORT) {
> -		if (!up->port.irq)
> -			up->port.mctrl |= TIOCM_OUT1;
> -	} else
> -		/*
> -		 * Most PC uarts need OUT2 raised to enable interrupts.
> -		 */
> -		if (port->irq)
> -			up->port.mctrl |= TIOCM_OUT2;
> -
> -	serial8250_set_mctrl(port, port->mctrl);
> -
> -	/*
> -	 * Serial over Lan (SoL) hack:
> -	 * Intel 8257x Gigabit ethernet chips have a 16550 emulation, to be
> -	 * used for Serial Over Lan.  Those chips take a longer time than a
> -	 * normal serial device to signalize that a transmission data was
> -	 * queued. Due to that, the above test generally fails. One solution
> -	 * would be to delay the reading of iir. However, this is not
> -	 * reliable, since the timeout is variable. So, let's just don't
> -	 * test if we receive TX irq.  This way, we'll never enable
> -	 * UART_BUG_TXEN.
> -	 */
> -	if (!(up->port.quirks & UPQ_NO_TXEN_TEST)) {
> -		/*
> -		 * Do a quick test to see if we receive an interrupt when we
> -		 * enable the TX irq.
> -		 */
> -		serial_port_out(port, UART_IER, UART_IER_THRI);
> -		lsr = serial_port_in(port, UART_LSR);
> -		iir = serial_port_in(port, UART_IIR);
> -		serial_port_out(port, UART_IER, 0);
> -
> -		if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
> -			if (!(up->bugs & UART_BUG_TXEN)) {
> -				up->bugs |= UART_BUG_TXEN;
> -				dev_dbg(port->dev, "enabling bad tx status workarounds\n");
> -			}
> -		} else {
> -			up->bugs &= ~UART_BUG_TXEN;
> -		}
> -	}
> -
> -	uart_port_unlock_irqrestore(port, flags);
> +	serial8250_initialize(port);
>  
>  	/*
>  	 * Clear the interrupt registers again for luck, and clear the
> 
