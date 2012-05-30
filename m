From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Add driver for LPC32xx High Speed UARTs
Date: Wed, 30 May 2012 16:31:52 +0100
Message-ID: <20120530163152.38c26da0@pyramind.ukuu.org.uk>
References: <1338389751-16022-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37771 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab2E3P3e (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 May 2012 11:29:34 -0400
In-Reply-To: <1338389751-16022-1-git-send-email-stigge@antcom.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, linux-arm-kernel@lists.infradead.org

> +#define LPC32XX_TTY_MINOR_START	196
> +#define LPC32XX_TTY_MAJOR 204

NAK - please use dynamic allocations.


> +	/* Read data from FIFO and push into terminal */
> +	tmp = readl(LPC32XX_HSUART_FIFO(port->membase));
> +	while (!(tmp & LPC32XX_HSU_RX_EMPTY)) {
> +		flag = TTY_NORMAL;
> +		port->icount.rx++;
> +
> +		if (tmp & LPC32XX_HSU_ERROR_DATA) {
> +			/* Framing error */
> +			writel(LPC32XX_HSU_FE_INT,
> +			       LPC32XX_HSUART_IIR(port->membase));
> +			port->icount.frame++;
> +			flag = TTY_FRAME;
> +			tty_insert_flip_char(port->state->port.tty, 0,
> +					     TTY_FRAME);
> +			tty_schedule_flip(port->state->port.tty);
> +		}
> +
> +		tty_insert_flip_char(port->state->port.tty, (tmp & 0xFF), flag);
> +
> +		tmp = readl(LPC32XX_HSUART_FIFO(port->membase));

This seems odd - you don't need to schedule the flip of the framing error
separately. It all just ends up in the queue and can be kicked in one go.

Also if the last byte is a normal char - who ensures the buffer is pushed
and not wedged until a future I/O ?

Second problem is port->state->port.tty can be or go to NULL. Take a look
how drivers use tty_port_tty_get(), and tty_kref_put.


> +	/* Data received? */
> +	if (status & (LPC32XX_HSU_RX_TIMEOUT_INT | LPC32XX_HSU_RX_TRIG_INT)) {
> +		__serial_lpc32xx_rx(port);
> +		spin_unlock(&port->lock);
> +		tty_flip_buffer_push(port->state->port.tty);
> +		spin_lock(&port->lock);
> +	}

Not sure what the locking is about here - you shouldn't need to fiddle
with locks unless you are using low latency and you can't use low latency
safely from an IRQ handler...

(Also again tty and NULL - you may want to grab it once at the start of
the handler)


> +static void serial_lpc32xx_set_termios(struct uart_port *port,
> +				       struct ktermios *termios,
> +				       struct ktermios *old)
> +{
> +	unsigned long flags;
> +	unsigned int baud, quot;
> +	u32 tmp;
> +
> +	/* Always 8-bit, no parity, 1 stop bit */
> +	termios->c_cflag &= ~(CSIZE | CSTOPB | PARENB | PARODD);
> +	termios->c_cflag |= CS8;
> +
> +	termios->c_cflag &= ~(HUPCL | CMSPAR | CLOCAL | CRTSCTS);
> +
> +	baud = uart_get_baud_rate(port, termios, old, 0,
> +				  port->uartclk / 14);

You want to set the resulting baud rate back into the struct - see 8250.c
for an example.

Alan
