From: Harald Welte <laforge@gnumonks.org>
Subject: Fix supprot for AFAVLAB 8port boards in 2.6.x
Date: Fri, 5 Mar 2004 12:24:04 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040305112404.GJ1105@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KSn4sQg3MnruwCB4"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:1471 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S262498AbUCELdM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Mar 2004 06:33:12 -0500
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org


--KSn4sQg3MnruwCB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I didn't yet use one of my AFAVLAB boards with 2.6.x until now.  The
upper 4 ports are not detected at all.  I suppose the bug was introduced
while porting the driver from 2.4.x.

Please consider applying the following patch.  It also adds support for
a new 8port board called P030.

Thanks,


diff -Nru --exclude-from /sunbeam/home/laforge/scripts/dontdiff linuxppc25b=
h-040218-test/drivers/pci/pci.ids linuxppc25bh-040218-serial/drivers/pci/pc=
i.ids
--- linuxppc25bh-040218-test/drivers/pci/pci.ids	2004-02-16 09:43:49.000000=
000 +0100
+++ linuxppc25bh-040218-serial/drivers/pci/pci.ids	2004-03-05 12:10:09.6857=
24629 +0100
@@ -5601,6 +5601,8 @@
 14da  National Aerospace Laboratories
 14db  AFAVLAB Technology Inc
 	2120  TK9902
+	2180  P028
+	2182  P030
 14dc  Amplicon Liveline Ltd
 	0000  PCI230
 	0001  PCI242
diff -Nru --exclude-from /sunbeam/home/laforge/scripts/dontdiff linuxppc25b=
h-040218-test/drivers/serial/8250_pci.c linuxppc25bh-040218-serial/drivers/=
serial/8250_pci.c
--- linuxppc25bh-040218-test/drivers/serial/8250_pci.c	2004-02-16 09:44:28.=
000000000 +0100
+++ linuxppc25bh-040218-serial/drivers/serial/8250_pci.c	2004-03-05 12:23:0=
2.331325424 +0100
@@ -141,13 +141,15 @@
 	      struct serial_struct *req, int idx)
 {
 	unsigned int bar, offset =3D board->first_offset;
 =09
 	bar =3D FL_GET_BASE(board->flags);
 	if (idx < 4)
 		bar +=3D idx;
-	else
+	else {
+		bar =3D 4;
 		offset +=3D (idx - 4) * board->uart_offset;
+	}
=20
 	return setup_port(dev, req, bar, offset, board->reg_shift);
 }
=20
@@ -1891,6 +1895,9 @@
 	{	PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P028,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_8_115200 },
+	{	PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P030,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_8_115200 },
=20
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DSERIAL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--KSn4sQg3MnruwCB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFASGNUXaXGVTD0i/8RAjG8AJ4rIcKPZ6vbPD/uX1UP8h2jNtw4EwCeJfoH
l9Itlz5NfNZ+wby3ibub7I4=
=g8h0
-----END PGP SIGNATURE-----

--KSn4sQg3MnruwCB4--
