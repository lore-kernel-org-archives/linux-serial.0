Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386132;
	b=lP2OELtdziPHX1H9k5HHaKtyPTZesF9wbFv3K/t3tyNTRSVE9tUQEviwxtA5N+iizxQr
	 oIL4arpArcDBfRKop/lK+N3skkHwTDLEDvElFwVGSrARhFmg0epT82Qjvz+mUSqghRbcJ
	 t4OS/qYcxubxOYHeO0ZTp1owIEejgfj1O05KAm7sBvVBg9TDFaqdNu9AhM9UbM4eXnc4N
	 OIwN+MP3s+WWUhMUzE0SqJKGjCr1k3gMG5KOAkStF0oeWmEI3FVs4DYm/n4qeUoOf+ZW8
	 sCRqNKRT+PbXSXFc+CfqWQ+wzi5ia5l2+Mjz+VXG9jfs/PleXVlsG/mIdcxhc1YVmrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386132;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R/eIeqkBzYBk/a7bk6HBVW5bw90Y01K8kHpJhRb/ZEw=;
	b=heos3C4IpxacHAQvwfQyC4hn6Zwkq00j6nw+DnuiKhD+Wh4dg0QHPbAOYzu4CRQKZ04I
	 d29ACVzpmIxBu2SveLJG1pVDoDk7LKrX88nx9GGxFN/obEJUtGcaG5lOcLI4aow+1L8Tr
	 DRAXTN72D1MRRYfaEQHYv+3KsN8gzVG99BLjC5qjwL2+YaNS+iv4/05C4EzasMEDQVykW
	 l00B4tZM3tNoJEtz3xPGdqmNgK+BnaUTN2ojmZ5cXRlxa+q2crRJ5B5A45wwaHWf6b+JB
	 HqMajz9TazbxyCAhs7F1E8nE4Bq7iYj0LjmnNUHMDMb5kx5GuYMp60pbr+48fkhhYAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dne/oRkf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DD606A31A;
	Fri, 30 Oct 2026 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dne/oRkf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A2C1F000C1;
	Fri, 30 Oct 2026 18:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386131;
	bh=R/eIeqkBzYBk/a7bk6HBVW5bw90Y01K8kHpJhRb/ZEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dne/oRkfLYri4BFiKeyLkAjOPPkE4/MjbAS5xLOIkxVFiO5Tz3S2GwZy5vqztJS+S
	 SlH+BLaXRWJjUvYldSciyH5tr9fj5GWB0DP21dSZHUny+9haPdib/8Z30pmXR7tkAS
	 y3oj2gFInLggMWmmTMengisGONlGd/GwvWkGpGeeZCP6JMUvOlmta8IJO9XKXxR2tT
	 3+Wqci9W9kMknmBQor273A8rkAUmN7ziVLIDMzDZ+Ke+Rgh/IxRyj/0AQMxGdIZjdB
	 EaBnqu3AgerPufv67HsyfTChzJu9jO9qgHDrHbPI8ofwt5Ru/5fWgEPGUcOBPW1QYk
	 XyBu0HOERGGYw==
Date: Fri, 30 Oct 2026 18:48:42 +0000
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
Message-ID: <20261030-slider-finished-360b10521e0b@spud>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-12-b736ee920078@gmail.com>
 <20261029-spyglass-evasion-772697094cb9@spud>
 <20261029-amuser-savior-6a6ab062f471@spud>
 <auSDJH9V31wmbrYv@debian>
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
	protocol="application/pgp-signature"; boundary="z09qSibq+nPgici6"
Content-Disposition: inline
In-Reply-To: <auSDJH9V31wmbrYv@debian>

--z09qSibq+nPgici6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 07:44:36AM -0400, Kwanghoon Son wrote:
> On Thu, Oct 29, 2026 at 07:20:41PM +0000, Conor Dooley wrote:
> > On Thu, Oct 29, 2026 at 07:08:56PM +0000, Conor Dooley wrote:
> > > On Thu, Oct 29, 2026 at 01:05:53AM -0400, Kwanghoon Son wrote:
> > > > Add a MAINTAINERS entry for the Bouffalo Lab BL808 platform, device=
 trees
> > > > and Rust serial driver and abstractions.
> > > >=20
> > > > Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
> > > > ---
> > > >  MAINTAINERS | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 801f964899ba790a8f71fe61f9b3777a494dabd5..b76d3e168468bf6139c=
958a81b626c73b422c0d4 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -4926,6 +4926,19 @@ S:	Maintained
> > > >  F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> > > >  F:	drivers/iio/imu/bmi323/
> > > > =20
> > > > +BOUFFALO LAB BL808 SUPPORT
> > > > +M:	Kwanghoon Son <asdfkwang@gmail.com>
> > > > +L:	linux-riscv@lists.infradead.org
> > > > +L:	linux-serial@vger.kernel.org
> > > > +S:	Maintained
> > >=20
> > > Missing git tree, unless you're expecting me to apply patches for the
> > > platform for you?
>=20
> I added this entry after seeing checkpatch's MAINTAINERS warning,
> but made its scope too broad. I'll separate the BL808 platform support
> from the generic Rust serial abstractions in MAINTAINERS.

Okay, that's good - but that's more of a response to my comment down
below about splitting the entry, not a response to what I was asking
here about the lack of a git tree. Are you going to send the SoC
maintainers PRs for this platform or were you expecting someone else to
apply the patches for this platform (IOW, me).

>=20
> >=20
> > Additionally, are you actually going to add wider scale support for this
> > device? Like a clock-controller driver and the various other
> > peripherals, or is this really just a vehicle to support your rust
> > serial driver work?
> >=20
>=20
> Yes, I'd like to extend BL808 support beyond serial. I have local work
> on peripheral clock/reset support, pinctrl/GPIO, SPI and PWM, including
> an SPI display on the M1s Dock.
>=20
> I'd like to bring those pieces upstream incrementally as they are ready!

Cool!

>=20
> > >=20
> > > > +F:	Documentation/devicetree/bindings/riscv/bflb.yaml
> > > > +F:	Documentation/devicetree/bindings/serial/bflb,uart.yaml
> > > > +F:	arch/riscv/boot/dts/bouffalolab/
> > > > +F:	drivers/tty/serial/bflb_uart.rs
> > >=20
> > > > +F:	rust/helpers/serial.c
> > > > +F:	rust/kernel/serial.rs
> > > > +F:	rust/kernel/serial/
> > >=20
> > > These should probably not be maintained under the arch support since
> > > they're not platform specific.
> > >=20
> > > > +
> > > >  BPF JIT for ARC
> > > >  M:	Shahab Vahedi <list+bpf@vahedi.org>
> > > >  L:	bpf@vger.kernel.org
> > > >=20
> > > > --=20
> > > > 2.47.3
> > > >=20
> >=20
> >=20
>=20
> Thanks for review!
>=20
> Best regards,
> Kwang.

--z09qSibq+nPgici6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauTmigAKCRB4tDGHoIJi
0kS/AQD87LyZbjxV+0reytTO2JJdLqp7qGXF8E+JLF1EVO2SNwD+PJ0smcHb0yyh
KcwNJW06vgZpnTnI5RXuUEIPuE3QcQs=
=UI1l
-----END PGP SIGNATURE-----

--z09qSibq+nPgici6--
