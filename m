Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18165429014;
	Tue, 29 Sep 2026 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710860; cv=none; b=F+8cFYfa7ZMdwg11nbctF9QNe/tfqLIVYgVqhvYMSFst7dP9SaJpnVzRSMgDfHMJ6Mvh5UwzFBEGww8adkTobv+b/yZ2TxV1/r4zU+rUNSyvMPIylpLoMlylGCI75qpJq08rrxfZA8HJRZ23jnqgAozCP8WpL58BAoJVkvYfEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710860; c=relaxed/simple;
	bh=KAUghNeL44tviTaVmIMjHkDsIJ29Dhpn/+AN6JDKLAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODyxYxDsQMRlpBI9vDR7aSZKOldKY6x0ddurMxF33UXFUbtKJYGXlFl1IGEJVljaNLqNaTTJSdUF3NMgzn6R6gQW+RFR5yKb+dhweSbLeLG3CrnNeP67ZiLJFnw3sb3aJazX+TOXMA0KHfT0xOaFuWRLB9YwVBYoYDQlfPTVZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2d3TTkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2d3TTkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20111F000FF;
	Tue, 29 Sep 2026 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710859;
	bh=KAUghNeL44tviTaVmIMjHkDsIJ29Dhpn/+AN6JDKLAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P2d3TTkISdUJC1YsLuhZljaOYdZOKKzQF+g7bVMFxM78S9Y9e+uNzUmoc/ZtK4D3F
	 LIstQvkhHvev0H5nG4LCBasAdNG0umlWOg8/QZW+Zjk4C1PfR3W71azyaBKDfe+hiU
	 sI/Mnpfc/dntc7NK0ZruCuOnKM8ucxfqNICfC9BmvVnXi115NbQ2a2Ne0F2TnBjPAl
	 lXvm4XHznPyHKOhVeq8wj/Ay9+UZdpd0NtahbFiQ4kYL22BdR8YhMCjt2ZqjkPu+Bs
	 juq/wcsIezSGXOEDR7kvrCbPcLsZdyC15CG3OetKSBLIGAPE5Y1rJGTW31qSg+EOSA
	 mOqszPh2hETDw==
Date: Tue, 29 Sep 2026 20:40:51 +0100
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
Subject: Re: [PATCH 18/20] regulator: dt-bindings: sy8827n: support standard
 properties
Message-ID: <20260929-childish-ethically-0a9c6d63ee62@spud>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-19-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6jYRsrYHOKy0uFBN"
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-19-jszhang@kernel.org>

--6jYRsrYHOKy0uFBN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--6jYRsrYHOKy0uFBN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarwUQwAKCRB4tDGHoIJi
0kiZAP98RDyWo+sgTIVhEcs8b/0YZbaCHEucmwHwYittmSNXQgD/ViPojKzhd0DA
1NfubBBIQUkUPapBQUZaKnCSWaP1BAw=
=mlj2
-----END PGP SIGNATURE-----

--6jYRsrYHOKy0uFBN--
