Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAC1A9B48;
	Wed,  8 Jan 2025 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323995; cv=none; b=a57wW4w/wvA2/GjzoVGUzQ3RKEp61zYTom7WQkvx5Czjx7vsmGTBz+J5jmkGss9Tk1pBIHhYD/KOk7VlAGCBJKTXo0GlDcz7CnieYCS1HBhM/w5xQaHQ4jsSujw+SnDcIsVRScnNP2f8WPHzz8G4pxXdjqQjp30tWKvooyST5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323995; c=relaxed/simple;
	bh=tRgRy8gM6MaS6N044gOjTwzD7jxxj2feUGYBJJLTg/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWLtnW0WoxehVBACrKUb9ik2TmHRC+SWRjUXxws0X5fmkxXZ2z1zbofXdNe2aW1dBTF+UlJY6r3SqF4d/Gkbt/KYGmV0prCuzzocTZ38xYu5PF9P+7QveMNxgM/wInNmvQZwKb2LMY1s0ZecwKhcOTaeubu3kSYqly3LMAKi+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Kn2klvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Kn2klvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD10C4CEE0;
	Wed,  8 Jan 2025 08:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736323994;
	bh=tRgRy8gM6MaS6N044gOjTwzD7jxxj2feUGYBJJLTg/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0Kn2klvt5ASlC1OAmrvwRdle0k28Id+SCbIl+iFauiALT665T/b7NmtgOLS3xzakj
	 s38dAFTp49eQp8X7WolXssh2M3Pd/x8TquoSfpphTvwXo3wIysepRC9SXm3VW6emHn
	 pjISi93b/mlZ07uQB79IKI349pOjvHmFFfjrABPg=
Date: Wed, 8 Jan 2025 09:13:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
Cc: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: amba-pl011: Implement nbcon console
Message-ID: <2025010845-deceiver-imaginary-ea04@gregkh>
References: <20250108004730.2302996-1-fj6611ie@aa.jp.fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108004730.2302996-1-fj6611ie@aa.jp.fujitsu.com>

