Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299944;
	b=R/T2KU/oqh129tsgeksdjSYWTNTTVUDQyuOgVPWzdOjE1GzbvSuAKbJqPE9O8KPvFMaj
	 RkwqaqlKH8YYdq9RcfKLXAXKWs+Nq5Yncl0yTRsvw4tuouSa4k3wN/rRMtpRwDpmPjP/w
	 vXpzIq2ek8XI2nclUlSgLbNF1cDzDo9REqNhI+Na+v0m2hExaftzo0xBd+lO/69MetmoW
	 1uR0Mob+wQxz4KnNwvX6RuoYgUrGXqwodVzxAk/z6ZcUjr88XZ0qhpVH5EbmFkUzZszXw
	 zsGvMBsGPM67cGCLUq6ElF17MwJJYgA8AA6ERs5Ig+k41uyYGBrZGgHBMptEgxjbrHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XWPYBGnM5MkiXHmVnaCPpYcOP6fueC/bukxMlPBkAzU=;
	b=1AW2pn4J3fXHJvMmuyBE1AFG3LgaPRJmq6J8KEZTi+WeP27NhBSDN+vXzR8xiRwVie0V
	 Ic9lDw0nqDSWRv1Fqaja0VzdDPDYpPr0Chsy+MgdHrTHLP3LLey+/7ss61U5KZVThACE0
	 8ljaoSnQor1BoviXqYs7f3UIzhJj/lo5sLCLigtOD/rjMeydsNxAti9yyCmmrMaXtXcof
	 TboVynaWSBBPrWcE6oskYQi3IrZZ5tEkBMpQXbMA8AK+L2u9jz9SzZWFm5bJsaWWSsfDr
	 UitHn+QDTD5uuWODopjQ0Gjie5HirukSRiSlgx4GXllCAJnJfNR37bR5+flXE0DY1eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGEcPwfk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF8606A31C;
	Thu, 29 Oct 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGEcPwfk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D24D1F01816;
	Thu, 29 Oct 2026 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299943;
	bh=XWPYBGnM5MkiXHmVnaCPpYcOP6fueC/bukxMlPBkAzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DGEcPwfkatxrQKJzpfcKlaBXAYxwYS49Sx49GlL2tG4+fEjjG+zm6qvMbCMMYfHvO
	 FmkChSx1ug7A45iUKCoLTkCs2hUmp/rXY3a5HMPnYGsRdPbwVrjDXBr2nH/Rj/m4M4
	 GPmXaLEFAkS8TvMO+WxjjjClYw0trZrfJ7YYF86rd6AHtbpFxJMU6wb6ImaZwp/TmX
	 Nq1BmQNrEcKWR0y26EPbOHfOnALPQylDPhy245z/6HNsio9GsDq4sbzvNgKSOPiIvZ
	 PN9+GPzhF1NTFZBCuwbfwtErfnGWBqgZ2w+UPstL+wEs5I2SGQpM5zxeaoXqYY88/Q
	 YuNj/sWF4ri/Q==
Date: Thu, 29 Oct 2026 18:52:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Kwanghoon Son <asdfkwang@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 01/12] dt-bindings: vendor-prefixes: Add Bouffalo Lab
Message-ID: <20261029-unpaired-viper-830e55436015@spud>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-1-b736ee920078@gmail.com>
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
	protocol="application/pgp-signature"; boundary="rHCtu9GAzIbs5mdw"
Content-Disposition: inline
In-Reply-To: <20261029-rust-bl808-console-v1-1-b736ee920078@gmail.com>

--rHCtu9GAzIbs5mdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 01:05:42AM -0400, Kwanghoon Son wrote:
> Register bflb for Bouffalo Lab Technology (Nanjing) Co., Ltd. Reuse the
> prefix already deployed by Zephyr, including its bflb,uart binding.
>=20
> Link: https://docs.zephyrproject.org/latest/build/dts/api/bindings/serial=
/bflb,uart.html
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Worth noting that last time this came up, we agreed on "bouffalolab"
because that matched the domain used by the vendor - which is what we
use as the source for compatible strings.

https://lore.kernel.org/all/20230607195027.GA3894404-robh@kernel.org/
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 5471a06f93f1012f08e26f7f105ad846ab3629ac..24c670ff75b6f482ede1bda3b=
59c70ed9116042f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -249,6 +249,8 @@ patternProperties:
>      description: Shanghai Belling Co., Ltd.
>    "^bestar,.*":
>      description: Shenzhen Bestar Electronic Technology Co., Ltd.
> +  "^bflb,.*":
> +    description: Bouffalo Lab Technology (Nanjing) Co., Ltd.
>    "^bhf,.*":
>      description: Beckhoff Automation GmbH & Co. KG
>    "^bigtreetech,.*":
>=20
> --=20
> 2.47.3
>=20

--rHCtu9GAzIbs5mdw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOV3wAKCRB4tDGHoIJi
0mtFAQC91Kvt02oSw6bmF5jkMTfZvkF2KHf55Yk+76p/7FQUZAD8Dz2UZOSHhRNH
/FY6RKawJXTzMCT7gGeHa+1gFxncYQU=
=6vqi
-----END PGP SIGNATURE-----

--rHCtu9GAzIbs5mdw--
