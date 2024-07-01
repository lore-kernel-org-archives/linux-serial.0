Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A5149E0E;
	Mon,  1 Jul 2024 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836538; cv=none; b=WAkC4ktKpdUGNjGmWEwPwt2FXcSeW/fat64dSUr3pdwjjCNbFjWlaGTApLPNQVNhZ9LSgVNoWGZk3q1+ZuZkVuqpuOq+yocTGSEDU2VNfp7EsJmN8Nq8N2SaDeJP6Zdat5gH6cI2Hmu1rcIPkBH0lQMbryPlXM0PHbBKltNTpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836538; c=relaxed/simple;
	bh=lB4vzUltPKp8Kgm9znNaj4KrCjdwhhj+1lVTd42bv/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaZBxfbK0xs8EjbytUwWWxi9cLT4QCo9jd2KYFNrqanZL2qGjqDsTOy/NWXwvDG3ijRwNeFzt8T1X/FIn5pA0A4KnSx24IkyQtsnttDi+iYMiqrgQthGn7hE25XfnfgD25ldP96kLtCgk9wl6vp2L8VyAfZoDJQZwUK0G3ab+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpuQy5VF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpuQy5VF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BD2C116B1;
	Mon,  1 Jul 2024 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836537;
	bh=lB4vzUltPKp8Kgm9znNaj4KrCjdwhhj+1lVTd42bv/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpuQy5VFFjmKEaPMXsaETetKV78tb4S4on+ABIVOJo9oHW+Uj8aT8Wa+vv/JaKuRh
	 0EUUXhymZuu9UsRpzTNrWXTiJqHaATz4ypD9KabeQXBtjtcsA9xUPQzqDQ/mkmXdEW
	 5eG6MgwqQeXrh9oahZmpaPbiEaiDo9ni8+Gv0fBlPs2rukaJ2pzuCbjPU/BPnMAu4V
	 6c4xPxujWKzJeOYASMDS6iz0BnrAIMM/3m+FnsymVqxMEC3G55Qq/SwN0leImN3WRw
	 6CcHcO0OnEWXmJtaQfByrgbakY/gIY4tCM02kFfkauF3cHULXCyXihK0g/sAOPhpqj
	 Hnwdpa/ZE3qbw==
Date: Mon, 1 Jul 2024 13:22:11 +0100
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
Subject: Re: [PATCH v2 06/10] dt-bindings: serial: 8250: Add SpacemiT K1 uart
 compatible
Message-ID: <20240701-recycler-snowbound-49f1a91a6777@spud>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-6-cc06c7555f07@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wspCxHI5UDPUaivK"
Content-Disposition: inline
In-Reply-To: <20240627-k1-01-basic-dt-v2-6-cc06c7555f07@gentoo.org>


--wspCxHI5UDPUaivK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 03:31:20PM +0000, Yixun Lan wrote:
> Found SpacemiT's K1 uart controller is compatible with
> Intel's Xscale uart, but it's still worth to introduce a new compatible.
>=20
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index 692aa05500fd5..0bde2379e8647 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -111,7 +111,9 @@ properties:
>                - mediatek,mt7623-btif
>            - const: mediatek,mtk-btif
>        - items:
> -          - const: mrvl,mmp-uart
> +          - enum:
> +              - mrvl,mmp-uart
> +              - spacemit,k1-uart
>            - const: intel,xscale-uart
>        - items:
>            - enum:
>=20
> --=20
> 2.45.2
>=20

--wspCxHI5UDPUaivK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoKfcwAKCRB4tDGHoIJi
0jw/AP4tdlnJrm8aDYdcj85Bo0J++w0haA2Ofa6Obysppu2ygAEAvIKKHt6m4Diy
fSxNVb9CC9136Is0ni/ZvK4dY/fqeQo=
=cMlK
-----END PGP SIGNATURE-----

--wspCxHI5UDPUaivK--
