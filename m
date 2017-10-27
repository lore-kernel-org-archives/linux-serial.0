From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 1/5] serdev: Make .remove in struct
 serdev_device_driver optional
Date: Fri, 27 Oct 2017 20:17:11 +0200
Message-ID: <20171027181710.ne3ku6rysm4blqov@earth>
References: <20171018170136.12347-1-andrew.smirnov@gmail.com>
 <20171018170136.12347-2-andrew.smirnov@gmail.com>
 <493297bf-245b-10be-2659-e9fa9f424f5e@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6disxknc4zlcapvo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <493297bf-245b-10be-2659-e9fa9f424f5e@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, cphealy@gmail.com, Lucas Stach <l.stach@pengutronix.de>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org


--6disxknc4zlcapvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 21, 2017 at 10:08:40AM -0700, Guenter Roeck wrote:
> On 10/18/2017 10:01 AM, Andrey Smirnov wrote:
> > Using devres infrastructure it is possible to wirte a serdev driver
>=20
> s/wirte/write/
>=20
> otherwise
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> > that doesn't have any code that needs to be called as a part of
> > .remove. Add code to make .remove optional.
> >=20
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-serial@vger.kernel.org
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: cphealy@gmail.com
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >   drivers/tty/serdev/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index c68fb3a8ea1c..f500f6a2ca88 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -252,8 +252,8 @@ static int serdev_drv_probe(struct device *dev)
> >   static int serdev_drv_remove(struct device *dev)
> >   {
> >   	const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(=
dev->driver);
> > -
> > -	sdrv->remove(to_serdev_device(dev));
> > +	if (sdrv->remove)
> > +		sdrv->remove(to_serdev_device(dev));
> >   	return 0;
> >   }
> >=20
>=20

--6disxknc4zlcapvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnzeCYACgkQ2O7X88g7
+prKmg//YEU6uplaFiNOrg65kIy7qa6Uyhx1LV1dVYVbfBo1iYoxJM4FWbspy81+
dzqI6gbpGlnzCktiF6KLzssYFWqDxovd3S+UjLOCPUZaRmczf+ygDwelrZFC8hnE
T2PssKkOURAwa+s2tfnjJYm4hJuXmeHdlawcKE8yw38+wDaGOaUYNd9WlW+6XBSo
Kg9QQjYHcT5xaUBVKCQ4rlrYCoOdVrvSMGiV0SkARqGfkSqxujsf8tr+ue1R/nbp
HaTaoiDc9Y/BCoMmOqJW9mozOXeYeECXcCgpH/sh69JSIC0v4VPgk9XibkqAH2Eg
aYBIz0lL5f2R5pxPvYIKaI+Ns/G4Je5hwuE2EfMx4evcnC2WKuWPk9ObBHPgqy0k
kSR+AE0jQ8BAB0jYZjoK2zL5wQ94uNSnww9sbd/28mJJR2fTR3FOH0FG/Z6RozT7
wxEMdkWzxKA3TbFoyF5786hS9NZ+mRKB+g/GEgZl467kBrtb0qU8VlHovotYyAta
2Bruxvg0cCFbidrP1f7gL+BQ3UEHA6IW2d0gMYgh0biYdbZO0gfWEj/pIINlepYz
1sLWalkXXiK15sBXe1iwl4V7BBdnGLi/zPb/0+ddgxdyxi0CXLcKWxX5TOCn1knS
amOS8v9ecUfbHS4AVo0xKvS22It5px2YGwXsAWmj56p81t3llDI=
=0C8A
-----END PGP SIGNATURE-----

--6disxknc4zlcapvo--
