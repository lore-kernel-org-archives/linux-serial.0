Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5541F9AB9;
	Mon, 21 Oct 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513324; cv=none; b=pAXlrL+A6M29uiB30qle1uS3EjV2RPu8cBlqhUefcqPYGlOiyeFEdrxXTdx4CswqBC88JpRyDhX8gGkglbI2ahXGFC4fvlS/MX24Otnl9Mzao4yjeE32TvDR3nxxhzd7BLotej+KB8QHszWhUp7BS3ieTbaPKGMO21tCPzBdHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513324; c=relaxed/simple;
	bh=VogxaHDr5VXDt3OXG/BgBX3+80NJA3EfEloZ63QiD7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw4AbuCGErp4TRFHtzRynfnf8ep9IBvhXqI/09/cOnURju6A2yp7G3AD/QwbaHfyXX3QKlUkueNR3qDdbvuH1CxTBiUZOZyFbt36CiAn5Ngbk8gy6OgOR6Vuj5dkjvu6CZbPRZs7b3zA1X9XQ/ebekKxcd07hzJBKkV9IUbNULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n463WHQm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n463WHQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD70C4CEC3;
	Mon, 21 Oct 2024 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513323;
	bh=VogxaHDr5VXDt3OXG/BgBX3+80NJA3EfEloZ63QiD7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n463WHQm9i8QVjyGeh3YMoJAcfrGatS7n1qqFasYQonh5m/Mv+Aw4akG/ZG52sgMn
	 uHZ624sQoxRDJkxYuuRyxr/XYKvIgU5UsQ7Q6nEhpkGrtOg7QSsYo3/i5F+XcY0LLL
	 FSgczerOI7oh76JDaCb4Fyom1SwfsuA5Dk176E91UH1J2hCwzcezor9fIgjTqr/Sf5
	 CPaDMPai/0yREpBwkh6RmHKiDq9G/WHxQfQVPiZ/3qlHCq/jJrd7imk6naNUvy2rP8
	 Iq3BokG3RtcKePOODcI93PdumSJj32OZnqAFlZoc0JxBxvV9r+HvWAB8/w8HxLgTLW
	 qZ7AFh9PYsE+w==
Date: Mon, 21 Oct 2024 13:21:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2044 uarts
Message-ID: <20241021-rosy-drove-1ae3c8985405@spud>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-2-inochiama@gmail.com>
 <20241021-outlying-washday-8f171dedc703@spud>
 <r5ngs2j776jcy6sfirwzmtsoljotatfvgmlmv4sj4xksye2bff@xtn7adafbpfz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vROro1MZrp9CSqQL"
Content-Disposition: inline
In-Reply-To: <r5ngs2j776jcy6sfirwzmtsoljotatfvgmlmv4sj4xksye2bff@xtn7adafbpfz>


--vROro1MZrp9CSqQL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 08:18:58PM +0800, Inochi Amaoto wrote:
> On Mon, Oct 21, 2024 at 01:10:52PM +0100, Conor Dooley wrote:
> > On Mon, Oct 21, 2024 at 03:26:05PM +0800, Inochi Amaoto wrote:
> > > The UART of SG2044 is modified version of the standard Synopsys
> > > DesignWare UART. The UART on SG2044 relys on the internal divisor
> > > and can not set right clock rate for the common bitrates.
> > >=20
> > > Add compatibles string for the Sophgo SG2044 uarts.
> > >=20
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > ---
> > >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 4 ++=
++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uar=
t.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > index 4cdb0dcaccf3..6963f89a1848 100644
> > > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > @@ -58,6 +58,10 @@ properties:
> > >                - brcm,bcm11351-dw-apb-uart
> > >                - brcm,bcm21664-dw-apb-uart
> > >            - const: snps,dw-apb-uart
> > > +      - items:
> > > +          - enum:
> > > +              - sophgo,sg2044-uart
> > > +          - const: snps,dw-apb-uart
> >=20
> > Why does each vendor have an items entry of its own? Seems like needless
> > clutter of the file IMO, except for the renesas bit.
>=20
> I just follow others when writing this binding. I think it may need
> another patch to fix this problem, right?

Yeah. But I'd hold off to see if someone gives a rationale for it being
done this way before sending that. I've not deleted this thread, and
will send an ack if someone justifies why the binding is written like
this.

--vROro1MZrp9CSqQL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxZHZgAKCRB4tDGHoIJi
0rj+AP44waD9B7Jd/XToGUQfeog3xWZy/JWbqvcVrrp8HiNOBQD8CTzmD0lxAnQx
KSwr6YOPFc2LF2eursvFE/afDgddUwk=
=3xW3
-----END PGP SIGNATURE-----

--vROro1MZrp9CSqQL--
