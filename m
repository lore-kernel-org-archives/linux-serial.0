Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FC81487EF;
	Tue,  4 Jun 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520071; cv=none; b=aQBEmeBttp4KUvkdFybTTwA8nLtA0x8F8QfuoLH2jcsfb/uaKWTiIW+VqrQtMfUi6F1PMGJzQe+pTU2KFrIyCqEhGrN8KxoFOJzBSXCZvku+nmZux9OXbIvsb1hMoe2hP7JkQttltFOm4cKk9CkNsxZd7+9/CtEUvaxDFp1zTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520071; c=relaxed/simple;
	bh=9QxiAFyRtObELcKE8Pdt8Q3G8VNOVmS0MGj3q8rQD1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrPOWjkwDZwW34Uywz6aEMaSHoO1WLKkjWC+AWADvl9z7lqi/D7EXKAd3H3kD7yEfz2s5jJDkUJan3k7CNkkVqNrhLMJWKz8RGC5vDOaDLo1QocFgChMIf8brR+iQbEXCEbloBIkjEK6uEhIke0xTJgAiw8UeXQPZ9SOsxtkRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vfjd0UrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vfjd0UrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A47C2BBFC;
	Tue,  4 Jun 2024 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520070;
	bh=9QxiAFyRtObELcKE8Pdt8Q3G8VNOVmS0MGj3q8rQD1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vfjd0UrE2T+Gw7EaDN2F9IKww+eROskhaELkjqCbX0lg+lVJ+MLsrQfelrViaAjRK
	 vrTuTLxSPpypv72kmQAt8Cde37e0dM0by7sRAXP0j2/P0ICSo/VDotdM1ThDn23VKx
	 nchFMcSkJp3H1Go+ZPvoQgK90QywEjPLEfPc5m0fmGSr4lmmVyUpdTi9T1esqkrB7z
	 jFUz8p5LZUBgPwHI4sb84alubcVZSfqIdk1ar2MEhpeU0hXfVlNr6Mm8btlKkr6y7g
	 8V5ZydI77l33AdOWULTvZm554rTgl5qkqVRCqnb5gvWo5bWP4Btsqp0X02t8eUcyp3
	 H/GbHVznSCciA==
Date: Tue, 4 Jun 2024 17:54:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: snps-dw-apb-uart: Add one
 more reset signal for StarFive JH7110 SoC
Message-ID: <20240604-sagging-unbiased-17083b875576@spud>
References: <20240604084729.57239-1-hal.feng@starfivetech.com>
 <20240604084729.57239-2-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gEvQNIf624IsR0Q/"
Content-Disposition: inline
In-Reply-To: <20240604084729.57239-2-hal.feng@starfivetech.com>


--gEvQNIf624IsR0Q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 04:47:27PM +0800, Hal Feng wrote:
> The UART of StarFive JH7110 has two reset signals.
> Both of them are necessary for JH7110 to initialize UART.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--gEvQNIf624IsR0Q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9GwQAKCRB4tDGHoIJi
0pIEAQCPDEC7F3bwjXqRwHk8slfZh89WNAGHTG3bfBDIyQqRJAD/Rel/CIsjO73v
ESIZqBFtkTn9zKJuSZN0Z3XX9Kv1qwc=
=tyjt
-----END PGP SIGNATURE-----

--gEvQNIf624IsR0Q/--
