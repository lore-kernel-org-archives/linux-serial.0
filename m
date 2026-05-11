Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EFE426D33;
	Mon, 11 May 2026 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515693; cv=none; b=AUtKPq1eValxqqF1LtAWyngeuyuFdbsxQxqpDqURVJ15bGSfq2jZHgqVljhbPQzRG5u5cOXHeaRZZpu2exwB9gIS4LaZtcVIs2l2RQ1Hom3zTixFWiGJzN2tW/HwXid0N7Iz0A4K6nkfidaWDlHECaxpYk9q4aW7gVEDiGIS9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515693; c=relaxed/simple;
	bh=WAsNg53o9Q/xBXOANEhRTn3Z57nnYp13Q4ybBydrjoo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DvUou3d0f+MoGIZoLxdzQC/wX6AhyxTQmAfboJTSBrGa2wifOGWoZ5Xoi9sahf8VPcvxM3xR6Bifxii8dyRFoEfg/35HQQPkfyivH2fEPqyeCQTKKvOZBMH8KGLHkVaYn7wWlaEzms5dVVBwT2a2BBBAX9n91+i6qSni2Gfk7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdxgtuCH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdxgtuCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778515690; x=1810051690;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WAsNg53o9Q/xBXOANEhRTn3Z57nnYp13Q4ybBydrjoo=;
  b=bdxgtuCHQUb/DXyt2LsQUWURaRA7p98KUkTpbbdXA2bxJq/n5tdUbsa6
   lje64nPzJoQ75TEmqZ+feyheFf2i8zkY2MzWEq1KcWYAEEJ8j5Bp3KRmS
   VqmDFEEVZ2D+YP9x3Qak+9OFzArREE559jHpH7eQVfKolHXzYkdmTshVo
   2GRJS0VAumf2yKx1ois3SeeOelJMxi9NKRdV90vTyLrr8VqQOMSx3iVoT
   1/mo1UGt5z1qHP/z6uW+kstB9QSmosaQYwt6vIFqqrUK7TNy96//TL957
   mPXMazE6etO4b9PNur8rwEp7kesik/QrLPo8xQv97TUgNj5s8jM16I4bp
   w==;
X-CSE-ConnectionGUID: F7Ha0FMITW6haWnnO3MPCQ==
X-CSE-MsgGUID: 0ytZsduDScOaWPuEnvWOzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="102071123"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="102071123"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:08:01 -0700
X-CSE-ConnectionGUID: 7eyUlNxlTmCV+R0XVaJVTA==
X-CSE-MsgGUID: HNElnIzXRJi4eUEaZN11bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261234862"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:07:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 May 2026 19:07:51 +0300 (EEST)
To: John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
    Kees Cook <kees@kernel.org>, Osama Abdelkader <osama.abdelkader@gmail.com>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Joseph Tilahun <jtilahun@astranis.com>, 
    Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
    "Dr. David Alan Gilbert" <linux@treblig.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH tty v5 3/3] serial: 8250: Add support for console flow
 control
In-Reply-To: <20260511152706.151498-4-john.ogness@linutronix.de>
Message-ID: <f9f408c5-72f5-4be8-7471-e9aee2935a5b@linux.intel.com>
References: <20260511152706.151498-1-john.ogness@linutronix.de> <20260511152706.151498-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 May 2026, John Ogness wrote:

