From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: RS-485 automatic RTS toggle in Linux (on Winbond W83627UHG)
Date: Tue, 29 Nov 2011 23:36:26 +0100
Message-ID: <20111129223626.GB12314@pengutronix.de>
References: <CAFnDbmD-LG1O45d9s8GPxcbmjeFJ=vSp450oJ_75ooxBMtZFCg@mail.gmail.com>
 <20111129175728.GH5455@pengutronix.de>
 <CAFnDbmAAZZFNJAc=Y92xrkUujemTK63_2-H3TVkvbjVrsjUKgg@mail.gmail.com>
 <20111129222002.GA12314@pengutronix.de>
 <CAFnDbmA1u041X4LQv0pbdAAoR=LBqgdmOGRj_J5MhA2euMKFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57182 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756898Ab1K2Wg2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Nov 2011 17:36:28 -0500
Content-Disposition: inline
In-Reply-To: <CAFnDbmA1u041X4LQv0pbdAAoR=LBqgdmOGRj_J5MhA2euMKFOw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomas Lastovicka <tomas.lastovicka@gmail.com>
Cc: linux-serial@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2011 at 05:25:32PM -0500, Tomas Lastovicka wrote:

> Then i definitely have a different datasheet (v1.41). No 485 matches were=
 found.

I got v1.7:

http://www.nuvoton.com/NuvotonMOSS/Community/ProductInfo.aspx?tp_GUID=3D831=
0ab06-af65-4ec9-92a6-17cf791aa9f2

Ah, it says RS485 is only available on Revision E. Hopefully, you have that.

> Indeed, if it has support then there is no need for software toggle
> (although i still think it is done this way in the Etrax driver coming
> with the kernel).

I think that was the first RS485 one, so probably just lucky ;)

If you are interested, another series adding support for 8250-variants that
have HW support can be found here:

http://lkml.org/lkml/2011/11/16/270

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7VXmoACgkQD27XaX1/VRtl3gCfRcT+/Jj8aH7aZRbSXhJKHdJX
bvoAn3jmapAWMJic4c+Iv3LZEXfT4mPI
=MJ2w
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
