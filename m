Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96424C10C3;
	Mon, 12 Oct 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826846; cv=none; b=Vu9gB0dJHxsyUxWDaDTr2FgXEss/fwgahSqk9WfbBnpR6bvy8MEOboYSyhNbQZRO8GkW9TFAzWWAmcSHMJDPhzrmTzhL6qxKJTzq8R3P7ZCb5YCGwxFiy5i5aMSmtOvKzMAsww1/BKNgRktPk9Cc9gOCmWfaQEXr1W6/tu8cSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826846; c=relaxed/simple;
	bh=pnOdqMtQvPt4C1zFIbS1dCoqOQvPqOnA1dUjQV8lTiE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Y5WHPvgZUf5TXqHAEyrLiVYKdacN2umkt7F7R9CBO1wC2bQTdEWUV8aP8bewoZztHKgWehb00po3mkVOw20NMeK8vKu8+DyojQ7rnZsJ3oyceVRahbsQEZml+yiJxErXRc2rHAOV6RFp9X2l3FthK5nOayoT3qGOi29fxAYeSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbv3Dawl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbv3Dawl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8861F0089B;
	Mon, 12 Oct 2026 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826844;
	bh=xjxy5IySfWJOlUvSadD3Zc+ncEe/LZ8lecO8YIOog5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nbv3DawlnbBUfjQYRFcJWq2GmpHu5Fh+Qk2/wexxYBUV28RW/nPw4vqIivKLZLz8Z
	 3k7PazEFZchRQqz5gd+CqpROFCxZo/CDMNz+hC7v6ofNFFm/UJ+tDG7ydhFEot0X7b
	 oapnbrEeHy4Sk2e3/t4BKsE/VctMn3zk/0aFYa4Syq1mCV8gtmv5PBe26M/elTYQv5
	 GvkA38RZUXf4/1vQCUPSvEpcnva5lzKO1GAUHFaq8e4e2pZ2yK7o3RfqZtohhJoEGp
	 JK6HZF5locdax9eo6jH95lfuSMkMT7j6qmPZqT4E/URGpdI9+qyyoRX2x4Xsh3DGZS
	 beNP/C9mpzLEw==
Message-ID: <sashiko-outbox-168476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] tty: serial: Add Cortina UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v4-7-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
 <20261012-b4-cs75xx-v4-7-df250d903682@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:40:43 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tty: unconditional x_char write overflows full TX FIFO in uart_por=
t_tx
- [Medium] tty: missing break detection makes sysrq unreachable
- [Medium] tty: 10ms timeout in putchar causes console data loss at low bau=
d rates
--

commit cd8f7c82aa6edac81dac7b24361325875ebfc80f
Author: Fil Dunsky <filipp.dunsky@gmail.com>

tty: serial: Add Cortina UART driver

This commit adds a serial driver for the UART found in Cortina Systems CS75=
xx
and Cortina Access SoCs. It implements the current serial core API, managing
devm resources, transmit and receive FIFOs, and supports system console and
earlycon.

> diff --git a/drivers/tty/serial/cortina-uart.c b/drivers/tty/serial/corti=
na-uart.c
> index 0000000000000..899fc20978ca0
> --- /dev/null
> +++ b/drivers/tty/serial/cortina-uart.c
> @@ -0,0 +1,595 @@

[ ... ]

> +static void __maybe_unused cortina_uart_putchar(struct uart_port *port,
> +						unsigned char ch)
> +{
> +	u32 info;
> +
> +	readl_poll_timeout_atomic(port->membase + CORTINA_UART_INFO, info,
> +				  !(info & CORTINA_UART_INFO_TX_FULL), 1,
> +				  CORTINA_UART_POLL_TIMEOUT_US);
> +	writel(ch, port->membase + CORTINA_UART_TXDAT);

[Severity: Medium]
Will this hardcoded 10ms timeout cause console data loss at low baud rates?

The timeout is set to CORTINA_UART_POLL_TIMEOUT_US (10,000 microseconds) to=
 wait
for space in the TX FIFO. If the FIFO remains full and the timeout expires,=
 the
driver ignores the timeout error and executes writel() anyway, which could
overwrite the FIFO and drop characters.

At low baud rates, such as 300 baud, a single 10-bit character takes about
33.3ms to transmit. When the FIFO is full at this speed, the putchar functi=
on
would consistently time out because 10ms is not enough time for even a sing=
le
byte to free up, resulting in guaranteed data corruption during earlycon and
console output.

Should the timeout scale dynamically with port->frame_time, or perhaps spin
indefinitely?

> +}

[ ... ]

> +static void cortina_uart_tx_chars(struct uart_port *port)
> +{
> +	u8 ch;
> +
> +	uart_port_tx(port, ch,
> +		     !(readl(port->membase + CORTINA_UART_INFO) &
> +		       CORTINA_UART_INFO_TX_FULL),
> +		     writel(ch, port->membase + CORTINA_UART_TXDAT));

[Severity: High]
Does calling uart_port_tx() without first verifying available space risk
overflowing the hardware TX FIFO?

The driver calls cortina_uart_tx_chars() unconditionally from the ISR, even
on purely RX interrupts. During an active transmit workload, the TX FIFO
could be completely full.

The uart_port_tx() macro writes a pending port->x_char (e.g. for software
flow control) using the provided put_char expression immediately, without
evaluating the tx_ready expression first. It assumes the caller has already
ensured at least one byte of space is available.

If an x_char is pending and the TX FIFO is full, the put_char expression
will execute regardless, overflowing the FIFO and corrupting the hardware
state. Should we explicitly check for TX FIFO space and return early before
calling uart_port_tx()?

> +}

[ ... ]

> +static void cortina_uart_rx_chars(struct uart_port *port, u32 status)
> +{
> +	struct tty_port *tport =3D &port->state->port;
> +	unsigned int budget =3D CORTINA_UART_RX_BUDGET;
> +	u32 data, err;

[ ... ]

> +		if (ch_err & CORTINA_UART_IRQ_RX_PARITY)
> +			flag =3D TTY_PARITY;
> +		else if (ch_err & CORTINA_UART_IRQ_RX_STOP)
> +			flag =3D TTY_FRAME;
> +		else if (uart_prepare_sysrq_char(port, ch))
> +			continue;

[Severity: Medium]
Is the sysrq character handling reachable here without break detection?

The driver attempts to intercept sysrq characters with
uart_prepare_sysrq_char() and claims to support sysrq by setting
port->has_sysrq. However, uart_prepare_sysrq_char() only intercepts
characters if the port is already in the sysrq state (port->sysrq is
non-zero).

The sysrq state is traditionally entered when a BREAK condition is received,
requiring the driver to call uart_handle_break(port) to set port->sysrq
with a timestamp.

Since this driver does not appear to detect a break condition (e.g. checking
for a framing error with a null byte) and never calls uart_handle_break(),
is there another mechanism intended to place the port into the sysrq state,
or does this leave the sysrq feature non-functional?

> +
> +		tty_insert_flip_char(tport, ch, flag);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v4-0-df250d903682@gmail.com?part=3D7
