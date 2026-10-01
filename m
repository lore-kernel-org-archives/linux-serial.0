Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F474C33C4;
	Thu,  1 Oct 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889379; cv=none; b=gPMBUfFUfk5hCp34JN4pkwiW97YF60HQTV36/W64FD5psxnqNF87rsT185+N8JIQrvBSAUQ6RDN66ueS+tQCOZOSC+cpp4tEHVaARUa06D/3QzpPrm2ZoayaXZhFTXd4doDhotzYKU+So+VjQzR+D2Wy32QlqzfL5uzFNymsLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889379; c=relaxed/simple;
	bh=j3tZSe6EjWvLL4etfciKqeLMj4yhwYHePqQZXrAv+es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpeviNuzI4POAtAoUfcNAT2AYtXsB52ylsS+LjfZ772RnRtMpYmWe7Gf8juluIbYgTxS9mwzZwJAvr5VISACgPUOdIvAcXMyG08RmLn1PL3lpDymLZKpCg3Y16CcFXYEXs9OS9JUb7CD3hjGnckKSS6edAcjG2Wp7v+3y6HhqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+jof2y/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+jof2y/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924FB1F000FF;
	Thu,  1 Oct 2026 21:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889368;
	bh=j3tZSe6EjWvLL4etfciKqeLMj4yhwYHePqQZXrAv+es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P+jof2y/i9vG8bCW/VDqxjV0fYlsPcFcvV28SPkTi5EJkbAwebXlyhwbk/MQ368pc
	 rdm8EYPgjhCtlAZJs+7OoyURvkpvTWYf0ZfXp/jnS9jZ3s4Y2Fewt00mMzHcQ5VguI
	 7RvKWaUmQzXZBW/5JrzHPjcFhjVnANeuN260qA5Go4yg3zxY7w7j0IDgr3mgnUOO6Y
	 GnY7M1Z7c17LDioDVv3RS0hpTYkR1+Neb4KRV4RwLnQqDDjnU29kwFjoJjx76cK42i
	 7CDncrEAwGN+7bD0jTKHlNIdDigTs+QFArBhFGJjTbFUmE3GpONC/CHQarPyJYhOO8
	 mcUX60w2LtQKg==
Date: Thu, 1 Oct 2026 22:16:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/15] dt-bindings: gpio: pl061: add Ambarella CV75
 variant
Message-ID: <20261001-snuggle-flying-e7180d4ac1e8@spud>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-4-486cc289a4b8@ambarella.com>
 <20261001-attempt-savior-5d4a0eed4320@spud>
 <CAD++jL=tsETOFvC-AdethTdrGtet5neVanj3KyyB4EtEOpJ_Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1WD25rPQ8gIjRFJm"
Content-Disposition: inline
In-Reply-To: <CAD++jL=tsETOFvC-AdethTdrGtet5neVanj3KyyB4EtEOpJ_Gg@mail.gmail.com>

--1WD25rPQ8gIjRFJm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 09:36:50PM +0200, Linus Walleij wrote:
> On Thu, Oct 1, 2026 at 9:23=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> > On Thu, Oct 01, 2026 at 08:40:53PM +0800, Long Zhao via B4 Relay wrote:
> > > From: Long Zhao <longzhao@ambarella.com>
> > >
> > > The CV75 GPIO banks sit on the AMBA PrimeCell bus but are not
> > > register-compatible with the ARM PL061. Each bank is 32-bit and 32
> > > lines, with extra mask/enable registers, so arm,pl061 must not be used
> > > as a fallback compatible.
> >
> > What has this got in common with the pl061 beyond using the PrimeCell
> > bus? Current reason for putting them together is a bit tenuous to me.
>=20
> It was determined in early review that this is very clearly a modified
> PL061 block. The basic registers are even named the same.
> https://lore.kernel.org/linux-arm-kernel/CAD++jLk0LoOJk=3DTXin42AL3_z_7eV=
VkvMnYr1S8090C6A_B+dQ@mail.gmail.com/

Right. I think that'd be good to have in the commit message, because as
an outsider reading this it sounds like it could well be an entirely
different device.

With that explanation,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
but as things stand,
pw-bot: changes-requested

Thanks,
Conor.

>=20
> PL061 is different and quirky and could not use gpio-mmio, while
> with these changes to gpio-regmap it can handle its pecularities
> and use a library which is a good thing on its own.
>=20
> Yours,
> Linus Walleij

--1WD25rPQ8gIjRFJm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar7NkQAKCRB4tDGHoIJi
0iH7AQC+o17BgBwJe3k2EAZcRXfzE2tgNWgAPkP28V9wBeNGDwD/UAU1TinKSygv
MtUtKTvPb1iV01w1PpMHV1VZJCr5NA8=
=TwJs
-----END PGP SIGNATURE-----

--1WD25rPQ8gIjRFJm--
