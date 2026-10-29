Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300330;
	b=NUVjjlUIyB3Z7Z5qZjtVtcEsLyMdNRnbvP+NbMLxP6N934SBmRReARTUkDhVWAX8pViF
	 CQvB2wt5jLvH7mSLYi1Yrww8jTrAoC6PLVzZAcZdMIBhZk0ZyU+r79vaF3kcNHJ9RQ4cx
	 fjHBjI16mNC9kaZ7RXg3d652D8V0E5K0hTsLiPcveVHnBaSnbwSgxyfAAMXkafkUARZef
	 YAfAIYL/CE6wzZ2ZonqhxVVeJ/j52aip8VZpL9EuWf5LdPp0iwWiRGeYNKCIyf/m4+ppm
	 1PBNZbrbGWPNIJgyi6nae5ixTgB8xN2qItejg+CbsuDajtWDhvYO0NalW54hNriuvEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300330;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KHONBBdjh7iQh0mapfdJy3cnY06ZDJP4tujkx2v2Pl4=;
	b=CgXWs0zks73ZCePPazNoDGcCh49JjoKSWKrww8hvnB3u6LNFPizLEl1o0rmq5sl+WELN
	 lf0HkhisjabFTDgt6JO0gEpXVyUkoP4na4IURFINdzf9rXG1mMQPGFHofhoSgdlw5VBUw
	 Rqawnr/IZCrh9SO0hmG4s4FHa6wPTN2G9DYfvQEb/WZxkJxx3aroDU1bqEXO5+deIxPPd
	 O1niC6CfGywGnk8kqk3BmEHDQzfLP+WdfGsbRCwwdS2qLSFgEqMKB7S9P3zCZBHQzNsjV
	 O+BsYw2Qavt5TpFE0tiZZv2p1LaYFfzG4sqEO/IkQ2CPtR9E3Bkhy+aSwb0CqvboOFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD1wJEbK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F4606A31A;
	Thu, 29 Oct 2026 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD1wJEbK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDA51F01300;
	Thu, 29 Oct 2026 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793300329;
	bh=KHONBBdjh7iQh0mapfdJy3cnY06ZDJP4tujkx2v2Pl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KD1wJEbKIuWT4XOC8ifnI/94JBSzXbzTjHdfbSPYxot9vTldReA0Qgz8lBQYeUvb7
	 LskigVpp9/BJotoFwQWnCc7p6Qq0AuSfzVWr/4CuGKDg5Z60HOZf864RjkLRy0YC/Y
	 tYdvmLF6KkManvmNbqWJ6c5kyZUf6QOaZNTSftjTiDHcpCXPKPGSpjK5OPVbgktAnM
	 NQL75YZUQPanIt1Le4tXrnNgdy/clqaa06SMG4He+ms6Gy6HInIpaipN/i30VANb84
	 acKccbgk/3BtPJtoyHLvY8KgotLiBR7og+PkZ3nw4y3EZWctu3Y3gooBOrxpkroLXS
	 pCzj+mcF+5OGw==
Date: Thu, 29 Oct 2026 18:58:41 +0000
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
Subject: Re: [PATCH RFC 08/12] riscv: Add Bouffalo Lab SoC selection
Message-ID: <20261029-urging-dimly-3747c8bb9b1f@spud>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-8-b736ee920078@gmail.com>
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
	protocol="application/pgp-signature"; boundary="TJwnwN6dd3J6z/rc"
Content-Disposition: inline
In-Reply-To: <20261029-rust-bl808-console-v1-8-b736ee920078@gmail.com>

--TJwnwN6dd3J6z/rc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 01:05:49AM -0400, Kwanghoon Son wrote:
> Add a platform selection for the BL808 64-bit D0 processor, including
> the T-HEAD errata and common clock framework used by its UART.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> ---
>  arch/riscv/Kconfig.socs | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index cecbce0c498384d3283ed23cbf2514391eee361d..ea4667da7716a9a8d2ae156c4=
22b277064b42530 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -12,6 +12,14 @@ config ARCH_ANLOGIC
>  	help
>  	  This enables support for Anlogic SoC platform hardware.
> =20
> +config ARCH_BOUFFALOLAB
> +	bool "Bouffalo Lab BL808 SoC"

Ideally, this should be more generic because it would eventually include
other bouffalo devices.

> +	depends on 64BIT && MMU
> +	select ERRATA_THEAD

> +	select COMMON_CLK

This is not needed, there's a select of COMMON_CLK at the arch level.

> +	help
> +	  This enables support for Bouffalo Lab SoC platform hardware.
> +
>  config ARCH_ESWIN
>  	bool "ESWIN SoCs"
>  	help
>=20
> --=20
> 2.47.3
>=20

--TJwnwN6dd3J6z/rc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOXYQAKCRB4tDGHoIJi
0m4+APwLLXxq0bZ7C1Uz5V8JPQ30iBNkzxhYIBytaujWnKP6mQEAjbdFyjoBSugn
VC4kWUeUZlKq+dktIimVpN1lv8AjaAE=
=5lfT
-----END PGP SIGNATURE-----

--TJwnwN6dd3J6z/rc--
