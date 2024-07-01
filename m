Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9452231C;
	Mon,  1 Jul 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836667; cv=none; b=AGFq16/PsEP0RWkMML7Goq5rSeQ6vVMGn0DbOxkldj8mWaoUYDNWnqS2YU/8NyuEJGYOrjrVaiUr3/IZVdOmbS8cLIvf2mMxM2iUOfC+oDqQs5UsY0CGZJ/gxX/xld1JIg4zNP+neWu9mqN6cUUw4AqEX4ZRf1e/+ZToA7ifjAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836667; c=relaxed/simple;
	bh=7Gs9Q7JZEYXal3PZNj/A/6mBzMzEEW3iLGgskmEVdN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/imVz0jxkAgT+0yc2ccCoqqXpXEDYTWlPhku2b8Jk2xk1lQYov1QJ8rDQ8sEemLfSu2KAQwstl5Yy8db4xg+0i5eowdn2udNz7mippBFSJmr/wJqtPCM4rKk00wTKgddOoCZWPoEngV7fiZv1D/kKXw2KIVHfHuvFkBmfNYgQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWEFcQdD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWEFcQdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B969C116B1;
	Mon,  1 Jul 2024 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836666;
	bh=7Gs9Q7JZEYXal3PZNj/A/6mBzMzEEW3iLGgskmEVdN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWEFcQdDR4hftb+ry0Tgx1mGlhZFYsNKzqKUFT9A9QyVM9/qAGMMvgQJD2941bVGv
	 Vj7qlgbYNOAoDu5SCWg02dEz0J6Qsjp8GHByQR7HK/0aayKb3OX0RPTZfrOLnT3jqH
	 t4NLEnjyQJllrhIfP942niZV1US2XWcD5CkCVfbboazshZawudVAd7eFE0yTUse3p9
	 q2LZsfzTu4N4lz5VGpfzODy9KXJ5j8/uAcy2JR6eB8jMY2ibv/9Pmur373UNK0NNtS
	 ZDh9V6JvkQSXxTh4R1cHPBcnicJlHVdVYhWVG68Mwvo8qElcmJmJea/VcacR/wCtMC
	 5C9+pY2Fx2PJQ==
Date: Mon, 1 Jul 2024 13:24:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v2 03/10] dt-bindings: riscv: add SpacemiT K1 bindings
Message-ID: <20240701-undercook-flatterer-7f18f7420a6d@spud>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-3-cc06c7555f07@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zGw7lplsaqNbmjY2"
Content-Disposition: inline
In-Reply-To: <20240627-k1-01-basic-dt-v2-3-cc06c7555f07@gentoo.org>


--zGw7lplsaqNbmjY2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 03:31:17PM +0000, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
>=20
> Add DT binding documentation for the SpacemiT K1 Soc[1] and the Banana
> Pi BPi-F3 board[2] which used it.
>=20
> [1] https://www.spacemit.com/en/spacemit-key-stone-2/
> [2] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
>=20

Please make these link tags when you resend, like

Link: https://foo [1]

and don't leave blank lines between them and the signoff.

> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  .../devicetree/bindings/riscv/spacemit.yaml        | 24 ++++++++++++++++=
++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Docu=
mentation/devicetree/bindings/riscv/spacemit.yaml
> new file mode 100644
> index 0000000000000..3b151fd02473e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/spacemit.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT SoC-based boards
> +
> +description:
> +  SpacemiT SoC-based boards

Please work out who is gonna maintain these SoCs and add that here to
resolve the bot's report.

Thanls,
Conor.

> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - bananapi,bpi-f3
> +          - const: spacemit,k1
> +
> +additionalProperties: true
> +
> +...
>=20
> --=20
> 2.45.2
>=20

--zGw7lplsaqNbmjY2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoKf9AAKCRB4tDGHoIJi
0saUAP9HO8UZAlDq+B2KUs5Nm5I8paGb5pgWiWUGC4za85sbzgD+JyyFMlmU7Ro0
5EhR2LrpaRqLEwpuHlgevpF+NWOgugU=
=+Mjf
-----END PGP SIGNATURE-----

--zGw7lplsaqNbmjY2--
