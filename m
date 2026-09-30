Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F13BED69;
	Wed, 30 Sep 2026 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752470; cv=none; b=ZZHfvkSNMkqgqU09116uATSc5JoqsbOun/Gw7qFKn2XTTMN2OEq6umGtjsfirzM5GIdJARniby61LGTWntTjlBpQUnTK6HuHIGguTn3keNVLA+A7eOwQRDprSgrVzgp+TXqMQVjJ/DJ6s4f6wGbYnqLN2H4RLFMQf4G5Zv3shUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752470; c=relaxed/simple;
	bh=ldcs5kckl0jCruCEhlnqzryZeGJdxn8dDtwSpQz59Xg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q8VgTN66U1LYF9ank5mVJ2JpLy8rd9/ktzvsGiqs8qnzuFMWjPGXKwVa52V+YVLpMQ7osGCdr9oeCDi3Nc0XKez+tljPWBlDC4bGdm/d+iRihMhlMGRjhIG9moaJpKOZM44c3aEll0PRf6kt3EiMRts7zXsqJqzHWWN/ko6v5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUgqNrbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUgqNrbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0354F1F000FF;
	Wed, 30 Sep 2026 07:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752468;
	bh=tiFOng4APKsK3PJsMclfvS98wcEbTvqIU6lITxu2ck8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YUgqNrbulSRCFRBuMInjMZdUU2Zvt0xEFEhA6mBUJhWd57YJeuIGezIsIus+BBf3g
	 lYLqiaRu52ipvULAA/yo6D+Y6cipi/Y7e00B/DCfeycZkFN+6P9YdM+nyRZkO/iiCx
	 sTfyk1YD3LyRwKLZ27oYYi+Mls81Xk5xLdd4jICQhs5SmXibEmtaxheV3h6LltSqGb
	 Fc4JoeXZplYfRls98u+w/1o3WnQ2eMmCkgEZJ8EizV0/obpZMdO9J8dXGonVG1CgvI
	 jBvtaFJTeHIkq5kehpVqUcTetnZof37RJfTfQB60k2El7nZcH4Dabwb+46lzmhRSn/
	 j99p1dnmRPZuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:14:27 +0000
Message-Id: <20260930071428.0354F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] tty: serial: TOCTOU race in port ID allocation and error path NULL=
 pointer deref
- [High] tty: serial: unprotected IE register modification races with conso=
le
- [High] tty: serial: missing clock boundary check causes divide by zero
- [Medium] tty: serial: cs75xx_uart_poll_get_char ignores RXDAT_VALID bit
- [Medium] tty: serial: TX completion polling timeout is insufficient for 9=
600 baud
- [Medium] tty: serial: unbounded RX loop in interrupt handler causes DoS
- [Medium] tty: serial: stale RX data delivery upon reopen due to missing f=
lush
--

commit 4691ca0bebc0549ec6e71e453bc7c5a203026946
Author: Fil Dunsky <filipp.dunsky@gmail.com>
Date:   Wed Sep 30 07:00:06 2026 +0000

tty: serial: Add Cortina Systems CS75xx UART driver

This commit introduces a UART driver for the Cortina Systems CS75xx
(Goldengate G2) SoCs. It utilizes the current serial core API, devm resource
management, and supports the system console and earlycon.

