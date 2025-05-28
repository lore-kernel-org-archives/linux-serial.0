Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709928750D;
	Wed, 28 May 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439302; cv=none; b=dmZViHZUZlj1pBP/FMwLTJn4rbp7X79IyLUU4glX94/+Ux82GDGL1N7eqiqEynUgJ4bWRx6B/AKLje1dwGhhAQ6hkxP1XCV/JcpJ+8ly99JA0NgJ5dwna+CclpenYQCDKtCf+GaC30mx+oiCsPCDk5tJqFjvSXCP0JdVm1/ZS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439302; c=relaxed/simple;
	bh=AL79StjEVtOpavdCkIahecDYTSI5U301axB+UHG6/+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i48dwgptsdM3eJq0oS0o0PRBCY81k5wdCEnQ4Q98yFrU1i5jIDZGpEnRi2OVHw9QpteKwaaW2asMtHvsqfoP+M24cWUOOBxDQeZ0zMn9f9pVHW+jFPFk3VKbEbOk4fCT2Dd2kisTD9BLqWRi4xtRpN1772TrmtubvLAq9qxsk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcZ1hRKl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcZ1hRKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0E8C4CEE7;
	Wed, 28 May 2025 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748439301;
	bh=AL79StjEVtOpavdCkIahecDYTSI5U301axB+UHG6/+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcZ1hRKl5SI6DfS7sQRRpj9srZkoV1J1Ed07m7kfcRYNurWctQ2ZJdCkF3SD+LI1j
	 /pTze2DEljbQvvEtdsJNehKbTrKru8jANdHP0ioR5QtL1QeaCtH3Lg0L/7to98X+PA
	 HBT4BHe+F4DXI7paCfPryMjT8TbQKGI3Zrco3GORP3ur8QKLVlwGACfAT9DnQW7ZwI
	 nJzLtwY8xiOPD9/WYwHLTudmE4cw0pcDj9IJZM7ElP/X0B/uX1waFeIHkIZaSFFHou
	 IMA8EsJuXVSMmpXvuyWPfsTPtEt8QMLXq+Ue46tGtpdO72UAduNeiFbpA/jxus95ng
	 UDzauWwz9ka0g==
Date: Wed, 28 May 2025 14:34:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: Make clocks and
 clock-frequency exclusive
Message-ID: <20250528-drastic-clever-e6122922e360@spud>
References: <20250524105602.53949-1-ziyao@disroot.org>
 <20250527-polio-snooze-c05aafc1e270@spud>
 <aDZ0NPg2UCVZisk2@pie.lan>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="340YyRNb6DFGG/A4"
Content-Disposition: inline
In-Reply-To: <aDZ0NPg2UCVZisk2@pie.lan>


--340YyRNb6DFGG/A4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 02:25:56AM +0000, Yao Zi wrote:
> On Tue, May 27, 2025 at 04:24:11PM +0100, Conor Dooley wrote:
> > On Sat, May 24, 2025 at 10:56:02AM +0000, Yao Zi wrote:
> > > The 8250 binding before converting to json-schema states,
> > >=20
> > >   - clock-frequency : the input clock frequency for the UART
> > >   	or
> > >   - clocks phandle to refer to the clk used as per Documentation/devi=
cetree
> > >=20
> > > for clock-related properties, where "or" indicates these properties
> > > shouldn't exist at the same time.
> > >=20
> > > Additionally, the behavior of Linux's driver is strange when both clo=
cks
> > > and clock-frequency are specified: it ignores clocks and obtains the
> > > frequency from clock-frequency, left the specified clocks unclaimed. =
It
> > > may even be disabled, which is undesired most of the time.
> >=20
> > That sounds like an issue in the driver itself, no? If the clock phandle
> > is present it sounds like the driver should be claiming the clock
> > whether a frequency is specified or not. If so, that should be fixed
> > whether this patch gets applied or not.
>=20
> Agree.
>=20
> > >=20
> > > But "anyOf" doesn't prevent these two properties from coexisting, as =
it
> > > considers the object valid as long as there's at LEAST one match.
> > >=20
> > > Let's switch to "oneOf" and disallows the other property if one exist=
s,
> > > exclusively matching the original binding and avoid future confusion =
on
> > > the driver's behavior.
> >=20
> > Have you checked whether or not there are devices that have both
> > in-tree? If there are, can you fix them up as part of the change, rather
> > than adding new warnings.
>=20
> Had taken a brief search, seems all UARTs ship both clock-frqeuency and
> clocks properties are snps,dw-apb-uart variants, which are not related
> to the generic 8250 binding. So I think it shouldn't cause new warnings.
>=20
> > >=20
> > > Fixes: e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to json-schem=
a")
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >  Documentation/devicetree/bindings/serial/8250.yaml | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Doc=
umentation/devicetree/bindings/serial/8250.yaml
> > > index dc0d52920575..4322394f5b8f 100644
> > > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > > @@ -45,9 +45,13 @@ allOf:
> > >                    - ns16550
> > >                    - ns16550a
> > >      then:
> > > -      anyOf:
> > > -        - required: [ clock-frequency ]
> > > -        - required: [ clocks ]
> > > +      oneOf:
> > > +        - allOf:
> >=20
> > Why is the allOf needed here? Does
> > oneOf:
> >   - required: foo
> >   - required: bar
> > not work? There's a bunch of bindings doing that, so not sure why it
> > doesn't work in your case.
>=20
> Oops, you're right, it does work here and emits an "... is valid under
> each of ..." error. Will change to this form in v2.

With that,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
I'd suggest you also send the driver patch to solve the issue on
platforms with whatever existing devicetree with both properties that
you're dealing with - or at the very least it'd open some discussion
about your problem.

--340YyRNb6DFGG/A4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDcRAQAKCRB4tDGHoIJi
0itSAP0cec8wqaljsnwTaGRD+Bzi9Y3dDDG+9F/K2r9XJm7/WgEAg+BAR0d6I+M8
A+ibSVgjYRZXLGLRDFAtnxKWNYwlQwU=
=ibR1
-----END PGP SIGNATURE-----

--340YyRNb6DFGG/A4--
