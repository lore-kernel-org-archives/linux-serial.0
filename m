From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 72/75] tty: Fix an ircomm warning and note another bug
Date: Mon, 5 Jan 2009 18:42:37 +0100
Message-ID: <20090105174237.GA5675@pengutronix.de>
References: <20090102133822.13472.53912.stgit@localhost.localdomain> <20090102135012.13472.40889.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32785 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbZAERmr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Jan 2009 12:42:47 -0500
Content-Disposition: inline
In-Reply-To: <20090102135012.13472.40889.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-serial@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Fri, Jan 02, 2009 at 01:50:20PM +0000, Alan Cox wrote:

> From: Alan Cox <alan@redhat.com>
>=20
> Roel Kluin noted that line is unsigned so one test is unneccessary. Also
> add a warning for another flaw I noticed while making this change.
>=20
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
>=20
>  net/irda/ircomm/ircomm_tty.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
>=20
> diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
> index e4e2cae..086d5ef 100644
> --- a/net/irda/ircomm/ircomm_tty.c
> +++ b/net/irda/ircomm/ircomm_tty.c
> @@ -371,9 +371,8 @@ static int ircomm_tty_open(struct tty_struct *tty, st=
ruct file *filp)
>  	IRDA_DEBUG(2, "%s()\n", __func__ );
> =20
>  	line =3D tty->index;
> -	if ((line < 0) || (line >=3D IRCOMM_TTY_PORTS)) {
> +	if (line >=3D IRCOMM_TTY_PORTS)
>  		return -ENODEV;
> -	}
> =20
>  	/* Check if instance already exists */
>  	self =3D hashbin_lock_find(ircomm_tty, line, NULL);
> @@ -405,6 +404,8 @@ static int ircomm_tty_open(struct tty_struct *tty, st=
ruct file *filp)
>  		 * Force TTY into raw mode by default which is usually what
>  		 * we want for IrCOMM and IrLPT. This way applications will
>  		 * not have to twiddle with printcap etc.
> +		 *
> +		 * Note this is completely usafe and doesn't work properly

Do you mean "unsafe"?

>  		 */
>  		tty->termios->c_iflag =3D 0;
>  		tty->termios->c_oflag =3D 0;
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkliRo0ACgkQD27XaX1/VRsvFQCgzPQjo9KwS5oWRaGpvt1gG+W9
nskAoLdUMNK9DZwuutGt2F8imRaJdnpM
=gsgy
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
