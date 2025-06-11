Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63621FF2B;
	Wed, 11 Jun 2025 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642133; cv=none; b=kva0TejKrz53HvcsFmwdMM4rr5F6zcn/MSLA1KRFiy8iya6I7KCmuFmZsFIOLYBR82/b0QxMxgkvm7X3WFJIdldW5xPbFtU6Ttrxba8eqvienIOLIVaCBFXzApuZfSOmIrt4uwWJm55fj3+GG0ASTwx62MNU7kBvOczpEPtHjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642133; c=relaxed/simple;
	bh=BdA4orRIE/XEYkCx+1v0rqbPNwUeA6DfeerQ3gnz6tw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fylDCioJRq/qJcmrtrnfDJF1cZhc5UHZ+HBJwDeT1AZSxEp76SdvWvV9+fYlekYHgXZBPsdeo60GN8/NVzqgK6ccKilgPpfkGr7u7WeLVhs6O+pP4WQlkt1uVPsY92b6ST1UtVpnyifHtifYUQxDszLa8oT1RiYAp9sj8UKe3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sf1TqoWS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sf1TqoWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749642132; x=1781178132;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BdA4orRIE/XEYkCx+1v0rqbPNwUeA6DfeerQ3gnz6tw=;
  b=Sf1TqoWSIOMWhIP8Yi2U9Yc3gZ3tfdSqe72l29PBrB7Lv9p/vScfQvjm
   D96tpDbRkmVhJwJZG/PBrtL620tlPVQv19tlmV7s/0AImjQQXMsqrqSsS
   BshDe+K6jYcyUrMEnYzpcVbyB6eoh+300Q8M/EMoOjaOxKGmLtSpe9+7/
   yd1D0BFPFUsIN3Atl7BlX08m6OIR5YMZu4lj3RpSevD9LVs634aXVzm7A
   o4N19Z3lxXb4851R+I289I3ReuyjWICZaYK7at3/vc1nnNDvkruog90G0
   7rJzbZRVjQGhJiPTRvNbwGBEefXbTQP3e1zzpTUIiODQ6RHkOipSUYsKU
   g==;
X-CSE-ConnectionGUID: 0yTYt+u6QDiazi3lWy7Q7w==
X-CSE-MsgGUID: 5oeuFTerQBqIANT/wVOaQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55586751"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="55586751"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:42:11 -0700
X-CSE-ConnectionGUID: GwQfmCBYT+GN4xnP2MbbfA==
X-CSE-MsgGUID: CH5V+7WrQqiZDlCCuKZpSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152065771"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:42:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:42:05 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/33] serial: 8250: remove CONFIG_SERIAL_8250_RSA inline
 macros from code
In-Reply-To: <20250611100319.186924-10-jirislaby@kernel.org>
Message-ID: <95e65501-7096-045f-db52-26e90683a003@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-10-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> All these:
>   #ifdef CONFIG_SERIAL_8250_RSA
>   ...
>   #endif
> 
> in the 8250 generic code distract the reader. Introduce empty inlines to
> handle the !CONFIG_SERIAL_8250_RSA case and handle the '#if's around the
> RSA functions definitions.
> 
> This means rsa_autoconfig() and rsa_reset() functions were introduced to
> contain the particular code.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 54 ++++++++++++++---------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index f5407832e8a7..233316a88df2 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -738,6 +738,9 @@ static int __enable_rsa(struct uart_8250_port *up)
>  	return result;
>  }
>  
> +/*
> + * If this is an RSA port, see if we can kick it up to the higher speed clock.
> + */
>  static void enable_rsa(struct uart_8250_port *up)
>  {
>  	if (up->port.type == PORT_RSA) {

In general, a good change but it would also be nice to reverse all these 
type check because then it would be immediately obvious the function does 
nothing if it's not PORT_RSA.

> @@ -752,10 +755,9 @@ static void enable_rsa(struct uart_8250_port *up)
>  }
>  
>  /*
> - * Attempts to turn off the RSA FIFO.  Returns zero on failure.
> - * It is unknown why interrupts were disabled in here.  However,
> - * the caller is expected to preserve this behaviour by grabbing
> - * the spinlock before calling this function.
> + * Attempts to turn off the RSA FIFO and resets the RSA board back to 115kbps compat mode. It is
> + * unknown why interrupts were disabled in here. However, the caller is expected to preserve this
> + * behaviour by grabbing the spinlock before calling this function.
>   */
>  static void disable_rsa(struct uart_8250_port *up)
>  {
> @@ -780,6 +782,25 @@ static void disable_rsa(struct uart_8250_port *up)
>  		uart_port_unlock_irq(&up->port);
>  	}
>  }
> +
> +static void rsa_autoconfig(struct uart_8250_port *up)
> +{
> +	/* Only probe for RSA ports if we got the region. */
> +	if (up->port.type == PORT_16550A && up->probe & UART_PROBE_RSA &&
> +	    __enable_rsa(up))
> +		up->port.type = PORT_RSA;
> +}
> +
> +static void rsa_reset(struct uart_8250_port *up)
> +{
> +	if (up->port.type == PORT_RSA)
> +		serial_out(up, UART_RSA_FRR, 0);
> +}
> +#else
> +static inline void enable_rsa(struct uart_8250_port *up) {}
> +static inline void disable_rsa(struct uart_8250_port *up) {}
> +static inline void rsa_autoconfig(struct uart_8250_port *up) {}
> +static inline void rsa_reset(struct uart_8250_port *up) {}
>  #endif /* CONFIG_SERIAL_8250_RSA */
>  
>  /*
> @@ -1267,14 +1288,7 @@ static void autoconfig(struct uart_8250_port *up)
>  		break;
>  	}
>  
> -#ifdef CONFIG_SERIAL_8250_RSA
> -	/*
> -	 * Only probe for RSA ports if we got the region.
> -	 */
> -	if (port->type == PORT_16550A && up->probe & UART_PROBE_RSA &&
> -	    __enable_rsa(up))
> -		port->type = PORT_RSA;
> -#endif
> +	rsa_autoconfig(up);
>  
>  	serial_out(up, UART_LCR, save_lcr);
>  
> @@ -1289,10 +1303,7 @@ static void autoconfig(struct uart_8250_port *up)
>  	/*
>  	 * Reset the UART.
>  	 */
> -#ifdef CONFIG_SERIAL_8250_RSA
> -	if (port->type == PORT_RSA)
> -		serial_out(up, UART_RSA_FRR, 0);
> -#endif
> +	rsa_reset(up);
>  	serial8250_out_MCR(up, save_mcr);
>  	serial8250_clear_fifos(up);
>  	serial_in(up, UART_RX);
> @@ -2248,13 +2259,7 @@ int serial8250_do_startup(struct uart_port *port)
>  				UART_DA830_PWREMU_MGMT_FREE);
>  	}
>  
> -#ifdef CONFIG_SERIAL_8250_RSA
> -	/*
> -	 * If this is an RSA port, see if we can kick it up to the
> -	 * higher speed clock.
> -	 */
>  	enable_rsa(up);
> -#endif
>  
>  	/*
>  	 * Clear the FIFO buffers and disable them.
> @@ -2521,12 +2526,7 @@ void serial8250_do_shutdown(struct uart_port *port)
>  			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
>  	serial8250_clear_fifos(up);
>  
> -#ifdef CONFIG_SERIAL_8250_RSA
> -	/*
> -	 * Reset the RSA board back to 115kbps compat mode.
> -	 */
>  	disable_rsa(up);
> -#endif
>  
>  	/*
>  	 * Read data port to reset things, and then unlink from
> 

-- 
 i.