> The kernel documentation specifies that the console option 'r' can
> be used to enable hardware flow control for console writes. The 8250
> driver does include code for hardware flow control on the console if
> cons_flow is set, but there is no code path that actually sets this.
> However, that is not the only issue. The problems are:
> 
> 1. Specifying the console option 'r' does not lead to cons_flow being
>    set.
> 
> 2. Even if cons_flow would be set, serial8250_register_8250_port()
>    clears it.
> 
> 3. When the console option 'r' is specified, uart_set_options()
>    attempts to initialize the port for CRTSCTS. However, afterwards
>    it does not set the UPSTAT_CTS_ENABLE status bit and therefore on
>    boot, uart_cts_enabled() is always false. This policy bit is
>    important for console drivers as a criteria if they may poll CTS.
> 
> 4. Even though uart_set_options() attempts to initialize the port
>    for CRTSCTS, the 8250 set_termios() callback does not enable the
>    RTS signal (TIOCM_RTS) and thus the hardware is not properly
>    initialized for CTS polling.
> 
> 5. Even if modem control was properly setup for CTS polling
>    (TIOCM_RTS), uart_configure_port() clears TIOCM_RTS, thus
>    breaking CTS polling.
> 
> 6. wait_for_xmitr() and serial8250_console_write() use cons_flow
>    to decide if CTS polling should occur. However, the condition
>    should also include a check that it is not in RS485 mode and
>    CRTSCTS is actually enabled in the hardware.
> 
> Address all these issues as conservatively as possible by gating them
> behind checks focussed on the user specifying console hardware flow
> control support and the hardware being configured for CTS polling
> at the time of the write to the UART.
> 
> Since checking the UPSTAT_CTS_ENABLE status bit is a part of the new
> condition gate, these changes also support runtime termios updates to
> disable/enable CRTSCTS.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250_core.c |  6 +++++-
>  drivers/tty/serial/8250/8250_port.c | 13 +++++++++++--
>  drivers/tty/serial/serial_core.c    | 21 ++++++++++++++++++++-
>  include/linux/serial_core.h         |  8 ++++++++
>  4 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index b0275204e1167..1f03da85e3414 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -693,6 +693,7 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
>  int serial8250_register_8250_port(const struct uart_8250_port *up)
>  {
>  	struct uart_8250_port *uart;
> +	bool cons_flow;
>  	int ret;
>  
>  	if (up->port.uartclk == 0)
> @@ -716,6 +717,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  	if (uart->port.type == PORT_8250_CIR)
>  		return -ENODEV;
>  
> +	/* Preserve specified console flow control. */
> +	cons_flow = uart_cons_flow_enabled(&uart->port);
> +
>  	if (uart->port.dev)
>  		uart_remove_one_port(&serial8250_reg, &uart->port);
>  
> @@ -746,7 +750,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  	uart->lsr_save_mask	= up->lsr_save_mask;
>  	uart->dma		= up->dma;
>  
> -	uart_set_cons_flow_enabled(&uart->port, uart_cons_flow_enabled(&up->port));
> +	uart_set_cons_flow_enabled(&uart->port, uart_cons_flow_enabled(&up->port) | cons_flow);
>  
>  	/* Take tx_loadsz from fifosize if it wasn't set separately */
>  	if (uart->port.fifosize && !uart->tx_loadsz)
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index fe2e0f1e66c21..ef245114105bc 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1991,7 +1991,7 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>  	tx_ready = wait_for_lsr(up, bits);
>  
>  	/* Wait up to 1s for flow control if necessary */
> -	if (uart_cons_flow_enabled(&up->port)) {
> +	if (uart_console_hwflow_active(&up->port)) {
>  		for (tmout = 1000000; tmout; tmout--) {
>  			unsigned int msr = serial_in(up, UART_MSR);
>  			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
> @@ -2788,6 +2788,12 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  		serial8250_set_efr(port, termios);
>  		serial8250_set_divisor(port, baud, quot, frac);
>  		serial8250_set_fcr(port, termios);
> +		/* Consoles manually poll CTS for hardware flow control. */
> +		if (uart_console(port) &&
> +		    !(port->rs485.flags & SER_RS485_ENABLED)
> +		    && termios->c_cflag & CRTSCTS) {
> +			port->mctrl |= TIOCM_RTS;
> +		}
>  		serial8250_set_mctrl(port, port->mctrl);
>  	}
>  
> @@ -3357,7 +3363,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  		 * it regardless of the CTS state. Therefore, only use fifo
>  		 * if we don't use control flow.
>  		 */
> -		!uart_cons_flow_enabled(&up->port);
> +		!uart_console_hwflow_active(&up->port);
>  
>  	if (likely(use_fifo))
>  		serial8250_console_fifo_write(up, s, count);
> @@ -3427,6 +3433,9 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
>  	if (ret)
>  		return ret;
>  
> +	/* Track user-specified console flow control. */
> +	uart_set_cons_flow_enabled(port, flow == 'r');
> +
>  	if (port->dev)
>  		pm_runtime_get_sync(port->dev);
>  
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 89cebdd278410..840336f95c5f6 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2235,6 +2235,18 @@ uart_set_options(struct uart_port *port, struct console *co,
>  	port->mctrl |= TIOCM_DTR;
>  
>  	port->ops->set_termios(port, &termios, &dummy);
> +
> +	/*
> +	 * If console hardware flow control was specified and is supported,
> +	 * the related policy UPSTAT_CTS_ENABLE must be set to allow console
> +	 * drivers to identify if CTS should be used for polling.
> +	 */
> +	if (flow == 'r' && (termios.c_cflag & CRTSCTS)) {
> +		/* Synchronize @status RMW update against the console. */
> +		guard(uart_port_lock_irqsave)(port);
> +		port->status |= UPSTAT_CTS_ENABLE;
> +	}
> +
>  	/*
>  	 * Allow the setting of the UART parameters with a NULL console
>  	 * too:
> @@ -2541,7 +2553,14 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  		 * We probably don't need a spinlock around this, but
>  		 */
>  		scoped_guard(uart_port_lock_irqsave, port) {
> -			port->mctrl &= TIOCM_DTR;
> +			unsigned int mask = TIOCM_DTR;
> +
> +			/* Console hardware flow control polls CTS. */
> +			if (uart_console_hwflow_active(port))
> +				mask |= TIOCM_RTS;
> +
> +			port->mctrl &= mask;
> +
>  			if (!(port->rs485.flags & SER_RS485_ENABLED))
>  				port->ops->set_mctrl(port, port->mctrl);
>  		}
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 4f7bbdd900176..17fcff466e301 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -1175,6 +1175,14 @@ static inline bool uart_cons_flow_enabled(const struct uart_port *uport)
>  	return uport->cons_flow;
>  }
>  
> +static inline bool uart_console_hwflow_active(struct uart_port *uport)
> +{
> +	return uart_console(uport) &&
> +	       !(uport->rs485.flags & SER_RS485_ENABLED) &&
> +	       uart_cons_flow_enabled(uport) &&
> +	       uart_cts_enabled(uport);
> +}
> +
>  /*
>   * The following are helper functions for the low level drivers.
>   */
> 

Hi,

Did you miss Andy's comments or choose to not act on them?

-- 
 i.

