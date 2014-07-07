From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 4/9] mfd: sun6i-prcm: Add support for
 Allwinner A23 PRCM
Date: Mon, 7 Jul 2014 10:55:03 +0200
Message-ID: <20140707085503.GF16262@lukather>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-5-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBEWD5GOQKGQESBTFYFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404399349-20237-5-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 10:55:44PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
> The differences are the AR100 clock can no longer be modified,
> the APB0 clock has different divisors, and some clock gates are
> gone.
>=20
> This patch adds a compatible with a modified subdevice list for
> the A23.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTumBnAAoJEBx+YmzsjxAg1+8P/22zdtJyxLOuxwmVggTQzDEs
HAEdiGul1bNsS/IQBPyxw4Yw9c4JkAL9ueH/3r6XW2+UVcCFo3R6EumW2RUXDL8M
frawSF4knS+SXX6m7QiQgT3J95+mrKaP69eZa++FHLKhbTIQwdSQwd6Ru2csusBW
EQAMt/xH7eOPHZRDWLFo6exMqSSLKLVe0Q/goGwh/JcqIZsCyKvidwDDHY0NseGq
iGBUWu0QxdxhPicAlTWJFnnCw+Gv3NTmshrt4xK0X90kFTWj/69QRBhvdUxew1zz
4Lb018kbZ7ayMNrtHfihmH2vwZYp4QD/WalPHG37CzQjTEIhbkgS5PXBNATuYuM4
NtvFiIr6wdGkKlUBhqBDNyi7kLQtft3aYPGaLgL19i4wjZkGk+3JiTQ6rUmjtTRQ
2wOMOU/c9xIavj74KMu8Uk+vNgvMVeVCPmyq2fmwVTvJoB5PafbaRKyeYxpsN1Xf
+uwpDQ9UxuXABgR0iu1TTIiw5gRKIA6L1WiIDTqWGbdcX/b5pVJTlTRfi1dvL5eE
oqnUxjO2wQ3mDTYsvx3I/k3PjDE+CW0pjkOXi0THaf9Ajul3GBvUmpWXvRGgiVd1
CVmb9SgzBHdLI03ulRcXMr1SmmuKXcioS7pGrAS0b/Y2cxi7ibBe0FbtBgyTnTpQ
gJ7KPrC/vyygYqhWhBjG
=52y/
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
