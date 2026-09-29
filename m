Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541055294B;
	Tue, 29 Sep 2026 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710833; cv=none; b=aD9yT/GD4fGvNVyQrqhtMCzUTozPP3clJB7SmpsCkA4DTJyTbpoa4uvWJwFtBlyVKAoTkW0L8+DWEY69QN0gQXcI9SrLE3Xwyi5arDfNeSS4E3djWzHKb2kZAIyM72eqOpY1YfQo2HCIIfCRACIQo2Y0R3kef/lF0Gf3IUPy3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710833; c=relaxed/simple;
	bh=aNYEOm2al7dSo/zt+FqJh80DH46zxWbb8ZGY+2IqAg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFTmwjhyRM+vLVkB13zNiwwEZlU90DPK8zZiBxaGUZ9R8rhdNC2QhfRPIkDqHlCV8UjMFli/tcMAiblvURyhAgSSk38Y7uzJFxaBSMyQDvJkfGK2dY0dxy3SZ0TY+3WhXdpTlKkIY2W0Ffj0q3snIs6HXZXmbADZh9aizB1JI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOuErwfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOuErwfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B301F000FF;
	Tue, 29 Sep 2026 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710832;
	bh=4b8KCRe7pF1UqNMFpoJsf5H8zaBgkDgxOQMy+atvx7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bOuErwfrk7NMaqfjlf5HuaPdYFmDWfTHIAMMEzSnr5aJsUqWx5U+I4VwiUMbdj33w
	 BtxKfshZ9IR5H4w8fzb9tMfGLY1yEK9E9pQEslSdG7GrE+2gbUwzj86njTDypghKsh
	 7BWyfxMbPagDogjSokAHMmPq9nSVDUU2ZY7I7y7J4lGlVe1W+sfdP/Fy3kbYnYWVY+
	 7+N0vOMcPsSrifNvgVeVu2SOF8+aiUgE0xc909LIEloJ0i5AZfk/VrKduALcdhz+sr
	 C6TqEcv3V0HfMGkRnWamyRhGlk0r/l6LZRK0Xs5OMTKjpmRpcm5d6g5NGOP8LXlCke
	 PvSR8lBpXDofA==
Date: Tue, 29 Sep 2026 20:40:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/20] dt-bindings: i3c: dw: support up to two reset lines
Message-ID: <20260929-unnatural-zeppelin-3105dec85864@spud>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-5-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9lZEJPU9yWTSdoib"
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-5-jszhang@kernel.org>

--9lZEJPU9yWTSdoib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 02:14:01PM +0800, Jisheng Zhang wrote:
> The Synopsys DesignWare I3C master controller can have multiple reset
> lines, such as core reset, apb reset, and dma reset.
>=20
> Update the DT binding documentation to increase maxItems for the resets
> property to 2.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Could you add a conditional section alongside this change to restrict
the altera device to one please?

pw-bot: changes-requested

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yam=
l b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> index dc7ee38001d6..dcc21a7ab4c4 100644
> --- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> @@ -39,7 +39,7 @@ properties:
>      maxItems: 1
> =20
>    resets:
> -    maxItems: 1
> +    maxItems: 2
> =20
>    power-domains:
>      maxItems: 1
> --=20
> 2.53.0
>=20

--9lZEJPU9yWTSdoib
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarwUKQAKCRB4tDGHoIJi
0jjwAQD9+7FuFrd+5qA4gMDQY8mXGlaQtYk8bd0Z/zH2KFeicgEApFzahkQU8FyW
bKYBxyIUcX60l+VoK9eLy/VuqFSj2Q8=
=gE/1
-----END PGP SIGNATURE-----

--9lZEJPU9yWTSdoib--
