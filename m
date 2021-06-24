Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09F3C48BDF
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 12:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C480A613F6
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 12:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhFXM6K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhFXM6J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 08:58:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A61EB61407;
        Thu, 24 Jun 2021 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624539350;
        bh=vy27O8JHG86KjCPMaZ8nNLDj35x7lCCYEq8JX2Xp62E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WibYVJLWPuC17dxXRiJ/EJVGl8V8CbfngWxp8RGBc0x1M60+UijMx72/gokL0k/pL
         Run4vxeWl0vC/Xxia7yw4dIT6aDnGlfzTXlUse2FZfKuzegx2DCXnLVtPo5nIQOz3q
         CzUf5ahKm+Hp3HLBkOCcpjqVnqKlyAIhTefOUp6I=
Date:   Thu, 24 Jun 2021 14:55:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: amba-pl011: add RS485 support
Message-ID: <YNSA1H0cFKiPUn6N@kroah.com>
References: <20210618145153.1906-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618145153.1906-1-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 18, 2021 at 04:51:53PM +0200, Lino Sanfilippo wrote:
> Add basic support for RS485: Provide a callback to configure RS485
> settings. Handle the RS485 specific part in the functions
> pl011_rs485_tx_start() and pl011_rs485_tx_stop() which extend the generic
> start/stop callbacks.
> Beside via IOCTL from userspace RS485 can be enabled by means of the
> device tree property "rs485-enabled-at-boot-time".
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
> This patch applies against Gregs tty-testing branch and was tested on a
> Raspberry Pi CM3.
> 
> Changes in V2:
> - clamp RTS delays to 100ms as suggested by Jiri Slaby
> - instead of counting bits "by hand" use the new function tty_get_frame_size()
>   (also suggested by Jiri)
> - use the term RS485 consistently in the commit message
> - remove one blank line
> 
> 
>  drivers/tty/serial/amba-pl011.c | 152 +++++++++++++++++++++++++++++++-
>  1 file changed, 150 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index e14f3378b8a0..92c6b08d56fb 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -265,6 +265,8 @@ struct uart_amba_port {
>  	unsigned int		old_cr;		/* state during shutdown */
>  	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
>  	char			type[12];
> +	bool			rs485_tx_started;
> +	unsigned int		rs485_tx_drain_interval; /* usecs */
>  #ifdef CONFIG_DMA_ENGINE
>  	/* DMA stuff */
>  	bool			using_tx_dma;
> @@ -275,6 +277,8 @@ struct uart_amba_port {
>  #endif
>  };
>  
> +static unsigned int pl011_tx_empty(struct uart_port *port);
> +
>  static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
>  	unsigned int reg)
>  {
> @@ -1282,6 +1286,34 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>  #define pl011_dma_flush_buffer	NULL
>  #endif
>  
> +static int pl011_rs485_tx_stop(struct uart_amba_port *uap)
> +{
> +	struct uart_port *port = &uap->port;
> +	u32 cr;
> +
> +	/* Wait until hardware tx queue is empty */
> +	while (!pl011_tx_empty(port))
> +		udelay(uap->rs485_tx_drain_interval);

No way out if the hardware doesn't ever empty?  Shouldn't you have an
"upper bound" on this loop somehow?


> +
> +	if (port->rs485.delay_rts_after_send)
> +		mdelay(port->rs485.delay_rts_after_send);
> +
> +	cr = pl011_read(uap, REG_CR);
> +
> +	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +		cr &= ~UART011_CR_RTS;
> +	else
> +		cr |= UART011_CR_RTS;

Blank line here please.

> +	/* Disable the transmitter and reenable the transceiver */
> +	cr &= ~UART011_CR_TXE;
> +	cr |= UART011_CR_RXE;
> +	pl011_write(cr, uap, REG_CR);
> +
> +	uap->rs485_tx_started = false;
> +
> +	return 0;

Why does this function return a value if it can not fail and you do not
check the return value of it?

> +}
> +
>  static void pl011_stop_tx(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
> @@ -1290,6 +1322,9 @@ static void pl011_stop_tx(struct uart_port *port)
>  	uap->im &= ~UART011_TXIM;
>  	pl011_write(uap->im, uap, REG_IMSC);
>  	pl011_dma_tx_stop(uap);
> +
> +	if ((port->rs485.flags & SER_RS485_ENABLED) && uap->rs485_tx_started)
> +		pl011_rs485_tx_stop(uap);

So, no check :(


>  }
>  
>  static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
> @@ -1380,6 +1415,31 @@ static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
>  	return true;
>  }
>  
> +static void pl011_rs485_tx_start(struct uart_amba_port *uap)
> +{
> +	struct uart_port *port = &uap->port;
> +	u32 cr;
> +
> +	/* Enable transmitter */
> +	cr = pl011_read(uap, REG_CR);
> +	cr |= UART011_CR_TXE;

Blank line please.

> +	/* Disable receiver if half-duplex */
> +	if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
> +		cr &= ~UART011_CR_RXE;
> +
> +	if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
> +		cr &= ~UART011_CR_RTS;
> +	else
> +		cr |= UART011_CR_RTS;
> +
> +	pl011_write(cr, uap, REG_CR);
> +
> +	if (port->rs485.delay_rts_before_send)
> +		mdelay(port->rs485.delay_rts_before_send);
> +
> +	uap->rs485_tx_started = true;
> +}
> +
>  /* Returns true if tx interrupts have to be (kept) enabled  */
>  static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
>  {
> @@ -1397,6 +1457,10 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
>  		return false;
>  	}
>  
> +	if ((uap->port.rs485.flags & SER_RS485_ENABLED) &&
> +	    !uap->rs485_tx_started)
> +		pl011_rs485_tx_start(uap);
> +
>  	/* If we are using DMA mode, try to send some characters. */
>  	if (pl011_dma_tx_irq(uap))
>  		return true;
> @@ -1542,6 +1606,9 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	    container_of(port, struct uart_amba_port, port);
>  	unsigned int cr;
>  
> +	if (port->rs485.flags & SER_RS485_ENABLED)
> +		mctrl &= ~TIOCM_RTS;
> +
>  	cr = pl011_read(uap, REG_CR);
>  
>  #define	TIOCMBIT(tiocmbit, uartbit)		\
> @@ -1763,7 +1830,17 @@ static int pl011_startup(struct uart_port *port)
>  
>  	/* restore RTS and DTR */
>  	cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
> -	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
> +	cr |= UART01x_CR_UARTEN | UART011_CR_RXE;
> +
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +			cr &= ~UART011_CR_RTS;
> +		else
> +			cr |= UART011_CR_RTS;
> +	} else {
> +		cr |= UART011_CR_TXE;
> +	}
> +
>  	pl011_write(cr, uap, REG_CR);
>  
>  	spin_unlock_irq(&uap->port.lock);
> @@ -1864,6 +1941,9 @@ static void pl011_shutdown(struct uart_port *port)
>  
>  	pl011_dma_shutdown(uap);
>  
> +	if ((port->rs485.flags & SER_RS485_ENABLED) && uap->rs485_tx_started)
> +		pl011_rs485_tx_stop(uap);
> +
>  	free_irq(uap->port.irq, uap);
>  
>  	pl011_disable_uart(uap);
> @@ -1941,6 +2021,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  	unsigned int lcr_h, old_cr;
>  	unsigned long flags;
>  	unsigned int baud, quot, clkdiv;
> +	unsigned int bits;
>  
>  	if (uap->vendor->oversampling)
>  		clkdiv = 8;
> @@ -1991,18 +2072,29 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  	if (uap->fifosize > 1)
>  		lcr_h |= UART01x_LCRH_FEN;
>  
> +	bits = tty_get_frame_size(termios->c_cflag);
> +
>  	spin_lock_irqsave(&port->lock, flags);
>  
>  	/*
>  	 * Update the per-port timeout.
>  	 */
>  	uart_update_timeout(port, termios->c_cflag, baud);

