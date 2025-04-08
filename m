Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387D218587;
	Tue,  8 Apr 2025 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093502; cv=none; b=h7BJN9B25Q4zTDdEzfsn1NF5FbuIlauBc/0TwX/aRcJi4QXJrn7CO6gWyiiPB/rFl8Mc9cuCwE7ym194J33VSp0q6/5/59F4w1TXiw2UpLhzyGsU7KqIbJ7ZWMUUdrVzqQ7j/mzJFLEacM4xsyRp7lyALi3olZc5mnVGD5KNYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093502; c=relaxed/simple;
	bh=1ghIqGTVzMSL0QD6IHFM3pf2OL0QNAhUteNjrsYKOuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4s+SNkAbf3tzt4ba3lwyI8RFAncef2cdkOPAf99mmLNz4utyKqO8ManKO/EbW5YBNdp/3uH/z3XzCMg/NMS+N2pCGBL+qCjNtmFRZKvwque/VHmdtSC1UrMgViOO6RF8XbwUiTvu8w9wdpBFZx+VfMMo+8ZiNf7pQX0/N52d8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/ein4Vu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/ein4Vu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5779CC4CEE5;
	Tue,  8 Apr 2025 06:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744093501;
	bh=1ghIqGTVzMSL0QD6IHFM3pf2OL0QNAhUteNjrsYKOuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/ein4VuRJ3NKN1HY+5Jk07AkVqJkKPL/89xzWX+nx1cAYKVAh2KPf65w1yMb/M8P
	 uLn61uhyaww0TwptaP3eRzQpbN2EuwxAQf/dtnCmFt3E6LQFQtXEkrhSeLHvgAwgvF
	 oeFwh6GxeI4BB1nypK8suKtfuYjw8B5nyPgcSBQo=
Date: Tue, 8 Apr 2025 08:23:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: jirislaby@kernel.org, john.ogness@linutronix.de, pmladek@suse.com,
	arnd@arndb.de, andriy.shevchenko@linux.intel.com,
	namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, matt.porter@linaro.org,
	tim.kryger@linaro.org, markus.mayer@linaro.org,
	heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250: fix panic due to PSLVERR
Message-ID: <2025040814-dagger-referee-7b61@gregkh>
References: <20250408061200.76148-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408061200.76148-1-cuiyunhui@bytedance.com>

On Tue, Apr 08, 2025 at 02:12:00PM +0800, Yunhui Cui wrote:
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
> To resolve this issue, relevant serial_port_out() operations should be
> placed in a critical section, and UART_RX data should only be read
> when the UART_LSR DR bit is set.
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
>  drivers/tty/serial/8250/8250_port.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3f256e96c722..3df358008489 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2264,13 +2264,16 @@ int serial8250_do_startup(struct uart_port *port)
>  	 * Clear the FIFO buffers and disable them.
>  	 * (they will be reenabled in set_termios())
>  	 */
> +	uart_port_lock_irqsave(port, &flags);
>  	serial8250_clear_fifos(up);
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  	/*
>  	 * Clear the interrupt registers.
>  	 */
> -	serial_port_in(port, UART_LSR);
> -	serial_port_in(port, UART_RX);
> +	lsr = serial_port_in(port, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		serial_port_in(port, UART_RX);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
>  
> @@ -2380,9 +2383,10 @@ int serial8250_do_startup(struct uart_port *port)
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
> @@ -2435,8 +2439,9 @@ int serial8250_do_startup(struct uart_port *port)
>  	 * saved flags to avoid getting false values from polling
>  	 * routines or the previous session.
>  	 */
> -	serial_port_in(port, UART_LSR);
> -	serial_port_in(port, UART_RX);
> +	lsr = serial_port_in(port, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		serial_port_in(port, UART_RX);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
>  	up->lsr_saved_flags = 0;
> @@ -2492,6 +2497,7 @@ void serial8250_do_shutdown(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned long flags;
> +	u16 lsr;
>  
>  	serial8250_rpm_get(up);
>  	/*
> @@ -2538,7 +2544,9 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	 * Read data port to reset things, and then unlink from
>  	 * the IRQ chain.
>  	 */
> -	serial_port_in(port, UART_RX);
> +	lsr = serial_port_in(port, UART_LSR);
> +	if (lsr & UART_LSR_DR)
> +		serial_port_in(port, UART_RX);
>  	serial8250_rpm_put(up);
>  
>  	up->ops->release_irq(up);
> -- 
> 2.39.2
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
