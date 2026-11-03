Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744622;
	b=yDtKyTEDKlYLDibLSmRlptnWaa4HfSVXYwCB5sI4/dXywzBut793uzN3fVBGVHU8D/8F
	 hYz/9oycYt6GYa0U68rt9pexmKl8hldm9cwy+J45hgbbhEQfUpMYp0C1VXPTFoYrjsZcg
	 3xZYHUYA/FO5IMWjZrFkIzmv+aygFNayV7DDNLwsvzjev7HvJAvx/iQ+5ftsduXgk/nrT
	 2ewz/XM+rvXhKMIWWUUxG0phigcsb/030fGxEmaXBxGfetiU2goO7V9zcO7dBjpnhcUAY
	 fCJB7uioySH6uj1I2rgSPgzrH8Kaz7cAAHiujZS5wyyZ0cHpS/urFEYvJYoQTd8GbAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744622;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qa1wzE1kZAxTS+6dzP+AXd2e6bJRsw99UOqzgu8gHJg=;
	b=0s5JA2ldlM/etx142ICjAc8Dbp60Ey3L1XRdTK/0Pv7DLORC1njPloD0AfAOQ7KW/0vC
	 Wt7ys3TKcuX6bBrZkJaMDxs8ufva8XzOMNXMMldMXlJgXh9+DlnxKK5B3EgDPXlaPOByH
	 W7P9TpCGuo8zprCGOqdeTkn1S9TrOXk7g5GzqsL1aXC3fUT19R96X2mwdKdel/tQL8YYH
	 bHZcl5KAJJ5dPv7dBZ5gAqV363Yli+U5oieCUYsbCWA5ZEgvkZMwIyBCSZ8EQXLoY6eyN
	 K6RHfjDfiBRRzXtMtxGCDRLoJpQJdOee9AWKedQhP+rrzE+VNG5FCHecRQI+oV+pGkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZ5mkujz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54165606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZ5mkujz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44391F00919;
	Tue,  3 Nov 2026 22:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793744621;
	bh=Qa1wzE1kZAxTS+6dzP+AXd2e6bJRsw99UOqzgu8gHJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OZ5mkujzw933X+CfTiuv+1fH0x/z8Vk3he8Z3fiOXp4HBZkNkPhNkxw74GkCnz7OE
	 91TOfJeZIAW0TgzpC8wdBoGUZEILpStYBpk39hiOhRQ8pHxj+vTCOeZK5wv7rQAiS0
	 fCVjFbm/KcmLzLSeebUpsUvMp1hJhMG1ZhZzvLmYs3yGoq2dPaEqExRPzD/+t8/3qh
	 W1h6A+mTDK92j+lm0c9dX0Hhfas8FplqQlPRiWadIMEGmGpWqOu/32ydHiXEOHnXoZ
	 GfQPhYW5NyvRhrSBD1pBlkHy5r2BRi3YO54udOEAHJA08WxMFmL9csG2OapWU8j5/Y
	 jds+WEIFKuQMg==
Message-ID: <sashiko-outbox-196103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] serial: core: Unify uart_get_baud_rate() success
 return paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2611032029130.15685@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
 <alpine.DEB.2.21.2611032029130.15685@angie.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:23:41 +0000
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
- [High] serial: core: B0 fallback in uart_get_baud_rate() clobbers termios
--

commit b1a1a662c408c018aa01ee6285ba7172be487d43
Author: Maciej W. Rozycki <macro@orcam.me.uk>

serial: core: Unify uart_get_baud_rate() success return paths

