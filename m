Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11534BA4A;
	Wed, 17 Sep 2025 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137329; cv=none; b=A/BnIMo+GdS6PtnD4LAtEHCxKIG8vZfr3B9IdwS77SEIDb6jQeNB26YCJVZMxKQw/bW7qOLz6Ec/AAgnohTL3FmE6px+i2dX97emOgitUfj4Xeoo3yx0zJjcyxyBmmbbe8ihztxkKC0cpps3om0/h257o0lhM/uNRW2qpLWYMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137329; c=relaxed/simple;
	bh=bO+Rdo09ZmQqxDbXVAQNLU9C/l6SM21oUy6Mt1G5icQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7OtDr6B4/Xol0+vIfvqX9tXda1xl/gK46rtbH6vr0YvzTq73OBBx0Zzas9xTonKu2xAjv1Kh9iWP3k/9lX0Srp9pmJ1HH2QJY/u47Qmr4cnja9flQ4Skv6MJE8PsNEgU5TWme2w/GQWXa2ppEojqA9EX+QrRo+2JL4rkUHu9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOdwcCrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOdwcCrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCD6C4CEE7;
	Wed, 17 Sep 2025 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137329;
	bh=bO+Rdo09ZmQqxDbXVAQNLU9C/l6SM21oUy6Mt1G5icQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOdwcCrEW4gyFi855frrHUzdOFYjt+aqN9VsgRrHV2d6Acg1N3L3r5kcg0jBgHCEM
	 N6oz0z559RnY00+iQ7Ec8Nc54TNAU7zKGmS/hzhg1FrjBIJuUzVReeaG4ddsYJw+u2
	 UOm3M4LqsrAtu7sQdfOblElgFvvxCZFW5eeg5zeSgHqLYuH6wgU+rTeyOOT/koE8mf
	 nsQORkzfGfMruWEQv1RU9qO9PYu50UEJjKQzUqMhaFokK2GnGX1XQOQ31yD0t/e0LE
	 RcQc2WG7+bCJkQdNI4/S2JVDyBPZBNDv4PzUJN3NH14IoRO2LNPTw1gEJluViPLFFr
	 2wmyRyW3h+qWQ==
Date: Wed, 17 Sep 2025 20:28:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Ravi Patel <ravi.patel@samsung.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, ksk4725@coasia.com, pjsin865@coasia.com,
	gwk1013@coasia.com, bread@coasia.com, jspark@coasia.com,
	limjh0823@coasia.com, lightwise@coasia.com, hgkim05@coasia.com,
	mingyoungbo@coasia.com, smn1196@coasia.com, shradha.t@samsung.com,
	swathi.ks@samsung.com, kenkim@coasia.com
Subject: Re: [PATCH] dt-bindings: serial: samsung: Add compatible for
 ARTPEC-9 SoC
Message-ID: <20250917-tweezers-selective-15358e9b4a4d@spud>
References: <CGME20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb@epcas5p3.samsung.com>
 <20250917071342.5637-1-ravi.patel@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="migAs+wAbCopZcHg"
Content-Disposition: inline
In-Reply-To: <20250917071342.5637-1-ravi.patel@samsung.com>


--migAs+wAbCopZcHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:43:42PM +0530, Ravi Patel wrote:
> Add Axis ARTPEC-9 uart compatible to the bindings documentation.
> It is similar to the older samsung,exynos8895-uart design.
>=20
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b=
/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 1a1f991d5364..3895049c954c 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -48,6 +48,7 @@ properties:
>            - const: samsung,exynos850-uart
>        - items:
>            - enum:
> +              - axis,artpec9-uart
>                - samsung,exynos7870-uart
>            - const: samsung,exynos8895-uart

> @@ -168,6 +169,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - axis,artpec9-uart

This hunk is not needed, any compatible property that contains artpec9 must
contain exynos8895.

>                - google,gs101-uart
>                - samsung,exynos8895-uart
>      then:
> --
> 2.17.1
>=20

--migAs+wAbCopZcHg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsL6gAKCRB4tDGHoIJi
0qsFAQC7dQTZb+AhWTKjbK8mk/SWMn2c0Vxzq6RxdIFWcDmOogEAsW8Xl2ySct4Q
S2pOZoK6WnXIQwvnjFU50iM6+fM/jgk=
=hHNy
-----END PGP SIGNATURE-----

--migAs+wAbCopZcHg--
