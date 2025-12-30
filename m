Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74753D531;
	Tue, 30 Dec 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767116789; cv=none; b=Fuq03Vm4NiMl70bIRsnY4Rehb0k2Vckb0JJ7oY0dEgvii2oF1k/vdWR1d/Z6oW6CO3E1Pim8QA0wY5EH07m7tj5sAtJhY7aFXLwqKSrTWxgYRIHUA25xZV+M9QS5QV0g33jVNSyuw8q1HA1fL0LUK9N41WDRs8MNfk81s+1iRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767116789; c=relaxed/simple;
	bh=t986NWjtOCY432CYhl/i72wzsePu9ObhJ6p9g0WCm6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYJqmSin+kskJC6yIw/vy47A6JU7w82lqAmUlo0XQJh+H+dJ78U7n5szz7h12yClu26iBEiiEKBPcMnWb7KeS3BXa/rmDZQQcdKgjGoCB6PDvPqTgdfgML5YiGPW6gcCNU4d6HT29iaUE9mxfCaEIg3JiAHGYRRvNC6esP/Q/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvOzge0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvOzge0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E373C4CEFB;
	Tue, 30 Dec 2025 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767116789;
	bh=t986NWjtOCY432CYhl/i72wzsePu9ObhJ6p9g0WCm6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvOzge0lTO1Esbu8a+PFR/gpch9eDV5+DU1Bi8a5rqM8MLc1zJ6HmyjfkNGaHuaoN
	 mmf74/07dkK+FVhfPac8k52dCuMGeAEEz4l+CnyTYZw6CJdidNJm7k1WvVfKOKFi/8
	 Pf18DDTtlX8+zv/hO5eIrYzsR1CLI3UMGM0BWWP/CUfMFJ3z5PBBmlBOuHh/daL3wk
	 /wXxqxugS8DYBDWAh/7q751SOm0b0OlgetxUzRYbFstUbdhT76n2hcmstdW8aGCC++
	 huCH93mT3jPdHc3p4XzGe3zuknM8rh76FvOJpSw4Q9uj3nUHDfqWdyQbwwgSGmi7B7
	 CiWB1IksC9BXg==
Date: Tue, 30 Dec 2025 17:46:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Message-ID: <20251230-ungloved-unworthy-cacc7e22e1c7@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com>
 <20251222-stitch-preachy-3fab87fd6f0f@spud>
 <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com>
 <66c0676a-7920-4825-b916-3c00b1648a08@riscstar.com>
 <20251230-imprison-sleet-6b5a1e26d34b@spud>
 <dc87a3c0-8627-4328-a17a-6510ee8245ac@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xe10YCEvPWRSR39s"
Content-Disposition: inline
In-Reply-To: <dc87a3c0-8627-4328-a17a-6510ee8245ac@riscstar.com>