This commit merges the B0 return path in uart_get_baud_rate() with the
regular range-checked return path in preparation for adding extra return
actions.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index b06d2649be343..012f22cf3a60e 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -519,7 +519,7 @@ uart_get_baud_rate(struct uart_port *port, struct kte=
rmios *termios,
>  		 * Special case: B0 rate.
>  		 */
>  		if (baud =3D=3D 0)
> -			return max(min, 9600);
> +			baud =3D max(min, 9600);
> =20
>  		if (baud >=3D min && baud <=3D max)
>  			return baud;

[Severity: High]
Can this break B0 hangup and trigger a division by zero when max is less
than max(min, 9600)?

Commit 091ea8e5d34e ("serial: core: prevent division by zero by always
returning non-zero baud rate") removed the hung_up guard from the
out-of-range fallback path in uart_get_baud_rate() because baud =3D=3D 0
returned max(min, 9600) immediately before reaching the range check. With
this change, B0 is subject to the baud <=3D max check, and if that fails it
falls through into the termios-mutating fallback path:

drivers/tty/serial/serial_core.c:uart_get_baud_rate() {
	...
		if (baud =3D=3D 0)
			baud =3D max(min, 9600);

		if (baud >=3D min && baud <=3D max)
			return baud;

		termios->c_cflag &=3D ~CBAUD;
		if (old) {
			baud =3D tty_termios_baud_rate(old);
			tty_termios_encode_baud_rate(termios, baud, baud);
			old =3D NULL;
			continue;
		}
	...
}

Several in-tree callers can pass max < max(min, 9600) to
uart_get_baud_rate():

1. In drivers/tty/serial/mvebu-uart.c, mvebu_uart_probe() allows
   port->uartclk to remain 0 on non-extended UART0 ports when no DT clock
   is present, and mvebu_uart_set_termios() then passes min_baud =3D 0 and
   max_baud =3D 0:

   drivers/tty/serial/mvebu-uart.c:mvebu_uart_set_termios() {
	...
	min_baud =3D DIV_ROUND_UP(port->uartclk, BRDV_BAUD_MAX *
				OSAMP_MAX_DIVISOR);
	max_baud =3D port->uartclk / 80;

	baud =3D uart_get_baud_rate(port, termios, old, min_baud, max_baud);
	...
   }

2. When the UART clock is parented to a 32.768 kHz LSE oscillator,
   stm32_usart_set_termios() in drivers/tty/serial/stm32-usart.c passes
   max =3D uart_clk / 8 (4096), and lpuart_set_termios() /
   lpuart32_set_termios() in drivers/tty/serial/fsl_lpuart.c pass
   max =3D port->uartclk / 16 (2048) or port->uartclk / 4 (8192):

   drivers/tty/serial/stm32-usart.c:stm32_usart_set_termios() {
	...
	uart_clk =3D clk_get_rate(stm32_port->clk);

	baud =3D uart_get_baud_rate(port, termios, old, 0, uart_clk / 8);
	...
   }

3. In drivers/tty/serial/serial_core.c, uart_set_info() checks
   new_info->baud_base < 9600 as a signed int before computing
   uport->uartclk =3D new_info->baud_base * 16 as a 32-bit unsigned int,
   which can wrap to a small non-zero value (for example, 16 when
   baud_base is 0x10000001) and yield max =3D 1 in
   serial8250_get_baud_rate().

When max < max(min, 9600) and userspace requests B0:

- If old has a non-zero baud rate within [min, max], the first iteration
  clears CBAUD and encodes old's speed into termios. Because B0 is
  overwritten in termios->c_cflag, uart_set_termios() no longer sees a
  transition to B0 and fails to drop TIOCM_RTS and TIOCM_DTR:

  drivers/tty/serial/serial_core.c:uart_set_termios() {
	...
	/* Handle transition to B0 status */
	if (((old_termios->c_cflag & CBAUD) !=3D B0) && ((cflag & CBAUD) =3D=3D B0=
))
		uart_clear_mctrl(uport, TIOCM_RTS | TIOCM_DTR);
	...
  }

- If old is also B0 (or when max =3D=3D 0 in mvebu_uart_set_termios()), both
  loop iterations fail the baud <=3D max check, clobber termios with
  max - 1, trigger WARN_ON(1), and return 0. Callers such as
  stm32_usart_set_termios(), lpuart_set_termios(), and
  serial8250_do_set_termios() then pass baud =3D 0 to divisor calculations
  and uart_update_timeout(), resulting in a division by zero.

Note that the follow-up commit "serial: core: Don't clobber the baud rate
on hangup via B0" changes the B0 assignment to:

	baud =3D port->hup_speed ? port->hup_speed : max(min, 9600);

which still fails the baud <=3D max check whenever port->hup_speed is 0
(such as before any valid speed has been saved, or when max =3D=3D 0) or wh=
en
port->hup_speed exceeds a reduced max.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/alpine.DEB.2.21.261=
1030057510.15685@angie.orcam.me.uk?part=3D1
