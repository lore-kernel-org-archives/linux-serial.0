Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988021;
	b=zazTN1mSQdbsCXEPnASK/T+ldWbZv6YlY4jQdSWTAiHI7wqEQUVP6YdXya/PWpUDgHF6
	 DSWDMJlmyDprlCeysM4r87Cl06AAiS0L+NTTiVLpqrug+jQc2rpavJBBYc3dD0SpnaeKK
	 z+/ZZ8SQAH8rkYf/c8YmDEcEkxdyjF0/j9y71ZXwK/xsEyXQXJYU6/xDgzIsRBPkCbkKx
	 vXNZ09YJD85awl3RINK2c/fk1R9h8qyVBAXTtHAE2UZNhMre37jIvs78A4E0E+M5N42FQ
	 M61qGR1hr9ogkqY2YhRpJo35ch33JCzK3r2a155iRg8UR18X5UsYQYbBR65J1o5KpgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988021;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NTao78Z0+nwqj/kr7PCUlsM5HEtatNcwotA0Fg/NlJo=;
	b=fDE78xBQ2NeEm5xB0yaan6f4serBXWi9z66YInqBH6fZhNcMh2sIPmhyZDIlI54/6tto
	 1by5MKVKYzaZ2TMnNTuZ0Do0oY7ldPoDkhpgrOsTENutR+U2XpuQYl/5v8hWin6dC/MLE
	 QZwIPFfFRDRuScXmgU3mGsbSPCfP8X7ldU8yD1vDJO0oNIbjvvt4HdUFwsM9TDNqY8Swk
	 Uwt3OkQK+2tSfO/und2nEeL1fEIRID1/DmXlIbQxQHETGkcyV4dhcR+GIOjRFtZH/lD04
	 1LEEku0BOaTZ1qa3ywwEWeCDQCp0stRCGkn/4rBn5FUfTDuJUbey6YU2L89m2JtrlUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq8VGHnD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FA606A326;
	Fri,  6 Nov 2026 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq8VGHnD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF5C1F0089F;
	Fri,  6 Nov 2026 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988021;
	bh=NTao78Z0+nwqj/kr7PCUlsM5HEtatNcwotA0Fg/NlJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lq8VGHnDYxh0RRUt2wtXp3vpG7zskXderJXd5WAPx+PZjb9pq436aB5jl1whO6R4e
	 KFwXxz5+yrxzUgQQTbl7+wP0w4mDIhdU/P7fXXPSWnx1cShilwI2/qHUYBZrv9b4Vj
	 l4j2L185Tx8JYxT+IsyPCBRJxjffUjkqya3bXhUzm12VwMh52nHwvbzYYkoFmC4zXj
	 SFi7AmpMG2kCDrWa7PRmud4TxEftH+to/F3hNLJU0lclgvivUbSvrQf/ZQzvGS36ge
	 ftW23GLEJf01Du5La+RogmFJQj3I2OxT0nrjegv/3mJkBLg/XEa8w1nlrWcAt9ctby
	 BEdU1Y8+LXDag==
Date: Fri, 6 Nov 2026 18:00:13 +0000
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
Message-ID: <20261106-dislike-despise-91106ac848dd@spud>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
 <20261029-spyglass-evasion-772697094cb9@spud>
 <20261029-amuser-savior-6a6ab062f471@spud>
 <auSDJH9V31wmbrYv@debian>
 <20261030-slider-finished-360b10521e0b@spud>
 <auXQaY25XfYzxEb1@debian>
 <20261102-throng-botanical-b244058ecc37@spud>
 <auqC9jOIQTyieQUJ@debian>
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
	protocol="application/pgp-signature"; boundary="nAZw+Rabccy81wd0"
Content-Disposition: inline
In-Reply-To: <auqC9jOIQTyieQUJ@debian>

--nAZw+Rabccy81wd0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 07:57:42PM -0500, Kwanghoon Son wrote:
> > I'd rather not really. I shouldn't be the maintainer for platforms I do
> > not care about, but I will do it if you're unwilling to - in part
> > because I expect that the volume for the platform will be pretty low.
> >=20
> > Please read through Documentation/process/maintainer-soc.rst to see what
> > the expectations for a platform maintainer are.
> >=20
> > Cheers,
> > Conor.
>=20
> I'd like to take on BL808 platform maintenance. I'm new to the
> maintainer workflow, so I may need some guidance initially, but I'd like
> to give it a try.
>=20
> I'll update on v2.

Cool. One thing that I noticed, and felt it was a bit odd actually is
that the uarts are fed directly from the crystal oscillator. Jisheng had
that in his original series though so I assume that's actually how the
hardware works?

--nAZw+Rabccy81wd0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4VrAAKCRB4tDGHoIJi
0hBwAP0Y6pVSxYDxvE94R7FNDUSClc7MlbdimpLzv2QjqTnZPQD+N2+2p4DXHqcg
uBvIe5LDtWCUnTdIerEB6cv9Ct+QRwU=
=Yrrl
-----END PGP SIGNATURE-----

--nAZw+Rabccy81wd0--
