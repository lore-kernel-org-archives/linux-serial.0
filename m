From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Date: Wed, 23 May 2018 09:30:40 +0100
Message-ID: <20180523083040.GC4828@sirena.org.uk>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <20180517050406.GF20254@sirena.org.uk>
 <6a59e071-3159-4939-8535-6c7a9d491379@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a59e071-3159-4939-8535-6c7a9d491379@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, richard.genoud@gmail.com, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
List-Id: linux-serial@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 11:10:28AM +0300, Radu Pirea wrote:
> On 05/17/2018 08:04 AM, Mark Brown wrote:

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Driver for AT91 USART Controllers as SPI
> > > + *
> > > + * Copyright (C) 2018 Microchip Technology Inc.

> > Make the entire block a C++ comment so it looks more intentional rather
> > tha mixing C and C++.

> I know it's ugly, but SPDX license identifier must be in a separate comment
> block.

No, it doesn't - it just needs to be the first line of the file.

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFJq8ACgkQJNaLcl1U
h9A5Dwf+IXTaaeH5wemGlp1J1Cqj9ET0B9mUUqYNsQ+BsMbdI314G1a/S3isLCCw
XjOds1vEWxncEZb6kxV4v/3bUuOKKrZ7UVlVsY2nycfzgvLsIaGhBcf7/OAAJWb/
kzfX3gceAsRfmFgbPHXcHMQbT+cWxJMBWUA0hJt2xBdJCVh1EduJ9VNZsbqjJSkU
nyOZffnBU/sIMj0mibun82oVVFtdu71N0DJEfMAP/mf4sajkjFs4IqGqK80Ghfyx
LYoD8hf8RKOvGF/Jr/x3K7T7bjAp1tny7kWtwqwf5zAb44FDgG+e6AEDN1bbzAva
MdFlv1uRTZwcunY5iN+UhKQgi7e4iw==
=+KAd
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
