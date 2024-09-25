Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC31591F1;
	Wed, 25 Sep 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274461; cv=none; b=SxaUfHmpW2PcS+9BJIh2bzDrCLBoXL0nIasoSgdDN7odv0KKW2DQ5lDJ7mbxA0+og8uOhhtgjgK/m0F4R4fLowhxSBmx2wFHmvoyyTjSsB8XZMVJz1P3esu8rlyFX5vv4JEpFuSP7H1bRX73cMfOG1V3xxKwokJUyf0sjuEF6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274461; c=relaxed/simple;
	bh=63oaX325SYpxbL3bIK8gMNOxof7JWBN8Cv11K1SrD2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQj543ozy7060ZgV38xYqfSBqFAV0JfGcIblp4CLOqm3/fipmLtdRTWKr3T6VdBrMzjpv1Hloj5b5VPKymuvOUDZK7WDUH+Rbpvgu15XApARc4UjVBebNcmW9pU8OUXGDNdCf4kB977m6tC+HVtuMiwspzVFpx1/1h7JyxCerc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg00ml7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg00ml7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD72DC4CEC9;
	Wed, 25 Sep 2024 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727274460;
	bh=63oaX325SYpxbL3bIK8gMNOxof7JWBN8Cv11K1SrD2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mg00ml7NxMoy3bqxa5/5kyfPA3sl37LnByf7e3eE3+siVonLVNa+lbhLOCHk2WGVx
	 tE8vLB6T+9rk49Y8d2vqBQWEOSQs4jG9KR5rkP1/cx96CFF3VD62wllvuNIVV9BWTq
	 N6hzcGS4Q46ktrnzv9AQDegIPK/lGESky1zo0lyfl0wGX3QDc0aAZPYICfbXsX0xMl
	 QrMgaZDHxAaAa2916wzsqP53Ip9DdPXVJgWcmD8HRTHyMZQL1tfbmS/1NRpWBXx6w3
	 1Jrp6sr1fP4NtghSWf5wczOFnEIGXHlgEH0kFqZAxC/Tmr7WoBEPsez/NYazNuQK08
	 wIt7/UJPacSXQ==
Date: Wed, 25 Sep 2024 15:27:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 1/2] dt-bindings: linflexuart: add clock definitions
Message-ID: <20240925-enunciate-bleak-04799744ae2b@spud>
References: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
 <20240924141247.132455-2-ciprianmarian.costea@oss.nxp.com>
 <20240924-twitch-embody-0ffb3ab7fd26@spud>
 <b8024c74-f5d7-4b56-96ea-dee5d8dd9a98@oss.nxp.com>
 <20240924-exposure-juiciness-c0e9a0c54854@spud>
 <a043494e-0dd3-4db1-93c7-55f59dbe2d0f@oss.nxp.com>
 <20240924-pulverize-ranging-0ec3fca845a0@spud>
 <b1282273-51d9-436f-bf39-749ff21f4ea2@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B3l/DQ6TwETtwbP9"
Content-Disposition: inline
In-Reply-To: <b1282273-51d9-436f-bf39-749ff21f4ea2@oss.nxp.com>


--B3l/DQ6TwETtwbP9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 06:32:30PM +0300, Ciprian Marian Costea wrote:
> On 9/24/2024 6:27 PM, Conor Dooley wrote:
> > On Tue, Sep 24, 2024 at 06:17:11PM +0300, Ciprian Marian Costea wrote:
> > > On 9/24/2024 6:01 PM, Conor Dooley wrote:
> > > > On Tue, Sep 24, 2024 at 05:52:13PM +0300, Ciprian Marian Costea wro=
te:
> > > > > On 9/24/2024 5:24 PM, Conor Dooley wrote:
> > > > > > On Tue, Sep 24, 2024 at 05:12:46PM +0300, Ciprian Costea wrote:
> > > > > > > From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > > > > > >=20
> > > > > > > Add clock definitions for NXP LINFlexD UART bindings
> > > > > > > and update the binding examples with S32G2 node.
> > > > > > >=20
> > > > > > > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@os=
s.nxp.com>
> > > > > > > ---
> > > > > > >     .../bindings/serial/fsl,s32-linflexuart.yaml  | 21 ++++++=
+++++++++++++
> > > > > > >     1 file changed, 21 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/devicetree/bindings/serial/fsl,s32=
-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.yaml
> > > > > > > index 4171f524a928..45fcab9e186d 100644
> > > > > > > --- a/Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linfle=
xuart.yaml
> > > > > > > @@ -34,6 +34,14 @@ properties:
> > > > > > >       interrupts:
> > > > > > >         maxItems: 1
> > > > > > > +  clocks:
> > > > > > > +    maxItems: 2
> > > > > > > +
> > > > > > > +  clock-names:
> > > > > > > +    items:
> > > > > > > +      - const: ipg
> > > > > > > +      - const: lin
> > > > > >=20
> > > > > > Can all devices have 2 clocks, or just the s32g2?
> > > > > >=20
> > > > >=20
> > > > > All devices (S32G2, S32G3 and S32V234) have 2 clocks for LINFlexD=
 module.
> > > >=20
> > > > I see. How come the driver is capable of working without them?
> > > >=20
> > >=20
> > > The driver was working because the LINFlexD clocks were configured an=
d kept
> > > enabled by the downstream bootloader (TF-A and U-Boot). This is not i=
deal
> > > since LINFlexD Linux driver should manage those clocks independently =
and not
> > > rely on a previous bootloader configuration (hence the need for this =
current
> > > patchset).
> >=20
> > I'd also mark them as required in the binding too, but the driver will
> > still have to account for them being missing, for backwards
> > compatibility reasons. Add a comment explaining the history to the
> > commit message when you do that.
>=20
> Already in the second patch from this patchset the clocking support was
> added in the LINFlexD driver as optional, indeed for backwards
> compatibility.

Oh great.

> I presumed that because of this optional clock enablement, I should not a=
dd
> the clocks as required in the bindings, but I will do so in V2. Thanks.

IMO required is correct, since it would not have worked properly if the
bootloader hadn't done the setup.

--B3l/DQ6TwETtwbP9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvQd1wAKCRB4tDGHoIJi
0jpzAQC4u1mfSbrQguccpgycXMf3WJfiiUTr6Errb/EdwGB3EwD+NVIBniKKkhll
1mtG/XuKnspmfTTIWW9UXBLlNyzkpwE=
=Czve
-----END PGP SIGNATURE-----

--B3l/DQ6TwETtwbP9--
