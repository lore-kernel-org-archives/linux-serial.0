From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: mxs-auart serial driver DMA support?
Date: Thu, 12 Jan 2012 12:00:11 +0100
Message-ID: <20120112110010.GF2775@pengutronix.de>
References: <4F0E7EB0.2060906@bluegiga.com>
 <20120112094244.GA2775@pengutronix.de>
 <4F0EB5BB.1060008@bluegiga.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43835 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2ALLAP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jan 2012 06:00:15 -0500
Content-Disposition: inline
In-Reply-To: <4F0EB5BB.1060008@bluegiga.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2012 at 12:28:11PM +0200, Lauri Hintsala wrote:
> On 01/12/2012 11:42 AM, Wolfram Sang wrote:
> >
> >>Any plans to add DMA support for mxs-auart serial driver? I noticed
> >>it is impossible to archive full 3.25 Mbs speed with current one.
> >
> >No plans from our side, currently.
>=20
> OK, AUART works fine with 115200 bps but over that it loose data
> randomly. I have seen fifo overrun errors during receiving data with
> 1Mbs and over. So current driver is unuseful with higher baud rates.

Care to send a patch adding this information to Kconfig help text and/or
source code? Would be much more useful there, I think.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8OvToACgkQD27XaX1/VRvURwCcCcsM1Or07Z7tGAvVHtF1Snzw
Gt8AoMI6sLWvwl6evKor4EIAEHqWx04p
=+5Rd
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
