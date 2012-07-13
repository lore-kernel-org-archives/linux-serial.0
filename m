From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 2/2] serial: mxs-auart: Allow device tree probing
Date: Fri, 13 Jul 2012 12:35:45 +0200
Message-ID: <4FFFFA01.6070306@pengutronix.de>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com> <1340024769-7122-1-git-send-email-fabio.estevam@freescale.com> <4FDF929B.7000809@grid-net.com> <4FFFF968.5000801@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBCE4CB1DB44D85F9341B1C5F"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37867 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463Ab2GMKfz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Jul 2012 06:35:55 -0400
In-Reply-To: <4FFFF968.5000801@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Subodh Nijsure <snijsure@grid-net.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, kernel@pengutronix.de, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, shawn.guo@linaro.org, "Matt@grid-net.com" <Matt@grid-net.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBCE4CB1DB44D85F9341B1C5F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/13/2012 12:33 PM, Marc Kleine-Budde wrote:
> On 06/18/2012 10:42 PM, Subodh Nijsure wrote:
>>
>> If one were to try run console on one of the /dev/ttyAPP* ports, as is=

>> the case for hardware I am working with, console output wouldn't show =
up
>> without the following diff:
>>
>> Let me know if should send formal patch or we can include it as part o=
f v5?
>=20
> Has this patch been applied?

Yes. [1]

Marc

[1]
http://git.linaro.org/gitweb?p=3Dpeople/shawnguo/linux-2.6.git;a=3Dcommit=
;h=3D1ea6607d4cdc917987e7e6cfaafc4a630d97a297
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBCE4CB1DB44D85F9341B1C5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk//+gEACgkQjTAFq1RaXHM8bQCgh0+R+j71op+Pz8qcQT+1jEQC
6xMAn1qiwW/S7/i6P7s/ana6v4vFZTG8
=ii8L
-----END PGP SIGNATURE-----

--------------enigBCE4CB1DB44D85F9341B1C5F--
