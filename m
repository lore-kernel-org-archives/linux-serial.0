Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE6418A22;
	Tue, 13 Oct 2026 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863832; cv=none; b=NDVZmRJqYqy8Rbatu68qafpD2Aopk3y4mC3/bugTFfeQ6DID4b9xlBk5hEkBtcz37rRlY59R9VYSBdO1ErA0BJesRmkQDmBfCwbriZl6BJk5KoLI1LqjxR0uiTrVjDwUb/rTH9nfWKD80G73VrjQLk3NN2HcdqqD5//hXu8DjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863832; c=relaxed/simple;
	bh=c3oIvzrhYdamcS1+vBcmvjzupg68MMwn1M6rB2oyLGk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EhsUIm+z/soR5Y8AyFIFwmEab44e07yiqPo1TyzfStC5oQyK+4SCgPRuKM1jAsjtAVmFUjdnY0/uXf8OWHZLyjwbYaiaIyqvAWsf49XB3K2bMZwR51BfO33kSaUkdEETo/pV+PLzEcpMhLrD693dWGM6uhUZ4ewaxcd68iGCGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQYFHzNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQYFHzNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B790E1F00893;
	Tue, 13 Oct 2026 03:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863831;
	bh=lDhdbdxwSgRGr0O5k3MdmiLbmspQYxIRvfs/WiedR3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gQYFHzNzS7mpbjb4h5ktS2H8yBpln7bMQwKWXXvK0xPYl+K4QvIPbsrKfTEZItsNq
	 WqtpQFeFwxAmqHQasQDfPFIwc2tZsNHu1BZsszhK25dY34QzHCGEAm9j2tIt9TPh97
	 J2k06hygf22YV7w6LnDJtOZPUGeUiodLVMj1NQ/ibVu8nw32HzMMJZBb0nzDxwXQMj
	 YwivAGQalyW0i9nyTvfptiBxzq2UMPGSdWY8ooNM4iKAw11UNX25L7hMvRkvZGHbXO
	 M6ja0pcgcsu8GbTwI580cebUYf7wDkEi+WM+8ihjCHAWHjvpTxNK2vyPzKSGd1HnHK
	 5ZBA0o2um86WA==
Message-ID: <sashiko-outbox-168941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] tty: serial: Add Cortina UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013-b4-cs75xx-v5-7-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
 <20261013-b4-cs75xx-v5-7-4e72aa383d39@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:57:10 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tty: serial: cortina: Overrun errors reported when CREAD is cleared
--

commit 6c5059b7f2174557fc1b85a7365146c863b99a28
Author: Fil Dunsky <filipp.dunsky@gmail.com>

tty: serial: Add Cortina UART driver

This commit adds a new serial driver for the UART found in Cortina Systems
CS75xx SoCs. It supports the system console and earlycon, using the modern
serial core API.

> diff --git a/drivers/tty/serial/cortina-uart.c b/drivers/tty/serial/corti=
na-uart.c
> new file mode 100644
> index 0000000000000..58faddfe0f37d
> --- /dev/null
> +++ b/drivers/tty/serial/cortina-uart.c

[ ... ]

> +static void cortina_uart_rx_chars(struct uart_port *port, u32 status)
> +{
> +	struct tty_port *tport =3D &port->state->port;
> +	unsigned int budget =3D CORTINA_UART_RX_BUDGET;
> +	u32 data, err;

[ ... ]

> +	/* The characters left in the FIFO were received before the lost ones */
> +	if (status & CORTINA_UART_IRQ_RX_OVERRUN &
> +	    ~port->ignore_status_mask)
> +		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
> +
> +	tty_flip_buffer_push(tport);
> +}

[ ... ]

> +static void cortina_uart_set_termios(struct uart_port *port,
> +				     struct ktermios *termios,
> +				     const struct ktermios *old)
> +{
> +	unsigned int baud, div;
> +	u32 cfg;

[ ... ]

> +	port->ignore_status_mask =3D 0;
> +	if (termios->c_iflag & IGNPAR)
> +		port->ignore_status_mask |=3D CORTINA_UART_IRQ_RX_ERR;
> +	if (!(termios->c_cflag & CREAD))
> +		port->ignore_status_mask |=3D CORTINA_UART_RXDAT_VALID;

[Severity: Low]
Does this leave the port vulnerable to reporting overrun errors even when
the receiver is supposed to be disabled?

When CREAD is cleared, the intent is to ignore all received data. However,
it appears CORTINA_UART_IRQ_RX_OVERRUN is omitted from the ignore mask here.

Since CORTINA_UART_CFG_RX_EN remains unconditionally set in the configurati=
on,
the hardware receiver stays active and the FIFO can still overrun if data
arrives.

If an overrun occurs under these conditions, cortina_uart_rx_chars() would
inject a TTY_OVERRUN character into the buffer because the overrun status b=
it
isn't masked out by ignore_status_mask. Should CORTINA_UART_IRQ_RX_OVERRUN
also be added to the mask when CREAD is cleared to avoid this?

> +
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	writel(cfg, port->membase + CORTINA_UART_CFG);
> +	/* Sample the received bits in the middle of the bit time */
> +	writel(div / 2, port->membase + CORTINA_UART_RX_SAMPLE);
> +
> +	if (tty_termios_baud_rate(termios))
> +		tty_termios_encode_baud_rate(termios, baud, baud);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v5-0-4e72aa383d39@gmail.com?part=3D7
