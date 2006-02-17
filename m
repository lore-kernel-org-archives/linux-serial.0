From: Freddy Spierenburg <freddy@dusktilldawn.nl>
Subject: [PATCH] Small time UART configuration fix for AU1100 processor
Date: Fri, 17 Feb 2006 17:43:06 +0100
Message-ID: <20060217164306.GF14066@dusktilldawn.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tool.snarl.nl ([213.84.251.124]:40356 "EHLO tool.snarl.nl")
	by vger.kernel.org with ESMTP id S1750700AbWBQQnW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Feb 2006 11:43:22 -0500
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 9B57F5E020
	for <linux-serial@vger.kernel.org>; Fri, 17 Feb 2006 17:43:07 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29544-08 for <linux-serial@vger.kernel.org>;
	Fri, 17 Feb 2006 17:43:07 +0100 (CET)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--mFHiwr52TKrxpkjc
Content-Type: multipart/mixed; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The AU1100 processor does not have an internal UART2. Only UART0,
UART1 and UART3 exist. This patch removes the non existing UART2
and replaces it with a descriptive comment.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl> http://snarl.nl/~freddy/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uart2.patch"

diff -Naur master.orig/drivers/serial/8250_au1x00.c master.good/drivers/serial/8250_au1x00.c
--- master.orig/drivers/serial/8250_au1x00.c	2006-02-17 10:57:28.000000000 +0000
+++ master.good/drivers/serial/8250_au1x00.c	2006-02-17 14:02:38.000000000 +0000
@@ -51,7 +51,7 @@
 #elif defined(CONFIG_SOC_AU1100)
 	PORT(UART0_ADDR, AU1100_UART0_INT),
 	PORT(UART1_ADDR, AU1100_UART1_INT),
-	PORT(UART2_ADDR, AU1100_UART2_INT),
+	/* The internal UART2 does not exist on the AU1100 processor. */
 	PORT(UART3_ADDR, AU1100_UART3_INT),
 #elif defined(CONFIG_SOC_AU1550)
 	PORT(UART0_ADDR, AU1550_UART0_INT),

--MPkR1dXiUZqK+927--

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9f0abxf9XXlB0eERAp1VAKCU+71BcITsXn+jrVM5L2woGUqRTgCeJ5Gi
uMTN6rhpGUDOI8ReZePbcFc=
=TBZe
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
