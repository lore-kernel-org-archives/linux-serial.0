Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4493D75C7;
	Fri,  4 Sep 2026 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509828; cv=none; b=lqtneRvIJY4MeH1eWEyUUfIEauPonQh0mqdLnw8eh8CTprDOEACmbtC7yb1XDRKQxW7dGFaIPhWIV0A7Fbt6kskwqVQr2dBzbV9ipKIV3oubFnPnvKG5KcyrvtrkLE76JuCMAXsGwS/lho5qPU0lthQmd9pA6yApZ9IBWSdwZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509828; c=relaxed/simple;
	bh=yKaiXiH5NQRoMAzdI/ZniH6m6MCJz7WcuxpsF5mtuKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eK5NfnUSf2JiAhggGnf8qzVjLNErWyK37NcSxNsWn2v4twO8omL0IynCQgSz74aq2VHDZMObm8n2gnIMla5bToCJhNf+QsLyMFGepne7WdPDD3+9UUIHtzg6a9fTOndE7TNWyXTeBUf+yVZtYGXpcet8zoS7rp9gSrN32eJI+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8yepe6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8yepe6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B01A1F00ADB;
	Fri,  4 Sep 2026 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788509826;
	bh=BhxQGymHFkjsUNUyL4bLHk5LJQ5jGJvm0zL61y6tp6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z8yepe6r77Lr6t575kRAfr47dMyaor8mVq4Uwp+QKkTs3VQk5wHjzsoOFxz5F1prp
	 uElL7g5rH0vm6MHv/xxuo30F45TFUo4X8JGTX+/Xv4V+hK9dwyK5Kx69kB/lFjFdQB
	 4I4ApVtSOeREkUCEvVUiEyjOA5vC9e4uEZEwWDC0VXJmD72BPZ0HndsnVlmidQj9wh
	 4fxHh7EPk+WZV3ihJb52YPgpDIW+28aMkkSd5/ziIITid3HUqIYT2SU9M6sleeFBMY
	 t1tULd1wNmLCV+kJtR9EXKlhVV1gi+vc+94n36kft8TQAorOtgy1D7MZ3MVrzphFlo
	 xTugvaT7vRJKA==
Message-ID: <8f8a4946-e8e2-4683-b837-c783c40b81c1@kernel.org>
Date: Fri, 4 Sep 2026 10:17:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: wk2xxx: Add WK2xxx SPI UART driver
To: zjzhao <zjzhao@edatec.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org
References: <20260904072027.67473-1-zjzhao@edatec.cn>
 <20260904072027.67473-2-zjzhao@edatec.cn>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260904072027.67473-2-zjzhao@edatec.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 04. 09. 26, 9:20, zjzhao wrote:
> Add a driver for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
> WK2168, WK2202 and WK2204) from WKmic (Chengdu Weikai Microelectronics).
> Each IC exposes two or four full-duplex UART channels with 256-byte
> RX/TX FIFOs through a single SPI slave interface and one interrupt line.
> 
> The driver is a rework of the vendor driver (https://github.com/britus/
> wk2xxx) modeled after the NXP sc16is7xx driver. It registers ttyWK0..N
> lines (IDA-allocated), uses devm_request_threaded_irq with a kthread
> worker for register access, falls back to polling when the interrupt
> line is not described, and supports hardware flow control and RS485
> where the IC provides them.

Have you checked that there is no similar driver which could be only 
extended?

> Also allocate PORT_WK2XXX (124) and add the SERIAL_WK2XXX Kconfig
> option.
> 
> Tested on Raspberry Pi 5 boards (EDATEC IPC1200 with WK2132 on SPI0 and
> SBC2300 with WK2204 on SPI1); loopback TX/RX tests pass.
> 
> Signed-off-by: zjzhao <zjzhao@edatec.cn>
...
> --- /dev/null
> +++ b/drivers/tty/serial/wk2xxx.c
> @@ -0,0 +1,1245 @@
...
> +static int wk2xxx_port_reg_write(struct wk2xxx_port *s, unsigned int portno,
> +				 u8 reg, u8 val)
> +{
> +	guard(mutex)(&s->reg_lock);
> +	return wk2xxx_raw_port_write(s, portno, reg, val);
> +}
> +
> +static void wk2xxx_port_reg_update(struct wk2xxx_port *s, unsigned int portno,
> +				   u8 reg, u8 mask, u8 val)
> +{
> +	u8 r = 0;
> +
> +	scoped_guard(mutex, &s->reg_lock) {

why is this one scoped?

> +		if (wk2xxx_raw_port_read(s, portno, reg, &r))
> +			return;
> +		wk2xxx_raw_port_write(s, portno, reg, (r & ~mask) | val);
> +	}
> +}

