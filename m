From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] serial imx.c: fix CTS trigger level lower to avoid
	lost chars
Date: Thu, 21 Jan 2010 23:06:53 +0100
Message-ID: <20100121220653.GA21010@pengutronix.de>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47832 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab0AUWG5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Jan 2010 17:06:57 -0500
Content-Disposition: inline
In-Reply-To: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CCing linux-serial

On Thu, Jan 21, 2010 at 10:26:03PM +0100, Valentin Longchamp wrote:
> The imx CTS trigger level is left at its reset value that is 32
> chars. Since the RX FIFO has 32 entries, when CTS is raised, the
> FIFO already is full. However, some serial port devices first empty
> their TX FIFO before stopping when CTS is raised, resulting in lost
> chars.

? Isn't that a flaw of the other side? Have you spotted other serial drivers
doing the same as your patch?

>=20
> This patch sets the trigger level lower so that other chars arrive
> after CTS is raised, there is still room for 16 of them.
>=20
> Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
> Tested-by: Philippe R=E9tornaz <philippe.retornaz@epfl.ch>
> ---
>  drivers/serial/imx.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
> index 18130f1..f7d2da5 100644
> --- a/drivers/serial/imx.c
> +++ b/drivers/serial/imx.c
> @@ -119,7 +119,8 @@
>  #define  MX2_UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select, on mx2/m=
x3 */
>  #define  UCR3_INVT  	 (1<<1)  /* Inverted Infrared transmission */
>  #define  UCR3_BPEN  	 (1<<0)  /* Preset registers enable */
> -#define  UCR4_CTSTL_32   (32<<10) /* CTS trigger level (32 chars) */
> +#define  UCR4_CTSTL_SHF  10      /* CTS trigger level shift */
> +#define  UCR4_CTSTL_MASK 0x3F    /* CTS trigger is 6 bits wide */
>  #define  UCR4_INVR  	 (1<<9)  /* Inverted infrared reception */
>  #define  UCR4_ENIRI 	 (1<<8)  /* Serial infrared interrupt enable */
>  #define  UCR4_WKEN  	 (1<<7)  /* Wake interrupt enable */
> @@ -590,6 +591,8 @@ static int imx_setup_ufcr(struct imx_port *sport, uns=
igned int mode)
>  	return 0;
>  }
> =20
> +#define CTSTL 16
> +
>  static int imx_startup(struct uart_port *port)
>  {
>  	struct imx_port *sport =3D (struct imx_port *)port;
> @@ -606,6 +609,11 @@ static int imx_startup(struct uart_port *port)
>  	if (USE_IRDA(sport))
>  		temp |=3D UCR4_IRSC;
> =20
> +	/* set the trigger level for CTS to 16 by default
> +	 */
> +	temp &=3D ~(UCR4_CTSTL_MASK << UCR4_CTSTL_SHF);
> +	temp |=3D CTSTL << UCR4_CTSTL_SHF;
> +
>  	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
> =20
>  	if (USE_IRDA(sport)) {
> --=20
> 1.6.3.3
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktYz/0ACgkQD27XaX1/VRs90ACfS59brA/rTXakZI16b3829M8h
4hcAn0QmIRzzBoqiMVoFnK1RM6wgNXkw
=TgBf
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
