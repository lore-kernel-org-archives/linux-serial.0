From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: RS-485 automatic RTS toggle in Linux (on Winbond W83627UHG)
Date: Tue, 29 Nov 2011 23:20:02 +0100
Message-ID: <20111129222002.GA12314@pengutronix.de>
References: <CAFnDbmD-LG1O45d9s8GPxcbmjeFJ=vSp450oJ_75ooxBMtZFCg@mail.gmail.com>
 <20111129175728.GH5455@pengutronix.de>
 <CAFnDbmAAZZFNJAc=Y92xrkUujemTK63_2-H3TVkvbjVrsjUKgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50167 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab1K2WUH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Nov 2011 17:20:07 -0500
Content-Disposition: inline
In-Reply-To: <CAFnDbmAAZZFNJAc=Y92xrkUujemTK63_2-H3TVkvbjVrsjUKgg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomas Lastovicka <tomas.lastovicka@gmail.com>
Cc: linux-serial@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Unless i have overlooked something, i do not see how to toggle the
> automatic RTS mode from W83627UHG's datasheet. Have you found it?

Yes, searching for '485' gives you all the info you need (if we got the same
datasheet).

> Regarding 2.6.38+ drivers, Atmel supports RS485 on the hardware level
> and Etrax is handling the RTS toggling directly from the driver. I

Hardware level is the only official supported way in Linux. Software toggli=
ng
can easily fail due to preemption.

> guess this is what i will finally have to do, i.e. to toggle RTS from
> the driver myself.

Why? If the hardware has support?

> I am surprised that the RTS toggling issue for RS485 in Linux is
> around for quite a while.

It has come a long way, but all you need is there now (except for software
based direction control, see above).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7VWpIACgkQD27XaX1/VRvIUACgnX92dFgJ2IxR0IAINrwb4n+l
TJkAn2aSO3jFGvjYtgZH+8Ez4EvK7hun
=fvpa
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