On Wed, Jan 08, 2025 at 12:47:30AM +0000, Toshiyuki Sato wrote:
> Implement the callbacks required for an NBCON console [0] on the 
> amba-pl011 console driver.
> The codes for legacy console are retained, and the module
> parameter (use_nbcon) allows switching between legacy and NBCON.
> The default is off (use legacy console) for now.
> 
> Referred to the NBCON implementation work for 8250 [1] and imx [2].
> 
> The normal-priority write_thread checks for console ownership
> each time a character is printed.
> write_atomic holds the console ownership until the entire string
> is printed.
> 
> UART register operations are protected from other contexts by 
> uart_port_lock, except for a final flush(nbcon_atomic_flush_unsafe) 
> on panic.
> 
> The patch has been verified to correctly handle the output and
> competition of messages with different priorities and flushing
> panic message to console after nmi panic using ARM64 QEMU and
> a physical machine(A64FX).
> 
> [0] https://lore.kernel.org/all/ZuRRTbapH0DCj334@pathway.suse.cz/
> [1] https://lore.kernel.org/all/20240913140538.221708-1-john.ogness@linutronix.de/T/
> [2] https://lore.kernel.org/linux-arm-kernel/20240913-serial-imx-nbcon-v3-1-4c627302335b@geanix.com/T/
> 
> Signed-off-by: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 113 ++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 69b7a3e1e..52fab3170 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -41,6 +41,7 @@
>  #include <linux/sizes.h>
>  #include <linux/io.h>
>  #include <linux/acpi.h>
> +#include <linux/moduleparam.h>
>  
>  #define UART_NR			14
>  
> @@ -263,6 +264,7 @@ struct uart_amba_port {
>  	char			type[12];
>  	bool			rs485_tx_started;
>  	unsigned int		rs485_tx_drain_interval; /* usecs */
> +	bool			console_line_ended;
>  #ifdef CONFIG_DMA_ENGINE
>  	/* DMA stuff */
>  	unsigned int		dmacr;		/* dma control reg */
> @@ -274,6 +276,10 @@ struct uart_amba_port {
>  #endif
>  };
>  
> +/* if non-zero, the console is nbcon. */
> +static int use_nbcon;
> +module_param(use_nbcon, int, 0444);

Why is a module parameter needed here?  That feels wrong and not
scalable at all.  What happens if you have multiple devices, which one
is nbcon and which isn't?


> +
>  static unsigned int pl011_tx_empty(struct uart_port *port);
>  
>  static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
> @@ -2305,6 +2311,7 @@ static void pl011_console_putchar(struct uart_port *port, unsigned char ch)
>  	while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
>  		cpu_relax();
>  	pl011_write(ch, uap, REG_DR);
> +	uap->console_line_ended = (ch == '\n');
>  }
>  
>  static void
> @@ -2411,6 +2418,8 @@ static int pl011_console_setup(struct console *co, char *options)
>  	if (ret)
>  		return ret;
>  
> +	uap->console_line_ended = true;
> +
>  	if (dev_get_platdata(uap->port.dev)) {
>  		struct amba_pl011_data *plat;
>  
> @@ -2494,6 +2503,106 @@ static int pl011_console_match(struct console *co, char *name, int idx,
>  	return -ENODEV;
>  }
>  
> +static void
> +pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt)
> +{
> +	struct uart_amba_port *uap = amba_ports[co->index];
> +	unsigned int old_cr = 0;
> +
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
> +
> +	clk_enable(uap->clk);
> +
> +	if (!uap->vendor->always_enabled) {
> +		old_cr = pl011_read(uap, REG_CR);
> +		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
> +				uap, REG_CR);
> +	}
> +
> +	if (!uap->console_line_ended)
> +		uart_console_write(&uap->port, "\n", 1, pl011_console_putchar);
> +	uart_console_write(&uap->port, wctxt->outbuf, wctxt->len, pl011_console_putchar);
> +
> +	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
> +		cpu_relax();
> +
> +	if (!uap->vendor->always_enabled)
> +		pl011_write(old_cr, uap, REG_CR);
> +
> +	clk_disable(uap->clk);
> +
> +	nbcon_exit_unsafe(wctxt);
> +}
> +
> +static void
> +pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt)
> +{
> +	struct uart_amba_port *uap = amba_ports[co->index];
> +	unsigned int old_cr = 0;
> +
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
> +
> +	clk_enable(uap->clk);
> +
> +	if (!uap->vendor->always_enabled) {
> +		old_cr = pl011_read(uap, REG_CR);
> +		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
> +				uap, REG_CR);
> +	}
> +
> +	if (nbcon_exit_unsafe(wctxt)) {
> +		int i;
> +		unsigned int len = READ_ONCE(wctxt->len);
> +
> +		for (i = 0; i < len; i++) {
> +			if (!nbcon_enter_unsafe(wctxt))
> +				break;
> +			uart_console_write(&uap->port, wctxt->outbuf + i, 1, pl011_console_putchar);
> +			if (!nbcon_exit_unsafe(wctxt))
> +				break;
> +		}
> +	}
> +
> +	while (!nbcon_enter_unsafe(wctxt))
> +		nbcon_reacquire_nobuf(wctxt);
> +
> +	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
> +		cpu_relax();
> +
> +	if (!uap->vendor->always_enabled)
> +		pl011_write(old_cr, uap, REG_CR);
> +
> +	clk_disable(uap->clk);
> +
> +	nbcon_exit_unsafe(wctxt);
> +}
> +
> +static void
> +pl011_console_device_lock(struct console *co, unsigned long *flags)
> +{
> +	__uart_port_lock_irqsave(&amba_ports[co->index]->port, flags);
> +}
> +
> +static void
> +pl011_console_device_unlock(struct console *co, unsigned long flags)
> +{
> +	__uart_port_unlock_irqrestore(&amba_ports[co->index]->port, flags);
> +}
> +
> +static void
> +pl011_console_switch_to_nbcon(struct console *co)
> +{
> +	co->write = NULL;
> +	co->write_atomic = pl011_console_write_atomic;
> +	co->write_thread = pl011_console_write_thread;
> +	co->device_lock = pl011_console_device_lock;
> +	co->device_unlock = pl011_console_device_unlock;
> +	co->flags = CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON;
> +	pr_info("Serial: switched to nbcon\n");

dev_info()?

thanks,

greg k-h
