From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: S3C64xx serial broken in -next
Date: Thu, 18 Apr 2013 13:56:26 +0100
Message-ID: <20130418125625.GF13687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qpqR4wE1CEr+Roqx"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Michael Spang <spang@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, arnd@arndb.de
List-Id: linux-serial@vger.kernel.org


--qpqR4wE1CEr+Roqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm seeing lots of dropped characters from the s3c64xx serial driver in
something closely resmbling -next today, it seemed fine yesterday.  Not
100% sure that this is the serial driver itself but reverting 38adbc
(serial: samsung: Avoid waiting forever for TX ready) seems to improve
things a bit.

I'm not seeing any obvious changes in the arch code recently, the serial
driver looks like the most recently updated thing though that wasn't
today either.

--qpqR4wE1CEr+Roqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRb+1yAAoJELSic+t+oim9abcP/0fBoa/WgSRQ9i73SmbHC7z9
59hPzbRjses6lH3788EPARKT6KHUzh3tsXVzC2y7T6MVNVok/GLrvXo05TBYSH0j
XPA0fC5bSjGgXHAGSQkaey2YfCyIyuHw8+eaiJ8D29E3kyQJqME14xrfe1LEVmTs
+EvkH0eh+vUnLC/JZxNycm1yi40m4tQAB+tM0Y6fY/o9kuCZKZVhjk3N+JKa+lNV
RxfW993/4Gf8Zs/U8gZaWptAbInwXc7CBHHBohJjZNCrMerS/z/fxbyt/Dt/vu5D
N8n/N1uE3YQgx4uWgRBBtVvfkuqPC01E5wMimWljkC+PKAQ9JdoDIHiexdkAlB0a
qAX4v8Uy40bjFIPYkOOqI66w9WzNB1wQzO5OasWkFNjYSZM3/BwNJHeb6D2aAm6e
lGSGA/DnIvcs5fuhYXk7ktTtVY139teFBQuvtEkiMuZxvHsWNG1KjmtyBKTQYIYg
NAId5i+dtp2EvPZ/AdH9Qbsv0r2B+n5T6M0/lbNOefg+nJpi0c9jq4oXdimfkyya
pTLRvbovv7wtEnOtPvU1eiCNupNV4vddcu9ToFpTPQH6Dc8LzhT0qjaBbzNETAbt
bYS5cRfm3Z6MSsgng/EAlQ7QEU9S0UodP9WmtwM0tud0kxoSxBcBpV9bs3d8lj99
4q84iGYUlvpAXmresb8+
=IF14
-----END PGP SIGNATURE-----

--qpqR4wE1CEr+Roqx--
