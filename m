Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301657;
	b=nX0fb7qPxQTDQIoUvsw7ufDcWnsDFioXMgRLqcZtM48SR1M7gq2n+U0TPkbR7PsUCq+K
	 6Tl2B0M74XSPrCys/KrB2b9Tf4N3fUBLlL1Y3qjGGR5EEtXRKBjkdXJNQpg+TVxAjGtiq
	 S/EVZxKobc8Dd0Ug83bm9/J+r/Ezav+avSXpBZvEntt4MJBMaR6PlHSUu8qEK1uuuh5y1
	 L1YTHuh6mBhz6BpYEihDvqez5mizlCZyZtmhpFKEeKLWKbb8JjSH+divuYZPrlefM3m+3
	 ofTR2OFMJaL6WNqAHrOkjjlhjOe08dA8+kmQLI4ptiHlh8yADxBSJNM14mphdF33XdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301657;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6cRbs5oqkT6KWm1ocQa4weQvb7ZtTfs7ITLdAIDLxX8=;
	b=u2r0Ew+hA73hKXg7i0Jn/5jJ2IJ/C0m1ltvglTvC/kMekyG6GDAmkVqWHR4IVPJurJIR
	 D7lf++8JBeFqPvZkTt7t7dkjtW0fGNmVzRDpm6i8NPIEPA0aBuiRtF8X4XprDW+X/WZwv
	 VJYvNJhswbFVCmDldjTfUPDhlfcCmS7FP9rio70BEE9l22zzUNAVE3VYKcHLlHQDH6N6D
	 s5aqmY6dxVNnO+jml8XPoD23FXJqVR6noei5jVrw1MiioDKw52SNISuKqjlwf35jmZGYd
	 zw3nOFFFD6J+r0DhMqq3mPnnExJzYBBmwfDNnlWB5azPsTZS5KqpIfRopu5DPGYQjJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dn26AmIH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778ED606A33C;
	Thu, 29 Oct 2026 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dn26AmIH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A211F01824;
	Thu, 29 Oct 2026 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301649;
	bh=6cRbs5oqkT6KWm1ocQa4weQvb7ZtTfs7ITLdAIDLxX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dn26AmIHNql4k0vIhoTKyGSjVJ4cgpmGwE2pX2CE4VKQsm6Aexk95CuLDLOIYVU0F
	 dG8fIXm2p+2PJFCUzbUmZr5GOw8cxUaUmNM23yD2hphNspemteyEWIW/MC4Sy9KDE3
	 SexvEyi1ceDvbO+PdJ1eiePZ1xsHiGMc3+rH8c5x3NB5CXsBj4+KT3cHsM8+QqvFWn
	 n1l65j/tMmv2hvUkghE7K8NY9edNcBbAz9AnLDeq0cEXSWI3z5TwslHlT+sQbbJ4K8
	 nWprPv/+kXp+D0rD60DtBZxyT3Bp70dJ+EK7ZFm7SF0RNJbQintERb8KV5No3StC9G
	 1vSTaxHQy7IMQ==
Date: Thu, 29 Oct 2026 19:20:41 +0000
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
Message-ID: <20261029-amuser-savior-6a6ab062f471@spud>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
 <20261029-spyglass-evasion-772697094cb9@spud>
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
	protocol="application/pgp-signature"; boundary="FP9ChwAHSeteGPVI"
Content-Disposition: inline
In-Reply-To: <20261029-spyglass-evasion-772697094cb9@spud>

--FP9ChwAHSeteGPVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 07:08:56PM +0000, Conor Dooley wrote:
> On Thu, Oct 29, 2026 at 01:05:53AM -0400, Kwanghoon Son wrote:
> > Add a MAINTAINERS entry for the Bouffalo Lab BL808 platform, device tre=
es
> > and Rust serial driver and abstractions.
> >=20
> > Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> > ---
> >  MAINTAINERS | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 801f964899ba790a8f71fe61f9b3777a494dabd5..b76d3e168468bf6139c958a=
81b626c73b422c0d4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4926,6 +4926,19 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> >  F:	drivers/iio/imu/bmi323/
> > =20
> > +BOUFFALO LAB BL808 SUPPORT
> > +M:	Kwanghoon Son <asdfkwang@gmail.com>
> > +L:	linux-riscv@lists.infradead.org
> > +L:	linux-serial@vger.kernel.org
> > +S:	Maintained
>=20
> Missing git tree, unless you're expecting me to apply patches for the
> platform for you?

Additionally, are you actually going to add wider scale support for this
device? Like a clock-controller driver and the various other
peripherals, or is this really just a vehicle to support your rust
serial driver work?

>=20
> > +F:	Documentation/devicetree/bindings/riscv/bflb.yaml
> > +F:	Documentation/devicetree/bindings/serial/bflb,uart.yaml
> > +F:	arch/riscv/boot/dts/bouffalolab/
> > +F:	drivers/tty/serial/bflb_uart.rs
>=20
> > +F:	rust/helpers/serial.c
> > +F:	rust/kernel/serial.rs
> > +F:	rust/kernel/serial/
>=20
> These should probably not be maintained under the arch support since
> they're not platform specific.
>=20
> > +
> >  BPF JIT for ARC
> >  M:	Shahab Vahedi <list+bpf@vahedi.org>
> >  L:	bpf@vger.kernel.org
> >=20
> > --=20
> > 2.47.3
> >=20



--FP9ChwAHSeteGPVI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOciQAKCRB4tDGHoIJi
0kaYAQDe/U5aSNMnBN+gfEYMXHcowI6WsE/iqPlFmGa663zB1gEA7nC4tnTPdBIy
gnEMK9pC2q6MB8djjcDHvekkukxybgc=
=vdAX
-----END PGP SIGNATURE-----

--FP9ChwAHSeteGPVI--
