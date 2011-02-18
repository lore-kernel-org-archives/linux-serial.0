From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: MAX3107 driver faulty
Date: Fri, 18 Feb 2011 15:00:41 +0100
Message-ID: <20110218135908.GA7305@pengutronix.de>
References: <4D5E74C7.3040700@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50570 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab1BROAn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 09:00:43 -0500
Content-Disposition: inline
In-Reply-To: <4D5E74C7.3040700@gmx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nico Becker <nico.becker@gmx.de>
Cc: linux-serial@vger.kernel.org, jianwei.yang@intel.com, alan@linux.intel.com


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 18, 2011 at 02:31:51PM +0100, Nico Becker wrote:
> Hello,
> i want to use the MAX3107 driver,
> thats included in the kernel 2.6.37.
>=20
> I think the driver is faulty.
>=20
> I have done several changes,
> before the driver works rudimentary.
>=20
> I have check the datasheet and found
> inconsistence between chip and driver.
>=20
> In AutoCTS AutoRTS Mode the Register
> txdisable and rxdisable should be set.
> But txdisable isnt set, so the max3107 sends
> data even the cts signal is high.
>=20
> The IntOscen Flag (enable internal Oscilator) is never set.
>=20
> Different register write operations are done in one stream.
> Example: http://lxr.free-electrons.com/ident?a=3Darm;i=3Dmax3107_register=
_init
> But in the datasheet it is explained:
> "If the SPI burst address is different to 0x00, the MAX3107
> automatically increments the register address after each SPI data
> byte."
> So it is impossible to write in the register 0x1D, 0x1C, 0x1B
> in one stream.
> after the first address 0x1D the maxim increment the address
> automatically to 0x1E.
>=20
>=20
> Have somebody test the driver,
> or have although trouble with the chip?

I haven't, but I'll add the people who brought the driver to the kernel
to CC. Maybe they can comment.


> Because i am really new with the kernel hacking,
> what are the next steps, build an patch?

Doing patches (one per issue) might be an idea. It is usually easier to
talk about code. Reading Documentation/SubmittingPatches will probably
make the process easier.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1ee4gACgkQD27XaX1/VRvtdwCggXy2oc9JtjSI4XckRPCEHRb1
RhAAoL0/D+JFMU+DxcsAmTkKy/CF0fwN
=TC8/
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
