Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809690;
	b=vnMR7XqyqWhvZECDH4oyWNygbcGuKmUN/9RYHJzonEU8yRy1rL2ZePUVUqjy1c9V0Aps
	 JjVk1zWsL2ihyPM+AE/aBZ9nu2jUcYoIrO+u+XW9gr88g1SJ88Sq/QyGYsNKMYXJQBWEU
	 RtojL9S4au7Z9K9n+ts+aG5V+lZmhfOjwp8GB3uPEVlJn0b/eE5WelRUVFio2QgrdJtwE
	 GlroYWtCuBIUuzTHIyqhPOzeXyZ71UKuxpCQCUxRPnRVD50AZu3+q0j7azSAQzTrNYhtt
	 Z4krK4qJBo01ROVqE5sGR4OaA6CADnw3aYfuFgGRkECXhkwl3OGk02aqG/FtNSM2Rdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0uwutcWUOXjhi9mOhfWVRBIVxAJypJiaHVoSSXGrXrA=;
	b=X8KdJPNNEpZR4OEcqHFWnXSxSqvuWHkTl+gTXTOWxJd8/iE8h3y/7kIngPKcaiA4Qb/R
	 hIUl9rmp5GGbZLKVZ2YzhG1WgXsxIc8Xn1jNrslYEfb41hnCYvimJXVjwicGSO10cHsx8
	 cgSPKSestLo+r/2HdiM7PJlJZz4BUtLQhbpGTE+gCMkWs5aunfMhJGSxZbsnZAzft3sfa
	 ZL+xHQNdweQJlzCiZ4V5hJvEiz9IEysJMb72L9YTCSf+Swd+DNbMKZE8j4xYsZI94NP6d
	 f5uMQqOnpEKi79jBGZY6YguFu07Y/rBR0HkXI1vVJagERykQw5YOQBbscVuFsBam/aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlkpNh+z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079C606A336;
	Wed,  4 Nov 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlkpNh+z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADC61F00A18;
	Wed,  4 Nov 2026 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809689;
	bh=0uwutcWUOXjhi9mOhfWVRBIVxAJypJiaHVoSSXGrXrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mlkpNh+zTQEpWrbqTadXQW1MVQ4x/Ett9GW/Tkp52e1PSNgcgiVLj05008mS8sdRe
	 Ah/G4mPipsKcZH/Djkh8Wot5VvLzn8CebS4bxwPR3mG8FnGK/QcMcRsMbWCOGgrh3z
	 K1KtghPps7QXV6jPQbeFLqbRJDa9DSo2QkH62HsISTnKgUxmst1Vz/wNGdmcwyWgdF
	 p8YnDMBkoOuq8rp5H85mCMDj2/cOYTwSy9Co0RLDYiDM6//YL1AAnXDlmwKdTGjtJb
	 3MHPfUv2zVaVaDP9dje57yQhEVXtTRvp8a/pdoRXSycgzYEBtyDN/l4AoaOd8vnIYf
	 UJALjvba+Ql4Q==
Date: Wed, 4 Nov 2026 16:28:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Kohei Otsuka <kohei@spacemachines.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH 2/2] serial: 8250_of: drop RS-485 RTS on Microchip
 Core16550
Message-ID: <20261104-aqueduct-caregiver-1513775dd0f8@spud>
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
 <20261103-core16550-rs485-v1-2-6d15ebe1e5b9@spacemachines.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="naoNsQqpEmf8UReu"
Content-Disposition: inline
In-Reply-To: <20261103-core16550-rs485-v1-2-6d15ebe1e5b9@spacemachines.com>

--naoNsQqpEmf8UReu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 11:11:32AM +1100, Kohei Otsuka wrote:
> Core16550, a 16550-compatible UART for Microchip FPGAs, interrupts on
> THRE but not on TEMT. When the last character moves from the FIFO into
> the shift register, the THRE interrupt calls __stop_tx(), which finds
> TEMT clear and, without UART_CAP_NOTEMT, returns to wait for a TEMT
> interrupt that never comes. RTS, and with it the RS-485 driver enable,
> then stays asserted after the frame, and receive interrupts, disabled
> for the half-duplex transmission, stay off.
>=20
> Set UART_CAP_NOTEMT for nodes compatible with "microchip,core16550",
> so em485 drops RTS from its stop timer one frame time (plus 1/7) after
> THRE, as it does for DesignWare UARTs.
>=20
> Set UART_CAP_FIFO as well: with the capabilities already non-zero,
> serial8250_do_startup() no longer fills in the PORT_16550A default,
> and without UART_CAP_FIFO serial8250_clear_fifos() does nothing, so
> the RX FIFO is not flushed at the end of a half-duplex transmission.
>=20
> Link: https://github.com/linux4microchip/meta-mchp/issues/5

It's worth noting that in that GitHub link I pointed out that the time I
recall this core being used they required changes to the baud rate logic
in the driver and that there were differences between how the baud rate
is actually determined from the input clock:
| The docs for core16550 say:
|=20
| This block takes the input PCLK and divides it by a programmed value (fro=
m 1 to 216 =E2=80=93 1). The result
| is divided by 16 to create the transmission clock (BAUDOUT)
|=20
| whereas ns16550a docs say:
|=20
| The UART includes a programmable baud rate generator
| that is capable of dividing the timing reference clock input
| by divisors of 1 to (216-1 ), and producing a 16 x clock for
| driving the internal transmitter logic. Provisions are also included to u=
se this 16 x clock to drive the receiver logic.

Kohei reported not being affected by this, but I figured it was worth
mentioning.

Cheers,
Conor.

> Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
> ---
>  drivers/tty/serial/8250/8250_of.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/=
8250_of.c
> index b41ca604083f..2f1f505501a2 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -278,6 +278,15 @@ static int of_platform_serial_probe(struct platform_=
device *ofdev)
>  	if (port8250.port.fifosize)
>  		port8250.capabilities =3D UART_CAP_FIFO;
> =20
> +	/*
> +	 * Core16550 has no TEMT interrupt: without UART_CAP_NOTEMT the em485
> +	 * code waits for one after the last THRE interrupt and never drops RTS.
> +	 * Set UART_CAP_FIFO too, because a non-zero value stops
> +	 * serial8250_do_startup() filling in the PORT_16550A default.
> +	 */
> +	if (of_device_is_compatible(ofdev->dev.of_node, "microchip,core16550"))
> +		port8250.capabilities |=3D UART_CAP_FIFO | UART_CAP_NOTEMT;
> +
>  	/* Check for TX FIFO threshold & set tx_loadsz */
>  	if ((of_property_read_u32(ofdev->dev.of_node, "tx-threshold",
>  				  &tx_threshold) =3D=3D 0) &&
>=20
> --=20
> 2.53.0
>=20

--naoNsQqpEmf8UReu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCautdFQAKCRB4tDGHoIJi
0pYeAP9bzFHfeEOVzgCPalBVszyOeTqdZUtmuzJVLczvdHA/WwEAiVAoQZAfJtEY
hQc6VtUVhSHnO9bAJ9+2LFX/+FyRbgk=
=JBIx
-----END PGP SIGNATURE-----

--naoNsQqpEmf8UReu--
