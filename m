From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 5/6] spi: at91-usart: add driver for at91-usart as spi
Date: Tue, 10 Jul 2018 19:15:59 +0100
Message-ID: <20180710181559.GG8104@sirena.org.uk>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-6-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7765635742122202660=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180625172230.29686-6-radu.pirea@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, richard.genoud@gmail.com, gregkh@linuxfoundation.org, linux-spi@vger.kernel.org, robh+dt@kernel.org, linux-serial@vger.kernel.org, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============7765635742122202660==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 08:22:29PM +0300, Radu Pirea wrote:

This is mostly good, just a couple of small things:

> +config SPI_AT91_USART
> +	tristate "Atmel USART Controller SPI driver"
> +	depends on HAS_DMA
> +	depends on (ARCH_AT91 || COMPILE_TEST)
> +	select MFD_AT91_USART

Why is this selecting rather than depending on the MFD like we normally
do?

> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for AT91 USART Controllers as SPI
> + *
> + * Copyright (C) 2018 Microchip Technology Inc.
> + * Author: Radu Pirea <radu.pirea@microchip.com>
> + */

Please use C++ comments for the whole block so it looks a bit more
intentional.

Otherwise=20

Reviwed-by: Mark Brown <broonie@kernel.org>

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltE994ACgkQJNaLcl1U
h9AkeQf+Mq7IQsKQUVCnKMlLqJ5zyB55TxIx46+ND7yNKQrL9Iqyz6XWFUlOfwA4
4sYKoF4uDRaMv3EcelHQSA4Q4uCCfQkOB4wXeilyOM5XGz/dSu02hp9AHkUeIrYk
mFC0N0A9av/xbcS8VdDtbUjOuS/8P27Tmbwh3U/n+mcXa8k0YEQwYA1VSoIoTbno
IleZNwnp13oH/c5pDpgLX/HlmeHNjLI/DT4Rt+3nsq0sV4H3I/Zvn/wwtyhruG48
iubp+b9R6lBWFxAT/gj/WJnbMn8xa42mTFCazIwW6bJ+0d+UHQeqSmJYPZVz2jE8
rp9nuWdqIOxugrMSGaI9s+VhdD/Qzg==
=uIu3
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--


--===============7765635742122202660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7765635742122202660==--
