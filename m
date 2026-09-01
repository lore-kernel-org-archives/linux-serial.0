Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC630649C
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 04:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236608; cv=none; b=C5y0JMjSQtBQrZ6qpBfSqvNhTUwgeMgnnyDA/5ruCrGVzGc3kTmGa67dUt88ymVIylfPJ7qiTPKZ5FmP5VCLjLvgJF2W2fv0Jw0A0MHeeKiz1Z9CmVCayFjuyec9V4X555dZAaSOj6mqVQ5texyuaKbYocVnxQxz0pFZdAb0F/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236608; c=relaxed/simple;
	bh=GAwLTzjsHn28heXhVUT/K4jVBJxEGpjXcRPDYUmlMaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQozu/0IBzJcgNb+JDGIzGtQ7D+rUoX8m/x0cRhU+pwdNnMBWuGH5tz23M0VRuMLTOgAXWtmfX37B0AMuDZMe+3HdQ3ttBZUccqhpWW3OizujbmzWSQhkf7aXoeWk1BgUDvPE8CmgXNs2LUBCtPXqLK6pGYkVFshbWwztvhRpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DErk1tzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DErk1tzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AE41F000E9;
	Tue,  1 Sep 2026 04:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788236607;
	bh=OshdhF8TT6tRKGJvttTpFfRIoBsXy9zHPXimF+OdRkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DErk1tzHL06yGrHvEts03JLT9hWTeKjn1Ni6yXB5AhcocOPr3P5xsqy6z4f1yIIDp
	 J6xs2ji5veSUqw+RHOlvEJxAuNEV/TPfdeDkgomRj32wHzDSMzqv1N/ExyGE3P+0pf
	 omjcZGBoudG/oWrcPCIyL9mo/fLEoT0f/n6NGkp8cfGU13A8/twZK61GuS9PL0N4Si
	 iehzMvOcQTSMPFmvK0AIwgVVvkkA/m4QspDnPenGsZmjIg28b8GF2NuAr9UBk8Uf9E
	 W9mc/KYjhsxpF46Av2bw429WlyH9HegUOUHWq8iw+SdtNX9a9jDclI2nzVOIDxVHyg
	 ZGPjzCsEqIcoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] serial: 8250_mxpcie: take the line settings from
 the new termios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260901041519.114737-4-lilinmao@kylinos.cn>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
 <20260901041519.114737-4-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:23:26 +0000
Message-Id: <20260901042326.F3AE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware registers and port status are modified without holding th=
e port lock or a Runtime PM reference.
--

commit cc8d50f2957c7d540f5a4840cf6ed31ccd1bed47
Author: Linmao Li <lilinmao@kylinos.cn>

serial: 8250_mxpcie: take the line settings from the new termios

mxpcie8250_set_termios() reads the line settings out of port->state->port.t=
ty,
which is only set once the port has been opened. This commit fixes a NULL
dereference during console setup or kgdboc attach by reading the settings
from the termios the serial core passes in instead.

> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8=
250/8250_mxpcie.c
> index ef2516ec16da0..19f1f51eec477 100644
> --- a/drivers/tty/serial/8250/8250_mxpcie.c
> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
> @@ -218,8 +218,6 @@ static void mxpcie8250_set_termios(struct uart_port *=
port,
>  				   const struct ktermios *old)
>  {
>  	struct uart_8250_port *up =3D up_to_u8250p(port);
> -	struct tty_struct *tty =3D port->state->port.tty;
> -	unsigned int cflag =3D tty->termios.c_cflag;
>  	u8 efr, val;
> =20
>  	serial8250_do_set_termios(port, new, old);
> @@ -229,23 +227,25 @@ static void mxpcie8250_set_termios(struct uart_port=
 *port,
>  	efr =3D serial_in(up, MOXA_PUART_EFR);

[Severity: High]
This is a pre-existing issue, but is it safe to modify the port status and
access hardware registers here after serial8250_do_set_termios() has
already released the port lock and runtime PM reference?

Modifying up->port.status in mxpcie8250_set_termios() without holding the
port lock creates a data race that can corrupt flow control flags
(e.g., UPSTAT_AUTOCTS). This directly violates the locking contract
documented in include/linux/serial_core.h.

Furthermore, accessing UART hardware registers via serial_in() and
serial_out() without a port lock or a Runtime PM reference can lead to
concurrent register access races with IRQ handlers, or bus faults if the
device enters a suspended state. This sequence occurs every time
mxpcie8250_set_termios() is called, for instance when userspace calls
tcsetattr to change flow control on the TTY device.

>  	efr &=3D ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
> =20
> -	if (cflag & CRTSCTS) {
> +	if (new->c_cflag & CRTSCTS) {
>  		efr |=3D (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
>  		up->port.status |=3D (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901041519.1147=
37-1-lilinmao@kylinos.cn?part=3D3
