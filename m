From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 9/9] ARM: sun8i: Add reset controller
 nodes to the DTSI
Date: Mon, 7 Jul 2014 11:01:14 +0200
Message-ID: <20140707090114.GI16262@lukather>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-10-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBRGF5GOQKGQEO3TUPEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404399349-20237-10-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 10:55:49PM +0800, Chen-Yu Tsai wrote:
> The A23 has the same MMIO reset controllers matching the clocks gates,
> just like in the A31. This patch adds the reset controller nodes and
> the reset control phandles for the peripherals needing them to the
> DTSI.
>=20
> Unlike the sun6i DTSI, this patch uses sun6i-a31-clock-reset for
> ahb1_rst. sun6i-a31-ahb-reset is for early init, and requires some
> additions to the machine code. It is used to support the hstimer.
> However the hstimer on sun8i only has 1 timer, which is somewhat
> useless. Support for it will probably not be added. Hence the
> decision to use sun6i-a31-clock-reset here to avoid the changes to
> sun8i machine code.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Applied, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTumHaAAoJEBx+YmzsjxAgscAQAKCIcKO1r2CUQxERSeoMvfbK
xLQfNjJ1w0Dftxvv67lKNfS9k5vGgW4hqMgt6m7I4QDfz2rz9mfqwxdl+udYzCIm
oJMOsI7KPL1qkzWJYzQpbo1tX6Qovf58jKhDW1SoMKmiZgvX9P88CkNmxtmBlPym
8ija5gX2GVBWuUuVs5l6SHLls8P79j0g2xPPU8LuqOISjp9POaN6IciAZKsG9apb
Y7msSE56D5TBAu6WSRaiKTQxuj5LGOia02XX56J84rNUtyy6c3q+gtJNDzSK+hWl
T2aHC4eJYyOQvFyGMrwVeO3FZXRDWKM5sUMrYt/XQogpLEnwj0q7Utsknd16jdAO
LJdwG1FCD19ojDzf4SNAc+bGnIrUsMjjUkXwf2iOYwT12JoRgwfiziUOjFJ+89lS
WuYVuzYUInckmugYpdlI0Uudvzfc5eZSbdpzO0DObRxAo+XSkecTKQdUrtmopw0n
TjmAc2dEdaJQu1nl1qpw5Ccg7IwYQ6PxgV59ExUcm/waHyuiGD76WSBERO0jv5be
jAdWlUywcWA0XhJGEXf7sZw0eLNU2SxkaY2sFU8bFTSHHItQW+g/uMBzTo5HNd2e
T1Rt7JwUlEUwT5YI0n8aN24LrsA/oFRCZzRlQh2tC0PqbU+847w9SKpl8cBcQGKd
bPpGtTwvlAHunABL25oi
=BgaO
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
