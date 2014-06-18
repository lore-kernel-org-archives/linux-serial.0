From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 03/20] clk: sunxi: move "ahb_sdram" to
 protected clock list
Date: Wed, 18 Jun 2014 11:10:06 +0200
Message-ID: <20140618091006.GI19730@lukather>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-4-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBRFRQWOQKGQESEUZNLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403016777-15121-4-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 10:52:40PM +0800, Chen-Yu Tsai wrote:
> With sunxi_gates clocks registered with clkdev, we can use the
> protected clocks list to enable the "ahb_sdram" clock, instead
> of looking for it and adding CLK_IGNORE_UNUSED inline in the
> clock setup code.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToVduAAoJEBx+YmzsjxAgtaMP/jYzR7hHj+anXBPwRlYhm2iZ
ld/VmhxkOZnOKfeElrXRyZeV9Ks3PiplhHxhOyAFZG7Ep95jlgfvXoT7P4cUgp6F
vwtxDsFdjLUtuwRw9uutphn51IzKOc9tiqBUC8wwcLnvkLw7y5aJkRkPB++LEf0h
5PSwCybbCjFcCKJ6W0u0P5d/ECMRbioOMxRqbwz4tmL01EGq5Gw8xtAjY5cQzN7T
twJGtsPIsxh9okTAw6VRq3OhNRp8C0t53lWBRlgPoiXJMIy4OEdWuVZBD405g3Vh
hHky5SW2wKDBFstDB/XWueb24rDH30LYWGseeOL+CImPktfBEyHSfqLrKYzreEfT
/MDOkke5uJ4aSAb1HdQNe/F2V4VfqKamhkqoEF4E8+c7WQxXvwA7fRgjQwgCUyO3
B/9sa6NNVZlMq3Ceom8G5nokb5vWOAaPnmWkmcLIgTIhRVE9taxeLtBuazIqegZ+
/Xi1sDh6STgBn8KE5Cm/W97WS3tvqVyDDFTlYmozTFBsjR7xFO1Z8Ny/XZYxcX/K
LJFyJVFzvL4J6x4vnSIh59Glp8IDZLaR9+D1sOgvWVs/FYMUXeT3EC0o4SlST7FA
alOOaGq1W2UlwYv9fok28vVCN+t4mwHMmoNG4PtinM+Ph0Z3Y1hpjtxHvRdZCXYG
VNcKO+52NA/6J7a1231i
=2KR7
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
