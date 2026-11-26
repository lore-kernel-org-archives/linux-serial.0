Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735937;
	b=SBKqUf2Xbs0GKQkMFBTSTK5yoIG3DVRBeS2LEofnL49UzNeccUp1ZO9pD1Vi61NfmtP3
	 Z3Txg1WZ945ki1LZfY/rbFjwvtJo5KVrYkY7cNcXlz6QGavecwjFGZhTrUWeMHltRI3l+
	 TFRFxIbk5Mt0dNJCI9JfHnHY+H26Qf1gBQDY6WZBdQrwuwxNtL/+44uOqyFpbmzsyc3dY
	 olCYaxINbqVaIlRfdwg+guL5ld3NeKzKagg00SUOYMbzUXu8aLyGfAfJlw2ETkd7MLPG1
	 eu6otYxiFLvaVbuKRVKb4KRfORClTwDGgBQJlUDv4sp14wSnT6mPguttCU10zwSGupA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735937;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HJj6Zhv1yFBA1Dcn8bwRSN4l02pFFOxVv7oYkWGUIGU=;
	b=jjlf0RMl8NW+NJuZBoJM4rhwF9YK0KzMEmDTzdiZAHm7HvRiVE/yrl+dO5FXpAVZ1j3H
	 CSMi3xzuYJ1Wo9bMqQ5CW4LFRT0rltUsY3QLLy6sl2z/i2jokRZtkkLTZv/aLOI66aKqr
	 OwVTt527W+vNnVIbVlenSOpAqnm8RxWV7z3dbSWhTatqlTJTr7/z3mdVG1ghvdp02YsHS
	 e5yEIn/3wmJo6wA7+QgeCOflVITKwz1kAK5UpdtNwuSkHOw/KF6zqAsCHdEbAGinnqaIS
	 +muwyCpnd40bKTfpUPjapw5CtkdXHl3lEksIboC7AurSll5ZEpOm3CI9Q9+eMP39aVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAYJ44Jw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27B606A31C;
	Thu, 26 Nov 2026 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAYJ44Jw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3B81F00896;
	Thu, 26 Nov 2026 23:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735937;
	bh=HJj6Zhv1yFBA1Dcn8bwRSN4l02pFFOxVv7oYkWGUIGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AAYJ44JwTJDH4qH8M1mowwcs3+j3JL+I82pfvwuTP6KN099MAGiu3/BoVVL8rOhwc
	 wGCBcMa+cxNd4u4Dnanq9XzJV/Bqw8i1jzE11dby35GozB58eNPVzBJlKW3gRHXXPv
	 Zr0JUsIg6QAHVxuKAN/5UGxs1ABLwb3JIphXkDlsNRjMW0kxrmj4Fvr/US2/hYtGLf
	 FMzzsY1gHXoCjbVupsDqtDFjRoLl9CTvIkClil4pwKvxX+WddZ6A74wAwUJy+bpMWq
	 eQV7eLFOwTILsC01ljKF8Y6pjM3XQ8h/xWWOxB6HNZisGE5alL1YSN/m/9DB0O46yH
	 TPMTN44qVerXQ==
Message-ID: <sashiko-outbox-236332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/19] serial: esp32: Restore the ESP32 UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VsOtdG9yIEh1Z28gU2lsdmE=?= <vitorhg20080@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125233020.1380594-11-vitorhg20080@gmail.com>
References: <20261125233020.1380594-1-vitorhg20080@gmail.com>
 <20261125233020.1380594-11-vitorhg20080@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 23:32:16 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [Medium] serial: esp32: divide-by-zero in esp32_uart_set_baud() during
  earlycon setup
- [Medium] serial: esp32: SCLK prescaler miscalculation in
  esp32_uart_set_baud()
- [Medium] serial: esp32: unclocked MMIO access in
  esp32_uart_set_mctrl() during probe
- [Medium] serial: esp32: missing TTY_BREAK insertion in
  esp32_uart_rxint()
- [Medium] serial: esp32: UART_BRK_DET_INT left enabled in
  esp32_uart_stop_rx()
- [Low] serial: esp32: incomplete CRTSCTS flow control in
  esp32_uart_set_termios()
--

commit 12c65ed88656e1a1416d2544ca647a643b9237af
Author: V=C3=ADtor Hugo Silva <vitorhg20080@gmail.com>

