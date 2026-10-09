Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FD442376;
	Fri,  9 Oct 2026 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560705; cv=none; b=r22rLqeQElkHHFCDJt90la+K13qxlHnycLhpTWLt35gmwXrZwbWASLPZsws8WBdCTt8faJsGp8PZxHUOEmyVdpqyC8OYY2C+N48UvC92WURJY4Dc3k/7plM+DysbBgQPfUJjutBJsqI6BEMbRgoshoUO9P9eS4/g6fmUQj666/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560705; c=relaxed/simple;
	bh=oA3Vfh6qRQ7yC22i/Gas1ob2mb9HsZOFcZDomUnhA1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItC6+qSm5Wu3sr6gSZT5ZnwlhH/0k3RWB3ynvnsXyuQ2f81jWvGV8vx03HyZDqZI5/M9+nqhSh+p0kskXGEGDTBJZ98LPMqb3s52gV8/+QX9UiMFZQRowceQ6EJmn24z+qrPv2WRTlK4gheLFARO5ZTb5ElJYOTtSwHWOlBeuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAAsio8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAAsio8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630721F000FF;
	Fri,  9 Oct 2026 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560702;
	bh=bhneI3i68fkhZ2Jgbi8goQLyl1+Jza3G4dlHPOjaRuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dAAsio8Vvr6puXRP4boe/zQClUwDRdY4zs8XRMVg7lhINUrsbCJJ5cBpHuzfQsEAR
	 dbOY9UGmGrXoBpUS9tXy6I5JLUHuWOlwQrmXAI7iCr7Z5Hn1Lq/HMt+OvwoWalfEaA
	 uMu0cNbonN7mk/JJLclFPB4fF3Z3OCFBCcL3RLkOjLTDjQRNN7Y1HVVTiNIKeBWke9
	 /OnzfpPMlLeT9ZkPNd7o/cZqZTkku9vOyo5lkYf564qdzlehhiQzq/6/GMmCgxga6b
	 7lp1wqcmE31YJfWy/ITdtlUSShOob4L4Mf9KlO7j6YkbQ86QLR8KH+cxjnyHzDjpqW
	 1uClpcuMipKCA==
Date: Fri, 9 Oct 2026 16:44:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add Synaptics
 sl2610 uart
Message-ID: <20261009-a44cbc473aa9a56e36d5a0de@squawk>
References: <20261005151918.25259-1-jszhang@kernel.org>
 <20261007-450d3d9a4f4a2c07cc088067@squawk>
 <asefUxK90dlGkW8a@xhacker>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HMrqKfN3oWVvEGW9"
Content-Disposition: inline
In-Reply-To: <asefUxK90dlGkW8a@xhacker>

--HMrqKfN3oWVvEGW9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026 at 09:49:07PM +0800, Jisheng Zhang wrote:
> On Wed, Oct 07, 2026 at 02:04:05PM +0100, Conor Dooley wrote:
> > On Mon, Oct 05, 2026 at 11:19:18PM +0800, Jisheng Zhang wrote:
> > > Add the compatible for the UARTs of the Synaptics SL2610, which are
> > > compatible with the Synopsys DesignWare APB UART.
> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >=20
> > > since v1:
> > >  - use sl2610 instead of sl261x
> > >  - send as a separate patch
> > >=20
> > >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml | 12 ++++++++++=
+-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uar=
t.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > index 664305de4986..a40f2737e71b 100644
> > > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > @@ -34,7 +34,16 @@ allOf:
> > >        properties:
> > >          resets:
> > >            minItems: 2
> > > -    else:
> > > +
> > > +  - if:
> > > +      not:
> > > +        properties:
> > > +          compatible:
> > > +            contains:
> > > +              enum:
> > > +                - starfive,jh7110-uart
> > > +                - syna,sl2610-uart
> >=20
> > Is the number of uart resets on this device variable?
>=20
> Yes, some uarts have only 1 reset, while others have two resets.

In the future, please mention this so it doesn't look like an oversight.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Thanks,
Conor.

>=20
> >=20
> > > +    then:
> > >        properties:
> > >          resets:
> > >            maxItems: 1
> > > @@ -80,6 +89,7 @@ properties:
> > >                - starfive,jh7100-hsuart
> > >                - starfive,jh7100-uart
> > >                - starfive,jh7110-uart
> > > +              - syna,sl2610-uart
> > >                - ultrarisc,dp1000-uart
> > >            - const: snps,dw-apb-uart
> > >        - const: snps,dw-apb-uart
> > > --=20
> > > 2.53.0
> > >=20
>=20
>=20

--HMrqKfN3oWVvEGW9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaskL9wAKCRB4tDGHoIJi
0pYGAQC9SlEMKUU48PzA3L+JQhl2e4NoT7Gk6afzqvmNvQ0UdAD/WaNW+xB5FHTK
bFSNaNPl6qZxJIzN4QfE/EzDIU1P0wQ=
=pXl5
-----END PGP SIGNATURE-----

--HMrqKfN3oWVvEGW9--
