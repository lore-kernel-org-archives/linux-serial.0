Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981B253355;
	Fri,  6 Jun 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206437; cv=none; b=PluaLMWsTxDOtadCParaKFB7bwlN9n679cZkK35g41MdBC1jjjDa9YEUEZuXiBeZQr3Viatso81PYAAYMY8N8UIEed1663GJ3Cl8lZRE1dCJOoQozhzptKFf/ylyNJdNt96VAEQNDaeQH2hPD7xxw2aw+tXQkfD0DlVzeU6daP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206437; c=relaxed/simple;
	bh=N0dWlwt/wUZAlKZIKffM0LxIo2EDg6xSxq+YVnEkUYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQUurBhX5k5RBjYuQ1YIFQmYoHyp2ZG4dlpnEb+4xFh0tqyvPhIFU8Awlwwy4U2sg7exl2qpx+V6ebxQ0I0g36GTqumDXk3TDiL+86Ji4rwOyf3BDAfmqigxdUZ4O1yt4mgqFgZveV21Vu2vOIGGYpjasKnimVbDpymekC+zcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LlhYlBT/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LlhYlBT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A3AC4CEEB;
	Fri,  6 Jun 2025 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749206436;
	bh=N0dWlwt/wUZAlKZIKffM0LxIo2EDg6xSxq+YVnEkUYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlhYlBT/0EQdYF0dX9loZ15WZBxDzM3zowld8tKGu4uUwK1OzXcDwNyxHMks1wjgt
	 SawS3DS6Mp5CtUbz+FNqcguL78XRgRIPU7TTSL5G7Wjbcneo3sI+leO5/03MpLxD1z
	 P9b1eBOXp1zO84Srh5X8sbMZxP+loTc6DOAv3CFg=
Date: Fri, 6 Jun 2025 12:40:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu, heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	markus.mayer@linaro.org, matt.porter@linaro.org,
	namcao@linutronix.de, paulmck@kernel.org, pmladek@suse.com,
	schnelle@linux.ibm.com, sunilvl@ventanamicro.com,
	tim.kryger@linaro.org
Subject: Re: [PATCH v7 1/4] serial: 8250: fix panic due to PSLVERR
Message-ID: <2025060621-hankie-groovy-bad6@gregkh>
References: <20250528062609.25104-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528062609.25104-1-cuiyunhui@bytedance.com>

On Wed, May 28, 2025 at 02:26:06PM +0800, Yunhui Cui wrote:
> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
> 
> In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the serial_port_in(port, UART_RX).
> This satisfies the PSLVERR trigger condition.
> 
> When another CPU (e.g., using printk()) is accessing the UART (UART
> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> (lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
> dw8250_force_idle().
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
> index 6d7b8c4667c9c..07fe818dffa34 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2376,9 +2376,10 @@ int serial8250_do_startup(struct uart_port *port)
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
> -- 
> 2.39.5
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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
