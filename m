Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7F388390;
	Fri, 11 Sep 2026 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119685; cv=none; b=pLpOLjwGz+bnKaWt8Fam0qcZA1KeuGPftCZMjZ5XbJR2tKEiAVuM4MFazbDoTYaeVrKHSe+4RMW9XpSzYRJ220b7UjEKy/9RF3QnkqsqA4kQ59VocLXfQNnYs8QeBjDWPKDVkhla1YfcmJdhYiKGaxWlQpbW5B4UuTNnUn+BLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119685; c=relaxed/simple;
	bh=FeLQQDdl4G6lNidOgqRusTwmXPdHY3TiP21Pxf82dbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R/ZsaRj3C0NRjH/y/9wub5XTG53LaUWOxu3vOvsDTx39if8m9PG7tDWvJj6kgYESIuyOF+CF7AQhGmQcxIhbPBMe5PBMDAFWPRDJHksiPgidvnj66wPMsEDYnyJ2vlNylB3enIUlv+RSoXgQYH2wz0xi5OtWjdevTvzQkxkg03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2aO/NU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2aO/NU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913011F000FF;
	Fri, 11 Sep 2026 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119683;
	bh=KjzVaDYVg+QtYBvhx348szYv5nAarKYVoA2qyu7mHXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2aO/NU9wF45DN359iVvqAEsDPVHckFfe/K5g6MXNDji0BqUxmFYTirCqWTr4tqbl
	 8pR+blDvZqLCSy6RhpzHHabflECO0Jgsjf7jnnXtpPnESMdsivZMW2qLBnEgCqxfJn
	 Hntyr49prYejvuXu7p3KePFxUFwV94b384anl9TKo+rJV/WLj89siGjYoAb9KNJQ1Y
	 U9v/5wp4xNAMpSbXhNkMbXxG0CeGMWlI2ZAHaHY0DlZfHqrifio8vg0kGaq47BxwRY
	 eKFvxdsUkCVfH58N7LKrUwxxzkHuuF89MM7XhJNvxTkAeUfZztoYz7YoiXMICaF3Ak
	 N6BOKm9eY287A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_dw: Add ti,tda54-uart quirk to skip
 empty FIFO read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Moteen Shah" <m-shah@ti.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260911092529.306082-3-m-shah@ti.com>
References: <20260911092529.306082-1-m-shah@ti.com>
 <20260911092529.306082-3-m-shah@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:41:23 +0000
Message-Id: <20260911094123.913011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The quirk avoids reading an empty FIFO in the IRQ handler, but gen=
eric 8250 core code performs unconditional empty FIFO reads during port sta=
rtup and shutdown, which will still trigger a data abort on this hardware.

Pre-existing issues:
- [High] pm_runtime_enable() is called after serial port registration, viol=
ating callback timing rules.
--

commit 31fb31567ebe4c6e4b9eb7b2826e35722f3e46f5
Author: Moteen Shah <m-shah@ti.com>
serial: 8250_dw: Add ti,tda54-uart quirk to skip empty FIFO read

This commit adds a quirk to the 8250_dw driver for the ti,tda54-uart. The
quirk skips an empty FIFO read during an RX_TIMEOUT interrupt condition. Th=
is
is intended to avoid triggering a data abort on the TDA54 IP, which crashes
when reading an empty FIFO.

> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 51d026f20825a..f97cc3dfbab4a 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c

[ ... ]

> @@ -436,7 +437,7 @@ static int dw8250_handle_irq(struct uart_port *p)
>  	 * This problem has only been observed so far when not in DMA mode
>  	 * so we limit the workaround only to non-DMA mode.
>  	 */
> -	if (!up->dma && rx_timeout) {
> +	if (!(quirks & DW_UART_QUIRK_SKIP_RX_TIMEOUT_READ) && !up->dma && rx_ti=
meout) {

[Severity: High]
The quirk avoids reading an empty FIFO in the IRQ handler, but will this
fully protect the hardware from data aborts?

The generic 8250 core code performs unconditional empty FIFO reads during
port startup and shutdown. For example, serial8250_clear_interrupts()
unconditionally reads UART_RX, and serial8250_do_shutdown() does the same
immediately after clearing FIFOs.

Won't opening or closing the TTY device still trigger a data abort on the
TDA54 IP due to these core empty FIFO reads?

>  		status =3D serial_lsr_in(up);
> =20
>  		if (!(status & (UART_LSR_DR | UART_LSR_BI)))

[ ... ]

> @@ -888,6 +889,11 @@ static const struct dw8250_platform_data dw8250_ultr=
arisc_dp1000_data =3D {
>  	.quirks =3D DW_UART_QUIRK_CPR_VALUE,
>  };
> =20
> +static const struct dw8250_platform_data dw8250_tda54 =3D {
> +	.usr_reg =3D DW_UART_USR,
> +	.quirks =3D DW_UART_QUIRK_SKIP_RX_TIMEOUT_READ,
> +};
> +
>  static const struct of_device_id dw8250_of_match[] =3D {
>  	{ .compatible =3D "snps,dw-apb-uart", .data =3D &dw8250_dw_apb },
>  	{ .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_octeon_3=
860_data },
> @@ -895,6 +901,7 @@ static const struct of_device_id dw8250_of_match[] =
=3D {
>  	{ .compatible =3D "renesas,rzn1-uart", .data =3D &dw8250_renesas_rzn1_d=
ata },
>  	{ .compatible =3D "sophgo,sg2044-uart", .data =3D &dw8250_skip_set_rate=
_data },
>  	{ .compatible =3D "starfive,jh7100-uart", .data =3D &dw8250_skip_set_ra=
te_data },
> +	{ .compatible =3D "ti,tda54-uart", .data =3D &dw8250_tda54 },

[Severity: High]
This is a pre-existing issue, but does dw8250_probe() violate the runtime PM
callback timing rules, which could cause a boot deadlock when this new
compatible device is probed?

dw8250_probe() calls serial8250_register_8250_port(), which synchronously
invokes the dw8250_do_pm() callback. This happens before pm_runtime_enable()
is called at the end of the probe function:

drivers/tty/serial/8250/8250_dw.c:dw8250_probe() {
	...
	data->data.line =3D serial8250_register_8250_port(up);
	if (data->data.line < 0)
		return data->data.line;

	platform_set_drvdata(pdev, data);

	pm_runtime_enable(dev);
	...
}

Since dw8250_do_pm() uses pm_runtime_get_sync() before runtime PM is enable=
d,
could this cause a circular dependency and hung worker threads during device
registration?

>  	{ .compatible =3D "ultrarisc,dp1000-uart", .data =3D &dw8250_ultrarisc_=
dp1000_data },
>  	{ /* Sentinel */ }
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911092529.3060=
82-1-m-shah@ti.com?part=3D2
