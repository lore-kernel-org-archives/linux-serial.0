Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395830B53C;
	Thu, 21 May 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382142; cv=none; b=gLbWO0lO/uk5E9vTUeKLs0O3ygMZ9TQ5WOok2Ry1wGSvOgXzBrk0OCeIrXA6OUYGfGmoLWL6K+83ZC5qaPxBUwtA0FHVYqZl+EKeQp6C9/OgojO3lBQr2JY/VjxtqsQYqCRKnNCKHwILh2EqZliTsjQwvmG6aZXNlqBKYgMMQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382142; c=relaxed/simple;
	bh=DVFvk9aAUJ7j9VYz4u9t48egEPUZJ0k0RU7un6BH5Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feysJmW1u5/SxwsvmK2ONjal8p8edvxkVxG5Y5ZXDrbJQmX+3oQ31XZGcf9lEXEdeJ8XBY4nPATiOtRIjF06lAM6V8i4U8voJj4OH7bj75U046iIQi0kJBThJ9dfy630aFxyuXevoppFgF1/L4zHvGSVwed2Hxp0T6SrkM/UoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m51NEWIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m51NEWIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9290E1F000E9;
	Thu, 21 May 2026 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779382141;
	bh=TK/PmbG7Gqeh7gUNbHnh10+sGFRgBRtv46SR1if5nuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m51NEWIL+tOUNeE+GB8C7iAZOPUWYhpqA17s1dsrGddvfwNHzXYbSHF26GdLcOMtG
	 VseAJnoOke5WQ8uGGsQORSVoYUEXGi96Y4IYESbRN2v/dvUGx4ZIMLyBMeoidkshur
	 Pev3FwbXMbEe8gXa0pMlz2rWn/seIcF37pB8gaQtobLknEhnIC0lWWFqFmaPvuz/6a
	 fUUOj1PWzSiY2A4xSabMSnVRnUhYxBtoDhkSwF5R5sBbwNJqcOVHHyzCMZmuEDNB7d
	 2nKiyMfEHji6Rj6kJ3SQi7fWmALb6a9UgoYpDGeLnlTAEsMFiXy8kXy/hTZ4lDBO6H
	 Usd57Vl0rlqVA==
Date: Thu, 21 May 2026 17:48:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: krzk+dt@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: rs485: remove deprecated .txt
 binding stub
Message-ID: <20260521-ragged-ultra-9970fd9e8495@spud>
References: <20260521162137.6325-1-akash.sukhavasi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9T5GZpc4FKRZfLvC"
Content-Disposition: inline
In-Reply-To: <20260521162137.6325-1-akash.sukhavasi@gmail.com>


--9T5GZpc4FKRZfLvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:21:35AM -0500, Akash Sukhavasi wrote:
> The plain text binding file was superseded by the YAML schema in
> commit d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings
> to json-schema"). The file now contains only a redirect notice.
> Remove it, and update references in serial_core.c and
> serial-rs485.rst to point to the YAML schema.
>=20
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>

Unless I am missing something about how docs.kernel.org redirects
magically work or something along those lines,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Cheers,
Conor.

> ---
> Changes in v2:
> - Update references in serial_core.c and serial-rs485.rst to point
>   to rs485.yaml (Sashiko review).
>=20
> v1: https://lore.kernel.org/all/20260521150748.4816-1-akash.sukhavasi@gma=
il.com/
>=20
>  Documentation/devicetree/bindings/serial/rs485.txt | 1 -
>  Documentation/driver-api/serial/serial-rs485.rst   | 2 +-
>  drivers/tty/serial/serial_core.c                   | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/rs485.txt
>=20
> diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documen=
tation/devicetree/bindings/serial/rs485.txt
> deleted file mode 100644
> index a7fe93efc..000000000
> --- a/Documentation/devicetree/bindings/serial/rs485.txt
> +++ /dev/null
> @@ -1 +0,0 @@
> -See rs485.yaml
> diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documenta=
tion/driver-api/serial/serial-rs485.rst
> index dce061ef7..f53043d21 100644
> --- a/Documentation/driver-api/serial/serial-rs485.rst
> +++ b/Documentation/driver-api/serial/serial-rs485.rst
> @@ -132,4 +132,4 @@ RS485 Serial Communications
>  6. References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -.. [#DT-bindings]	Documentation/devicetree/bindings/serial/rs485.txt
> +.. [#DT-bindings]	Documentation/devicetree/bindings/serial/rs485.yaml
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 89cebdd27..df4589880 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3496,7 +3496,7 @@ EXPORT_SYMBOL_GPL(uart_try_toggle_sysrq);
>   * @port: uart device's target port
>   *
>   * This function implements the device tree binding described in
> - * Documentation/devicetree/bindings/serial/rs485.txt.
> + * Documentation/devicetree/bindings/serial/rs485.yaml.
>   */
>  int uart_get_rs485_mode(struct uart_port *port)
>  {
> --=20
> 2.54.0
>=20

--9T5GZpc4FKRZfLvC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag83eAAKCRB4tDGHoIJi
0qRwAP45vGLSukw/aHHHypp+5Z43TSGFtTTuBAmqeT+0a7PMjwEAx/dYKdq/xZbK
TB9BIBcIOG64v/rGq0jOuhsi2EfzJwQ=
=gmIc
-----END PGP SIGNATURE-----

--9T5GZpc4FKRZfLvC--
