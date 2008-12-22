From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH/RFC] serial: Add ioctl to enable auto rs485 mode with
	some Exar UARTs
Date: Mon, 22 Dec 2008 16:59:56 +0100
Message-ID: <20081222155956.GA13526@pengutronix.de>
References: <200812190048.35249.mfuchs@ma-fu.de> <200812191613.29657.laurentp@cse-semaphore.com> <1229853004.3216.14.camel@thewinkle.toftronix.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44400 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbYLVQAG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Dec 2008 11:00:06 -0500
Content-Disposition: inline
In-Reply-To: <1229853004.3216.14.camel@thewinkle.toftronix.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Gibson <chris@toftronix.com.au>
Cc: Laurent Pinchart <laurentp@cse-semaphore.com>, Matthias Fuchs <mfuchs@ma-fu.de>, linux-serial@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Chris,

On Sun, Dec 21, 2008 at 08:50:04PM +1100, Chris Gibson wrote:
> Two and a half weeks ago I submitted a patch to implement RS485 auto
> direction control on either (or both) the RTS and the DTR lines with
> varying pre and post delay settings that would work for _all_ uarts that
> support mctrl.

Just observing the case, I assume that this concern about software RS485
is still valid:

http://article.gmane.org/gmane.linux.serial/2568

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklPuXwACgkQD27XaX1/VRuiSgCdHe/cxrsKjpeoI1gIKRoQggAF
Av0An3yMEWy9sr9kElPqtbRKS9/o0ENX
=6kAh
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
