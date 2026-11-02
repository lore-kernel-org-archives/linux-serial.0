Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612692;
	b=xtc4HNrx27AiA6jEytpFROrg5OoCJu5qbJ6xUNWYdA4jNFHbHCWDuPyxCRigk/YNY2Kj
	 8VJjsIshhIR/JKjnlw7B62p4fG1zO1h5yh/GmqD8ofmaVcPS70W0OFEIIe4vzMdbiUejl
	 lGAtRYGczcNZNjud5WxiFU9YCLFOZLjgZJPmiIFwAOL0K+8I4eowFKgwRh/3fTWue3cdi
	 OCFrE0v29G3DrUxdoxsntPMQzmFQwySDUhwuuz20RgYFqPQLJa3CQiemAnZtqUOIf+2os
	 p7Xwxy0t0+LEdRrKcZ+12EkJ9V4eAyJaetCp6kK4QMaMYYHMftxvYtq/OcwrzpsYlEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EGSJvB0d0ysJitdNo1aaZCvRZrtbV/Yfe8Xcfjc7SyA=;
	b=Lzu84A+IqT9Tc5G5m6F625NhNygjCOAS3KAEl05nHS17+idkyLiF/5Olt8vRxxlsrtBK
	 gxcaRlDkyr8TYbI/hDFOUNeYbMla5aVSHD5Mf3lAx1K83ou8VSMvlU3gDQrZddAFxcyeH
	 Bh7kDn12hPrhMd3gyJ77shgiD4yDZPF33CmCYtxlvF4xtB1Z9AenvmRuaMsHnymcTpZP7
	 JulUgS3rImnJs6Ax65ACLOeWOvsk+JZU8Mn1bNmpDGbFyBtYDeAYGEnsZ8AVWosHNTNVE
	 GCv3dzIXOayAXdx2mVkro4A+5R1sMxb+g/LD8MjbK/I4dYIWsYhnpcVURwFuKlTZwIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvmZ8m2J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FF606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvmZ8m2J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA541F00919;
	Mon,  2 Nov 2026 09:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793612691;
	bh=EGSJvB0d0ysJitdNo1aaZCvRZrtbV/Yfe8Xcfjc7SyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RvmZ8m2JJFkm3kFDKNstISw0wYwuMkGmkm4rRCjwYdeU57Y9jqcxM7BRkYGxmZLKo
	 Fc2RUFokzlpYJznZVd61d4XDaLYP3Df0567Mc2g2SuMfMOIzA3D0YNUdCoYrvDkFKX
	 XC4zhXDkhVwEWqGCtc8d3bbzQGkK/Ptu1nZmYTBUmMdTj2DprxXUecpkVx8kCnsr+W
	 ZdsoX0eb/Vqo+H7vwe9b2L+YxAoc7Cxn+I1jp0YRgBTwIE5JjLea8PJy6dsN9wnQ1L
	 uaJxl6bHpdWR1ixO0bVI19JVVYPorcojwnNDNM73hbErGzuFkz2kRQEDNmNq7v1qwT
	 ns0xstCicSPCQ==
Message-ID: <sashiko-outbox-193200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: restore FIFO in
 serial8250_console_restore()
Reply-To: sashiko-reviews@lists.linux.dev
To: fuzheng.meng <fuzheng.meng@semidrive.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102093609.2400381-1-fuzheng.meng@semidrive.com>
References: <20261102093609.2400381-1-fuzheng.meng@semidrive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 09:44:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] serial: 8250: open-coded FCR restore in serial8250_console_resto=
re()
--

commit 1d1d530952ba054a9213852856484185009eeee9
Author: fuzheng.meng <fuzheng.meng@semidrive.com>

serial: 8250: restore FIFO in serial8250_console_restore()

This commit factors out serial8250_console_use_fifo() and uses it in
serial8250_console_restore() to reprogram the FIFO control register after t=
he
UART loses power during system suspend with console_suspend disabled.

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 36b2b0a2c05cd..ee6b02cff0156 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c

[ ... ]

> @@ -3345,6 +3376,19 @@ static void serial8250_console_restore(struct uart=
_8250_port *up)
>  	serial8250_set_divisor(port, baud, quot, frac);
>  	serial_port_out(port, UART_LCR, up->lcr);
>  	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
> +
> +	/*
> +	 * System sleep may reset the FCR, leaving the FIFO disabled,
> +	 * while the cached up->fcr still tells console_write() to push
> +	 * tx_loadsz bytes into the FIFO at once; with the hardware FIFO
> +	 * off, the THR holds only one byte and earlier ones are
> +	 * overwritten, which garbles the console output after resume.
> +	 * Restore the FCR when the FIFO write path is going to be used.
> +	 */
> +	if (serial8250_console_use_fifo(up)) {
> +		serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
> +		serial_port_out(port, UART_FCR, up->fcr);
> +	}
>  }

[Severity: Medium]
Could serial8250_console_restore() call the existing serial8250_set_fcr()
helper (after dropping its unused termios parameter) instead of open-coding
the lcr and fcr writes here?

drivers/tty/serial/8250/8250_port.c:serial8250_set_fcr() {
	struct uart_8250_port *up =3D up_to_u8250p(port);
	bool is_16750 =3D port->type =3D=3D PORT_16750;

	if (is_16750)
		serial_port_out(port, UART_FCR, up->fcr);

	/*
	 * LCR DLAB must be reset to enable 64-byte FIFO mode. If the FCR is writt=
en without DLAB
	 * set, this mode will be disabled.
	 */
	serial_port_out(port, UART_LCR, up->lcr);

	if (is_16750)
		return;

	/* emulated UARTs (Lucent Venus 167x) need two steps */
	if (up->fcr & UART_FCR_ENABLE_FIFO)
		serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);

	serial_port_out(port, UART_FCR, up->fcr);
}

In serial8250_console_restore(), serial8250_set_divisor() sets the divisor
latch access bit, and writing up->lcr to the line control register before
programming the fifo control register clears that bit. On 16750 ports,
writing up->fcr after clearing the divisor latch access bit disables 64-byte
fifo mode and leaves a 16-byte hardware fifo while up->tx_loadsz remains 64,
which can overflow the fifo in __serial8250_console_fifo_write().

Also, if serial8250_console_use_fifo(up) returns false (for instance when
uart_console_hwflow_active(port) is true, when auto-flow control is enabled=
 in
up->mcr, when up->tx_loadsz is 1, or when the tty port is not initialized),
doesn't skipping the fcr write leave up->fcr unprogrammed after a power res=
et?

Finally, the commit message mentions that writing the enable bit followed by
the cached up->fcr matches dw8250_idle_exit(), but dw8250_idle_exit() in
drivers/tty/serial/8250/8250_dw.c only performs a single write:

	if (up->capabilities & UART_CAP_FIFO)
		serial_port_out(p, UART_FCR, up->fcr);

Using serial8250_set_fcr() directly after serial8250_set_divisor() would
handle both the 16750 ordering requirement and the two-step write without
duplicating the sequence.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102093609.2400=
381-1-fuzheng.meng@semidrive.com?part=3D1
