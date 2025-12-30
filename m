Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415132C305;
	Tue, 30 Dec 2025 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114601; cv=none; b=NjzaX+StIHwOnAccMwqVNx9pVPHJfzXxxQJdzLff5IQn9u32Me5R3OWGH44g8RPEdJM2fBlt77+4NIJB46T3QXX8hUIbZ3Ablja1SGVYklzCbMYeRD70PihlKGuvq4Qcd3Z3D6hm7oiSIBAZ6gzLD7b3PTBYJA4RQ5c8UZxsgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114601; c=relaxed/simple;
	bh=D22/wa8KSWDXfmcDM/UZjmt1GsaferlLEdACnpU/TMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKtWY7GWtn0qjhwV96/YsJJYq84/Qb7/ZEYQ+q9bHqwyqK6Jm6Lu8A7lxUBWFdHMR+hDpzCQQrJGS5WBTJRnFm9y/CK1Tc3WsEbdwNxZ41IoYanT4XM6ponIX1bI30L+45oK2omezld1HDeDvRPRAiIvVPnld+mayhqmjfrySNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkEI6Osh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkEI6Osh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3C1C4CEFB;
	Tue, 30 Dec 2025 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767114600;
	bh=D22/wa8KSWDXfmcDM/UZjmt1GsaferlLEdACnpU/TMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkEI6OshXPjSn99taJ3K4HSF6Nb+dcPepicrpvWCMyczOWvSvfriaSVeyq4Bh2+ub
	 ys9oBB/k2eHOPuGSUvTiGkW7fwfVZKIwTppjhMkYbfsfai8Q6H0WM8aNi3tmwAWF0v
	 a804GTQvTyovg2Xs11eF+Dl5U9ySwjOU+BXk6ByzAYBqYvTY2e4/Mu/dwoInSqBTpv
	 3gtGkJoPSMWJuc6JvIZEKYk/MH9OfRfQgJYjHTQT2/TCPwQLLCOTD0QugsCVOB3D3q
	 O/F4iWy/d1zkFFvLWF8q96KzulGExHXCzH93MwnzultKnaMNOiRDd2ppMdLSLZgnyU
	 jlMPJUlW/XSpA==
Date: Tue, 30 Dec 2025 17:09:52 +0000
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
Message-ID: <20251230-imprison-sleet-6b5a1e26d34b@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com>
 <20251222-stitch-preachy-3fab87fd6f0f@spud>
 <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com>
 <66c0676a-7920-4825-b916-3c00b1648a08@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UppzS2JaFGP6BwpL"
Content-Disposition: inline
In-Reply-To: <66c0676a-7920-4825-b916-3c00b1648a08@riscstar.com>


--UppzS2JaFGP6BwpL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 03:28:25PM -0600, Alex Elder wrote:
> On 12/23/25 12:51 AM, Guodong Xu wrote:
> > Hi, Conor
> >=20
> > On Tue, Dec 23, 2025 at 5:17=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >=20
> > > On Mon, Dec 22, 2025 at 09:04:17PM +0800, Guodong Xu wrote:
> > > > Add description of the single-letter "B" extennsion for Bit Manipul=
ation.
> > > > B is mandatory for RVA23U64.
> > > >=20
> > > > The B extension is ratified in the 20240411 version of the unprivil=
eged
> > > > ISA specification. According to the ratified spec, "the B standard
> > > > extension comprises instructions provided by the Zba, Zbb, and Zbs
> > > > extensions.
> > > >=20
> > > > Hence add a schema check rule to enforce that B implies Zba, Zbb an=
d Zbs.
> > > >=20
> > > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > > ---
> > > > v2: New patch.
> > > > ---
> > > >   .../devicetree/bindings/riscv/extensions.yaml         | 19 ++++++=
+++++++++++++
> > > >   1 file changed, 19 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yam=
l b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > index 565cb2cbb49b552959392810a9b731b43346a594..385e1deb23996d294e7=
662693f1257f910a6e129 100644
> > > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > @@ -109,6 +109,13 @@ properties:
> > > >               The standard C extension for compressed instructions,=
 as ratified in
> > > >               the 20191213 version of the unprivileged ISA specific=
ation.
> > > >=20
> > > > +        - const: b
> > > > +          description:
> > > > +            The standard B extension for bit manipulation instruct=
ions, as
> > > > +            ratified in the 20240411 version of the unprivileged I=
SA
> > > > +            specification. The B standard extension comprises inst=
ructions
> > > > +            provided by the Zba, Zbb, and Zbs extensions.
> > > > +
> > > >           - const: v
> > > >             description:
> > > >               The standard V extension for vector operations, as ra=
tified
> > > > @@ -735,6 +742,18 @@ properties:
> > > >           then:
> > > >             contains:
> > > >               const: f
> > > > +      # b comprises the following extensions
> > > > +      - if:
> > > > +          contains:
> > > > +            const: b
> > >=20
> > > What's the value in adding b, if it depends on having all 3 of the
> > > components defined individually too? Currently all "superset" types of
> > > extensions are permitted without their component parts also being def=
ined,
> > > this doesn't follow convention and therefore needs to be explained.
> > >=20
> > > You obviously need this construct because the kernel does not underst=
and
> > > "b", and even if you added support for interpreting "b" to the kernel
> > > this is probably still needed to make sure the ABI is maintained for
> > > anything importing a devicetree from the kernel.
> >=20
> > Yes, exactly. Unlike other single-letter extensions, "b" was ratified
> > (Apr/2024) much later than its components zba/zbb/zbs (Jun/2021).
> > Existing software and the kernel already expect these explicit component
> > strings, so enforcing this dependency ensures cores declaring "b" will
> > also be correctly understood by older software that only looks for
> > zba/zbb/zbs.
>=20
> I might be misunderstanding you, but I don't think extension "b"
> should *require* the other three extensions.  Instead, the "b"
> extension should be considered *equivalent* to the other three.
> That's what I understand it to mean, anyway.
>   https://github.com/riscv/riscv-b
>=20
> There's no point in supporting "b" in devicetree to represent
> the others if it also requires the others to be present.

The dependency can be go both ways, to also make specifying "b" mandatory
when the three components are. That probably produces the most helpful
devicetree ultimately.

> I think that, instead, "b", "zba", "zbb", and "zbs" should all
> be allowed.

> I might even go further and harden the requirement, saying that
> if you specify "b" you should *not* specify "zba", "zbb", or "zbs".
> But that might not be normal practice, and it's not necessary
> because they aren't in conflict.

I disagree completely with this "even further", since that's potentially
actively harmful to importers of kernel devicetrees.
If "b" is to be allowed, I'm only in favour if having it requires the
component parts.

--UppzS2JaFGP6BwpL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaVQHXQAKCRB4tDGHoIJi
0sitAP9XC4rPR71MuBPWD5gaVqjr7j+cuLMhvbbuT0NMc0HsiwD/fGOfXg/HKoaQ
LVhSMcWQnbakBRz6RXDLYk8GZUczKww=
=mkYw
-----END PGP SIGNATURE-----

--UppzS2JaFGP6BwpL--
