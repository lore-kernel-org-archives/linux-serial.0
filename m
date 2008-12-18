From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Enabling auto RS485 half-duplex control
Date: Thu, 18 Dec 2008 10:35:14 +0100
Message-ID: <20081218093514.GA3400@pengutronix.de>
References: <200812172224.13608.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42371 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbYLRJfQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Dec 2008 04:35:16 -0500
Content-Disposition: inline
In-Reply-To: <200812172224.13608.mfuchs@ma-fu.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Fuchs <mfuchs@ma-fu.de>
Cc: linux-serial@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

> I did not find a way to enable this mode through the=20
> standard serial driver. The UART is is detected correctly
> but there seems to be no way to enable this mode
> out of the box.
>=20
> So what's the best way to implement this?
> A new ioctl? Any idea?

See commmit c26c56c0f40e200e61d1390629c806f6adaffbcc. I think any
solution to activate RS485 should be based on this.

Regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklKGVIACgkQD27XaX1/VRvowwCfetdpSS6jivyXZvizETlrSdHw
JXYAnj8pIQNymPmR3HR40vvnhVJdmflO
=aBA3
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
