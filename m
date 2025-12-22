Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F163009C1;
	Mon, 22 Dec 2025 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437035; cv=none; b=Zn2Ia8lhbDgAQZiM5+OqpuXrnZUr9WqeHBAoMcNXri+cULJPw91PtPV4Oeodk/qpoJyo+saJ+PT8vMZJOBX1izxpKqFRUcqqjmmx8p6qrjh7yivOHmAfiLn3KFyIT5BSjgJ3QdsvtCeR/JM23KuAAhUh/KEPa5aS7OeNLi+Pb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437035; c=relaxed/simple;
	bh=ntkxToLftiZf604wAYbiqavOt/eAg7o5YWPPmmXiPj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXdt0+cc4hmWus9r2dVKUGfV0bxDUsIKrxtI31K5cM0BX4IEXnalV0PigL63ONrveWt8YTPEacTSlylRXzPuGvrdgQZyiI3H3IXu39Nn6uj1A48oK7o1Ta+ebEqzmk6kKLVbcJ3dD78aINCtMv6ik4Y7Qaq7AvB5BjOJUApKIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBjoitII; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBjoitII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97982C4CEF1;
	Mon, 22 Dec 2025 20:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766437034;
	bh=ntkxToLftiZf604wAYbiqavOt/eAg7o5YWPPmmXiPj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBjoitIIZTEiX3VNhpJz2I8AsqrGezL012hxQt1cGFzURala68HX0fLW9Ex30Duf2
	 tsz0pn2Okgff1Kxm7npNnsFj+vt25BuZKNE7c/W3fila96vl3H25A8ssbu3bMrTJc1
	 P+p3WcUhfvBZJ2gDa/E7zTpa+q+jER2NJaqilIOaM5tSMCMyS55Mg3Z/YEch1ZhOnm
	 YikraY+HE8or8cWan/NMnyP3aTQ4rBGSvQsoFGvqROjjljKVuc2imTk4Co9sVIfKUl
	 TZuxsYpNd5UuhTPI/y20cejiAGzYLOCIyzveId2VGYj7JYdmh/qgCBlozMbIVbRHqU
	 E5Y84lzZe77EA==
Date: Mon, 22 Dec 2025 20:57:06 +0000
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
Subject: Re: [PATCH v2 11/13] dt-bindings: riscv: Add Supm extension
 description
Message-ID: <20251222-parasail-resolved-f8014165d903@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-11-3af3f3cd0f8a@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qNISUK/sx4KO+kox"
Content-Disposition: inline
In-Reply-To: <20251222-k3-basic-dt-v2-11-3af3f3cd0f8a@riscstar.com>


--qNISUK/sx4KO+kox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 09:04:21PM +0800, Guodong Xu wrote:
> Add description for the Supm extension. Supm indicates support for pointer
> masking in user mode. Supm is mandatory for RVA23S64.
>=20
> The Supm extension is ratified in commit d70011dde6c2 ("Update to ratified
> state") of riscv-j-extension.
>=20
> Supm depends on either Smnpm or Ssnpm, so add a schema check to enforce
> this dependency.
>=20
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2: New patch.
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 16 +++++++++++=
+++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 1066b7e65dab89704dbac449db4aa5605c95b9d3..4997f533b2c0defad88fd5941=
3a6885b5b9e109a 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -267,6 +267,12 @@ properties:
>              ratified in RISC-V Profiles Version 1.0, with commit b1d8066=
05f87
>              ("Updated to ratified state.")
> =20
> +        - const: supm
> +          description: |
> +            The standard Supm extension for pointer masking support in u=
ser
> +            mode as ratified at commit d70011dde6c2 ("Update to ratified=
 state")
> +            of riscv-j-extension.

I'm not yet convinced that this makes sense as this describes how the
consumer of the devicetree behaves not the hardware. How the hardware
behaves is already described by smnpn and ssnpm. I'd really like to
see some commentary from Samuel Holland on either this or on
https://lore.kernel.org/all/20251222-dimmer-wooing-db29fe925498@spud/
before I'd be happy with this change.

> +
>          - const: svade
>            description: |
>              The standard Svade supervisor-level extension for SW-managed=
 PTE A/D
> @@ -892,6 +898,16 @@ properties:
>                  const: shvstvecd
>              - contains:
>                  const: ssstateen
> +      # Supm depends on either Smnpm or Ssnpm
> +      - if:
> +          contains:
> +            const: supm
> +        then:
> +          anyOf:
> +            - contains:
> +                const: smnpm
> +            - contains:
> +                const: ssnpm
>        # Zcb depends on Zca
>        - if:
>            contains:
>=20
> --=20
> 2.43.0
>=20

--qNISUK/sx4KO+kox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUmwogAKCRB4tDGHoIJi
0h7+AP4q3MR0wybpLOqCzJYp5ojUqaGxgeOMP/vyYRTlkr79NwEAtjbxOg0Nvbh+
KL+X8G57GAjyye8tZAYNbOZtnSxcqAY=
=LBwj
-----END PGP SIGNATURE-----

--qNISUK/sx4KO+kox--
