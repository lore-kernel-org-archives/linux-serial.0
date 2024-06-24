Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935113E888;
	Mon, 24 Jun 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236014; cv=none; b=uVvTY34c8rRSmpTIdShVN9FpfHwRTVxzZPC8Xrw8gPlbM8PgagtkFC4Otj/ObffTasP3YyA5LB091jXdKu4F8FxF1e1MM6ZZvt7ugM+GZhjt7UVu1L97/diFxYnPE2LR1zLzW9S6P90FDNMmQcIONRh+wuJN4mdk+xNU04ZRIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236014; c=relaxed/simple;
	bh=9zFosSwVy43COA5LXpYQ2Dm9NEd+eTcGR2GIviXSK5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8FT6sFL5aiWkwejHnJn+437ZnuL+KeiFEIG/IjU2iSo42PInW5dx/sOXQR/bBR9uOPIckTBp5hBgTGmR7YqELShB34kRcEp1E27lX0oOVuPNKuO57ok09Z4TBkJWR/pXQshb60fBLKktqm2AtceZGpctbWhFecRzITgW1eMiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ILygvCUw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ILygvCUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A801BC2BBFC;
	Mon, 24 Jun 2024 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719236014;
	bh=9zFosSwVy43COA5LXpYQ2Dm9NEd+eTcGR2GIviXSK5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILygvCUwZtEwOsboz813cE78GyGTV1+Q536rrkhlPHQ5+yLrn2GWhzLTMIuP+Arum
	 U3ndDYX9c8/ks0zT8QwCcVoUCfVeR3VOjK/RMfZmee50qL5/Y/ROePNjN6JkQF7Kbu
	 4ZIGVuG0AkQKOXMzrX4zEOUvwWnZolPBaO00g44g=
Date: Mon, 24 Jun 2024 15:33:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: imx: ensure RTS signal is not left active after
 shutdown
Message-ID: <2024062427-cheating-cloning-3de1@gregkh>
References: <20240524121246.1896651-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524121246.1896651-1-linux@rasmusvillemoes.dk>

On Fri, May 24, 2024 at 02:12:45PM +0200, Rasmus Villemoes wrote:
> If a process is killed while writing to a /dev/ttymxc* device in RS485
> mode, we observe that the RTS signal is left high, thus making it
> impossible for other devices to transmit anything.
> 
> Moreover, the ->tx_state variable is left in state SEND, which means
> that when one next opens the device and configures baud rate etc., the
> initialization code in imx_uart_set_termios dutifully ensures the RTS
> pin is pulled down, but since ->tx_state is already SEND, the logic in
> imx_uart_start_tx() does not in fact pull the pin high before
> transmitting, so nothing actually gets on the wire on the other side
> of the transceiver. Only when that transmission is allowed to complete
> is the state machine then back in a consistent state.
> 
> This is completely reproducible by doing something as simple as
> 
>   seq 10000 > /dev/ttymxc0
> 
> and hitting ctrl-C, and watching with a logic analyzer.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> 
> A screen dump from a logic analyzer can be seen at:
> 
>   https://ibb.co/xCcP7Jy
> 
> This is on an imx8mp board, with /dev/ttymxc0 and /dev/ttymxc2 both
> configured for rs485 and connected to each other. I'm writing to
> /dev/ttymxc2. This demonstrates both bugs; that RTS is left high when
> a write is interrupted, and that a subsequent write actually fails to
> have RTS high while TX'ing.
> 
> I'm not sure what commit to name as a Fixes:. This certainly happens
> on 6.6 and onwards, but I assume the problem exists since the tx_state
> machine was introduced in cb1a60923609 (serial: imx: implement rts
> delaying for rs485), and possibly even before that.
> 
> 
>  drivers/tty/serial/imx.c | 50 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 2eb22594960f..35a47f4ab6ed 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1551,6 +1551,7 @@ static void imx_uart_shutdown(struct uart_port *port)
>  	struct imx_port *sport = (struct imx_port *)port;
>  	unsigned long flags;
>  	u32 ucr1, ucr2, ucr4, uts;
> +	int loops;
>  
>  	if (sport->dma_is_enabled) {
>  		dmaengine_terminate_sync(sport->dma_chan_tx);
> @@ -1613,6 +1614,55 @@ static void imx_uart_shutdown(struct uart_port *port)
>  	ucr4 &= ~UCR4_TCEN;
>  	imx_uart_writel(sport, ucr4, UCR4);
>  
> +	/*
> +	 * We have to ensure the tx state machine ends up in OFF. This
> +	 * is especially important for rs485 where we must not leave
> +	 * the RTS signal high, blocking the bus indefinitely.
> +	 *
> +	 * All interrupts are now disabled, so imx_uart_stop_tx() will
> +	 * no longer be called from imx_uart_transmit_buffer(). It may
> +	 * still be called via the hrtimers, and if those are in play,
> +	 * we have to honour the delays.
> +	 */
> +	if (sport->tx_state == WAIT_AFTER_RTS || sport->tx_state == SEND)
> +		imx_uart_stop_tx(port);
> +
> +	/*
> +	 * In many cases (rs232 mode, or if tx_state was
> +	 * WAIT_AFTER_RTS, or if tx_state was SEND and there is no
> +	 * delay_rts_after_send), this will have moved directly to
> +	 * OFF. In rs485 mode, tx_state might already have been
> +	 * WAIT_AFTER_SEND and the hrtimer thus already started, or
> +	 * the above imx_uart_stop_tx() call could have started it. In
> +	 * those cases, we have to wait for the hrtimer to fire and
> +	 * complete the transition to OFF.
> +	 */
> +	loops = port->rs485.flags & SER_RS485_ENABLED ?
> +		port->rs485.delay_rts_after_send : 0;
> +	while (sport->tx_state != OFF && loops--) {
> +		uart_port_unlock_irqrestore(&sport->port, flags);
> +		msleep(1);
> +		uart_port_lock_irqsave(&sport->port, &flags);
> +	}
> +
> +	if (dev_WARN_ONCE(sport->port.dev, sport->tx_state != OFF,
> +			  "unexpected tx_state %d\n", sport->tx_state)) {

Please don't reboot devices that have panic-on-warn enabled for
something like this, as you are handling it, but that didn't help for
those devices that had that option turned on :(

thanks,

greg k-h
