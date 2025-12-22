Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5D72617;
	Mon, 22 Dec 2025 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766438261; cv=none; b=ZyhcxM4J0DSRf+YnVUPrrpBQTU2Ql1AAuMfen2A1HVgZ1ME+WRtotCtABa/x1ZuQ7hSk1kv8LQ5dOdaAZQPShwHWpo1xt5J1aGpuj78HneHCbwyu+04ysslg2HTcPvdk2dEUjuYzKW5+6IEpkwqu9IC3phHpltAYx47auOIOBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766438261; c=relaxed/simple;
	bh=GfY5s1jBkGPXNhoUhVc6wQFpoyh0UvGJ5YyvJZLCOU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjNgFjgZfiCx7RfsT/7CQqstK53A7OPplLvfu46wII7klhe+jqawhpdl0Spy4Hl/W+UGpRrZVrmRcT/PiOOLSg07H7OiwBF1JvQEUKuZkupwS08mxUfhkoPlDTwpiXLYNntM+BDpFGU+Bh2SoPcZNJ9lq78ktYGcUgl50tlIiwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvrOQ6FD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvrOQ6FD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF833C4CEF1;
	Mon, 22 Dec 2025 21:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766438261;
	bh=GfY5s1jBkGPXNhoUhVc6wQFpoyh0UvGJ5YyvJZLCOU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvrOQ6FDET9p406hSffOsoZvYWTj6v5TN/N2i4HCb/CTWVTnLjRppHqXHYq7U3nRu
	 tVoBFjZw5R60v+rGElR8NJjk1ZkPfGENW7HgJvll8x1HZDxXsVuSHvWl3VFhz/r+6l
	 Q3CwBUak5YyrBNanchDTVwCI3BIQy8/BFQ3E1icYkgfjxLPpbLxenbLXOiWmtIuX81
	 F7JxNLyvBo8yoF9/XqA01X6SmAresQnRV8pKbz4Gty80uMMlDv7gZURB403V7Kcmv7
	 F7OdgVDHIQSQ/3l57b5Ljl3QO4uYOhRKv1zzTpcEEcMIzlk+qcWJosqth23TVSWDVv
	 UzufiPLm68s9A==
Date: Mon, 22 Dec 2025 21:17:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 07/13] dt-bindings: riscv: Add B ISA extension
 description
Message-ID: <20251222-stitch-preachy-3fab87fd6f0f@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ycfAa/SXC6QLLG2U"
Content-Disposition: inline
In-Reply-To: <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com>


--ycfAa/SXC6QLLG2U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 09:04:17PM +0800, Guodong Xu wrote:
> Add description of the single-letter "B" extennsion for Bit Manipulation.
> B is mandatory for RVA23U64.
>=20
> The B extension is ratified in the 20240411 version of the unprivileged
> ISA specification. According to the ratified spec, "the B standard
> extension comprises instructions provided by the Zba, Zbb, and Zbs
> extensions.
>=20
> Hence add a schema check rule to enforce that B implies Zba, Zbb and Zbs.
>=20
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2: New patch.
> ---
>  .../devicetree/bindings/riscv/extensions.yaml         | 19 +++++++++++++=
++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 565cb2cbb49b552959392810a9b731b43346a594..385e1deb23996d294e7662693=
f1257f910a6e129 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -109,6 +109,13 @@ properties:
>              The standard C extension for compressed instructions, as rat=
ified in
>              the 20191213 version of the unprivileged ISA specification.
> =20
> +        - const: b
> +          description:
> +            The standard B extension for bit manipulation instructions, =
as
> +            ratified in the 20240411 version of the unprivileged ISA
> +            specification. The B standard extension comprises instructio=
ns
> +            provided by the Zba, Zbb, and Zbs extensions.
> +
>          - const: v
>            description:
>              The standard V extension for vector operations, as ratified
> @@ -735,6 +742,18 @@ properties:
>          then:
>            contains:
>              const: f
> +      # b comprises the following extensions
> +      - if:
> +          contains:
> +            const: b

What's the value in adding b, if it depends on having all 3 of the
components defined individually too? Currently all "superset" types of
extensions are permitted without their component parts also being defined,
this doesn't follow convention and therefore needs to be explained.

You obviously need this construct because the kernel does not understand
"b", and even if you added support for interpreting "b" to the kernel
this is probably still needed to make sure the ABI is maintained for
anything importing a devicetree from the kernel.

> +        then:
> +          allOf:
> +            - contains:
> +                const: zba
> +            - contains:
> +                const: zbb
> +            - contains:
> +                const: zbs
>        # Zcb depends on Zca
>        - if:
>            contains:
>=20
> --=20
> 2.43.0
>=20

--ycfAa/SXC6QLLG2U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUm1awAKCRB4tDGHoIJi
0vUSAP0fICE8zvMf7nKsGMB1PUziS2TeQFTUfBwL6F1gkBjJBgD9Hx+1K5//DD3s
nFLDmffVAL3rtA/B5gNBII8pxhYASwQ=
=bj2o
-----END PGP SIGNATURE-----

--ycfAa/SXC6QLLG2U--