...

> +static void wk2xxx_throttle(struct uart_port *port)
> +{
> +	unsigned long flags;
> +
> +	/* Stop draining the RX FIFO to apply back-pressure. */
> +	uart_port_lock_irqsave(port, &flags);

This can be a guard too, right?

> +	wk2xxx_ier_clear(port, WK2XXX_SIER_RFTRIG_IEN_BIT);
> +	uart_port_unlock_irqrestore(port, flags);
> +}
> +
> +static void wk2xxx_unthrottle(struct uart_port *port)
> +{
> +	unsigned long flags;
> +
> +	uart_port_lock_irqsave(port, &flags);

Same here.

> +	wk2xxx_ier_set(port, WK2XXX_SIER_RFTRIG_IEN_BIT);
> +	uart_port_unlock_irqrestore(port, flags);
> +}
> +
> +static void wk2xxx_handle_tx(struct uart_port *port)
> +{
> +	struct wk2xxx_one *one = to_wk2xxx_one(port, port);
> +	struct wk2xxx_port *s = dev_get_drvdata(port->dev);
> +	struct tty_port *tport = &port->state->port;
> +	unsigned long flags;
> +	unsigned int portno = port->iobase;
> +	unsigned int txlen, to_send, sent;
> +	const unsigned char *tail;
> +	u8 fsr, tfcnt;

What's the reason not to use any of the uart_port_tx* helpers?

> +	mutex_lock(&one->tx_lock);

Why not guard?

> +
> +	if (unlikely(port->x_char)) {
> +		wk2xxx_port_reg_write(s, portno, WK2XXX_FDAT_REG, port->x_char);
> +		port->icount.tx++;
> +		port->x_char = 0;
> +		goto out;

And kill the goto then.

> +	}
> +
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
> +		uart_port_lock_irqsave(port, &flags);
> +		wk2xxx_stop_tx(port);
> +		uart_port_unlock_irqrestore(port, flags);
> +		goto out;
> +	}
> +
> +	/* Limit to the free space available in the TX FIFO. */
> +	wk2xxx_port_reg_read(s, portno, WK2XXX_TFCNT_REG, &tfcnt);
> +	if (tfcnt == 0) {
> +		wk2xxx_port_reg_read(s, portno, WK2XXX_FSR_REG, &fsr);
> +		txlen = (fsr & WK2XXX_FSR_TFULL_BIT) ? 0 : WK2XXX_FIFO_SIZE;
> +	} else {
> +		txlen = WK2XXX_FIFO_SIZE - tfcnt;
> +	}
> +	if (txlen > WK2XXX_MAX_TX_CHARS)
> +		txlen = WK2XXX_MAX_TX_CHARS;
> +
> +	to_send = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> +	sent = to_send;
> +	while (to_send) {
> +		unsigned int chunk = min_t(unsigned int, to_send,
> +					   WK2XXX_MAX_SPI_LEN);
> +
> +		wk2xxx_fifo_write(s, portno, tail, chunk);
> +		tail += chunk;
> +		to_send -= chunk;
> +	}
> +	uart_xmit_advance(port, sent);
> +
> +	uart_port_lock_irqsave(port, &flags);
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	if (kfifo_is_empty(&tport->xmit_fifo))
> +		wk2xxx_stop_tx(port);
> +	else
> +		wk2xxx_ier_set(port, WK2XXX_SIER_TFTRIG_IEN_BIT);
> +	uart_port_unlock_irqrestore(port, flags);
> +
> +out:
> +	mutex_unlock(&one->tx_lock);
> +}

