Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649791;
	b=Auaol19gjm9FpdlFXg0qaKCpp1bxC4oNXcoIk3tOexwasaiTQ9oQ/NXP/liaYb8qEtWd
	 EdKFN5Izary3Di5+RHiCbDHBICiZKrBvKzdqGaeJdxETKYbMRvDOndXMlhryJHf272qcs
	 bUCMkuIpa5rvZPCZKeeyuDiLbFIIyX2ELhMMPznr7BYEtL3TKuI+gkRjPKjDtR2WI7KV8
	 qK1CuK2cB+u+71mV5SMl70sWcrG9lKKRqmcwBJIQcS7QBDRNBhItn8pS/7ynBjzysCDvg
	 c8UKFQahz3KM9wkAN+xialdUdhzuTp7e1ofKCHFprQ2mc4BhKHh8M92Cjd05ch7t+wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649791;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8f53qSaOUew/yduHzYAT33Sw2UKphgT8s54cwVuq9zg=;
	b=z3aTaQGFDCQAcLXAnceNQ9n50rCKWBf7BzP42gnK9SAm+rqtsB1UcyI1s9yTdf2Rbv2g
	 +4FRcd6HROyOJH9JhCvN54PbNQfvGhtcf6reicim9O5h9aaQMsZPJ8VEPlsr50DFtfS3I
	 jXzR4DG4MTNXctTAp/UHCQMJwIb8Q/agLhsQD1QCOV94/tAbQUgClIKrwkKwImF//AK9L
	 g9EmZxyqaK3zF1INLv6cSrjK1PNYfbWxQZA76qnlI1jKLRgTSlfCiOOnXFcqHClpkTKLZ
	 +TTXUJ86098w2iNM1JPJXwMGWJTEYicsCgm8bfU80KwBy51VImglqvqRdB1Ws7m2PjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6Hdo+hz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8444606A324;
	Mon,  2 Nov 2026 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6Hdo+hz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BAD1F00A16;
	Mon,  2 Nov 2026 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649790;
	bh=8f53qSaOUew/yduHzYAT33Sw2UKphgT8s54cwVuq9zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C6Hdo+hzAM2aCE2yQ8wCZI1E6GJUxrrbCQEknhiE/gjw6+GJfM09ra7ImVB1dXmv1
	 X3nGRPBTQJVmzPrSs/z91HwdgBceJXITyLZ3R1hHYACecmOBgd3tygryGmNZpglEzM
	 mp5JNuk23aI58tr5io/JBr6I7Nxs9Elc4SGO+NE1H3KhSmnynlwEP4/CFTP1tFTlmJ
	 xfc83r9QPWcZUhsjIGLxPH7dnrQvoFsew+Kfv2OdzzuuyvR/oNBjCCZDKE5tT/ckTB
	 0zPhV8w7eEbQo7m4CPyA0QZhqc5JWCPsJhDQyIEOnSE6974xmUcMk1l5P5B1yhiDpf
	 Gx8L+kVhNHtqQ==
Date: Mon, 2 Nov 2026 20:03:02 +0000
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
Message-ID: <20261102-throng-botanical-b244058ecc37@spud>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
 <20261029-spyglass-evasion-772697094cb9@spud>
 <20261029-amuser-savior-6a6ab062f471@spud>
 <auSDJH9V31wmbrYv@debian>
 <20261030-slider-finished-360b10521e0b@spud>
 <auXQaY25XfYzxEb1@debian>
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
	protocol="application/pgp-signature"; boundary="VKJ1YVFC0pQdfxF2"
Content-Disposition: inline
In-Reply-To: <auXQaY25XfYzxEb1@debian>

--VKJ1YVFC0pQdfxF2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 07:26:33AM -0400, Kwanghoon Son wrote:
> =20
> > Okay, that's good - but that's more of a response to my comment down
> > below about splitting the entry, not a response to what I was asking
> > here about the lack of a git tree. Are you going to send the SoC
> > maintainers PRs for this platform or were you expecting someone else to
> > apply the patches for this platform (IOW, me).
>=20
> Thanks for clarifying.
>=20
> Could you take the BL808 platform patches through your tree once they
> are ready? (If that you okay with this way)

I'd rather not really. I shouldn't be the maintainer for platforms I do
not care about, but I will do it if you're unwilling to - in part
because I expect that the volume for the platform will be pretty low.

Please read through Documentation/process/maintainer-soc.rst to see what
the expectations for a platform maintainer are.

Cheers,
Conor.

--VKJ1YVFC0pQdfxF2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaujsdgAKCRB4tDGHoIJi
0rvXAQCHO96kr3fe760sxHNQfps8aidw4ByhVix9gyeGS+Q7WwD/XoV2kQ70wj6S
Ayz1b9AlQkWnpQ7NCsg4w9US5ybLXgQ=
=TfLH
-----END PGP SIGNATURE-----

--VKJ1YVFC0pQdfxF2--
