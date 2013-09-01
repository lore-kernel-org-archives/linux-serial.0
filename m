From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] serial: mfd: Replace MODULE_ALIAS with MODULE_DEVICE_TABLE
Date: Sun, 01 Sep 2013 19:34:06 +0100
Message-ID: <1378060446.25743.40.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-cf1wXo7mcH0s0MPIZ5Gm"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59607 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756360Ab3IASeR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Sep 2013 14:34:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org


--=-cf1wXo7mcH0s0MPIZ5Gm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a PCI driver and should be auto-loaded based on PCI ID.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
Compile-tested only.

By the way, this module name is a bit confusing as there is now an mfd
subsystem.  Perhaps it's time to rename it?

Ben.

 drivers/tty/serial/mfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 4a82267..47ec080 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -1498,4 +1498,4 @@ module_init(hsu_pci_init);
 module_exit(hsu_pci_exit);
=20
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:medfield-hsu");
+MODULE_DEVICE_TABLE(pci, pci_ids);


--=-cf1wXo7mcH0s0MPIZ5Gm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUiOInue/yOyVhhEJAQoqcA//dhjycQ3tH3dCZwTpT4ixwztdLJfaWBFo
7FIbMAEFXd9MRDmj+ymD+9foq/O4a82fDIQBw62RZgt1gjyiPSsZgaCvku+eZu50
gBmGUA89DBGspRSLJ43crGjGO+jPuhXRJULzhTgartmYRM/Wqd6h6ydJPxv/+Byr
1Ff0xEZD3L4aO6yycfN/GNFBCt7Pn3MkHcUatMwoIskoa9Jakgo5B3jzxPj2S8zm
Jszwh/83xXZ0dzpVysykOlm0RnqTko8FmNOhcSDJuKXU+zDvOlWWflrzBI/Scf9Z
PtshAh1zScqjVxC/PPEtejKj+FMv0Bm6Qv0Ap2eT3/Q7ukFvh/jL0+9CfAWaJc2S
5ge+ZRRPWfRGBFgQ4W2NbZEb0KB30Sm/6fgwPG8GGNCQm8KJqPbUkFtj4/XNAmG6
sXVJWlLrdn4EZHDacxOKq2XgEEkqGSNJzgsLxqx+O+kiP47EfaQnu7HeazH41b5n
3FlxAgpU5C8NiIS3if5IXBnruefOy5+0Z4NbIsarFEvHAQt/R65SnYl7NlEX22vb
ddbEpxz8uSU+dBWuWD2SS9Yg6CzywUJKQvyrJwZUDFwsGww2lhj+djAto9wuRQDt
pzR56niYP1IC/aYnfWIF0q1lY9RM9XbXyyfr9+SpxvF1TeTwV20wcxPNV+1e8VpB
NnQ7D1ENhP8=
=6PBP
-----END PGP SIGNATURE-----

--=-cf1wXo7mcH0s0MPIZ5Gm--
