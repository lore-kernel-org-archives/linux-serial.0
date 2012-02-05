From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add sc16is7x2 driver
Date: Sun, 5 Feb 2012 19:56:25 +0000
Message-ID: <20120205195625.1b594909@pyramind.ukuu.org.uk>
References: <1328424925-645-1-git-send-email-thomas@tweber.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33142 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260Ab2BETzF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Feb 2012 14:55:05 -0500
In-Reply-To: <1328424925-645-1-git-send-email-thomas@tweber.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Weber <thomas@tweber.de>
Cc: linux-serial@vger.kernel.org, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

> +/* ******************************** IRQ ********************************* */
> +
> +static void sc16is7x2_handle_rx(struct sc16is7x2_chip *ts, unsigned ch)
> +{
> +	struct sc16is7x2_channel *chan = &ts->channel[ch];
> +	struct uart_port *uart = &chan->uart;
> +	struct tty_struct *tty = uart->state->port.tty;

What guarantees tty cannot go NULL during this ? - I think you need to
hold references and check ? (tty_port_tty_get)


> +/* Trigger work thread*/
> +static void sc16is7x2_dowork(struct sc16is7x2_channel *chan)
> +{
> +	if (!freezing(current))
> +		queue_work(chan->workqueue, &chan->work);
> +}

Threaded interrupt handler or is the single queue for work in tx and rx
actually a nicer way to do it - just asking the question.


> +static void sc16is7x2_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	struct sc16is7x2_channel *chan = to_sc16is7x2_channel(port);
> +	struct sc16is7x2_chip *ts = chan->chip;
> +
> +	dev_dbg(&ts->spi->dev, "%s (0x%02x)\n", __func__, mctrl);
> +
> +	/* TODO: set DCD and DSR
> +	 * CTS/RTS is handled automatically
> +	 */

Looks like it's not yet finished and ready for merging ?

> +static void sc16is7x2_stop_rx(struct uart_port *port)
> +{
> +	struct sc16is7x2_channel *chan = to_sc16is7x2_channel(port);
> +	struct sc16is7x2_chip *ts = chan->chip;
> +
> +	dev_dbg(&ts->spi->dev, "%s\n", __func__);
> +
> +	chan->ier &= ~UART_IER_RLSI;
> +	chan->uart.read_status_mask &= ~UART_LSR_DR;
> +	chan->handle_regs = true;
> +	/* Trigger work thread for doing the actual configuration change */
> +	sc16is7x2_dowork(chan);
> +}

> +static void sc16is7x2_break_ctl(struct uart_port *port, int break_state)
> +{
> +	/* We don't support break control yet, do nothing */
> +}

More unfinished bits

> +	/* Setup IRQ. Actually we have a low active IRQ, but we want
> +	 * one shot behaviour */
> +	if (request_irq(ts->spi->irq, sc16is7x2_irq,
> +			IRQF_TRIGGER_FALLING | IRQF_SHARED,
> +			"sc16is7x2", chan)) {

Is this a property of the device or of your board ?


> +static void
> +sc16is7x2_set_termios(struct uart_port *port, struct ktermios *termios,
> +		       struct ktermios *old)
> +{

> +#ifdef CMSPAR
> +	if (termios->c_cflag & CMSPAR)
> +		lcr |= UART_LCR_SPAR;
> +#endif

ifdef shouldn't be needed


termios should write back the actual baud (see how 8250.c does it)


> +#ifdef CONFIG_GPIOLIB

I wonder if this should be a separate driver and the device an MFD -
would anyone ever be using it as gpio only ?


Looks basically sound. The GPIO question I think needs figuring out, and
there are a few bits of unfinished code that need glancing it.

Alan
