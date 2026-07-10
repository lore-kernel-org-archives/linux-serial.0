Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E42D1303;
	Fri, 10 Jul 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701806; cv=none; b=eTUQYKrRcnA+GhOXBbAk+THME7HfwTMzVlkU25EcphzzRW7DlUv3EwhpnROSv6emC7sgj4xa7qKsPS3OxTN/1WubdlKi97N0iY+GwCgsbg3PHWpAb/aGxGQcw/u7qDLGrzZd2dn9duo+sDfJi/M4dsc9Qk5Mz60xTGq1QKNx2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701806; c=relaxed/simple;
	bh=ChvTXHvx34Xg3F5MDS+a5BsoegX5ol/QwAiR7YlRa3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmVrk4B614rMFJ33NJ1tt77uC5HczlfbhncEUZWAj7ImXonIY13uN9tR6x2YEEZlHld/z3d4c3kdOBhh5iIHMFDrXp3UHaHU6KFCrhyJVSAymyR6W6XjS2t+XjQtKcIQ+N9BWlr2NybYTKyof8u/9oolMsUKeHOTOQmJgHQq2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsiTqlTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsiTqlTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5657E1F000E9;
	Fri, 10 Jul 2026 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783701805;
	bh=7ogAkQAhaJZBG9XEWmXZL7FdFtI/DMFZsjHdpdm0Y0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dsiTqlTXPm0UlJ4EXOF/tYU/BS+Wx2Cy3nWdGg+be5KUkoAWq7d8Xngy6pkYPqfTW
	 gTWUqO6xqV7sM7kjXw+RfnTTd5nRv9rZBPOs24rzAp2NP1tPOFrC7IA/l0xz0NuJBk
	 mn5FRYGJS2sQ9593X6EK7ZQMADnkd9QRg6YV0PeJtP06/9kA2ZTHiIDlpIgHRlzGaW
	 5R+i42MVMtOFECsd/TKlCq3/PCspykFAejTqF1Vz1OyeiZXiWZAy+9/YmX5aVku5/y
	 Od0eut+hYOGgVpgeJWrd2v4yGKoFRQeemi/JpLDZUAdJ6K07iYAiwiGC2UgySfWmRj
	 abUIDL3AwB8LQ==
Date: Fri, 10 Jul 2026 17:43:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: serial: 8250: Add Airoha compatibles
Message-ID: <20260710-fraternal-tweed-1f21692e3459@spud>
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
 <20260709205656.319531-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+WP+e31A+iCOpFYA"
Content-Disposition: inline
In-Reply-To: <20260709205656.319531-2-ansuelsmth@gmail.com>

--+WP+e31A+iCOpFYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 10:56:49PM +0200, Christian Marangi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
>=20
> The Airoha SoC family have a mostly 16550-compatible UART
> and High-Speed UART hardware with the exception of custom
> baud rate settings register.
>=20
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index bb7b9c87a807..b6f7e093d8d7 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -110,6 +110,11 @@ properties:
>        - const: mrvl,pxa-uart
>        - const: nuvoton,wpcm450-uart
>        - const: nuvoton,npcm750-uart
> +      - const: airoha,en7523-uart
> +      - items:
> +          - const: airoha,an7581-uart
> +          - const: airoha,en7523-uart

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> +      - const: airoha,an7581-hsuart
>        - const: nvidia,tegra20-uart
>        - const: nxp,lpc3220-uart
>        - items:
> --=20
> 2.53.0
>=20

--+WP+e31A+iCOpFYA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalEhJwAKCRB4tDGHoIJi
0so4AP9SSRYXFqxGY5GOo4VyFsVYR2rcdKcTIjLhSBgQqrgn0AD+K6+FvsxAElhB
4excAS9JQzxHsWcUQZAvmsPzygOtHgI=
=UIDo
-----END PGP SIGNATURE-----

--+WP+e31A+iCOpFYA--
