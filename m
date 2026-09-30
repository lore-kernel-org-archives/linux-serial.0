Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C89511180;
	Wed, 30 Sep 2026 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786117; cv=none; b=Fx7HCkKf0LYrv8Baje2M4x+he6nBWND6KA86PGxW2+YAy7vREycQkQQgZ2us38SNP5u+n37WU8C3yhb5cyAiPkMsGeuBoaNh3+NAGLj11Dhi89HGZ/zSoXZc3W1vOBhOPO6v7TzOpGsqIi2Q3fJ1jfYE/rcNLuCUM2e+me7IZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786117; c=relaxed/simple;
	bh=IotFDljTrZjJVOHJs5Jb8Ssuv+icr3IseWCLlR0xMJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsJvaAoZGsnzwlD3Xz4jwP/pUcYljix36WWzOIXzcJ6+fwlVojvS/jPR0aLe7pK35UQYUL6yDLdpj+fbm8XaKZgDx1m5982iCE6D6jXI+w17OSORn2nBvEZ03IpJ8Q0XcyqZd5mBgJBszNVZ/2ENyCtohcie3QKknD8EYJYsdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqkbTaeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqkbTaeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FCA1F00893;
	Wed, 30 Sep 2026 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790786116;
	bh=IotFDljTrZjJVOHJs5Jb8Ssuv+icr3IseWCLlR0xMJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BqkbTaeEJGPn65JzBCPQabvkfi4q3suZsUonrQ3JIYiiyBzhY/r9JNQUUwQ4lEnDf
	 UHIK5MS3srRqxbW56VkqD3p70BI2Y0c6OKFlj6G4gltrPwBGrgKdbY408ULgmc4Tm0
	 Ztg7yaeTGTz9GRlUb3PsnbV39dgYKKXEQJsjbdmo0RgLhWDe00VmQ+JF0ITPnrBbHF
	 9szCsNcsoKrnCD6vV9vh4wvdr2bSD3+XSqIb5sGXvL/J2w291GLOEWYhZkQ2L7TsXM
	 xDS79Vy3/jO+IhE+uyNP7JEPXozepUeV4VPYvK7sJgvoA4nYxECPu4SXOKrFPEXz95
	 +aGYtEz7XxSYQ==
Date: Wed, 30 Sep 2026 17:35:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/20] arm64: add Synaptics SL261X SoCs and RDK boards
Message-ID: <20260930-consoling-scouting-e60864374d04@spud>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929-smoked-laurel-087d5a3523a3@spud>
 <ar0da71zOeeYxURQ@xhacker>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0aKKosY+SZkBUlIw"
Content-Disposition: inline
In-Reply-To: <ar0da71zOeeYxURQ@xhacker>

--0aKKosY+SZkBUlIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:32:11PM +0800, Jisheng Zhang wrote:
> On Tue, Sep 29, 2026 at 08:38:52PM +0100, Conor Dooley wrote:
> > On Tue, Sep 29, 2026 at 02:13:57PM +0800, Jisheng Zhang wrote:
> > > Add initial support for the Synaptics SL261X SoCs and corresponding
> > > RDK boards.
> > >=20
> > > The SL261X SoCs include five pin-to-pin compatible SoCs: SL2611, SL26=
13,
> > > SL2615, SL2617, and SL2619.
> > >=20
> > > Only reset, pinctrl, clk/pll, uart, gpio, i2c, spi, i3c are included =
in
> > > this series. The support for Ethernet, USB, SDHCI, CAN, DMAC, XSPI wi=
ll
> > > be submitted after this series is merged.
> >=20
> > This series is filled with wildcard compatibles, which we don't permit
> > typically. The only case for SoCs that I've seen them accepted is when
> > the devices covered are actually just different binnings of the same
> > device. I took a look at the docs for this device, but it wasn't clear
> > to me if these are actually binnings or if there are different
> > integrations here. If they're binnings, I'd rather you used 0 as the
> > final digit, rather than x, since that matches the synaptics
> > documentation for the family. If they're not binnings, there's no
> > guarantee that they share the same errata etc, and must have different
> > compatibles.
>=20
> BTW: May I query a qustion?
> After searching the maillist archieves, it seems now maintainers prefer
> spiliting this kind of SoC initial support series into separate patches
> for different subsystems, e.g uart, i2c, i3c, spi and so on, then the
> SoC pinctrl, clk, reset and dtsi/dts files, but AIUI, there will be
> dtb check failures with the SoC dts(i) files patch(es), what's
> the normal solution then?

Depends on the type of failure, but yes it can be okay. If the failure is
some missing schema causing validation to fail, that's fine as long as it
passes in linux-next (same as when you add a new driver and binding, but
the dts goes to a different branch). What's not acceptable is breaking the
build because some header that provides clock defines is missing in the dts
branch or in the driver branch. In that case, either send all that stuff in
one "New SoC" PR to the soc tree, or put the binding headers in a shared
tag that is the basis for your PR to the relevant maintainers (typically
clock) and the dts PR to the soc tree.

--0aKKosY+SZkBUlIw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar06PAAKCRB4tDGHoIJi
0hpkAP0blrEbmogoZD0AKnwhpfLwMnReZOlvZF7i9+6g8f+4VAEAnxRjQq9YWWJf
7AVUGg191KqlxkjCS4xQdsNuVaTiiQw=
=6gkk
-----END PGP SIGNATURE-----

--0aKKosY+SZkBUlIw--
