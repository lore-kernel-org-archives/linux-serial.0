Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C228682;
	Wed, 24 Dec 2025 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766620389; cv=none; b=qG4SdNZdB4n0bDAALNv0ZTMCM4ksIYUEyJwkxtaCAc91MNutzNrAT1RNeQXT7pkCzGVqaCobSXt4LZV+FJqr1hcXIG4fb6XszxZjkJX3zLTHyLYOoCHwILRGiL1o1g5bnHS9fdtzd0X+i05pffo3fGikaso3/6ic2wAo9ffULhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766620389; c=relaxed/simple;
	bh=H0yqiO0IIh+bx2j+z5i/ox186xpZi3mE9KvZEbkJJuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bzb9sGX45Swb9FUCRoJe/0IFEMDXrMenZoS+pfN+AoSMvWUD3JFD3wpAwI/GIz3IArA9oeKdfZh24v4BsJ3R0SizrPL+FgdyLAntXSMj/OHdCdi01Dxgb649wLUjY3jzm8vPr4gfYAp1XL+Viy4dmAcz2t0eylx3pKunVBbFUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlFxyKY2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlFxyKY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B57C4CEF7;
	Wed, 24 Dec 2025 23:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766620389;
	bh=H0yqiO0IIh+bx2j+z5i/ox186xpZi3mE9KvZEbkJJuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlFxyKY2+80CMGNz7Jd+5h8dEgmn04kJoRtkVRXSZ0yXW9UwMn9P5hmADYMXlHmAi
	 ZochvG5h3JUryyw1cQahRqFJADt6oABUlPucQIPabU60fsYmwNiq4qiPpx8iuyNZst
	 cHZ2w9QDLn5+xMHcrh6azjhkah2GmrMK+MVjdPgsLltrpM928JQzFsWxKu5hNyO0Zu
	 QC+xyWPrhR/v9yoyBJ1Fuqe7u5UFtWq6QHflaAbGkB0Byy18UtNjYc1gKBHJofyUdU
	 CvLu40TmvlWHHQM8+JMZh6VXvSzdo+cLlNB+4h81VpZig5/3273Mmvl/FL0XXu5nLz
	 Cv3PAVooB/i7A==
Date: Wed, 24 Dec 2025 23:53:02 +0000
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
Message-ID: <20251224-charcoal-woozy-d2138984e37a@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com>
 <20251222-stitch-preachy-3fab87fd6f0f@spud>
 <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HifpPaV/N2udDB+0"
Content-Disposition: inline
In-Reply-To: <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com>


--HifpPaV/N2udDB+0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 02:51:17PM +0800, Guodong Xu wrote:
> Hi, Conor
>=20
> On Tue, Dec 23, 2025 at 5:17=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Dec 22, 2025 at 09:04:17PM +0800, Guodong Xu wrote:
> > > Add description of the single-letter "B" extennsion for Bit Manipulat=
ion.
> > > B is mandatory for RVA23U64.
> > >
> > > The B extension is ratified in the 20240411 version of the unprivileg=
ed
> > > ISA specification. According to the ratified spec, "the B standard
> > > extension comprises instructions provided by the Zba, Zbb, and Zbs
> > > extensions.
> > >
> > > Hence add a schema check rule to enforce that B implies Zba, Zbb and =
Zbs.
> > >
> > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > ---
> > > v2: New patch.
> > > ---
> > >  .../devicetree/bindings/riscv/extensions.yaml         | 19 +++++++++=
++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml =
b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > index 565cb2cbb49b552959392810a9b731b43346a594..385e1deb23996d294e766=
2693f1257f910a6e129 100644
> > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > @@ -109,6 +109,13 @@ properties:
> > >              The standard C extension for compressed instructions, as=
 ratified in
> > >              the 20191213 version of the unprivileged ISA specificati=
on.
> > >
> > > +        - const: b
> > > +          description:
> > > +            The standard B extension for bit manipulation instructio=
ns, as
> > > +            ratified in the 20240411 version of the unprivileged ISA
> > > +            specification. The B standard extension comprises instru=
ctions
> > > +            provided by the Zba, Zbb, and Zbs extensions.
> > > +
> > >          - const: v
> > >            description:
> > >              The standard V extension for vector operations, as ratif=
ied
> > > @@ -735,6 +742,18 @@ properties:
> > >          then:
> > >            contains:
> > >              const: f
> > > +      # b comprises the following extensions
> > > +      - if:
> > > +          contains:
> > > +            const: b
> >
> > What's the value in adding b, if it depends on having all 3 of the
> > components defined individually too? Currently all "superset" types of
> > extensions are permitted without their component parts also being defin=
ed,
> > this doesn't follow convention and therefore needs to be explained.
> >
> > You obviously need this construct because the kernel does not understand
> > "b", and even if you added support for interpreting "b" to the kernel
> > this is probably still needed to make sure the ABI is maintained for
> > anything importing a devicetree from the kernel.
>=20
> Yes, exactly. Unlike other single-letter extensions, "b" was ratified
> (Apr/2024) much later than its components zba/zbb/zbs (Jun/2021).
> Existing software and the kernel already expect these explicit component
> strings, so enforcing this dependency ensures cores declaring "b" will
> also be correctly understood by older software that only looks for
> zba/zbb/zbs.
>=20
> I will update the commit message in v3 to clearly explain this reasoning.

> Does it sound good to you?

Ye, sounds good.

--HifpPaV/N2udDB+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUx83gAKCRB4tDGHoIJi
0ljjAP96xVKxRWfFsjBSIjF8h7xUeXl0VufSfLRn5F0vEPVYagD9FVwi2yti7kCT
/cmOcUpIv5O0e1rm6HZBmL6W+TJv+ws=
=eCFG
-----END PGP SIGNATURE-----

--HifpPaV/N2udDB+0--
