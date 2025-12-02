Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8D221F0C;
	Tue,  2 Dec 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764713647; cv=none; b=rogTgIf9jG5S15ExNU6rReA/x2tVAq7EC3erMb56tpPefafO4x6XOBI8EXDtIB50d/LYVt/7K8msjxSUyDm+IZJXBpgWHvlMnM4gLp+AlrYYHbB68Ho5GBywgCFt4c+Bqs26LjsxSJC8zyrbOEP8FpMB50zH7AvXaZ7BP4orC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764713647; c=relaxed/simple;
	bh=B9dRa/axMnYdxkDsvVmwpFvE3UIjtYsO3uUQFTEth/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhnAqHArwILf4x4pOt/nXDkYe2p6Jbe/C9nII4pDB1+XTVucfaj7dzBP+FAyDqm4gmF/lfgfmK5hbr4rJvH1bdNWHhUjNvfgS+DJoy+m7XFLrfgbVI1nRSkJbmV+q2GiBcb9gmD9dPR2y7g573nUrhYLR/fhUTgWqeUCUpt6p4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=N+RN9xMR; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="N+RN9xMR"
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E35EB1C00AB; Tue,  2 Dec 2025 23:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1764713641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=td4zCRfT57+g0xmdtBp34YZgvdl6Eh6Vecq9FAfQC68=;
	b=N+RN9xMRtKT5+KNJu6lSKFFPerVub7ZeJC+MMqfzoaLTer5xiqSSa2VQNkcVj/Y2P5KxUj
	HWkNRfsm1uG5EuuqnsREMRz09crqOD26ppHLOYf8u01iUtV/sxkotL4BZFGL7S0o09PP+9
	Q3M5i2ZCjswJyhMovvnLrS8hEUfE7d8=
Date: Tue, 2 Dec 2025 23:14:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Doug Anderson <dianders@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-samsung-soc@vger.kernel.org, Roy Luo <royluo@google.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	William McVicker <willmcvicker@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Drew Fustini <fustini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH 0/4] arm64: google: Introduce frankel, blazer, and
 mustang boards
Message-ID: <aS9kqTTiH2keDL5G@duo.ucw.cz>
References: <20251111192422.4180216-1-dianders@chromium.org>
 <aSOKS35/huSWd/RW@duo.ucw.cz>
 <CAD=FV=WVeiGa6YkRmce4McnePEV9X_n79YA0bywPdNZcZCV=ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQRsnIWYvuS50k0p"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WVeiGa6YkRmce4McnePEV9X_n79YA0bywPdNZcZCV=ZQ@mail.gmail.com>


--xQRsnIWYvuS50k0p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This series adds barebones device trees for Pixel 10 (frankel), Pixel
> > > 10 Pro (blazer), and Pixel 10 Pro XL (mustang). With a yet-unreleased
> > > bootloader these can boot to a UART command prompt from an initramfs.
> >
> > Well, booting to full system with working cameras would be nicer,
>=20
> For sure!
>=20
>=20
> > but
> > this is good start. Do you plan / do you have resources for full
> > support in some reasonable timeframe?
>=20
> As you can probably guess, I can't really make any promises. :-) Of
> course, "full support" of Pixel 10 by an upstream kernel in a
> "reasonable" timeframe could arguably be impossible no matter how many
> resources were thrown at it. There are just some drivers / subsystems
> where getting upstream working as well as downstream is working
> doesn't feel likely as a short term goal.
>=20
> That all being said, interest / support from the community helps.
> Knowing that people are interested in this work helps motivate folks
> at Google and (hopefully) upstream maintainers.

Motivation is certainly there, and race for usable, supported phone is
still continuing. Check https://wiki.postmarketos.org/wiki/Devices for
small glimpse into "mainline on phones" effort.

Best regards,

								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--xQRsnIWYvuS50k0p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaS9kqQAKCRAw5/Bqldv6
8mIkAJwP7vo5DWx3gJx063WMFClmFIgZTgCeM5zJ3LlBnfgJpHpOAQSx21vz1aA=
=n9MH
-----END PGP SIGNATURE-----

--xQRsnIWYvuS50k0p--
