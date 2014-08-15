From: Oleksij Rempel <linux@rempel-privat.de>
Subject: [SOLVED] Re: one char delay
Date: Fri, 15 Aug 2014 15:05:55 +0200
Message-ID: <53EE05B3.9080504@rempel-privat.de>
References: <53EC7839.7060507@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3XGapBcqs4A4iUoe4DFkRk88SH1dfT1aw"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:64836 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbaHONGT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Aug 2014 09:06:19 -0400
Received: from [192.168.1.221] ([80.136.201.211]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lxu7U-1WMEWL1NVU-015LFi for
 <linux-serial@vger.kernel.org>; Fri, 15 Aug 2014 15:06:17 +0200
In-Reply-To: <53EC7839.7060507@rempel-privat.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3XGapBcqs4A4iUoe4DFkRk88SH1dfT1aw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 14.08.2014 um 10:50 schrieb Oleksij Rempel:
> Hello all,
>=20
> i do some hobby work on porting linux to Alpscale asm9260 SoC and have
> fallowing problem with serial driver. May be you can help me.
>=20
> - each RX char will be send to the console only after next chart is
> entered. For example:
> Typed: dmesg
> Displ:  dmesg
> - all chars are immediately send with uart_insert_char() and
> tty_flip_buffer_push() to the core. So this delay is not insight of
> driver. I assume, i miss some flag or initialization.
>=20
> The driver was initially based on atmel_serial.c and ported by Alpscale=

> to 2.4.28.
> I reused this code.. which is working with this issue. Here is the driv=
er:
> https://github.com/olerem/linux-2.6/blob/arm_9260-2014.07.29/drivers/tt=
y/serial/asm9260_serial.c
>=20

Never mind.
Problem is solved.

It was buggy driver code. Insight of start_tx some faulty check was not
allowing transmit buffers.

--=20
Regards,
Oleksij


--3XGapBcqs4A4iUoe4DFkRk88SH1dfT1aw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iF4EAREIAAYFAlPuBcEACgkQHwImuRkmbWkTpwD+I6SVJn4x8GuD3HJna6k1LhMN
tvPCvzUlzsGXpPax7RkA/Rxd0XyPu3+GEoVWPFXAsCQ6QSnZfQYOZsB16T6rrssG
=wbuZ
-----END PGP SIGNATURE-----

--3XGapBcqs4A4iUoe4DFkRk88SH1dfT1aw--
