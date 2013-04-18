From: Mark Brown <broonie@kernel.org>
Subject: Re: S3C64xx serial broken in -next
Date: Thu, 18 Apr 2013 15:01:11 +0100
Message-ID: <20130418140105.GG13687@opensource.wolfsonmicro.com>
References: <20130418125625.GF13687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mXWEJCq0x1D2MX0F"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130418125625.GF13687@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Michael Spang <spang@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, arnd@arndb.de
List-Id: linux-serial@vger.kernel.org


--mXWEJCq0x1D2MX0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2013 at 01:56:25PM +0100, Mark Brown wrote:
> I'm seeing lots of dropped characters from the s3c64xx serial driver in
> something closely resmbling -next today, it seemed fine yesterday.  Not
> 100% sure that this is the serial driver itself but reverting 38adbc
> (serial: samsung: Avoid waiting forever for TX ready) seems to improve
> things a bit.
>=20
> I'm not seeing any obvious changes in the arch code recently, the serial
> driver looks like the most recently updated thing though that wasn't
> today either.

*sigh* On further investigation I think this is actually the other end
of the connection deciding to play silly beggars overnight, sorry about
the noise.

--mXWEJCq0x1D2MX0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRb/xvAAoJELSic+t+oim9T0sP/2i+JVSJstH6bhVIGR3SyFsh
ZeFY7/bEwqOgj13f1uEGz1OIT+fOTiyZ/lrGiGFyECf53wZJlF2nfmODePjl+0XQ
aASn7FTLbDVgt4rLZjaWU7Hpb7Ue3KaraGP/vTtlWugF8Vopl1vkKxy9HIuTP+f9
zFzp6z0QGqgAIa9S6Q3LAaxkyBHSG/BUSeVpqXXytIXm/+P3uBchaz+t+o5CdkzX
l4Ri5FYd4zSLy2S2AgDhfVueyWJVAMRcFf0b2z/4qozoYUO8QRF2ETqxqRPtj5uK
YDD676czdM4uBwHk0NA/raNCglvX+933bpCHGlODZXfCIrmeH5cAgixYQykLAg3r
0w8ne8/lEZXbLA0BKQFY5qttp0kd4oZqTZmMusIxU36irbHgUghcpzPFKTXAzEMj
NHMsr0w22PPvZxfQieas9efjSMNUBmqjIk2DiwPU6O1ARTWeThkzLtBbivzc0vZe
2SZrXuPh7j9BbzsCG/VqdueNZ0znICFFhG+ZXMLsNWigyO89PWq4KeLZNCQegEGb
euLLXeQkxcgVEm0a4cOIbHnIzyRzF6L6eI6yyV0xZpKfe11Vbu3qP43n0HVkh2eN
4BBkQDG4NF56SXme9bbMCds0koHUltjTmCrpUz3xLZdRE0NjRRnFZi5M8bjZy4z/
WKrLq0W6pzbbno8BPcd4
=rJWZ
-----END PGP SIGNATURE-----

--mXWEJCq0x1D2MX0F--
