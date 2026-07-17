Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8273B14BC;
	Fri, 17 Jul 2026 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289764; cv=none; b=Os7Up/kif5vG6gFjprqVZ6279G5FRjmqOgQFLRfUM/pjsZmQsZxczJs4ohwIZTiUs+DUWj11YOI48nqlDf6qgwfB7zNT7CxX1/czPbCwkRq0ypJR24mGzyHABA0h/ScO0riP8/nlDjRZdPhs10a9ztW+1/ohgk6pHqTCPOoiWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289764; c=relaxed/simple;
	bh=M6dliTL3upPz3AWTcFuW/Bf8sQHGqFSf/FvFJ52AEJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9MYNYWA3Bpp819UCNDe+JUNa+wOfKqcDXg60x+0q3Tiihwwh2VuedriQwhzMjh5tHoeRlNtyHuqNfDHcDp6NqTMTfuAaobhd4zx3otJJJY8bA3VWpv/Xi19pDfNyYQvyU7sCFUeD6PiaGIMzRS6Oml+v3LwFxstZU6eU13KywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afG26BD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afG26BD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A1A1F000E9;
	Fri, 17 Jul 2026 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784289763;
	bh=M6dliTL3upPz3AWTcFuW/Bf8sQHGqFSf/FvFJ52AEJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=afG26BD5DJqcY9jFPHWwLoeF+nbY3GkVgbzmYISsj7xeZVCukUAa6Tdq4RdHOi1kv
	 VhO0c4wlgnq8/uJ4G1UyEHvTyxI9wOPKKaqgViGb19EFGyS0cg19B9qoWfDnJR0YZm
	 xD7VopeVKolG7iP9adxYqAQAtLV8auh9YJx/PsTDMa4HNn8peJiYCom6ppiEpBE6Ri
	 O5VPY2KO8x4IepP8GFuNG7upUnYOFwAgzIaIiRLTvysiIiBbNcvkYDfO9/wew8cRsb
	 l3JKPUr7GFFU/UKQZM1P948sh1G9gBvmTEg4KhGcT678i50OfZ6MBUBq9hVbqmsveD
	 3Nyo9BqNTTjfQ==
Date: Fri, 17 Jul 2026 13:02:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Swark Yang <syang@axiado.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, Jan Kotas <jank@cadence.com>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 6/8] dt-bindings: spi: dw-apb-ssi: add Axiado AX3005
 SPI variant
Message-ID: <6d69cfd0-5f3b-4324-8d64-b4695cbb3e92@sirena.org.uk>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-6-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="70M3+S0UoM/WolbI"
Content-Disposition: inline
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-6-c429095143ec@axiado.com>
X-Cookie: Enjoy yourself while you're still old.


--70M3+S0UoM/WolbI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2026 at 08:51:13PM -0700, Swark Yang wrote:
> Add binding for Axiado AX3005 SPI controller. So far, no changes
> are known, so it can fall back to the snps,dwc-ssi-1.01a compatible.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

If there is no need for things to be part of a multi-subsystem series
(eg, dependencies) it's normally better to send each subsystem
separately.

--70M3+S0UoM/WolbI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaGdoACgkQJNaLcl1U
h9CYYgf/a6ZXfaJE/jmFwdCosDxknw75RDj7nPAqr8ZtQ6OEKCVRSIVBgwrMG1B6
7TPPAIzIrDPqOWeb/BZihDW7BKUj2aDsl7pZivADMe0txrRhev2UcBUZUMxW1sXn
DgyCTELlXBzkCAltV41zPIZTn6Rwcy8lHkkDXAfh0JGD5azOUiDxKAusCY9IhML1
YtCaED6Zm325NAZ+cUqXIKy177WK3d4XQrt4N/qPahtGnlsER6BwUocE9HGNpNLh
l3iTBw5h+slXmMR6H40Ax4/E64jiKe5RpDEW3MeDQgZLROX+xs5G+fp3eE5NGFPQ
Z9zQeNxaiqK3XtZlukPgm9tW3O9UDA==
=i8XU
-----END PGP SIGNATURE-----

--70M3+S0UoM/WolbI--
