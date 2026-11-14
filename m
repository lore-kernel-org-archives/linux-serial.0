Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665200;
	b=oRBJgwbOhzWvMsICk/HqfQuuEuiAaRla9GXQISizf61PyNY3Zf6UPV13IzPuS8yiqDMp
	 67qIIy7Rel4gxKCUjAbB1EhT2ntI2TMdO7l4OBZMRHjjGVAWMhrFomFMfd70JU7QIz83v
	 oC/dO0KMmpj8ETY/E6jWPDSxcC05cb0Hjf2LjeVrT7xE7m1nKlhisV6Kq27ps9D9iFR5q
	 PpsYtFYcZW+qmuM4xLkUjDSCg3ffQ7VjXLYbTETbrI0XN5td1pOgj1LTBj6mBbOW7eUpa
	 d9Jll1dS1ZrnOpW7Jr0WqezWI8Bpz0TdNgVC8anKUcJ0dh017ITqVuRPi/pmjExu2OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665200;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vYqGiorBdtvdecT5cD8AXmsUsDqiGCj6eamVLGXX6pM=;
	b=uATKnLEIwo7l2vVrhIBW1vkjAm0mPGAEBXizun4yA1fqR8KgvIBcZpqyWPYfse1UFhPs
	 8xtPaS+je6Vj7jRfh6gBj7Cp/QMWfVAU0YNili+PzyqUCvLcL9mj7RSL3K2/aaI90u169
	 k8iysTqPict0gLHp9oRJWVo96ahOy23/JCUz25Fxif94eN06rK69Ppdzcis/oOn2XExv+
	 YbhB+FBkXz2fH1/U9OoMiQc9wssDw1aXIVszKcsQX0P/uze7n9RAbIvqX3gEwMJgq2/LG
	 ljDevgZQApyFlkNthd3Jx5imk8iUjuzYWA7FCKKvQCuReUj+nqr0zMmGJtHLJssCHEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2q8g9Cy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA9606A327;
	Sat, 14 Nov 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2q8g9Cy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BEE1F000C4;
	Sat, 14 Nov 2026 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665200;
	bh=vYqGiorBdtvdecT5cD8AXmsUsDqiGCj6eamVLGXX6pM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z2q8g9CyAplfSlCYcEujT/KQt7n8Cq0GOLLjwE3ezqOsU4xHhXKE/ZJjG6G2iLxPp
	 Tbha4XRPljPPteWE7HCrGknpLeqdfYkZ/awujr9pBmKaTGnmzIYV2310GF+lpziGnG
	 srB1wXiwlTGAPr4RDKRidRnlNvdc8h83/1+HsMotGQonEnDyG3IAgAodxQ8goEIIGN
	 T5ahThrEj3xMNhbW4HThs9+ejmI04kDocziEZZ5vazQY2xLTzjyjF1KKRTO1RlauJz
	 7sjlsN9uxuxVlseoN6V8l1JtwnZdKZzboFCmOseITFT7HD3uL1AEYnjnXpfxEGPi3T
	 PASGtTY5UtE4A==
Message-ID: <sashiko-outbox-214602@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] tty: serial: Add Cortina UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261114-b4-cs75xx-v7-7-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
 <20261114-b4-cs75xx-v7-7-8f17f38821b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:06:39 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] tty: serial: cortina-uart: missing uart_handle_break() breaks
  SysRq
- [Medium] tty: serial: cortina-uart: unconditional RX/TX handling in
  cortina_uart_isr()
--

commit b5b5d422d0304117c1e8a78b6129aa1a61ffa2ba
Author: Fil Dunsky <filipp.dunsky@gmail.com>

tty: serial: Add Cortina UART driver

This commit adds a serial driver for the UART found in Cortina Systems
CS75xx (Goldengate G2) SoCs, with system console and earlycon support.

> diff --git a/drivers/tty/serial/cortina-uart.c b/drivers/tty/serial/corti=
na-uart.c
> new file mode 100644
> index 0000000000000..72ac035eb8e91
> --- /dev/null
> +++ b/drivers/tty/serial/cortina-uart.c

[ ... ]