--Xe10YCEvPWRSR39s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 11:29:14AM -0600, Alex Elder wrote:
> On 12/30/25 11:09 AM, Conor Dooley wrote:
> > On Fri, Dec 26, 2025 at 03:28:25PM -0600, Alex Elder wrote:
> > > On 12/23/25 12:51 AM, Guodong Xu wrote:
> > > > Hi, Conor
> > > >=20
> > > > On Tue, Dec 23, 2025 at 5:17=E2=80=AFAM Conor Dooley <conor@kernel.=
org> wrote:
> > > > >=20
> > > > > On Mon, Dec 22, 2025 at 09:04:17PM +0800, Guodong Xu wrote:
> > > > > > Add description of the single-letter "B" extennsion for Bit Man=
ipulation.
> > > > > > B is mandatory for RVA23U64.
> > > > > >=20
> > > > > > The B extension is ratified in the 20240411 version of the unpr=
ivileged
> > > > > > ISA specification. According to the ratified spec, "the B stand=
ard
> > > > > > extension comprises instructions provided by the Zba, Zbb, and =
Zbs
> > > > > > extensions.
> > > > > >=20
> > > > > > Hence add a schema check rule to enforce that B implies Zba, Zb=
b and Zbs.
> > > > > >=20
> > > > > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > > > > ---
> > > > > > v2: New patch.
> > > > > > ---
> > > > > >    .../devicetree/bindings/riscv/extensions.yaml         | 19 +=
++++++++++++++++++
> > > > > >    1 file changed, 19 insertions(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/riscv/extensions=
=2Eyaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > > > index 565cb2cbb49b552959392810a9b731b43346a594..385e1deb23996d2=
94e7662693f1257f910a6e129 100644
> > > > > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > > > @@ -109,6 +109,13 @@ properties:
> > > > > >                The standard C extension for compressed instruct=
ions, as ratified in
> > > > > >                the 20191213 version of the unprivileged ISA spe=
cification.
> > > > > >=20
> > > > > > +        - const: b
> > > > > > +          description:
> > > > > > +            The standard B extension for bit manipulation inst=
ructions, as
> > > > > > +            ratified in the 20240411 version of the unprivileg=
ed ISA
> > > > > > +            specification. The B standard extension comprises =
instructions
> > > > > > +            provided by the Zba, Zbb, and Zbs extensions.
> > > > > > +
> > > > > >            - const: v
> > > > > >              description:
> > > > > >                The standard V extension for vector operations, =
as ratified
> > > > > > @@ -735,6 +742,18 @@ properties:
> > > > > >            then:
> > > > > >              contains:
> > > > > >                const: f
> > > > > > +      # b comprises the following extensions
> > > > > > +      - if:
> > > > > > +          contains:
> > > > > > +            const: b
> > > > >=20
> > > > > What's the value in adding b, if it depends on having all 3 of the
> > > > > components defined individually too? Currently all "superset" typ=
es of
> > > > > extensions are permitted without their component parts also being=
 defined,
> > > > > this doesn't follow convention and therefore needs to be explaine=
d.
> > > > >=20
> > > > > You obviously need this construct because the kernel does not und=
erstand
> > > > > "b", and even if you added support for interpreting "b" to the ke=
rnel
> > > > > this is probably still needed to make sure the ABI is maintained =
for
> > > > > anything importing a devicetree from the kernel.
> > > >=20
> > > > Yes, exactly. Unlike other single-letter extensions, "b" was ratifi=
ed
> > > > (Apr/2024) much later than its components zba/zbb/zbs (Jun/2021).
> > > > Existing software and the kernel already expect these explicit comp=
onent
> > > > strings, so enforcing this dependency ensures cores declaring "b" w=
ill
> > > > also be correctly understood by older software that only looks for
> > > > zba/zbb/zbs.
> > >=20
> > > I might be misunderstanding you, but I don't think extension "b"
> > > should *require* the other three extensions.  Instead, the "b"
> > > extension should be considered *equivalent* to the other three.
> > > That's what I understand it to mean, anyway.
> > >    https://github.com/riscv/riscv-b
> > >=20
> > > There's no point in supporting "b" in devicetree to represent
> > > the others if it also requires the others to be present.
> >=20
> > The dependency can be go both ways, to also make specifying "b" mandato=
ry
> > when the three components are. That probably produces the most helpful
> > devicetree ultimately.
>=20
> What about DT files that specified zba+zbb+zbs before "b" was
> ratified?

They'd generate a warning, which can then be fixed. That's fine to do, a
warning in linux-next doesn't harm anyone. Updating devicetrees in ways
that don't change their meaning but provide extra value is not a problem
in my book.

> > > I think that, instead, "b", "zba", "zbb", and "zbs" should all
> > > be allowed.
> >=20
> > > I might even go further and harden the requirement, saying that
> > > if you specify "b" you should *not* specify "zba", "zbb", or "zbs".
> > > But that might not be normal practice, and it's not necessary
> > > because they aren't in conflict.
> >=20
> > I disagree completely with this "even further", since that's potentially
> > actively harmful to importers of kernel devicetrees.
>=20
> This is related to one of the things I mentioned to Rob that I
> wanted to discuss.
>=20
> This type of "equivalent" extension is problematic for DT, or I
> guess, it doesn't really add any value.  I'm sure the people
> ratifying "b" to be equivalent to "zba+zbb+zbs" intend for it
> to simplify how the supported extensions are represented.
>=20
> But it actually complicates things for DT.  If you're going
> to support just "b" (which would be simpler and more concise)
> then there needs to be logic that treats the two possibilities
> as equivalent.  But old software won't recognize new DT files
> that contain only the newer (e.g. "b") extension.
>=20
> So I agree, there's active harm in doing what I suggested.

> But why even bother supporting "b" if you have to *also*
> support "zba+zbb+zbs" if you use it?  It adds the possibility
> of new errors ("b" without "zbs", for example), while not
> really enabling or representing anything new.

That was my first question after all! Ultimately I'd really err on the
side of adding it because people will expect to be able to use it and
because, in terms of kernel support, it will be useful for ACPI systems.

--Xe10YCEvPWRSR39s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaVQP7QAKCRB4tDGHoIJi
0gQuAP0Y/7pa1RHrtlKH+j1rodHRjxVYm9Ym4J1qkVxbq2ad7wEA3cCt3k/yuNhv
9vwYxyz+cSIUawgQEZ46x1v9ASutDAg=
=FGZt
-----END PGP SIGNATURE-----

--Xe10YCEvPWRSR39s--
