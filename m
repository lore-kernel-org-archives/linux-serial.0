Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3750B435;
	Tue, 13 Oct 2026 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897723; cv=none; b=coFEoVBpqSYE9jjpOPf7etKAwm8dKu1XUhoxQYjDo8IHdA8GgpfjdFHjZwEc5ab2frxn78r3L9NTQcEdT2RCbL6/lW4TBTU5JH/eWu0rAxIz8dCeA08+MYMFFWS6hGqZVL/UB0YCwG2hbmiQJoO/u8aI5w8PMXn1qWwwvEW+IjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897723; c=relaxed/simple;
	bh=nKKU9Lhegzb3OComcfAvNFzjQLaUZSopiSoZfQHM/L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg/AS1pz2ss4F0pT27TkaXPJnIzmCOuY06Gw5/mz2Ptvbp7XTpYx51eoR9Y0ivyzAKFnfXb0pIzio2NL9MIz8PdJ+J8islfFhS9aA9DLUiMBIWH0wWnN3XkmhKIHEwDhWDO0TaDBARMTetVwWWeWZX7SKyJaXwCcJh+o/4D2/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WtR0bx4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WtR0bx4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4F31F000FF;
	Tue, 13 Oct 2026 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791897722;
	bh=xUxtYdiU2R0c+K2lBG3528oOcrYM9dXUerJDvDBaG9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WtR0bx4H9z2W9aP7CEcG+BLjG8GttUugl9WYsa6NPLhVivO8F/faHLoDH/zFEhvhM
	 GvZGJ+BizVdHATD0FVrtmmb5AHgTmHVuXOoBQHdFC47w0MNG5jxD1oR5hRJrmuNbjv
	 3DEBF8+d55ikL/3mIMUETOnzzQQfa6tEKBjF8KUA=
Date: Tue, 13 Oct 2026 15:22:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: drive the bus during break in RS485
 mode
Message-ID: <2026101355-epidural-avenging-9249@gregkh>
References: <20261011-devel-pl011-rs485-break-v1-1-62ff402378c6@tipi-net.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-devel-pl011-rs485-break-v1-1-62ff402378c6@tipi-net.de>

