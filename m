Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD4344DB5;
	Mon, 12 Oct 2026 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789038; cv=none; b=Yt6Pwy90oj2mlHMFxEESaykZm3fHQK+Y2l70dqAVO/ij7K5jgAR2805DGJaAWqHLGcXQU05G1q7AUcROPbdj9xLcDKR2flN0eMEDOzFRYDx6wrlOsgr/CZdDxyVoacl+FutLdn/1r6C++RoUypvBuXj3Dfpjng5En3UrlZ6+zDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789038; c=relaxed/simple;
	bh=aWNSiGvmWwfPTRDLd2tEzJcP2Ho296YgMCTmeUW9n2c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iV2hQ5SvxaP03wGTdBoTHFuP1fMzRU4flmoZkAdChWOl9fmfiBOXL8tac3Mz97uNwbWRQHzUWJh112FfAZOF1WEEFn5VO3ojjkT7UoXugmQl6OjGX/ITQYWUydZnqiDHRLOhD0nJ4/mPzH/Gzciv5K7yLbY6ebp0GBQZHUkgLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd2yTJXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd2yTJXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E221F0089C;
	Mon, 12 Oct 2026 07:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791789037;
	bh=GsG+1IVi38sXkYbVdya7eJ1kcaTSmijwDDxtlHU8dv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gd2yTJXYy2bbPYjKjYJOkzYo3ebQXDoR1bsaVLjCUqxF8KblhDeIBsc7vXS1+gMc3
	 iNZpM4iuYWbENyeKbG/nMsvJMFtdHpHVUMvnBTtckLDxwORtxlzqrS2xpzP0rYgIeL
	 gf5pCR6p1ax7OCs7niEibB5lvHQHyF1n8GJvto8dn8mTd3WBsoRqaBu06MXRnGla0z
	 G4knI4KYKzDd4OgpgC7Hm65D2YYjA6e/bR3UakJj9FhvLnZv0mnqMd6zkvmZCiHEq+
	 FMyCXM6ZvSdKbX6RXHWj3tA2OHpgINGI98qBAIw9veX8MwtHJHnOsj7rRC4TaljSYO
	 1W3nyhtzLO20g==
Message-ID: <sashiko-outbox-167778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 07/10] tty: serial: Add Cortina UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261012-b4-cs75xx-v3-7-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-7-0e0d17a098cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:10:36 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] tty: serial: cortina: corrupted RX data passed as TTY_NORMAL on =
parity/framing errors
- [Low] serial: incorrect ordering of overrun error reporting in TTY buffer
--

commit 3e704212d6dee31d61d2da0a1c4e2caaf3d70e2e
Author: Fil Dunsky <filipp.dunsky@gmail.com>

tty: serial: Add Cortina UART driver

This commit adds a driver for the UART found in Cortina Systems CS75xx
(Goldengate G2) SoCs. It implements the current serial core API and devm
resource management, and supports the system console and earlycon.

> diff --git a/drivers/tty/serial/cortina-uart.c b/drivers/tty/serial/corti=
na-uart.c
> new file mode 100644
> index 0000000000000..0c2733a7c6b1d
> --- /dev/null
> +++ b/drivers/tty/serial/cortina-uart.c
[ ... ]
> +static void cortina_uart_rx_chars(struct uart_port *port, u32 status)
> +{
> +	struct tty_port *tport =3D &port->state->port;
> +	unsigned int budget =3D CORTINA_UART_RX_BUDGET;
> +	u32 data;
> +
> +	if (status & CORTINA_UART_IRQ_RX_OVERRUN) {
> +		port->icount.overrun++;
> +		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
> +	}

[Severity: Low]
Could this result in the TTY_OVERRUN marker being inserted before the older,
valid characters are extracted from the FIFO?

When a hardware overrun occurs, the RX FIFO is full of older, valid
characters, while the newly arriving characters that did not fit were lost.
By inserting the TTY_OVERRUN marker before the while loop that drains the
FIFO, it appears the driver places the error marker before the older
characters in the TTY stream.

Would this cause the TTY layer to report the data loss in the wrong
chronological position relative to the valid data? The overrun marker should
likely be inserted after the valid characters in the FIFO have been drained.

> +	if (status & CORTINA_UART_IRQ_RX_PARITY)
> +		port->icount.parity++;
> +	if (status & CORTINA_UART_IRQ_RX_STOP)
> +		port->icount.frame++;
> +
> +	while (budget-- && !(readl(port->membase + CORTINA_UART_INFO) &
> +			     CORTINA_UART_INFO_RX_EMPTY)) {
> +		u8 ch;
> +
> +		data =3D readl(port->membase + CORTINA_UART_RXDAT);
> +		if (!(data & CORTINA_UART_RXDAT_VALID))
> +			continue;
> +
> +		port->icount.rx++;
> +		ch =3D FIELD_GET(CORTINA_UART_RXDAT_DATA, data);
> +
> +		if (port->ignore_status_mask & CORTINA_UART_RXDAT_VALID)
> +			continue;
> +		if (uart_prepare_sysrq_char(port, ch))
> +			continue;
> +
> +		tty_insert_flip_char(tport, ch, TTY_NORMAL);
> +	}

[Severity: Medium]
Is it intentional that received characters are unconditionally flagged as
TTY_NORMAL and pushed to the TTY buffer, even if the interrupt indicated a
parity or framing error?

When the hardware detects a parity or framing error, it increments the
corresponding statistics but then unconditionally inserts all received
characters into the TTY buffer with the TTY_NORMAL flag.

[ ... ]
> +static void cortina_uart_set_termios(struct uart_port *port,
> +				     struct ktermios *termios,
> +				     const struct ktermios *old)
> +{
[ ... ]
> +	uart_port_lock_irqsave(port, &flags);
> +
> +	port->ignore_status_mask =3D 0;
> +	if (!(termios->c_cflag & CREAD))
> +		port->ignore_status_mask |=3D CORTINA_UART_RXDAT_VALID;
> +
> +	uart_update_timeout(port, termios->c_cflag, baud);

[Severity: Medium]
Should port->read_status_mask or port->ignore_status_mask be configured here
for parity and framing errors?

By not populating these masks based on termios->c_iflag (e.g., INPCK, IGNPA=
R,
PARMRK), it appears the driver completely bypasses termios error-handling
policies and silently passes corrupted data to userspace as perfectly valid
characters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v3-0-0e0d17a098cf@gmail.com?part=3D7
