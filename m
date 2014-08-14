From: Oleksij Rempel <linux@rempel-privat.de>
Subject: one char delay
Date: Thu, 14 Aug 2014 10:50:01 +0200
Message-ID: <53EC7839.7060507@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pLrNW7B4VLcqvP4hPvh7WPehQ1nfWhhQm"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:52551 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755083AbaHNIuH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Aug 2014 04:50:07 -0400
Received: from [192.168.1.100] ([79.222.215.53]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LinyL-1WflI03O5F-00cvqm for
 <linux-serial@vger.kernel.org>; Thu, 14 Aug 2014 10:50:05 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pLrNW7B4VLcqvP4hPvh7WPehQ1nfWhhQm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello all,

i do some hobby work on porting linux to Alpscale asm9260 SoC and have
fallowing problem with serial driver. May be you can help me.

- each RX char will be send to the console only after next chart is
entered. For example:
Typed: dmesg
Displ:  dmesg
- all chars are immediately send with uart_insert_char() and
tty_flip_buffer_push() to the core. So this delay is not insight of
driver. I assume, i miss some flag or initialization.

The driver was initially based on atmel_serial.c and ported by Alpscale
to 2.4.28.
I reused this code.. which is working with this issue. Here is the driver=
:
https://github.com/olerem/linux-2.6/blob/arm_9260-2014.07.29/drivers/tty/=
serial/asm9260_serial.c

--=20
Regards,
Oleksij


--pLrNW7B4VLcqvP4hPvh7WPehQ1nfWhhQm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iF4EAREIAAYFAlPseD0ACgkQHwImuRkmbWk8DAD/SZ0bnxiBQZPSeD55NZD5ob0j
+xCmwhqZgDn5S560bFoA/jb1+60xhlYL+9J9XAfo4AzUzcubmQnmQATGwseJ4QzQ
=S6sj
-----END PGP SIGNATURE-----

--pLrNW7B4VLcqvP4hPvh7WPehQ1nfWhhQm--