On Sun, Oct 11, 2026 at 10:23:07PM +0200, Nicolai Buchwitz wrote:
> In RS485 mode the transceiver is enabled only while data is sent. A
> break set with TIOCSBRK therefore never reaches the bus, and protocols
> that start each frame with a break, like DMX512, do not work.
> 
> Handle an active break like a transmission. Enable the transceiver
> before setting the break, after delay_rts_before_send if one is
> configured. When the break ends, stop transmitting unless the TX path
> is still sending data.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
> Noticed while implementing a DMX master on a CM5 with its PL011.
> Tested on that board, driving a DMX512 fixture with RS485 mode left
> enabled.
> 
> The 8250 em485 code probably has the same issue. I have no hardware to
> test it, but I'm happy to send a patch if someone is willing to.
> ---
>  drivers/tty/serial/amba-pl011.c | 69 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index fcfa9f00aec6..7bef1be5e9b4 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -327,6 +327,7 @@ struct uart_amba_port {
>  	char			type[12];
>  	ktime_t			rs485_tx_drain_interval; /* nano */
>  	enum pl011_rs485_tx_state	rs485_tx_state;
> +	bool			rs485_break;
>  	struct hrtimer		trigger_start_tx;
>  	struct hrtimer		trigger_stop_tx;
>  	bool			console_line_ended;
> @@ -1279,6 +1280,11 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>  	return uap->using_rx_dma && uap->dmarx.running;
>  }
>  
> +static inline bool pl011_dma_tx_queued(struct uart_amba_port *uap)
> +{
> +	return uap->dmatx.queued;
> +}
> +
>  #else
>  /* Blank functions if the DMA engine is not available */
>  static inline void pl011_dma_remove(struct uart_amba_port *uap)
> @@ -1330,6 +1336,11 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>  	return false;
>  }
>  
> +static inline bool pl011_dma_tx_queued(struct uart_amba_port *uap)
> +{
> +	return false;
> +}
> +
>  #define pl011_dma_flush_buffer	NULL
>  #endif
>  
> @@ -1357,6 +1368,10 @@ static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
>  {
>  	struct uart_port *port = &uap->port;
>  
> +	/* pl011_break_ctl() stops the transmission when the break ends */
> +	if (uap->rs485_break)
> +		return;
> +
>  	if (uap->rs485_tx_state == SEND)
>  		uap->rs485_tx_state = WAIT_AFTER_SEND;
>  
> @@ -1477,8 +1492,12 @@ static enum hrtimer_restart pl011_trigger_start_tx(struct hrtimer *t)
>  	unsigned long flags;
>  
>  	uart_port_lock_irqsave(&uap->port, &flags);
> -	if (uap->rs485_tx_state == WAIT_AFTER_RTS)
> -		pl011_start_tx(&uap->port);
> +	if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
> +		uap->rs485_tx_state = SEND;
> +		/* A break can arm the timer while TX is stopped */
> +		if (!uart_tx_stopped(&uap->port))
> +			pl011_start_tx(&uap->port);
> +	}
>  	uart_port_unlock_irqrestore(&uap->port, flags);
>  
>  	return HRTIMER_NORESTART;
> @@ -1770,16 +1789,60 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	struct tty_port *tport = &port->state->port;
> +	bool rs485 = port->rs485.flags & SER_RS485_ENABLED;
>  	unsigned long flags;
>  	unsigned int lcr_h;
>  
>  	uart_port_lock_irqsave(&uap->port, &flags);
> +
> +	/*
> +	 * In RS485 mode the transceiver only drives the bus while
> +	 * transmitting. Treat a break as a transmission.
> +	 */
> +	if (rs485 && break_state == -1 && !uap->rs485_break) {
> +		uap->rs485_break = true;
> +
> +		/* Pending data already enabled the transceiver */
> +		if (uap->rs485_tx_state != SEND &&
> +		    uap->rs485_tx_state != WAIT_AFTER_RTS)
> +			pl011_rs485_tx_start(uap);
> +
> +		/*
> +		 * Wait out delay_rts_before_send before starting the break.
> +		 * The state stays WAIT_AFTER_RTS, so the TX path behaves as
> +		 * without a break. Start it here if trigger_start_tx is late.
> +		 */
> +		if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
> +			uart_port_unlock_irqrestore(&uap->port, flags);
> +			msleep(port->rs485.delay_rts_before_send);
> +			uart_port_lock_irqsave(&uap->port, &flags);
> +
> +			if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
> +				hrtimer_try_to_cancel(&uap->trigger_start_tx);
> +				uap->rs485_tx_state = SEND;
> +				if (!uart_tx_stopped(port))
> +					pl011_start_tx(port);
> +			}
> +		}
> +	}
> +
>  	lcr_h = pl011_read(uap, REG_LCRH_TX);
>  	if (break_state == -1)
>  		lcr_h |= UART01x_LCRH_BRK;
>  	else
>  		lcr_h &= ~UART01x_LCRH_BRK;
>  	pl011_write(lcr_h, uap, REG_LCRH_TX);
> +
> +	if (break_state == 0 && uap->rs485_break) {
> +		uap->rs485_break = false;
> +		/* An active TX path stops the transmission when it is done */
> +		if (rs485 && (uart_tx_stopped(port) ||
> +			      (!pl011_dma_tx_queued(uap) &&
> +			       kfifo_is_empty(&tport->xmit_fifo))))
> +			pl011_rs485_tx_stop(uap);
> +	}
> +
>  	uart_port_unlock_irqrestore(&uap->port, flags);
>  }
>  
> @@ -2100,6 +2163,7 @@ static void pl011_shutdown(struct uart_port *port)
>  	hrtimer_cancel(&uap->trigger_stop_tx);
>  
>  	uart_port_lock_irq(port);
> +	uap->rs485_break = false;
>  	if (uap->rs485_tx_state != OFF)
>  		pl011_rs485_tx_stop_now(uap);
>  	uart_port_unlock_irq(port);
> @@ -2396,6 +2460,7 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
>  	struct uart_amba_port *uap =
>  		container_of(port, struct uart_amba_port, port);
>  
> +	uap->rs485_break = false;
>  	if (port->rs485.flags & SER_RS485_ENABLED)
>  		pl011_rs485_tx_stop(uap);
>  
> 
> ---
> base-commit: 36844ea19656fb41278799ef3d5cd52120d89149
> change-id: 20261011-devel-pl011-rs485-break-bec3b979a420

Does not apply to the tty-testing branch :(