> +static void cortina_uart_tx_chars(struct uart_port *port)
> +{
> +	u8 ch;
> +
> +	uart_port_tx(port, ch,
> +		     !(readl(port->membase + CORTINA_UART_INFO) &
> +		       CORTINA_UART_INFO_TX_FULL),
> +		     writel(ch, port->membase + CORTINA_UART_TXDAT));
> +}
> +
> +static void cortina_uart_start_tx(struct uart_port *port)
> +{
> +	cortina_uart_ie_update(port, 0, CORTINA_UART_IRQ_TX_EMPTY);
> +
> +	/*
> +	 * The TX empty interrupt only fires when the FIFO drains, so prime
> +	 * the FIFO here.
> +	 */
> +	cortina_uart_tx_chars(port);
> +}
> +
> +static void cortina_uart_stop_rx(struct uart_port *port)
> +{
> +	cortina_uart_ie_update(port, CORTINA_UART_IRQ_RX_NONEMPTY, 0);
> +}
> +
> +static void cortina_uart_rx_chars(struct uart_port *port, u32 status)
> +{
> +	struct tty_port *tport =3D &port->state->port;
> +	unsigned int budget =3D CORTINA_UART_RX_BUDGET;
> +	u32 data, err;
> +
> +	if (status & CORTINA_UART_IRQ_RX_OVERRUN)
> +		port->icount.overrun++;
> +	if (status & CORTINA_UART_IRQ_RX_PARITY)
> +		port->icount.parity++;
> +	if (status & CORTINA_UART_IRQ_RX_STOP)
> +		port->icount.frame++;
> +
> +	/*
> +	 * The parity and framing error status is only latched in the interrupt
> +	 * register, not per character, so charge it to the first character
> +	 * read in this pass.
> +	 */
> +	err =3D status & port->read_status_mask & CORTINA_UART_IRQ_RX_ERR;
> +
> +	while (budget-- && !(readl(port->membase + CORTINA_UART_INFO) &
> +			     CORTINA_UART_INFO_RX_EMPTY)) {
> +		u8 ch, flag =3D TTY_NORMAL;
> +		u32 ch_err =3D err;
> +
> +		data =3D readl(port->membase + CORTINA_UART_RXDAT);
> +		if (!(data & CORTINA_UART_RXDAT_VALID))
> +			continue;
> +
> +		port->icount.rx++;
> +		ch =3D FIELD_GET(CORTINA_UART_RXDAT_DATA, data);
> +		err =3D 0;
> +
> +		if (port->ignore_status_mask & CORTINA_UART_RXDAT_VALID)
> +			continue;
> +		if (ch_err & port->ignore_status_mask)
> +			continue;
> +
> +		if (ch_err & CORTINA_UART_IRQ_RX_PARITY)
> +			flag =3D TTY_PARITY;
> +		else if (ch_err & CORTINA_UART_IRQ_RX_STOP)
> +			flag =3D TTY_FRAME;
> +		else if (uart_prepare_sysrq_char(port, ch))
> +			continue;

[Severity: Medium]
Can uart_prepare_sysrq_char() ever succeed without a call to
uart_handle_break()?

uart_prepare_sysrq_char() checks port->sysrq, which is only armed by
uart_handle_break().  Because nothing in the driver calls
uart_handle_break() when a break is received (a NUL character with
CORTINA_UART_IRQ_RX_STOP), port->sysrq stays 0 and serial SysRq and break
handling never trigger.  In addition, cortina_uart_set_termios() only adds
CORTINA_UART_IRQ_RX_STOP to port->read_status_mask when INPCK is set, which
masks stop-bit errors and breaks when INPCK is clear.

> +
> +		tty_insert_flip_char(tport, ch, flag);
> +	}
> +
> +	/* The characters left in the FIFO were received before the lost ones */
> +	if (status & CORTINA_UART_IRQ_RX_OVERRUN &
> +	    ~port->ignore_status_mask)
> +		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
> +
> +	tty_flip_buffer_push(tport);
> +}
> +
> +static irqreturn_t cortina_uart_isr(int irq, void *dev_id)
> +{
> +	struct uart_port *port =3D dev_id;
> +	u32 status;
> +
> +	guard(uart_port_lock_check_sysrq_irqsave)(port);
> +
> +	status =3D readl(port->membase + CORTINA_UART_INT);
> +	writel(status, port->membase + CORTINA_UART_INT);
> +
> +	cortina_uart_rx_chars(port, status);
> +	cortina_uart_tx_chars(port);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Should cortina_uart_isr() check which interrupt causes are active before
running the RX and TX handlers?

Calling cortina_uart_tx_chars() -> uart_port_tx() on every RX interrupt
when TX is idle or stopped sees pending < WAKEUP_CHARS and triggers a
spurious uart_write_wakeup() and ->stop_tx() MMIO write.  Likewise, calling
cortina_uart_rx_chars() on a TX-only interrupt schedules flip-buffer work
via tty_flip_buffer_push() even when the RX FIFO is empty, and
unconditionally returning IRQ_HANDLED when status is 0 prevents the
spurious IRQ detector from catching a stuck interrupt.

Also, cortina_uart_start_tx() enables CORTINA_UART_IRQ_TX_EMPTY in
CORTINA_UART_IE before priming the FIFO and without clearing any stale
CORTINA_UART_IRQ_TX_EMPTY bit in CORTINA_UART_INT, which immediately fires
a spurious TX interrupt while the newly filled FIFO is still full.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-cs75xx-=
v7-0-8f17f38821b4@gmail.com?part=3D7
