From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] bcm63xx_uart: allow more than one uart to be
	registered.
Date: Sat, 30 Jan 2010 19:23:43 +0100
Message-ID: <20100130182343.GA6971@pengutronix.de>
References: <1264873377-28479-1-git-send-email-mbizon@freebox.fr> <1264873377-28479-3-git-send-email-mbizon@freebox.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48726 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab0A3SXr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 30 Jan 2010 13:23:47 -0500
Content-Disposition: inline
In-Reply-To: <1264873377-28479-3-git-send-email-mbizon@freebox.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Maxime Bizon <mbizon@freebox.fr>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 30, 2010 at 06:42:57PM +0100, Maxime Bizon wrote:
> The bcm6358 CPU has two uarts, make it possible to use the second one.
>=20
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
>  drivers/serial/bcm63xx_uart.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/serial/bcm63xx_uart.c b/drivers/serial/bcm63xx_uart.c
> index f78ede8..6ab959a 100644
> --- a/drivers/serial/bcm63xx_uart.c
> +++ b/drivers/serial/bcm63xx_uart.c
> @@ -35,7 +35,7 @@
>  #include <bcm63xx_regs.h>
>  #include <bcm63xx_io.h>
> =20
> -#define BCM63XX_NR_UARTS	1
> +#define BCM63XX_NR_UARTS	2
> =20
>  static struct uart_port ports[BCM63XX_NR_UARTS];
> =20
> @@ -784,7 +784,7 @@ static struct uart_driver bcm_uart_driver =3D {
>  	.dev_name	=3D "ttyS",
>  	.major		=3D TTY_MAJOR,
>  	.minor		=3D 64,
> -	.nr		=3D 1,
> +	.nr		=3D 2,

Err, why not using the #define here?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktkeS8ACgkQD27XaX1/VRunaACfXCtn8XYadPAc+/ykB5n5HEiY
8IcAn2qX4XsClbWCBbaYwic8kUFU/Hxt
=gEJH
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