> --- /dev/null
> +++ b/drivers/tty/serial/cs75xx-uart.c
[ ... ]
> +static void cs75xx_uart_rx_chars(struct uart_port *port, u32 status)
> +{
> +	struct tty_port *tport =3D &port->state->port;
> +	u32 data;
[ ... ]
> +	while (!(readl(port->membase + CS75XX_UART_INFO) &
> +		 CS75XX_UART_INFO_RX_EMPTY)) {
> +		u8 ch;
> +
> +		data =3D readl(port->membase + CS75XX_UART_RXDAT);

[Severity: Medium]
Could this loop run indefinitely? If a faulty peripheral or malicious
environment (like a compromised hypervisor) continuously asserts that the
RX FIFO is not empty, this could trap the CPU in interrupt context,
leading to a hard lockup. Should we add a maximum quota limit here
(e.g., 256 iterations)?

> +		if (!(data & CS75XX_UART_RXDAT_VALID))
> +			continue;
> +
> +		port->icount.rx++;
> +		ch =3D FIELD_GET(CS75XX_UART_RXDAT_DATA, data);
[ ... ]
> +static int cs75xx_uart_startup(struct uart_port *port)
> +{
> +	unsigned long flags;
> +	u32 cfg;
> +	int ret;
> +
> +	writel(0, port->membase + CS75XX_UART_IE);
> +	writel(CS75XX_UART_IRQ_ALL, port->membase + CS75XX_UART_INT);

[Severity: High]
Does modifying the IE register without acquiring the port lock create a
race condition? If the console subsystem (like cs75xx_uart_console_write)
concurrently reads the IE register before this zeroing occurs, and then
writes the old value back afterward, we could end up with a stale interrupt
mask being restored.

> +	ret =3D request_irq(port->irq, cs75xx_uart_isr, 0, dev_name(port->dev),
> +			  port);
> +	if (ret)
> +		return ret;
> +
> +	uart_port_lock_irqsave(port, &flags);
> +
> +	cfg =3D readl(port->membase + CS75XX_UART_CFG);
> +	cfg |=3D CS75XX_UART_CFG_EN | CS75XX_UART_CFG_RX_EN | CS75XX_UART_CFG_T=
X_EN;
> +	writel(cfg, port->membase + CS75XX_UART_CFG);
> +
> +	writel(CS75XX_UART_IRQ_RX_NONEMPTY, port->membase + CS75XX_UART_IE);

[Severity: Medium]
Is it possible that we are unmasking the RX interrupts without draining the
pre-existing characters in the RX FIFO? Since cs75xx_uart_shutdown leaves t=
he
hardware receiver enabled, data might accumulate while closed. Enabling the
interrupt without flushing the FIFO could cause applications to receive sta=
le
garbage data upon reopening the serial port.

> +	uart_port_unlock_irqrestore(port, flags);
> +
> +	return 0;
> +}
> +
> +static void cs75xx_uart_shutdown(struct uart_port *port)
> +{
> +	unsigned long flags;
> +
> +	uart_port_lock_irqsave(port, &flags);
> +	writel(0, port->membase + CS75XX_UART_IE);
> +	uart_port_unlock_irqrestore(port, flags);
> +
> +	free_irq(port->irq, port);
> +}

[Severity: Medium]
It looks like we are not disabling the receiver (CFG_RX_EN) here.
Does this allow the FIFO to fill with data while the port is supposedly
shut down?

> +static void cs75xx_uart_set_termios(struct uart_port *port,
> +				    struct ktermios *termios,
> +				    const struct ktermios *old)
> +{
> +	unsigned int baud, div;
> +	unsigned long flags;
> +	u32 cfg;
> +
> +	/* No hardware flow control or mark/space parity support */
> +	termios->c_cflag &=3D ~(CRTSCTS | CMSPAR);
> +
> +	baud =3D uart_get_baud_rate(port, termios, old,
> +				  DIV_ROUND_UP(port->uartclk, CS75XX_UART_DIV_MAX),
> +				  port->uartclk / CS75XX_UART_DIV_MIN);
> +	div =3D DIV_ROUND_CLOSEST(port->uartclk, baud);

[Severity: High]
Can this code divide by zero? In cs75xx_uart_probe(), port->uartclk is chec=
ked
against zero, but not against the minimum required value. If port->uartclk =
is
very low (e.g., < CS75XX_UART_DIV_MIN), the maximum rate passed to
uart_get_baud_rate() will be 0 and the minimum will be > 0.

When min > max, uart_get_baud_rate() can return 0, leading to a
division by zero in DIV_ROUND_CLOSEST().

> +	cfg =3D FIELD_PREP(CS75XX_UART_CFG_BAUD, div) | CS75XX_UART_CFG_EN |
[ ... ]
> +#ifdef CONFIG_CONSOLE_POLL
> +static int cs75xx_uart_poll_get_char(struct uart_port *port)
> +{
> +	if (readl(port->membase + CS75XX_UART_INFO) & CS75XX_UART_INFO_RX_EMPTY)
> +		return NO_POLL_CHAR;
> +
> +	return FIELD_GET(CS75XX_UART_RXDAT_DATA,
> +			 readl(port->membase + CS75XX_UART_RXDAT));
> +}

[Severity: Medium]
Are we missing a check against the CS75XX_UART_RXDAT_VALID bit here?
If the polling console subsystem invokes this and the VALID bit is not set
on the data, we might return corrupted or invalid characters to callers
like kgdb.

> +static void cs75xx_uart_poll_put_char(struct uart_port *port, unsigned c=
har c)
[ ... ]
> +static void cs75xx_uart_console_write(struct console *co, const char *s,
> +				      unsigned int count)
> +{
> +	struct uart_port *port =3D &cs75xx_uart_ports[co->index]->port;

[Severity: High]
Is it safe to dereference the cs75xx_uart_ports array element here?
If uart_add_one_port() fails in cs75xx_uart_probe(), it locklessly clears
this global array pointer. A concurrent console write could observe the NULL
pointer, causing a kernel panic.

> +	unsigned long flags;
> +	bool locked =3D true;
> +	u32 ie, info;
> +
> +	if (oops_in_progress)
> +		locked =3D uart_port_trylock_irqsave(port, &flags);
> +	else
> +		uart_port_lock_irqsave(port, &flags);
> +
> +	ie =3D readl(port->membase + CS75XX_UART_IE);
> +	writel(ie & ~CS75XX_UART_IRQ_TX_EMPTY, port->membase + CS75XX_UART_IE);
> +
> +	uart_console_write(port, s, count, cs75xx_uart_putchar);
> +
> +	readl_poll_timeout_atomic(port->membase + CS75XX_UART_INFO, info,
> +				  info & CS75XX_UART_INFO_TX_EMPTY, 1,
> +				  CS75XX_UART_POLL_TIMEOUT_US);

[Severity: Medium]
Is the 10000us (10ms) CS75XX_UART_POLL_TIMEOUT_US timeout sufficient?
If the console is configured to 9600 baud, transmitting a full 16-byte FIFO
takes ~16.6ms. This would cause the polling to time out before the
transmission completes, potentially dropping characters or prematurely
re-enabling interrupts.

> +	writel(ie, port->membase + CS75XX_UART_IE);

[Severity: High]
Could this unconditionally restore a stale interrupt mask?
If cs75xx_uart_startup() zeroes the IE register locklessly while this
function holds the lock, writing the ie variable back here will overwrite
that zeroed state with the previous (now stale) enabled mask.

> +
> +	if (locked)
> +		uart_port_unlock_irqrestore(port, flags);
> +}
[ ... ]
> +static int cs75xx_uart_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cs75xx_uart_port *up;
> +	struct uart_port *port;
> +	struct resource *res;
> +	int id, ret;
> +
> +	id =3D of_alias_get_id(dev->of_node, "serial");
> +	if (id < 0) {
> +		for (id =3D 0; id < CS75XX_UART_NR_PORTS; id++)
> +			if (!cs75xx_uart_ports[id])
> +				break;
> +	}

[Severity: High]
Does accessing the global cs75xx_uart_ports array without locks during probe
create a race condition? If multiple platform device probes run concurrently
(e.g., via sysfs bind operations), they could claim the same ID.

> +	if (id >=3D CS75XX_UART_NR_PORTS)
> +		return dev_err_probe(dev, -EINVAL, "invalid port index %d\n", id);
> +	if (cs75xx_uart_ports[id])
> +		return dev_err_probe(dev, -EBUSY, "port %d already in use\n", id);
[ ... ]
> +	port->uartclk =3D clk_get_rate(up->clk);
> +	if (!port->uartclk)
> +		return dev_err_probe(dev, -EINVAL, "clock rate is zero\n");

[Severity: High]
As mentioned above in cs75xx_uart_set_termios(), we only check if the clock
rate is exactly zero here. Should we also ensure the clock rate is at least
as large as the minimum required divisor to prevent a division by zero late=
r?

> +
> +	port->dev =3D dev;
> +	port->mapbase =3D res->start;
> +	port->mapsize =3D resource_size(res);
> +	port->iotype =3D UPIO_MEM32;
> +	port->ops =3D &cs75xx_uart_ops;
> +	port->line =3D id;
> +	port->fifosize =3D CS75XX_UART_FIFO_SIZE;
> +	port->flags =3D UPF_BOOT_AUTOCONF;
> +	port->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_CS75XX_CONSOLE);
> +
> +	cs75xx_uart_ports[id] =3D up;
> +	platform_set_drvdata(pdev, up);
> +
> +	ret =3D uart_add_one_port(&cs75xx_uart_driver, port);
> +	if (ret) {
> +		cs75xx_uart_ports[id] =3D NULL;
> +		return ret;
> +	}

[Severity: High]
Is it safe to clear cs75xx_uart_ports[id] locklessly on the error path?
If the console subsystem is actively attempting to write something, it may
dereference the global array during or after this assignment, leading to a
NULL pointer dereference as pointed out in cs75xx_uart_console_write().

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-cs75xx-=
v1-0-4617c4463529@gmail.com?part=3D7
