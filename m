Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300944;
	b=XfM9OLU1mDSg4M7D5lDg4sw0UEbcScSMUu/izYu+F5o5781IaBZAzz/4I35fmE4MOiiQ
	 3YACynN0VE6x90ik9gUyIP13YGgYsoBKsPS6z780Emx3A5wJfFCuwNDyW02b0kiVVLnM1
	 utwvgBgcH9rwWdIHXeggJ7HkL62fDKAWZF5muZ6te6ZLlrSES/50XB7ust3BTQevvUjW0
	 itNHGXDRtgaYC+fOuu88ZgV/7o01ugfpWr/mou9XQv9HjJj2xMuVFiTbIRJsPR6bK5opQ
	 yrL7Ki1NAVayDPkWIfIzjE3UmUh6JXvpFfUOkw1r9zbb60bPuZloniJvDkehPF0RsQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kS/R8HTbrTEVSzc0sDiS50P+LYYbuH1Vr7HCMcSsi7I=;
	b=s4muroTGyoAFTZINrDxko2JUTmOkBWWhPpfVxnDt+zmG4cNTNxF3Z1beYvM8t0n8Fqf5
	 6e1rG1T2DiWuS5iA5J+b93zFDxy7ffSsC6MGZeywAR+yAbQBauvcWcinftTK8zyh36qFF
	 uQOquCllmYdLaklk5drfkQ0hbWNWTdRdtPKi84kaYBRx/KGgRt+NZsbap4+tOpZnofwbe
	 l7xBHf2DhO/nBsCGZOM5aw8Ky9AOoPhzxUKX2cm3vrQXpkDBTV3l5S7WMQjBD0C+VfaSo
	 QQZoG6raISFFVHhg5P0b3m0r38HIMiUxl9rgXqVYZGVhZWrJUveJ2h+AVnZRqKMoOjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nI8tmPMp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1E606A31A;
	Thu, 29 Oct 2026 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nI8tmPMp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEA91F01816;
	Thu, 29 Oct 2026 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793300944;
	bh=kS/R8HTbrTEVSzc0sDiS50P+LYYbuH1Vr7HCMcSsi7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nI8tmPMp2izrsUe1uVlEWG+U/sSI9rWUs1pcSVvyzIP5t9ggGpQA/mXTeMWNqgfIG
	 9oAW5R9oSroaGdf19I3FZG1e2e/dG6meHt2pdG9OB5CC63z7dQrmKgLx5SYokQu7Lr
	 m/z4IRMauE76ndjaELomMjlJBEySbNuzm0M8xLkRQUBLcfHCynH7u3Cavspv/ACgbS
	 foH27kI9ZhUDaia2GvWEFaaOXLi+ae1wb8u4IdAiPLgt0tW9taWKfFgvx6QsFEk2GL
	 wQu6wfSuaiBB+uLzD+DK5SxhrTM0KpEOZrQQSutL27XzHcjLqdAf+6izWU/uSqCEZD
	 ZNsi4ZEtedRnQ==
Date: Thu, 29 Oct 2026 19:08:56 +0000
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
Subject: Re: [PATCH RFC 12/12] MAINTAINERS: Add Bouffalo Lab BL808 support
Message-ID: <20261029-spyglass-evasion-772697094cb9@spud>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
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
	protocol="application/pgp-signature"; boundary="vJMdIjEZ3fPHpCkZ"
Content-Disposition: inline
In-Reply-To: <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>

--vJMdIjEZ3fPHpCkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 01:05:53AM -0400, Kwanghoon Son wrote:
> Add a MAINTAINERS entry for the Bouffalo Lab BL808 platform, device trees
> and Rust serial driver and abstractions.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 801f964899ba790a8f71fe61f9b3777a494dabd5..b76d3e168468bf6139c958a81=
b626c73b422c0d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4926,6 +4926,19 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
>  F:	drivers/iio/imu/bmi323/
> =20
> +BOUFFALO LAB BL808 SUPPORT
> +M:	Kwanghoon Son <asdfkwang@gmail.com>
> +L:	linux-riscv@lists.infradead.org
> +L:	linux-serial@vger.kernel.org
> +S:	Maintained

Missing git tree, unless you're expecting me to apply patches for the
platform for you?

> +F:	Documentation/devicetree/bindings/riscv/bflb.yaml
> +F:	Documentation/devicetree/bindings/serial/bflb,uart.yaml
> +F:	arch/riscv/boot/dts/bouffalolab/
> +F:	drivers/tty/serial/bflb_uart.rs

> +F:	rust/helpers/serial.c
> +F:	rust/kernel/serial.rs
> +F:	rust/kernel/serial/

These should probably not be maintained under the arch support since
they're not platform specific.

> +
>  BPF JIT for ARC
>  M:	Shahab Vahedi <list+bpf@vahedi.org>
>  L:	bpf@vger.kernel.org
>=20
> --=20
> 2.47.3
>=20

--vJMdIjEZ3fPHpCkZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOZyAAKCRB4tDGHoIJi
0txfAQCJj90MdzNeIW71uOj8ZchBf4iq/DaenSiyECeFKc/rzgEA/V1dbc9W1Ay3
WdGm94JT3+kvaO1cTEk9MGjJE2KCmAE=
=NWZF
-----END PGP SIGNATURE-----

--vJMdIjEZ3fPHpCkZ--