...
> +static irqreturn_t wk2xxx_irq(int irq, void *dev_id)
> +{
> +	struct wk2xxx_port *s = dev_id;
> +	bool keep_polling;
> +
> +	do {
> +		u8 gifr;
> +		int i;
> +
> +		keep_polling = false;
> +
> +		if (wk2xxx_reg_read(s, WK2XXX_GIFR_REG, &gifr))
> +			return IRQ_HANDLED; /* Bus error; give up this pass. */
> +
> +		for (i = 0; i < s->devtype->nr_uart; ++i)
> +			if (gifr & BIT(i))
> +				keep_polling |= wk2xxx_port_irq(s, i);
> +	} while (keep_polling);

Should you perhaps cap the loop count as well?

> +
> +	return IRQ_HANDLED;

Pointed out by sashiko, this is indeed bad for shared irqs.

> +}

...

> +static void wk2xxx_conf_port(struct uart_port *port, u8 lcr, u8 fwcr,
> +			     u8 baud0, u8 baud1, u8 pres)
> +{
> +	struct wk2xxx_port *s = dev_get_drvdata(port->dev);
> +	unsigned int portno = port->iobase;
> +	u8 sier, scr, fsr;
> +	int count = 200;
> +
> +	scoped_guard(mutex, &s->reg_lock) {

Why is this scoped again?

> +		/* Disable all sub-UART interrupts. */
> +		wk2xxx_raw_port_read(s, portno, WK2XXX_SIER_REG, &sier);
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_SIER_REG, 0);
> +
> +		/* Wait for the transmitter to become idle. */
> +		do {
> +			wk2xxx_raw_port_read(s, portno, WK2XXX_FSR_REG, &fsr);
> +		} while ((fsr & WK2XXX_FSR_TBUSY_BIT) && count--);
> +
> +		/* Disable the transmitter and receiver. */
> +		wk2xxx_raw_port_read(s, portno, WK2XXX_SCR_REG, &scr);
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_SCR_REG,
> +				      scr & ~(WK2XXX_SCR_TXEN_BIT |
> +					      WK2XXX_SCR_RXEN_BIT));
> +
> +		/* Program the line control register. */
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_LCR_REG, lcr);
> +
> +		/* Configure hardware flow control levels. */
> +		if (fwcr) {
> +			wk2xxx_raw_port_write(s, portno, WK2XXX_FWCR_REG, fwcr);
> +			wk2xxx_raw_port_write(s, portno, WK2XXX_SPAGE_REG, 1);
> +			wk2xxx_raw_port_write(s, portno, WK2XXX_FWTH_REG, 0xf0);
> +			wk2xxx_raw_port_write(s, portno, WK2XXX_FWTL_REG, 0x80);
> +			wk2xxx_raw_port_write(s, portno, WK2XXX_SPAGE_REG, 0);
> +		}
> +
> +		/* Program the baud rate generator (page 1 registers). */
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_SPAGE_REG, 1);
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_BAUD0_REG, baud0);
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_BAUD1_REG, baud1);
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_PRES_REG, pres);
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_SPAGE_REG, 0);
> +
> +		/* Re-enable the transmitter and receiver. */
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_SCR_REG,
> +				      scr | (WK2XXX_SCR_TXEN_BIT |
> +					     WK2XXX_SCR_RXEN_BIT));
> +
> +		/* Restore the interrupt enable register. */
> +		wk2xxx_raw_port_write(s, portno, WK2XXX_SIER_REG, sier);
> +	}
> +}
> +
> +static void wk2xxx_calc_divisor(unsigned long clk, unsigned int baud,
> +				u8 *baud0, u8 *baud1, u8 *pres)
> +{
> +	unsigned int div;
> +
> +	div = clk / (baud * 16);
> +	if (div == 0)
> +		div = 1;
> +	div--;
> +	*baud0 = div & 0xff;
> +	*baud1 = (div >> 8) & 0xff;
> +	*pres = ((unsigned long long)(clk % (baud * 16)) * 100 / baud + 50) / 100;

Did you mean to use explicit u64?

> +}
> +
> +static void wk2xxx_set_termios(struct uart_port *port, struct ktermios *termios,
> +			       const struct ktermios *old)
> +{
> +	unsigned int baud;
> +	unsigned long flags;
> +	u8 lcr = 0, fwcr = 0;
> +	u8 baud0, baud1, pres;
> +
> +	/* The WK2xxx supports 8 data bits only. */
> +	termios->c_cflag &= ~CSIZE;
> +	termios->c_cflag |= CS8;
> +
> +	/* Parity. */
> +	if (termios->c_cflag & PARENB) {
> +		lcr |= WK2XXX_LCR_PAEN_BIT;
> +		switch (termios->c_cflag & (PARODD | CMSPAR)) {
> +		case 0:
> +			lcr |= WK2XXX_LCR_PAM1_BIT;	/* even */
> +			break;
> +		case PARODD:
> +			lcr |= WK2XXX_LCR_PAM0_BIT;	/* odd */
> +			break;
> +		case CMSPAR:
> +			break;				/* space */
> +		case PARODD | CMSPAR:
> +			lcr |= WK2XXX_LCR_PAM1_BIT |
> +			       WK2XXX_LCR_PAM0_BIT;	/* mark */
> +			break;
> +		}
> +	}
> +
> +	/* Stop bits. */
> +	if (termios->c_cflag & CSTOPB)
> +		lcr |= WK2XXX_LCR_STPL_BIT;
> +
> +	/* Set read status mask. */
> +	port->read_status_mask = WK2XXX_LSR_OE_BIT;
> +	if (termios->c_iflag & INPCK)
> +		port->read_status_mask |= WK2XXX_LSR_PE_BIT |
> +					  WK2XXX_LSR_FE_BIT;
> +	if (termios->c_iflag & (BRKINT | PARMRK))
> +		port->read_status_mask |= WK2XXX_LSR_BI_BIT;
> +
> +	/* Set status ignore mask. */
> +	port->ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNBRK)
> +		port->ignore_status_mask |= WK2XXX_LSR_BI_BIT;
> +	if (!(termios->c_cflag & CREAD))
> +		port->ignore_status_mask |= WK2XXX_LSR_BRK_ERROR_MASK;
> +
> +	/* Configure flow control. */
> +	port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
> +	if (termios->c_cflag & CRTSCTS) {
> +		fwcr = WK2XXX_FWCR_FWM_RTS_CTS;
> +		port->status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
> +	}
> +
> +	/* Get the baud rate generator configuration. */
> +	baud = uart_get_baud_rate(port, termios, old,
> +				  port->uartclk / 16 / 0xffff,
> +				  port->uartclk / 16);
> +
> +	wk2xxx_calc_divisor(port->uartclk, baud, &baud0, &baud1, &pres);
> +	wk2xxx_conf_port(port, lcr, fwcr, baud0, baud1, pres);
> +
> +	uart_port_lock_irqsave(port, &flags);