Blank line

> +	/*
> +	 * Calculate the approximated time it takes to transmit one character
> +	 * with the given baud rate. We use this as the poll interval when we
> +	 * wait for the tx queue to empty.
> +	 */
> +	uap->rs485_tx_drain_interval = (bits * 1000 * 1000) / baud;
>  
>  	pl011_setup_status_masks(port, termios);
>  
>  	if (UART_ENABLE_MS(port, termios->c_cflag))
>  		pl011_enable_ms(port);
>  
> +	if (port->rs485.flags & SER_RS485_ENABLED)
> +		termios->c_cflag &= ~CRTSCTS;
> +
>  	/* first, disable everything */
>  	old_cr = pl011_read(uap, REG_CR);
>  	pl011_write(0, uap, REG_CR);
> @@ -2124,6 +2216,40 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
>  	return ret;
>  }
>  
> +static int pl011_rs485_config(struct uart_port *port,
> +			      struct serial_rs485 *rs485)
> +{
> +	struct uart_amba_port *uap =
> +		container_of(port, struct uart_amba_port, port);
> +
> +	/* pick sane settings if the user hasn't */
> +	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) ==

Why the !! in an if statement?

> +	    !!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {

Same here, why?

> +		rs485->flags |= SER_RS485_RTS_ON_SEND;
> +		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> +	}
> +	/* clamp the delays to [0, 100ms] */
> +	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
> +	rs485->delay_rts_after_send = min(rs485->delay_rts_after_send, 100U);
> +	memset(rs485->padding, 0, sizeof(rs485->padding));
> +
> +	if (port->rs485.flags & SER_RS485_ENABLED)
> +		pl011_rs485_tx_stop(uap);
> +
> +	/* Set new configuration */
> +	port->rs485 = *rs485;

Blank line please.

> +	/* Make sure auto RTS is disabled */
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		u32 cr = pl011_read(uap, REG_CR);
> +
> +		cr &= ~UART011_CR_RTSEN;
> +		pl011_write(cr, uap, REG_CR);
> +		port->status &= ~UPSTAT_AUTORTS;
> +	}
> +
> +	return 0;
> +}
> +

thanks,

greg k-h
