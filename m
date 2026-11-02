Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619777;
	b=bJOj6y8HuKAr9i7Nw58Z2P/RhIgHPvnSwz39zD+z6wJjlbryCah9upwkX/UObzFSjZUl
	 lNHQx/TGfKvga/6bOPL6ANPXozrcQYTKEUPTtBFn/uK7RRaojKsxMNGCWkS5dU7LqsRjv
	 VDYY8dHGjtOKwPKudn+JCSyFg3tB16dhlAw2P8pdBgyWmDxWIbJd6uxvL0cJsvPSDrJ6s
	 fklcFji9xWi+lDqAYe5s4WhjIzrDcKIU5FIrAJLWUvQ6leBkDH6tXpGw6U/WRfVnbX7+d
	 Quo7DGqpFcQJsumfb4Nacplu8lE2BsOBbaPC3ycmsX9vrnP3iUKJyfz0THVlDw+bgfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hwBFK7W3RIZ8AyEe/QASm7pGThlOI2XX4GmjCbzsDBQ=;
	b=z/eHRu4LhocI9OcJpPFoHumYMHgZbPvOiqZNdYShXar6MZRUBDnAz3ZVe40nZgOhz99S
	 XmD89Altx5/Ax8Ij55uzbqoMIOk4kdnexRX9AcWQbf9QeOFbB1ViAgwlicfgsrtHoedy6
	 CzcWiMqSznAx8qV0CMuEaF1MuP9dXI8wPdFSR41+ip+EhzSRyoq1Vz1bPG9NultRnPw4m
	 JpJxGorxhswhlboQ9hgadCqjEu0SxxS1MpOgSQpU1c2HQ/chnHrDVxVW6ol+G2VryaIBw
	 OdFBt9yDI9JAhGmwChVTw+gLHFhAWnpcMIKZwg3C2ymSIPyCjWW+juMGDRASO1ihp0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YMX4/Tdc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3D606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMX4/Tdc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B094E1F00A16;
	Mon,  2 Nov 2026 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619776;
	bh=hwBFK7W3RIZ8AyEe/QASm7pGThlOI2XX4GmjCbzsDBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMX4/TdcizgcDsRlXxLfaOInOZKg+JAHM6Xodshm8X5mClhV+LA2mkjUGPmZPsic0
	 PF9eq/hmTiL162wkjmaL7qV7oFW65+VCuZql2fqHn72RYM2+gOBx9hotRdVzoeb4GT
	 312r6TEDM9HIsL+qNSuqInDM8Byn/RMB07j1D2jGiAdT3lp7TV63gUMeOxOLhV6oXL
	 ejCAQCjHpfZ7qm8ixJbOUfFpEhxLZYl1NeLLdS//gad95s8ZuCse/uXlmQwtBA9keF
	 uLGJNzjeiCM8nnxpvENxCy4lHN26q+eYD6pRN8m+opVlke9bM2REmoC+jAJ3TwkkqI
	 xZ0j5gOmhdzzA==
Message-ID: <sashiko-outbox-193347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: 8250: restore FIFO in
 serial8250_console_restore()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuzheng Meng" <fuzheng.meng@semidrive.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102113114.2453899-1-fuzheng.meng@semidrive.com>
References: <20261102093609.2400381-1-fuzheng.meng@semidrive.com>
 <20261102113114.2453899-1-fuzheng.meng@semidrive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:42:56 +0000
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

commit 6d2b7c890ac68c261011475644811d6fe155a916
Author: Fuzheng Meng <fuzheng.meng@semidrive.com>

serial: 8250: restore FIFO in serial8250_console_restore()

This commit factors the FIFO write condition into a
serial8250_console_use_fifo() helper and uses it in
serial8250_console_restore() to reprogram UART_FCR when the UART loses power
during system sleep with console_suspend disabled.

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
As reported by Sashiko on v1 [1], should serial8250_console_restore() call =
the
existing serial8250_set_fcr() helper instead of writing UART_LCR and
open-coding the UART_FCR restore conditionally on
serial8250_console_use_fifo()?

In drivers/tty/serial/8250/8250_port.c, serial8250_set_divisor() leaves
UART_LCR_DLAB set in UART_LCR, and serial8250_set_fcr() handles both the
PORT_16750 ordering requirement and the two-step FCR write:

static void serial8250_set_fcr(struct uart_port *port, struct ktermios *ter=
mios)
{
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

By writing up->lcr to UART_LCR before writing UART_FCR in
serial8250_console_restore(), UART_LCR_DLAB is already cleared when UART_FCR
is written. On TI 16750 (PORT_16750) UARTs, writing UART_FCR with DLAB
cleared disables 64-byte FIFO mode (UART_FCR7_64BYTE), leaving the hardware=
 TX
FIFO in 16-byte mode while up->tx_loadsz remains 64 and
__serial8250_console_fifo_write() bursts up to 64 bytes per UART_LSR_THRE
wait, overflowing the 16-byte FIFO.

In addition, gating the UART_FCR write on serial8250_console_use_fifo(up)
skips restoring up->fcr after power loss when console burst-FIFO writes are
not used (for example when uart_console_hwflow_active(port) is true even
though UART_MCR_AFE is restored via up->mcr, when UART_CAP_MINI is set or
tx_loadsz is 1, or when TTY_PORT_INITIALIZED is not set such as on
8250_ingenic where ingenic_uart_serial_out() sets UART_FCR_UME on UART_FCR
writes), while serial8250_console_write() still clears up->canary =3D 0. If
device_may_wakeup() is enabled on the tty device, uart_resume_port() returns
early without calling set_termios(), leaving the hardware FIFO unprogrammed
for normal interrupt-driven TTY transmission in serial8250_tx_chars() as
well.

Also, the commit message mentions that writing UART_FCR_ENABLE_FIFO followed
by up->fcr matches dw8250_idle_exit(), whereas dw8250_idle_exit() in
drivers/tty/serial/8250/8250_dw.c only performs a single write:

	if (up->capabilities & UART_CAP_FIFO)
		serial_port_out(p, UART_FCR, up->fcr);

and it is serial8250_set_fcr() that performs the two-step write. Would call=
ing
serial8250_set_fcr(port, NULL) right after serial8250_set_divisor() in
serial8250_console_restore() avoid duplicating this logic and restore both
UART_LCR and UART_FCR across all port types?

[1] https://lore.kernel.org/r/20261102093609.2400381-1-fuzheng.meng@semidri=
ve.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102113114.2453=
899-1-fuzheng.meng@semidrive.com?part=3D1