guard

> +	uart_update_timeout(port, termios->c_cflag, baud);
> +	uart_port_unlock_irqrestore(port, flags);
> +}

...

> +static const struct uart_ops wk2xxx_ops = {
> +	.tx_empty	= wk2xxx_tx_empty,
> +	.set_mctrl	= wk2xxx_set_mctrl,
> +	.get_mctrl	= wk2xxx_get_mctrl,
> +	.stop_tx	= wk2xxx_stop_tx,
> +	.start_tx	= wk2xxx_start_tx,
> +	.throttle	= wk2xxx_throttle,
> +	.unthrottle	= wk2xxx_unthrottle,
> +	.stop_rx	= wk2xxx_stop_rx,
> +	.enable_ms	= wk2xxx_enable_ms,
> +	.break_ctl	= wk2xxx_break_ctl,
> +	.startup	= wk2xxx_startup,
> +	.shutdown	= wk2xxx_shutdown,
> +	.set_termios	= wk2xxx_set_termios,
> +	.type		= wk2xxx_type,

> +	.request_port	= wk2xxx_request_port,
> +	.release_port	= wk2xxx_null_void,

req + rel are optional. Drop them.

> +	.config_port	= wk2xxx_config_port,
> +	.verify_port	= wk2xxx_verify_port,
> +};
...
> +static int wk2xxx_probe(struct spi_device *spi)
> +{
> +	const struct wk2xxx_devtype *devtype;
> +	struct device *dev = &spi->dev;
> +	struct wk2xxx_port *s;
> +	unsigned long uartclk;
> +	u32 clock_freq = 0;
> +	bool port_registered[WK2XXX_MAX_PORTS];
> +	u8 val;
> +	int i, ret;
> +
> +	/* Setup SPI bus. The SPI mode follows the device tree (spi-cpha,
> +	 * spi-cpol); it defaults to SPI mode 0 when unspecified.
> +	 */
> +	spi->bits_per_word = 8;
> +	spi->max_speed_hz = spi->max_speed_hz ? : 10 * HZ_PER_MHZ;
> +	ret = spi_setup(spi);
> +	if (ret)
> +		return ret;
> +
> +	devtype = spi_get_device_match_data(spi);
> +	if (!devtype)
> +		return dev_err_probe(dev, -ENODEV, "Failed to match device\n");
> +
> +	/* Allocate port structure. */
> +	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
> +	if (!s)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Error allocating port structure\n");
> +
> +	s->devtype = devtype;
> +	s->spi = spi;
> +	mutex_init(&s->reg_lock);
> +	dev_set_drvdata(dev, s);
> +
> +	/*
> +	 * The WK2xxx has no identification register, so the best we can do
> +	 * is to check that communication is at all possible.
> +	 */
> +	ret = wk2xxx_reg_read(s, WK2XXX_GENA_REG, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read GENA register\n");
> +
> +	/* Crystal clock; allow an optional DT override. */
> +	uartclk = devtype->crystal_freq;
> +	if (device_property_read_u32(dev, "clock-frequency", &clock_freq) == 0)
> +		uartclk = clock_freq;
> +
> +	/* Mark each port line and status as uninitialized. */
> +	for (i = 0; i < devtype->nr_uart; ++i) {
> +		s->p[i].port.line = WK2XXX_MAX_DEVS;
> +		port_registered[i] = false;
> +	}
> +
> +	kthread_init_worker(&s->kworker);
> +	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
> +				      "wk2xxx");
> +	if (IS_ERR(s->kworker_task)) {
> +		ret = PTR_ERR(s->kworker_task);
> +		goto out_ports;
> +	}
> +	sched_set_fifo(s->kworker_task);
> +
> +	for (i = 0; i < devtype->nr_uart; ++i) {
> +		ret = ida_alloc_max(&wk2xxx_lines, WK2XXX_MAX_DEVS - 1,
> +				    GFP_KERNEL);
> +		if (ret < 0)
> +			goto out_ports;
> +
> +		s->p[i].port.line = ret;
> +
> +		/* Initialize port data. */
> +		s->p[i].port.dev	= dev;
> +		s->p[i].port.irq	= spi->irq;
> +		s->p[i].port.type	= PORT_WK2XXX;
> +		s->p[i].port.fifosize	= WK2XXX_FIFO_SIZE;
> +		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> +		s->p[i].port.iobase	= i;
> +		/*
> +		 * Use all ones as membase so that uart_configure_port() in
> +		 * serial_core.c does not abort for SPI devices.
> +		 */
> +		s->p[i].port.membase	= (void __iomem *)~0;

0 is int, does the compiler not complain about cast to pointer? Or 
sparse? Maybe not, I am not sure anymore...

> +		s->p[i].port.iotype	= UPIO_PORT;
> +		s->p[i].port.uartclk	= uartclk;
> +		s->p[i].port.rs485_config = wk2xxx_config_rs485;
> +		s->p[i].port.rs485_supported = wk2xxx_rs485_supported;
> +		s->p[i].port.ops	= &wk2xxx_ops;
thanks,
-- 
js
suse labs
