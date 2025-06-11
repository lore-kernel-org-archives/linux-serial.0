Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64B273D6D;
	Wed, 11 Jun 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646721; cv=none; b=U6gm+qVs/R/38GoNAmouRVwSnWK9pnWU3226D7kFCUevk1+V+/g/cRgXHEnsV4J+LkJ7OSKB4rF7MOCtWFBhHpdBnloV5exJBRzMyo4p8nQXA1pNyvFTT+VozAk6YAHEFf+IbXKfJmE55ttFj1D2/cO9DO7z3jscb6BTZivRKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646721; c=relaxed/simple;
	bh=bjdrKjexsX9dGmwydNKwJmHNPIa3EItLfxeT5EPjBNo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sv6L0cdviaVDKibAHuPP9BVhNxgNYgvzeXmyWF6cJWtNqJQu44uRDwvlnAC+dSUBlVEsYERlHyvRP89nsY8UO+9qBMojqV23HrOrbtN5+Oy1Y9e5twlzkct43e4hN0TO5qMDNY5fCt3JDk/jURdcpwylu+6O6SQ1UexuHOWtx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGKI4BwO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGKI4BwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749646720; x=1781182720;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bjdrKjexsX9dGmwydNKwJmHNPIa3EItLfxeT5EPjBNo=;
  b=SGKI4BwOUtwwMGOkmBf2a/D/xhh5iZkO3Q5MIWARYXj6UExMGZD/JJd+
   LrlMiRhiKaJDhDk/n7gwntgeYwLZvFQOuU5+mw8JewtMYYkXYANsd3I65
   nl4HlLmneVHuWoBy6oWLU5cnMzlmYznkL2/GyA7EZ1JvDYpTlbEkflWO/
   GWZYeJfe/WNJVC/67RzdfrkjgzsT+13NC5RdqlNjc9iVI2fWkIVdT/1I4
   fCdvjtuxQ/eaDNMjeiVRoMfv/EDuMpN22vpWfvw938xsWIn2oCeM0QTkP
   TsgPjyX1xkrw2lIqKWhp5FNbv53Fk3NJzb4iGJbNfnkX3mVm6NRyzg39i
   Q==;
X-CSE-ConnectionGUID: BmaH5YdRQB+rtzWZxM/tMw==
X-CSE-MsgGUID: bvNcmIHjRUmx1shDzXQCmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51668205"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51668205"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:58:38 -0700
X-CSE-ConnectionGUID: eoVbkOfbTgekRsupGNYkbA==
X-CSE-MsgGUID: 4G02qJICQFG8m4zwuBY0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152080248"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:58:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:58:29 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/33] serial: 8250: extract serial8250_set_efr()
In-Reply-To: <20250611100319.186924-24-jirislaby@kernel.org>
Message-ID: <2b9d3171-6a71-ad9e-8a73-f07487f0ad6b@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-24-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> serial8250_do_set_termios() consists of many registers and up flags
> settings. Extract all these into separate functions. This time, setting
> of EFR for UART_CAP_EFR ports.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++++------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 2c045a4369fc..0f16398cc86f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2768,6 +2768,30 @@ static void serial8250_set_ier(struct uart_port *port, struct ktermios *termios)
>  	serial_port_out(port, UART_IER, up->ier);
>  }
>  
> +static void serial8250_set_efr(struct uart_port *port, struct ktermios *termios)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	u8 efr_reg = UART_EFR;
> +	u8 efr = 0;
> +
> +	if (!(up->capabilities & UART_CAP_EFR))
> +		return;
> +
> +	/*
> +	 * TI16C752/Startech hardware flow control.  FIXME:
> +	 * - TI16C752 requires control thresholds to be set.
> +	 * - UART_MCR_RTS is ineffective if auto-RTS mode is enabled.
> +	 */
> +	if (termios->c_cflag & CRTSCTS)
> +		efr |= UART_EFR_CTS;
> +
> +	if (port->flags & UPF_EXAR_EFR)

I wonder if it is possible to trigger this at all? Only 8250_exar.c sets 
this flag and does not contain have UART_CAP_EFR at all (nor uses 
UPF_BOOT_AUTOCONF)??

> +		efr_reg = UART_XR_EFR;
> +
> +	serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
> +	serial_port_out(port, efr_reg, efr);
> +}
> +
>  void
>  serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  		          const struct ktermios *old)
> @@ -2797,24 +2821,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  	uart_update_timeout(port, termios->c_cflag, baud);
>  	serial8250_set_errors_and_ignores(port, termios);
>  	serial8250_set_ier(port, termios);
> -
> -	if (up->capabilities & UART_CAP_EFR) {
> -		unsigned char efr = 0;
> -		/*
> -		 * TI16C752/Startech hardware flow control.  FIXME:
> -		 * - TI16C752 requires control thresholds to be set.
> -		 * - UART_MCR_RTS is ineffective if auto-RTS mode is enabled.
> -		 */
> -		if (termios->c_cflag & CRTSCTS)
> -			efr |= UART_EFR_CTS;
> -
> -		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
> -		if (port->flags & UPF_EXAR_EFR)
> -			serial_port_out(port, UART_XR_EFR, efr);
> -		else
> -			serial_port_out(port, UART_EFR, efr);
> -	}
> -
> +	serial8250_set_efr(port, termios);
>  	serial8250_set_divisor(port, baud, quot, frac);
>  
>  	/*
> 

-- 
 i.


