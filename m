Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0697253F07;
	Wed, 11 Jun 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645833; cv=none; b=La710kZck4mtL2brWvkg1JR1m8P7hyw9X0iyfrd5I11G2KM2TLKqc4D6LvjJicRNKg+mUmZAdmzkT34f4hlIHgaNjWnJDWMyovlJ0Sx8gTldSD9fckTuL32nN4Lv5ZqCOLsMuvOHFEgyu1+NWa6qEFbgt0pDjSQhRYWHfswjWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645833; c=relaxed/simple;
	bh=8CWw+IWPIrYBbXtL5RphJdZSTR77wntQotLoXBWVcNw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZXZmG8mUQkYiwLboVah0zgmoKfsHGH6bPZ/ON88SmUlHIw8DGAsfelyaU5r0oyyrxrDr43QJRR5L6qYHYgsUf4WEBdsfGQx7rpGAYfqf/RA/mobXxkPQlh9h0WjeMFw8apzu2o22DjXofkj4OzPS8f93P3xYXCeFZUTuhnUstGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpjMgZm8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpjMgZm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749645832; x=1781181832;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8CWw+IWPIrYBbXtL5RphJdZSTR77wntQotLoXBWVcNw=;
  b=QpjMgZm8cASJG71GDkuu1Lj8O+QeJSLSBSdpTcwI+7TlM1GUw1E27rHW
   Xvwh/LdvXPNUFr/IvmfW6Em5WHk56K/sxiB438kVpLrpC7W84dJpJKUdg
   VCc+K/C7n8h+lXZLN59bEu7oUQXMPKmBzHhrz44xpLhUEXlydPdR4+MoX
   S3toDOk8DPFzdLEm9LQIYCvLKF4kr6Hffx5vg5dISTvmnAD/J+cfsUc1B
   CoH3f7j7bR3gWS9kFSec1bvaDomqRwgXXxNRMQR1srS6xvE3UDkvtUJaM
   SjpUEq59S8GxfvRwxmw2dsQl/s6V1WnwlX6eoqIvSQJqYG0KlpAYxAw+D
   Q==;
X-CSE-ConnectionGUID: B7eDmI+hRiqEjbIvHTJ9YQ==
X-CSE-MsgGUID: XcAh9wPoTRKYygoP3p4h6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="69227664"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="69227664"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:43:51 -0700
X-CSE-ConnectionGUID: WAjCfuZpTAqX4eNaqGmX/w==
X-CSE-MsgGUID: 4O6bIGYpT+yZuq3JR+ORHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="184394909"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:43:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:43:45 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 21/33] serial: 8250: extract
 serial8250_set_errors_and_ignores
In-Reply-To: <20250611100319.186924-22-jirislaby@kernel.org>
Message-ID: <c3917f82-40e9-6aa8-79d3-f6dae57671c4@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-22-jirislaby@kernel.org>
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
> of ignore_status_mask and read_status_mask.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 67 ++++++++++++++---------------
>  1 file changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index b15371838366..6bb7f004d607 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2720,6 +2720,38 @@ static void serial8250_set_afe(struct uart_port *port, struct ktermios *termios)
>  		up->mcr |= UART_MCR_AFE;
>  }
>  
> +static void serial8250_set_errors_and_ignores(struct uart_port *port, struct ktermios *termios)
> +{
> +	/*
> +	 * Specify which conditions may be considered for error handling and the ignoring of
> +	 * characters. The actual ignoring of characters only occurs if the bit is set in
> +	 * @ignore_status_mask as well.
> +	 */
> +	port->read_status_mask = UART_LSR_OE | UART_LSR_DR;
> +	if (termios->c_iflag & INPCK)
> +		port->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
> +	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
> +		port->read_status_mask |= UART_LSR_BI;
> +
> +	/* Characters to ignore */
> +	port->ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		port->ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
> +	if (termios->c_iflag & IGNBRK) {
> +		port->ignore_status_mask |= UART_LSR_BI;
> +		/*
> +		 * If we're ignoring parity and break indicators, ignore overruns too (for real raw
> +		 * support).
> +		 */
> +		if (termios->c_iflag & IGNPAR)
> +			port->ignore_status_mask |= UART_LSR_OE;
> +	}
> +
> +	/* ignore all characters if CREAD is not set */
> +	if ((termios->c_cflag & CREAD) == 0)
> +		port->ignore_status_mask |= UART_LSR_DR;
> +}

Can this function be used also by 8250_omap.c or made reusable if not 
directly possible?

Inside non-8250 drivers there might even more duplication related to 
these. There might also be some duplication on the read character side
as I've feeling I've seen plenty of copy paste related these flags (or 
what looked copy paste).

>  void
>  serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  		          const struct ktermios *old)
> @@ -2747,40 +2779,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  	serial8250_set_trigger_for_slow_speed(port, termios, baud);
>  	serial8250_set_afe(port, termios);
>  	uart_update_timeout(port, termios->c_cflag, baud);
> -
> -	/*
> -	 * Specify which conditions may be considered for error
> -	 * handling and the ignoring of characters. The actual
> -	 * ignoring of characters only occurs if the bit is set
> -	 * in @ignore_status_mask as well.
> -	 */
> -	port->read_status_mask = UART_LSR_OE | UART_LSR_DR;
> -	if (termios->c_iflag & INPCK)
> -		port->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
> -	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
> -		port->read_status_mask |= UART_LSR_BI;
> -
> -	/*
> -	 * Characters to ignore
> -	 */
> -	port->ignore_status_mask = 0;
> -	if (termios->c_iflag & IGNPAR)
> -		port->ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
> -	if (termios->c_iflag & IGNBRK) {
> -		port->ignore_status_mask |= UART_LSR_BI;
> -		/*
> -		 * If we're ignoring parity and break indicators,
> -		 * ignore overruns too (for real raw support).
> -		 */
> -		if (termios->c_iflag & IGNPAR)
> -			port->ignore_status_mask |= UART_LSR_OE;
> -	}
> -
> -	/*
> -	 * ignore all characters if CREAD is not set
> -	 */
> -	if ((termios->c_cflag & CREAD) == 0)
> -		port->ignore_status_mask |= UART_LSR_DR;
> +	serial8250_set_errors_and_ignores(port, termios);
>  
>  	/*
>  	 * CTS flow control flag and modem status interrupts
> 

-- 
 i.

