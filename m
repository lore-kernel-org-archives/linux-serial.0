From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 3/6] mfd: sun6i-prcm: Add support for
 Allwinner A23 PRCM
Date: Tue, 15 Jul 2014 08:55:15 +0200
Message-ID: <20140715065515.GE3745@lukather>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-4-git-send-email-wens@csie.org>
 <20140710093707.GC11948@lee--X1>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB5VCSOPAKGQEZQGXY6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140710093707.GC11948@lee--X1>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Thu, Jul 10, 2014 at 10:37:07AM +0100, Lee Jones wrote:
> On Wed, 09 Jul 2014, Chen-Yu Tsai wrote:
>=20
> > The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
> > The differences are the AR100 clock can no longer be modified,
> > the APB0 clock has different divisors, and some clock gates are
> > gone.
> >=20
> > This patch adds a compatible with a modified subdevice list for
> > the A23.
> >=20
> > Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> > Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
> >  drivers/mfd/sun6i-prcm.c                           | 30 ++++++++++++++=
++++++++
> >  2 files changed, 31 insertions(+), 1 deletion(-)
>=20
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

We don't have any dependency on this driver, so it would be simpler if
you could just take it through your tree I guess.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxNBTAAoJEBx+YmzsjxAgfl8P/jFHIOvMnJE/mqI1P6XIOTv0
dbKGL39V8id6nmuytvSnVRUnPNK+CoNMmY5bDD648TfI2FcgxvoC300v/1+e+lls
0Hn2S/ZWgSuY4VQ2LpPAyGWewhJW+fkRD7EvKo32M33DTm+//jCfSGqimfwgMKbN
r9r4TSwB+E4XkaZqzLtlulUPFpxcgENhOIxOi+5uub48UKPkuDyNG/Ha2fNpvOR6
xvZnj+J9IVHBx9Jc3Jo2NCNQBmyaLxIk54yLOl8Zav5WBMrG3AUdjPGLHD0U+t08
OjWjDM+yWQdXdYnT67wl2ddLWohQBuvVIWpzwaWHOpBdeHxIAT7lQm1mGgEYMYgk
UyfeV8PEVPehlLpZlWsdGBTDxZFYorhY4Y7+WVc0073BTVPhRTrd9gqiu2wa+Wh/
Bwlq57z5f8FONQSHbeM1Hi/4EK1jgnU7Kg3iI5K8EYc3bKcRKBpdBm339HklXirJ
vistM6goTwO0CDOcUrnvp/df/Xdb0hYl7QFoFQQOni1a42RP+R0Aorsw8tC8Ema4
M1KnOexedgnQ0VsBH2hoiDinL1FkWj789HtDy8gXQM9iXVOG0kjRSewxGkeBdk+D
MvOEKNQO5SOlzT2UAlR24X5MloufuxXC7LD+/j6DxoFU9uO6OwFwbc1RcvtZX90s
0O6LeOP+vfqmbsWAKXM0
=AumZ
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
