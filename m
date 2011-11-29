From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: RS-485 automatic RTS toggle in Linux (on Winbond W83627UHG)
Date: Tue, 29 Nov 2011 18:57:28 +0100
Message-ID: <20111129175728.GH5455@pengutronix.de>
References: <CAFnDbmD-LG1O45d9s8GPxcbmjeFJ=vSp450oJ_75ooxBMtZFCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46480 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab1K2R5c (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Nov 2011 12:57:32 -0500
Content-Disposition: inline
In-Reply-To: <CAFnDbmD-LG1O45d9s8GPxcbmjeFJ=vSp450oJ_75ooxBMtZFCg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomas Lastovicka <tomas.lastovicka@gmail.com>
Cc: linux-serial@vger.kernel.org


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> supported. Googling this issue around, i found a couple of suggestions
> but no solution (except drivers for Atmel and Etrax since kernel
> 2.6.38).

Judging from the datasheet, the device can do hardware based RS485,
nice. So look at those drivers you mentioned above how they handle the
RS485-related IOCTLs and adapt the bits for the hardware configuration.
Should be more fun with a newer kernel, but I think it is doable.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7VHQgACgkQD27XaX1/VRsO2wCfXOsvPoOtw8QV8YzkKHocp6K8
lYEAnR/OExYTbdEtEqT8Dgl3Y/TCra83
=0ZuI
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--