serial: esp32: Restore the ESP32 UART driver

This commit restores the Espressif ESP32 UART driver under COMPILE_TEST
with esp32_uart_console_setup() moved to regular text.

> diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_u=
art.c
> new file mode 100644
> index 0000000000000..8f257cf0d2909
> --- /dev/null
> +++ b/drivers/tty/serial/esp32_uart.c

[ ... ]

> +static void esp32_uart_rxint(struct uart_port *port)
> +{
> +	struct tty_port *tty_port =3D &port->state->port;
> +	u32 rx_fifo_cnt =3D esp32_uart_rx_fifo_cnt(port);
> +	unsigned long flags;
> +	u32 i;
> +
> +	if (!rx_fifo_cnt)
> +		return;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	for (i =3D 0; i < rx_fifo_cnt; ++i) {
> +		u32 rx =3D esp32_uart_read(port, UART_FIFO_REG);
> +
> +		if (!rx &&
> +		    (esp32_uart_read(port, UART_INT_ST_REG) & UART_BRK_DET_INT)) {
> +			esp32_uart_write(port, UART_INT_CLR_REG, UART_BRK_DET_INT);
> +			++port->icount.brk;
> +			uart_handle_break(port);
> +		} else {

[Severity: Medium]
Should esp32_uart_rxint() insert a TTY_BREAK character into tty_port when
uart_handle_break() returns 0?  Without tty_insert_flip_char(tty_port, rx,
TTY_BREAK), breaks not consumed by SysRq are silently dropped and never
reach the TTY line discipline.

[ ... ]

> +static void esp32_uart_stop_rx(struct uart_port *port)
> +{
> +	u32 int_ena;
> +
> +	int_ena =3D esp32_uart_read(port, UART_INT_ENA_REG);
> +	int_ena &=3D ~UART_RXFIFO_FULL_INT;
> +	esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
> +}

[Severity: Medium]
Should esp32_uart_stop_rx() also clear UART_BRK_DET_INT?

esp32_uart_startup() enables both UART_RXFIFO_FULL_INT and
UART_BRK_DET_INT, and esp32_uart_int() calls esp32_uart_rxint() when
either bit is set.  If a break arrives after stop_rx(), esp32_uart_rxint()
will still run and push received bytes to the flip buffer.

[ ... ]

> +static bool esp32_uart_set_baud(struct uart_port *port, u32 baud)
> +{
> +	u32 sclk =3D port->uartclk;
> +	u32 div =3D sclk / baud;
> +
> +	if (port_variant(port)->has_clkconf) {
> +		u32 sclk_div =3D div / port_variant(port)->clkdiv_mask;
> +
> +		if (div > port_variant(port)->clkdiv_mask) {
> +			sclk /=3D (sclk_div + 1);
> +			div =3D sclk / baud;
> +		}
> +		esp32_uart_write(port, ESP32S3_UART_CLK_CONF_REG,
> +				 FIELD_PREP(ESP32S3_UART_SCLK_DIV_NUM, sclk_div) |
> +				 ESP32S3_UART_CLK_CONF_DEFAULT);
> +	}
> +
> +	if (div <=3D port_variant(port)->clkdiv_mask) {
> +		u32 frag =3D (sclk * 16) / baud - div * 16;
> +
> +		esp32_uart_write(port, UART_CLKDIV_REG,
> +				 div | FIELD_PREP(UART_CLKDIV_FRAG, frag));
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void esp32_uart_set_termios(struct uart_port *port,
> +				   struct ktermios *termios,
> +				   const struct ktermios *old)
> +{
> +	unsigned long flags;
> +	u32 conf0, conf1;
> +	u32 baud;
> +	const u32 rx_flow_en =3D port_variant(port)->rx_flow_en;
> +	u32 max_div =3D port_variant(port)->clkdiv_mask;
> +
> +	termios->c_cflag &=3D ~CMSPAR;
> +
> +	if (port_variant(port)->has_clkconf)
> +		max_div *=3D FIELD_MAX(ESP32S3_UART_SCLK_DIV_NUM);
> +
> +	baud =3D uart_get_baud_rate(port, termios, old,
> +				  port->uartclk / max_div,
> +				  port->uartclk / 16);

[Severity: Medium]
Can esp32_uart_set_baud() miscalculate the SCLK prescaler on variants with
has_clkconf?

When div equals clkdiv_mask (4095 on ESP32-S3, e.g. 9768 baud at 40 MHz),
sclk_div is 1, but the div > clkdiv_mask branch is skipped.  That writes
sclk_div =3D 1 into ESP32S3_UART_CLK_CONF_REG (dividing the source clock by
2) while leaving div =3D 4095 unscaled in UART_CLKDIV_REG, halving the baud
rate.

In addition, port->uartclk / max_div in esp32_uart_set_termios() truncates
downward (38 baud at 40 MHz with max_div =3D 4095 * 255), which yields div =
=3D
1052631 and sclk_div =3D 257 in esp32_uart_set_baud(), overflowing the 8-bit
ESP32S3_UART_SCLK_DIV_NUM field in FIELD_PREP().

[ ... ]

> +	if (termios->c_cflag & CRTSCTS)
> +		conf1 |=3D rx_flow_en;
> +
> +	esp32_uart_write(port, UART_CONF0_REG, conf0);
> +	esp32_uart_write(port, UART_CONF1_REG, conf1);

[Severity: Low]
Does CRTSCTS handling in esp32_uart_set_termios() leave hardware flow
control incomplete?

It toggles rx_flow_en in UART_CONF1_REG, but UART_TX_FLOW_EN in
UART_CONF0_REG is never set or cleared for CTS transmit flow control, and
esp32_uart_startup() overwrites UART_CONF1_REG without programming an RX
flow control threshold.

[ ... ]

> +static int __init esp32xx_uart_early_console_setup(struct earlycon_devic=
e *device,
> +						   const char *options)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->con->write =3D esp32_uart_earlycon_write;
> +#ifdef CONFIG_CONSOLE_POLL
> +	device->con->read =3D esp32_uart_earlycon_read;
> +#endif
> +	if (device->port.uartclk !=3D BASE_BAUD * 16)
> +		esp32_uart_set_baud(&device->port, device->baud);
> +
> +	return 0;
> +}

[Severity: Medium]
Can esp32xx_uart_early_console_setup() divide by zero or zero out
UART_CLKDIV_REG in esp32_uart_set_baud()?

When earlycon is set up via OF_EARLYCON_DECLARE, of_setup_earlycon() leaves
port.uartclk at 0 if clock-frequency is absent in Devicetree (as required
by esp,esp32-uart.yaml), which is not equal to BASE_BAUD * 16 on
architectures with a non-zero BASE_BAUD.  If device->baud is also 0 (or a
command-line earlycon specifies a clock rate without a baud rate),
sclk / baud in esp32_uart_set_baud() divides by zero; if device->baud is
set while port.uartclk is 0, esp32_uart_set_baud() writes a zero divisor to
UART_CLKDIV_REG.  Checking device->port.uartclk && device->baud before
calling esp32_uart_set_baud() would avoid both.

[ ... ]

> +static int esp32_uart_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	sport->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(sport->clk))
> +		return PTR_ERR(sport->clk);
> +
> +	port->uartclk =3D clk_get_rate(sport->clk);
> +	port->dev =3D &pdev->dev;
> +	port->type =3D PORT_GENERIC;
> +	port->iotype =3D UPIO_MEM;
> +	port->irq =3D platform_get_irq(pdev, 0);
> +	port->ops =3D &esp32_uart_pops;
> +	port->flags =3D UPF_BOOT_AUTOCONF;
> +	port->has_sysrq =3D 1;
> +	port->fifosize =3D ESP32_UART_TX_FIFO_SIZE;
> +	port->private_data =3D (void *)device_get_match_data(&pdev->dev);
> +
> +	esp32_uart_ports[port->line] =3D sport;
> +
> +	platform_set_drvdata(pdev, port);
> +
> +	return uart_add_one_port(&esp32_uart_reg, port);
> +}

[Severity: Medium]
Does uart_add_one_port() access UART_CONF0_REG before sport->clk is
enabled?

During uart_add_one_port(), uart_configure_port() calls
esp32_uart_set_mctrl(), which reads and writes UART_CONF0_REG before
esp32_uart_console_setup() or esp32_uart_startup() enables sport->clk
(and esp32_uart_pops has no .pm callback).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125233020.1380=
594-1-vitorhg20080@gmail.com?part=3D10
