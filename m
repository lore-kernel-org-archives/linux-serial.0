Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809210;
	b=ONOLCi4je+5vUB7b4FjJHBOCjVv9bNYf4io3BWLhPUizWr99+/IAIZ+ccbuHF7ls7FkD
	 4+HNVw7vwaf0eoJ78go6IAPgvRkvX/US6o/Jfusx7HqINiG9QfABs36p+gZDB8RNJyGA4
	 q/+wietvidrwEKi04oOuYeln1kidUeETKA94Ej9qnWKmT1OgSaT1C/ZUEsdc7KChB57PV
	 ioK+9Kqk5CO3ekR0LyOywhBgHOEbJonWY+bZsW63eNfcoO59RI4OoHRI9CwWv0U7SebxH
	 RrT0BtzHb2FYCxriWotYxgvnHay319VL+FWTMr1w6I8MKA6oBLZa359tyf+sZgCWNCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809210;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pjFn7Y3OC+D5gDYL7AOGzIF/B+0rHfG3IC6MlKA6Dpw=;
	b=vSWk4YKXtX3KI6o4ayAR+IN188U+h+rI4HXcUrNJ93LTRb5wPFDyHO5+Qep/tNyCc0jN
	 U/Z4AAoQyT0C8gLfMOv4SNPbVKTOj0PmjqHlxaxyTia6OQ4Ydk+VV/VA/Nf2zWvQYPRJL
	 qk8WlAYwE0iIgiTFqHqpSj4r7uI6hTbWBJ48UDUAjsh3z98OviiXVYYio8EWldoJ/hyor
	 zoH9LXOgIWqIMVgzQv3OnFaFA621dcHwJycqR4i1wKeNXN2fomy70y6xKddtyyH1Cosu6
	 XbB4nZCztTPExcEYYNP9uIQbdsrCuMuT5hLcYs7nsO8RY3hsy0XqUAkbfCP1BJzA7dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gd2sBo1z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8D606A329;
	Wed,  4 Nov 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gd2sBo1z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3485B1F000C1;
	Wed,  4 Nov 2026 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809209;
	bh=pjFn7Y3OC+D5gDYL7AOGzIF/B+0rHfG3IC6MlKA6Dpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gd2sBo1zjahjCh7eQHoPAalz/DGoiFeVygcECsHvD3ifKbD2lEZSekCHWyfTmPJWu
	 JNwY9+bwuxJwr7wh24R7z1tTEznV1UggkD0b2519IJ1+Lx0jwYWFTjiBnNIN0z6p+z
	 yonimCq04f417zwqthfYmVvyg1/EdilUfXIkyag9ih4ntTPqHlRLThSHrLEZnQWwXQ
	 GJbUVGZcPWuqOID+4phrkSxZYIqerJ8flIdbhN1Gd5t2xOObG0YyrQdevcCXCKhEIx
	 IoluWwmi7Bn/fMYZUNwbUx24PmO9SFFRLHFWB/ZIUu0WwuF+Bm0HAVYAZYY8T0djAI
	 vm02tBNmUNQww==
Date: Wed, 4 Nov 2026 16:20:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Kohei Otsuka <kohei@spacemachines.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: add Microchip Core16550
Message-ID: <20261104-zen-aloha-35da49a7e72c@spud>
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
 <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com>
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
	protocol="application/pgp-signature"; boundary="/YK4gQNoKzn69mov"
Content-Disposition: inline
In-Reply-To: <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com>

--/YK4gQNoKzn69mov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 11:11:31AM +1100, Kohei Otsuka wrote:
> Core16550 is a 16550-compatible UART soft IP core for Microchip FPGAs,
> including the fabric of PolarFire SoC. Its registers follow the 16550A,
> so ns16550a stays the fallback, but

> it raises no interrupt on TEMT,
> which the driver has to know about to support RS-485 on it.

Doesn't this exclude using the fallback to ns16550a, since it requires
specific interrupt handling?

>=20
> Add microchip,core16550 with ns16550a as the fallback.
>=20
> Link: https://github.com/linux4microchip/meta-mchp/issues/5
> Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index 50d5c977afa3..33a5929bdaa6 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -137,6 +137,7 @@ properties:
>                - ti,da830-uart
>                - loongson,ls2k0500-uart
>                - loongson,ls2k1500-uart
> +              - microchip,core16550

This needs a -rtl-vX suffix on the end, as is used for other fabric
cores - see microchip,corei2c.yaml for an example.

pw-bot: changes-requested

Thanks,
Conor.

>            - const: ns16550a
>        - items:
>            - enum:
>=20
> --=20
> 2.53.0
>=20

--/YK4gQNoKzn69mov
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCautbLwAKCRB4tDGHoIJi
0hEzAP9yRmEhtlbVR6cyvMk5PogsOPk+0H5ZoPenSwG3LA95mQD+P3B2Wjyav1c0
ZUWJtuzMvs7EkProyzmI9Y8M6PDHPQI=
=WvVS
-----END PGP SIGNATURE-----

--/YK4gQNoKzn69mov--
