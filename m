Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BA48CD7B;
	Tue,  1 Sep 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285106; cv=none; b=gsllYtdkEl2/BPncxhRK+2UGki2uk4NhvJWZci2e5RVO738T0ZLpwV7aqs4VowKGkIVGvBDOdtNgMbS3i9F4QW6Muha/HtHaJBqafurHU47U0p9oJfhMdN3hf0NJAVg5j2/1lTJKPuELq66ZmEgRuM1pySpNm83AIvyFlXTw/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285106; c=relaxed/simple;
	bh=mk6ZlwMR8I8JyL7P8y24/m1gn7Yiaio7RVEkXCR57rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzjyWXsPo+Ydr2LR81WqHJtXaI4ymWVz34EJvdFUhsAUkFNJUyf/OxnJrjxRMypZfki4NrHRKhYWYYWd6rB0Mze2A7/zwgTep4Bo60RDyUzm/z+X4eg8ku5sP8gb4j+IC+266QtY+pDw0ZV6jcyeu84w0bv2TuqMYepGBc8wOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn8bwCGu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn8bwCGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA0D1F000E9;
	Tue,  1 Sep 2026 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285105;
	bh=oMqnx0cSzXOgUG5/dEgx7SkbOHcdfGj04WjrZWYxDLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hn8bwCGucDycl0BIqxDSdg7l3vg6KOJ6Bi3OP2ujwXRz9PDh+bcCNiRUGXjrpmi2n
	 XiEQqNzo8nlua7UFs2rzUHELLbSwWQ/hiluVidrF1lKN7/mnsHu4qH3+ls2QuDgnBP
	 3mB2oRPdCnAkrm8AMspnR1R4gSQkGteCYLfJx2zHngjuz9KXMKkcRjE/k8ZN1IhzbQ
	 7QPiPnLNK+dW1XaYAP8xkejwceAyw3zDh0LgmbkcH1h54841LBIXv+1sZfFMqC6K2Y
	 SYkrrJ2N1ceK3szY0HEPitv8PGQyqNhEKUrgrtS311UstKR7USUkJJMtmO9CoMov1W
	 mvwAzRjNKJ2MQ==
Date: Tue, 1 Sep 2026 18:51:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	in file <devicetree@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: 8250: add marvell,armada-38x-uart
 compatible
Message-ID: <20260901-corrode-unvented-4cf271941722@spud>
References: <20260901004203.49686-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SToglXmfLL+RKNIv"
Content-Disposition: inline
In-Reply-To: <20260901004203.49686-1-rosenp@gmail.com>

--SToglXmfLL+RKNIv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 05:42:03PM -0700, Rosen Penev wrote:
> The Armada 38x and 98DX3236 SoCs use this compatible, either paired
> with "ns16550a" (armada-38x.dtsi) or on its own
> (armada-xp-98dx3236.dtsi). Neither form is covered by the 8250
> binding, so dtbs_check reports:
>=20
>   serial@12000: failed to match any schema with compatible:
>   ['marvell,armada-38x-uart', 'ns16550a']
>=20
> Add a standalone const entry and a two-string variant paired with
> "ns16550a".

Only one of these is correct, add one and fix the users.
Given there's match data, it's probably the standalone one.

pw-bot: changes-requested

Thanks,
Conor.

>=20
> Validated with make dt_binding_check (8250.yaml) and dt-validate on
> armada-38x and armada-xp 98DX3236 boards: the UART schema errors are
> gone.
>=20
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index 8c2c177faf89..f71c6afe02f2 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -109,6 +109,7 @@ properties:
>        - const: aspeed,ast2500-vuart
>        - const: intel,xscale-uart
>        - const: mrvl,pxa-uart
> +      - const: marvell,armada-38x-uart
>        - const: nuvoton,wpcm450-uart
>        - const: nuvoton,npcm750-uart
>        - const: nvidia,tegra20-uart
> @@ -119,6 +120,9 @@ properties:
>                - exar,xr16l2551
>                - exar,xr16l2550
>            - const: ns8250
> +      - items:
> +          - const: marvell,armada-38x-uart
> +          - const: ns16550a
>        - items:
>            - enum:
>                - altr,16550-FIFO32
> --=20
> 2.55.0
>=20

--SToglXmfLL+RKNIv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapcQrQAKCRB4tDGHoIJi
0kA5AP96ot4argarOlgm/qdoWeZgmyzkpAcwl8ej4iDZ88d37gEA6I/nD5yQZzOL
AoeeJsgShmEcMaI/5GG/Z8vucUkNDQQ=
=JF0w
-----END PGP SIGNATURE-----

--SToglXmfLL+RKNIv--
