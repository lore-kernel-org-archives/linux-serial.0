From: Harald Welte <laforge@gnumonks.org>
Subject: Support for NetMos NM9845 based 6port cards
Date: Tue, 24 Aug 2004 19:59:58 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040824175958.GG26877@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uI9S8aIOhfZRGnE0"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:60358 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S267775AbUHXSAD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Aug 2004 14:00:03 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org


--uI9S8aIOhfZRGnE0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russell & linux-serial list!

I recently bought another serial multiport card.

The stock 2.6.x kernel only detects the first five ports, leaving the
sixth port unusable.

The following patch (applies cleanly to 2.6.8.1) makes all six ports of
the card work, please apply.

Thanks!

Signed-off-by: Harald Welte <laforge@gnumonks.org>

--- linux-2.6.7-plain/drivers/serial/8250_pci.c	2004-06-16 05:19:44.0000000=
00 +0000
+++ linux-2.6.7-media-old/drivers/serial/8250_pci.c	2004-08-24 17:48:19.000=
000000 +0000
@@ -1005,6 +1006,7 @@
=20
 	pbn_b0_bt_1_115200,
 	pbn_b0_bt_2_115200,
+	pbn_b0_bt_6_115200,
 	pbn_b0_bt_8_115200,
=20
 	pbn_b0_bt_1_460800,
@@ -1144,6 +1146,12 @@
 		.base_baud	=3D 115200,
 		.uart_offset	=3D 8,
 	},
+	[pbn_b0_bt_6_115200] =3D {
+		.flags		=3D FL_BASE0|FL_BASE_BARS,
+		.num_ports	=3D 6,
+		.base_baud	=3D 115200,
+		.uart_offset	=3D 8,
+	},
 	[pbn_b0_bt_8_115200] =3D {
 		.flags		=3D FL_BASE0|FL_BASE_BARS,
 		.num_ports	=3D 8,
@@ -2051,6 +2059,15 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_8_115200 },
=20
+	/*
+	 * NetMos serial card, from Harald Welte <laforge@gnumonks.org>
+	 * This one actually has jumpers to set base baud rate.=20
+	 * 115200 was the shipping default.
+	 */
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9845,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_6_115200 },
+
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DSERIAL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_115200 },
diff -Nru linux-2.6.8.1/include/linux/pci_ids.h linux-2.6.8.1-serial-netmos=
/include/linux/pci_ids.h
--- linux-2.6.8.1/include/linux/pci_ids.h	2004-08-14 12:56:26.000000000 +02=
00
+++ linux-2.6.8.1-serial-netmos/include/linux/pci_ids.h	2004-08-24 15:00:25=
=2E552425619 +0200
@@ -2298,6 +2298,7 @@
 #define PCI_DEVICE_ID_NETMOS_9805	0x9805
 #define PCI_DEVICE_ID_NETMOS_9815	0x9815
 #define PCI_DEVICE_ID_NETMOS_9835	0x9835
+#define PCI_DEVICE_ID_NETMOS_9845	0x9845
 #define PCI_DEVICE_ID_NETMOS_9855	0x9855
=20
 #define PCI_SUBVENDOR_ID_EXSYS		0xd84d
--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--uI9S8aIOhfZRGnE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBK4IeXaXGVTD0i/8RAqpgAJ92dc64wQ1PZ72nAqdbYobM6Df6yACfcrmD
gRZc51atsjHTzmzdXjLc5FE=
=rtU1
-----END PGP SIGNATURE-----

--uI9S8aIOhfZRGnE0--
