Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD4154C07;
	Tue, 24 Sep 2024 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190104; cv=none; b=Co3U9for+2PYvNExrQdQOLdk3GtF2ql1zcL7lsApGl8QRSpM1riYEyYF6zQK21Uaw+Hg+NJnv2Y2qYS0+/XaqhI7xwWRMSTFNcz3QFQypmoUbdADqDTL7Phb+w+fnAPfc2+uc+GSwHeYza1DbxbhGSc9MNY3zprzkOtccifyM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190104; c=relaxed/simple;
	bh=/+9qcSupVH3POPJZxwbHSgEWylRpVy/CmFKPvlY5QvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGCmKpmBhkfSery2w4/zHWqrqpiHBAZWMTioUeZ48Jflr0pIyy/sKOXLXX/JgcM4VuWCqiWTBADX9Eajzsvj5Ej1F4zmHnR2Xo6G0i/oc67hXMNlp6VEFO0+dj6ZvEiKb5yDyGR9k9TfgK+E1LJd8BOYlQ4hM2fXah9+Q0fpnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llLTLK9D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llLTLK9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0300AC4CEC4;
	Tue, 24 Sep 2024 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727190103;
	bh=/+9qcSupVH3POPJZxwbHSgEWylRpVy/CmFKPvlY5QvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=llLTLK9DJhRBXjXa3i7fBUNevVn7pZwH6LRArtH+yz0A5UXbN1KSR7ZoTzIzEoPZG
	 6UaSOiK/JsDsdaYBNeT/AGyBDuL7vOuBwDY5iw823XZwuoLMZy7vqaUAvhPO3RbKhi
	 599aAdfcc22AxoZtm6D+OB8MaY0eQY8eDMx45ElypeEAfWkqxhw+avUIBp1QKVYTWC
	 DogNLIpVzK63oWbVx54k9fGr82/+d4i858/4qmicykjEzS9mRXOfcqnYSDGNaQeunH
	 LP3V1uHFQ3dq+zbnUv6QImkFqf4HY6mOSdX9hnHWObtvhZ5mcEGjqORYVmvbmtiqsx
	 QtkR9VeSfogkA==
Date: Tue, 24 Sep 2024 16:01:38 +0100
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
Message-ID: <20240924-exposure-juiciness-c0e9a0c54854@spud>
References: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
 <20240924141247.132455-2-ciprianmarian.costea@oss.nxp.com>
 <20240924-twitch-embody-0ffb3ab7fd26@spud>
 <b8024c74-f5d7-4b56-96ea-dee5d8dd9a98@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="46w7wTFtPYBTpmqZ"
Content-Disposition: inline
In-Reply-To: <b8024c74-f5d7-4b56-96ea-dee5d8dd9a98@oss.nxp.com>


--46w7wTFtPYBTpmqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 05:52:13PM +0300, Ciprian Marian Costea wrote:
> On 9/24/2024 5:24 PM, Conor Dooley wrote:
> > On Tue, Sep 24, 2024 at 05:12:46PM +0300, Ciprian Costea wrote:
> > > From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > >=20
> > > Add clock definitions for NXP LINFlexD UART bindings
> > > and update the binding examples with S32G2 node.
> > >=20
> > > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.co=
m>
> > > ---
> > >   .../bindings/serial/fsl,s32-linflexuart.yaml  | 21 ++++++++++++++++=
+++
> > >   1 file changed, 21 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflex=
uart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.ya=
ml
> > > index 4171f524a928..45fcab9e186d 100644
> > > --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.ya=
ml
> > > +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.ya=
ml
> > > @@ -34,6 +34,14 @@ properties:
> > >     interrupts:
> > >       maxItems: 1
> > > +  clocks:
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: ipg
> > > +      - const: lin
> >=20
> > Can all devices have 2 clocks, or just the s32g2?
> >=20
>=20
> All devices (S32G2, S32G3 and S32V234) have 2 clocks for LINFlexD module.

I see. How come the driver is capable of working without them?

> They are: "lin" which is the frequency of the baud clock and "ipg" which
> drives the access to the LINFlexD iomapped registers.

It would be good to have an items list in the clocks property with that
information.

--46w7wTFtPYBTpmqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLUUgAKCRB4tDGHoIJi
0mX/AQCI4qKclH3I0o00JjT999XdSMLRWn2oRUBUbbsO5mNWzAD/f6jV4BR/PlzD
koL9ddZgVd/yRVWJpw0JYuG+n6lgYQ4=
=pgIw
-----END PGP SIGNATURE-----

--46w7wTFtPYBTpmqZ--
