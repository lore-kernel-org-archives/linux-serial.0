Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207132209B;
	Wed,  7 Aug 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048323; cv=none; b=nBfBj345nK3cxFT8N7cuWZUJeadfVbS4IClt2fpmVAisTIpN5WlB8Az2Gu9KFUxKUNlvZ0/Xkar8VCeQGBtP6gq4VmP6kVRsG3utTwAlV71u55+Plrj5bE9sKzyibe2kwFTAL1otoy9EyjJw+DhCQssHDUNmYtT3Gtit+fyqhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048323; c=relaxed/simple;
	bh=Pz9LIqA2w9Dm+SFN1If7OeyusUM67h2aCExgxiL84hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5jx+ryszXXx9w2Fbq5OuS6k6Ss9AQ/jH72DDeSoah03K4TUlXKLjTo4pOldYZDRuvszFtIvjExdM01RjbP4PhQgeqkBCo8zwWZ/VyCiCUoUARJYS6KZyoNdKf2V+kE7/SZMF9EcQSV+mwehxiRJAZ60w1j7WQ9j5vZbBiVf4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wnr1K6FK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wnr1K6FK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7234C4AF13;
	Wed,  7 Aug 2024 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723048322;
	bh=Pz9LIqA2w9Dm+SFN1If7OeyusUM67h2aCExgxiL84hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wnr1K6FKtacUSftwUOvIq95lXyXwV4hFiem9fd92XELhHsZMnvJxk66f9x1D0jLj/
	 jiCV8bBaEMZgblHCbAWGTJg4RXDHBHq/2SDdfTpaYvv4OXLdlNtX5s8+0e7XHbNdp1
	 xvzSeagEBZI5LgitUpJU803NiQRpO2cPRjaYkOfPLUknSImTGgmLJkMg4JMnKp4aic
	 x0gCeNnwNwc8KPhbLyxQZ07Fv1U42x2/wWFu0x3dkzr+2Si6ipwgEAH13eo/3kXt1B
	 GnStFWYHb7qByrd9erKfTPlkMSzDIC9xPKbMPGoyd4YrYZsZ3KOyspVcDbSi6Y0DGm
	 10BPq+18B34Ow==
Date: Wed, 7 Aug 2024 17:31:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>, Udit Kumar <u-kumar1@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: serial: 8250_omap: Add wakeup-source
 property
Message-ID: <20240807-daybed-unlocking-6a03de657e2a@spud>
References: <20240807141227.1093006-1-msp@baylibre.com>
 <20240807141227.1093006-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="52z39HG9VPnBf+y4"
Content-Disposition: inline
In-Reply-To: <20240807141227.1093006-2-msp@baylibre.com>


--52z39HG9VPnBf+y4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 04:12:23PM +0200, Markus Schneider-Pargmann wrote:
> Add the wakeup-source to enable this device as a wakeup source if
> defined in DT.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--52z39HG9VPnBf+y4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrOhfAAKCRB4tDGHoIJi
0rlZAQDjLr9nRoERRFl43TvDTHa7ITQSV3Jl2NxS22zdRneStwD/QIvMmlXa+WTJ
TrIE/mOWXsBHMksg48dvcnnyPFx6VgY=
=Z5nu
-----END PGP SIGNATURE-----

--52z39HG9VPnBf+y4--
