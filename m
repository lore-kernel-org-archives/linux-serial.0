Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE339DBF7;
	Sat,  3 Oct 2026 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050178; cv=none; b=mihhuk0eM+ZHhduUmkMyWWtUJJpuckQafOiE5KLt7yW7kovLe7U+Vz5lrXr+Chjy2eos+NKEzaxJtNvFJRwxdPUl5noTMZabulkbXUT4l5S/7TrgC1A85Hss5PS9noVARQyKzyTrsKaA22l7B11r9vUkZ1sB9E+Z5wFAHQptb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050178; c=relaxed/simple;
	bh=Yh0S7crW3O0nxvXrBBYZIO0UTgeI4NX5DbmiBQEpf0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wvi7suxEzfVQOgrjzbM2mNXbdDoTugB+0GupGGsFpjZY4en01AfGurmpBd5iRES+mmX4EkmTynQ0idt/6dl+fUTtdfIDEyR2ja1MhEUi3sJKGuapF/Q6hpcZ9ktecHtFW+HW3ZYmVSsO+CrwChIP2zE+5MpR39C+HJZmH6l/BqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyz+0w1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyz+0w1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C0E1F0089E;
	Sat,  3 Oct 2026 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050177;
	bh=JjDDZO/D9EHraXMlfraMy9tKVss4FlDPoB4DeSvCAbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyz+0w1odpBXmY2TzAuXZ4YvAvMcuHid3PUQLQHzozUGVAnMSy+4PFQjW7x6Sy0x6
	 NiIhVNmA7Eov2jr1uVAkt7IYg5HZ9V7gJD8j6XHULnivRlgLPUmioYlUkeK/5ji4SJ
	 jAPQAa4H5NBbLuNyQhc/H0+6S4pMxgJxHsE69q6kqTiXA6RDUQ0hQGyRoXCGa7BC/J
	 tcMsex0zxtnvzA4v9y1ysnu9QACawUK6huAA99NzR43I4QT3T1Hsy93l0vDqqFT3iv
	 H6NVl4sZFGkynf1SZS+IZeiqS99hcDi+uiHWLYV2g7cktfNMU5PhDIivRDUN+xS8hl
	 t8bcQIm6RX05g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: fsl_lpuart: add support for GPIO-controlled
 modem lines
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm/Do28gTG91cmVpcm8=?= <joaofl@gmail.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-serial@vger.kernel.org
In-Reply-To: <20261003155022.466971-1-joaofl@gmail.com>
References: <20261003155022.466971-1-joaofl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:16 +0000
Message-Id: <20261003175617.59C0E1F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] tty: fsl_lpuart: native hardware flow control blocks TX with GPI=
O CTS
- [Medium] tty: fsl_lpuart: missing RTS GPIO toggle during RS-485 transmiss=
ion
- [Medium] tty: fsl_lpuart: modem status interrupts unconditionally enabled=
 on startup
--

commit 992ffb5df51e6a0dce4af1057b32c3465f75e984
Author: Jo=C3=A3o Loureiro <joaofl@gmail.com>

serial: fsl_lpuart: add support for GPIO-controlled modem lines

This commit adds support for GPIO-controlled modem lines (RTS/CTS) to the
LPUART driver by wiring it up to the serial_mctrl_gpio helpers. It aims to
support configurations where RTS is driven by software and answers on CTS,
or where RS-485 needs a GPIO RTS.

Link: https://lore.kernel.org/all/20260210-rearview-hungrily-536a95fc3385@t=
horsis.com/

> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c
> index c8575c9652035..909253aab2125 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c

[ ... ]

> @@ -1844,6 +1863,8 @@ static int lpuart_startup(struct uart_port *port)
>  	lpuart_request_dma(sport);
>  	lpuart_hw_setup(sport);
> =20
> +	mctrl_gpio_enable_ms(sport->gpios);
> +
>  	return 0;
>  }

[Severity: Medium]
Does unconditionally enabling modem status interrupts here defeat the serial
core's demand-driven .enable_ms callback design?=20

This will permanently enable GPIO interrupts whenever the port is open,
which introduces unnecessary interrupt overhead.

[ ... ]

> @@ -2912,6 +2939,10 @@ static int lpuart_probe(struct platform_device *pd=
ev)
>  		sport->port.rs485_config =3D lpuart_config_rs485;
>  	sport->port.rs485_supported =3D lpuart_rs485_supported;
> =20
> +	sport->gpios =3D mctrl_gpio_init(&sport->port, 0);
> +	if (IS_ERR(sport->gpios))
> +		return PTR_ERR(sport->gpios);
> +

[Severity: Medium]
When setting up GPIO-controlled modem lines, what happens when hardware flow
control is enabled via standard userspace termios configuration?

Looking at lpuart_set_termios():

	if (termios->c_cflag & CRTSCTS)
		modem |=3D UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;

And lpuart32_set_termios():

	if (termios->c_cflag & CRTSCTS)
		modem |=3D UARTMODIR_RXRTSE | UARTMODIR_TXCTSE;

If cts-gpios is being used, native hardware flow control is erroneously
enabled without checking if the CTS/RTS lines are being driven by the GPIO
framework.=20

This causes the LPUART hardware to block transmission waiting for the
physical CTS pin, ignoring the newly added GPIO CTS line.

[Severity: Medium]
Additionally, when using RS-485 mode with a board using rts-gpios, does this
implementation miss toggling the RTS GPIO during transmission?

Looking at lpuart_config_rs485(), it only enables the hardware's auto-RTS
feature on the dedicated physical RTS pin, which has no effect on the GPIO
RTS:

		modem |=3D UARTMODEM_TXRTSE;

		/*
		 * The hardware defaults to RTS logic HIGH while transfer.
		 * Switch polarity in case RTS shall be logic HIGH
		 * after transfer.
		 */
		if (rs485->flags & SER_RS485_RTS_ON_SEND)
			modem |=3D UARTMODEM_TXRTSPOL;

Then when starting TX in lpuart_start_tx():

	if (sport->lpuart_dma_tx_use) {
		if (!lpuart_stopped_or_empty(port))
			lpuart_dma_tx(sport);
	} else {
		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
			lpuart_transmit_buffer(sport);
	}

And similarly in lpuart32_start_tx():

	if (sport->lpuart_dma_tx_use) {
		if (!lpuart_stopped_or_empty(port))
			lpuart_dma_tx(sport);
	} else {
		ctrl =3D lpuart32_read(port, UARTCTRL);
		lpuart32_write(port, ctrl | UARTCTRL_TIE, UARTCTRL);
	}

Because the driver relies exclusively on the native UARTMODIR_TXRTSE
auto-RTS feature and fails to invoke mctrl_gpio_set(), the GPIO pin is never
toggled and RS-485 transmission over an RTS GPIO fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003155022.4669=
71-1-joaofl@gmail.com?part=3D1
