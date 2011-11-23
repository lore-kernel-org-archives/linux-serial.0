From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/8] serial: 8250: support hw-based RS485 direction
 control (finally!)
Date: Wed, 23 Nov 2011 16:03:12 +0100
Message-ID: <20111123150312.GH4063@pengutronix.de>
References: <1321460685-15753-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33140 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176Ab1KWPDO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Nov 2011 10:03:14 -0500
Content-Disposition: inline
In-Reply-To: <1321460685-15753-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>, Juergen Beisert <jbe@pengutronix.de>, Matthias Fuchs <mfuchs@ma-fu.de>


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2011 at 05:24:37PM +0100, Wolfram Sang wrote:
> Some 8250-variants control the direction pin for RS485 in hardware. Linux=
 has
> RS485 support these days, so update the 8250-driver to adhere to that. Th=
ere
> have been attempts for mainlining this before. So, I started with the ver=
sion
> from Matthias which got no further comments, a proof-of-concept for the 1=
6V2750
> from J=FCrgen, and reworked it to match the current state of RS485 in Lin=
ux. Some
> minor cleanup patches came along the way. Really looking forward to
> comments/tags, because I think it is really time to get this functionalit=
y into
> mainline once and for all ;)

Ping. Claudio? What do you think? Matthias, are you still there?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7NCzAACgkQD27XaX1/VRtKDQCfX90JuzHxBmNyE93y7FdKO+VQ
OrAAnRy2LiZtXAJCRgctO/fVYMh2rGuu
=HgFy
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--
