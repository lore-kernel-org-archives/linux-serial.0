From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] serial imx.c: fix CTS trigger level lower to avoid
	lost chars
Date: Fri, 22 Jan 2010 12:49:35 +0100
Message-ID: <20100122114934.GE4782@pengutronix.de>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch> <20100121220653.GA21010@pengutronix.de> <20100121221133.GA30419@n2100.arm.linux.org.uk> <4B597A82.4020906@epfl.ch> <20100122110701.GA15699@shareable.org> <20100122113130.GB10449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47309 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab0AVLtk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Jan 2010 06:49:40 -0500
Content-Disposition: inline
In-Reply-To: <20100122113130.GB10449@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Valentin Longchamp <valentin.longchamp@epfl.ch>


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> What you're assuming is that flow control was there to prevent overruns
> on the hardware receiver.  That's not the way it works on these devices;
> flow control is entirely managed in software - there is no hardware
> assistance.
>=20
> The flow control implemented for non-FIFO and non-hardware assisted
> UARTs is purely to do with preventing the software buffer behind the
> UART from overflowing - it can't prevent the device's receiver buffering
> from overrunning.  (Non-FIFO devices have the shift register and a
> buffer register - complete reception of a second character before the
> first is read causes an overrun condition.)
>=20
> If you have overruns on the receiver, that's an interrupt latency
> problem and its an error that's reported to the receiver side only.
>=20
> Yes, later devices have the ability in hardware to deassert RTS when
> the receiver FIFO gets above a certain threshold to /help/ prevent
> overruns occuring when there's high interrupt latency - but normal
> system operation should still ensure that the FIFO is emptied in a
> timely manner.
>=20
> They also gained the ability to stop the transmitter once CTS is
> deasserted, mainly because the transmitter FIFOs in these devices
> is soo large (maybe 32 to 128 bytes deep.)

Russell, thanks for this explanation. Patch seems principally OK to me, the=
n.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktZkM4ACgkQD27XaX1/VRsLpwCfWd2ThQybpeRj9ruASx3/6OLY
mWMAnjNEUD/l5/Pfi61TS6wpqcrArw5+
=5eYo
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
