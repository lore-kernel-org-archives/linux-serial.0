From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: mxs-auart serial driver DMA support?
Date: Thu, 12 Jan 2012 10:42:45 +0100
Message-ID: <20120112094244.GA2775@pengutronix.de>
References: <4F0E7EB0.2060906@bluegiga.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60161 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2ALJmw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jan 2012 04:42:52 -0500
Content-Disposition: inline
In-Reply-To: <4F0E7EB0.2060906@bluegiga.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Any plans to add DMA support for mxs-auart serial driver? I noticed
> it is impossible to archive full 3.25 Mbs speed with current one.

No plans from our side, currently.

> As I understood porting DMA support from freescale's driver is not
> trivial because MXS DMA implementation has been changed to mainline
> version.

Yes, luckily. DMAENGINE is really the way to go.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8OqxQACgkQD27XaX1/VRse0wCfVXQN7EUxohj0oMOsEec5jiUv
KLkAoMByQul5yNiogeKqTec5Izec7Blq
=gJRU
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
