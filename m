From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 10/20] clk: sunxi: Add support for
 table-based divider clocks
Date: Wed, 18 Jun 2014 12:06:21 +0200
Message-ID: <20140618100621.GN19730@lukather>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-11-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QQNwO3VdVfodZayb"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBCGLQWOQKGQEMWGPSQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403016777-15121-11-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--QQNwO3VdVfodZayb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 10:52:47PM +0800, Chen-Yu Tsai wrote:
> A few of the clock modules have odd dividers, such as
> the 2 lowest dividers being the same (2), or have the
> same divider when the highest bit is set.
>=20
> This patch adds support for optional divider tables,
> so the clock framework will know about the odd values.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--QQNwO3VdVfodZayb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToWSdAAoJEBx+YmzsjxAgPcIP/39SdTi3g5pFiGnZ8Q4zhyrv
6yTHjDumObD1eH/UkOOm8R9gM0w1Mbzkt9W644+65Q8mJR/ugxYWn5JhLqBaeddu
O+CqPeP2jhxZP0vY3WTnHTXh2pye1sdXIP2U/bdEyvFg2jPrZFpR6MtXz7Kn9hah
HH6CPhzEA0t153jAc4AINY5IXIjFnh5IzBevEh2DbZ1wKlBxMbF3EOeW/TRCQPug
6GxrKh6Pd3YD1+IDNe8B2BflXdiUs6j05ZlzAYF8RHqa9DBrTuvH9MJexY+NXmk/
DVOfVVq9XRbMyohXCzB6ZSbFNDoTf7UP3U7GKQy2rhq1SdpBmzBV23EUMn+Xy+R9
B7WJWslKGT5kQ3ZSIDf8bGIYdAHk9/qgKEYRrjOUx304/yofRGm7yLJLO8QUVRg5
41OpuUccbH8BK5EL/ys1Gzfc1h/0b4gVZeFavqdI/bfEleUHCmg15AlFq8XFDAjf
hUb3Jbt23GzUC43obzM4r3hB403qxgXOqgxnPVg3qlX4UJeBnnRKOun/WJUrys2w
d2mHsyWf7jPFZ6x+QojiXvLimdK2W4hJfg4DbBugHiGl3ePvd1UNgHKpD55t1Jio
noBtu48+tq6fZUK1nwvOGLsB4q4wRgjAtmQOgrTCGAei9/glEXtG524/iSe5eawC
uSroEbQDsYFCLd0CVs20
=MADy
-----END PGP SIGNATURE-----

--QQNwO3VdVfodZayb--
