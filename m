Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51481AAE13;
	Tue, 24 Sep 2024 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191668; cv=none; b=KaemcIJh3bWX8z6/xnTEgrNfd8TtZLvZ0QH0n5ApF93yRTXfc8T5sGQ3RjSzb5c/n3q6As4qbHEZSgz563/SgBkTGNtync+Q1Ue4PD+K8EB6F+lcf+cT0z3vpV62XLA5/I84CwfSRFlFboupesV3djwllx9zlBW7FBSyKdGbkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191668; c=relaxed/simple;
	bh=yc2knjEPv73lLIQthZ+Gb0/bsbWV2LNL1Qf5zN9S8Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DALRifjqex1whc8NXhQ4Go6tp9pmsw7G1qMVTwAc7Edg1LOmkMglb6cAr+14SYm27Q51iark0gjDXs3DErYKGeTRgtUH+mCWVlhn2aqBVRy1Q5dgYc2UNCTZINpIkVjyKEH/VY65/8EX+eyjAZsDClAldRrJiwNB5MZ8mgxA19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9XPjaVR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9XPjaVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704ABC4CEC4;
	Tue, 24 Sep 2024 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727191668;
	bh=yc2knjEPv73lLIQthZ+Gb0/bsbWV2LNL1Qf5zN9S8Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9XPjaVR5slUb2QP0zW6KvRylsTaNtT3CFjTNEIz0qX9SQhvcfVaLzT1H5pvK+4j/
	 BeyrUHxQBdMwIro5C5VLjkGCyV55Ujn/N09XD/5kG83sRDqs4foNQbF9tnNckxVjiu
	 Nz8D59LKg5ShzBsrqyqriOlvg4/ZZwUocZ7JUV25oZAGKCDpcxGow4QydYMlr8a8ff
	 a3JPgy6MfZC4dUfie5Vz04xwXJbnFCQO1sIcTy0Lfo8rmsgKgQ/mycMkJYdmKnDvMi
	 sNJ65cmNCyJUFy5Y/JtB948M9Gw1Lyfs28fzvKMbgr+0pjZjGfpgCo4DrbY3CQW4IL
	 eUxrvgBYsZiPg==
Date: Tue, 24 Sep 2024 16:27:43 +0100
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
Message-ID: <20240924-pulverize-ranging-0ec3fca845a0@spud>
References: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
 <20240924141247.132455-2-ciprianmarian.costea@oss.nxp.com>
 <20240924-twitch-embody-0ffb3ab7fd26@spud>
 <b8024c74-f5d7-4b56-96ea-dee5d8dd9a98@oss.nxp.com>
 <20240924-exposure-juiciness-c0e9a0c54854@spud>
 <a043494e-0dd3-4db1-93c7-55f59dbe2d0f@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gPqgmOXDQivkzV97"
Content-Disposition: inline
In-Reply-To: <a043494e-0dd3-4db1-93c7-55f59dbe2d0f@oss.nxp.com>


--gPqgmOXDQivkzV97
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 06:17:11PM +0300, Ciprian Marian Costea wrote:
> On 9/24/2024 6:01 PM, Conor Dooley wrote:
> > On Tue, Sep 24, 2024 at 05:52:13PM +0300, Ciprian Marian Costea wrote:
> > > On 9/24/2024 5:24 PM, Conor Dooley wrote:
> > > > On Tue, Sep 24, 2024 at 05:12:46PM +0300, Ciprian Costea wrote:
> > > > > From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > > > >=20
> > > > > Add clock definitions for NXP LINFlexD UART bindings
> > > > > and update the binding examples with S32G2 node.
> > > > >=20
> > > > > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nx=
p.com>
> > > > > ---
> > > > >    .../bindings/serial/fsl,s32-linflexuart.yaml  | 21 +++++++++++=
++++++++
> > > > >    1 file changed, 21 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-lin=
flexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuar=
t.yaml
> > > > > index 4171f524a928..45fcab9e186d 100644
> > > > > --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuar=
t.yaml
> > > > > +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuar=
t.yaml
> > > > > @@ -34,6 +34,14 @@ properties:
> > > > >      interrupts:
> > > > >        maxItems: 1
> > > > > +  clocks:
> > > > > +    maxItems: 2
> > > > > +
> > > > > +  clock-names:
> > > > > +    items:
> > > > > +      - const: ipg
> > > > > +      - const: lin
> > > >=20
> > > > Can all devices have 2 clocks, or just the s32g2?
> > > >=20
> > >=20
> > > All devices (S32G2, S32G3 and S32V234) have 2 clocks for LINFlexD mod=
ule.
> >=20
> > I see. How come the driver is capable of working without them?
> >=20
>=20
> The driver was working because the LINFlexD clocks were configured and ke=
pt
> enabled by the downstream bootloader (TF-A and U-Boot). This is not ideal
> since LINFlexD Linux driver should manage those clocks independently and =
not
> rely on a previous bootloader configuration (hence the need for this curr=
ent
> patchset).

I'd also mark them as required in the binding too, but the driver will
still have to account for them being missing, for backwards
compatibility reasons. Add a comment explaining the history to the
commit message when you do that.

--gPqgmOXDQivkzV97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLabwAKCRB4tDGHoIJi
0uOqAP4063I4lZxR1dhdEzsE9E2w7cKC86X1uM4/6lTy6h6nLwEAobW/rq8DXcxb
imqgCJunc/oUA7En3oSTTYMpOgoxgQ8=
=jo4x
-----END PGP SIGNATURE-----

--gPqgmOXDQivkzV97--
