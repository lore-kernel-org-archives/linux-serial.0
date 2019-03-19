From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] dmaengine: idma64: Use actual device for DMA transfers
Date: Tue, 19 Mar 2019 12:57:47 +0000
Message-ID: <20190319125747.GC5514@sirena.org.uk>
References: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 06:39:30PM +0300, Andy Shevchenko wrote:
> Intel IOMMU, when enabled, tries to find the domain of the device,
> assuming it's a PCI one, during DMA operations, such as mapping or
> unmapping. Since we are splitting the actual PCI device to couple of

Acked-by: Mark Brown <broonie@kernel.org>

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyQ50oACgkQJNaLcl1U
h9BWoQf6AikcRK0ln1GJY2lTfUMdPnWYgLla9DdKl8DY9TMEK8UIvOJLkOPFkkgZ
8MBJdiL+2II3x3nDJmkz+LgVghlFukCuHRTEHjcY4fKeFX5Dbqcm0/KQhgJTD0NW
XrHhGP7Bm1FIyC9q5fSsTnpmiKyVsizCmShnC0/rqPfihoC69a7KQJ7L9PxTyQkT
Sg7nq+Qo2JqE18YiI4YRrqOlnfQ7Ref1yf5zxViZwH2UEFFhnjJT/PcBrun2o2zc
rlBbnNRpHo/8qJEvhjwG9A8ulx5Ofvvj3v8pa9AR5R2iFU4EzVSeVCZhQXEBk5ak
gvQD1TxaTtRxk33YEyZBR7RElp3wZg==
=yBp4
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
