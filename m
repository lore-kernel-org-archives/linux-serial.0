From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v10 1/5] serdev: Make .remove in struct
 serdev_device_driver optional
Date: Sat, 4 Nov 2017 18:05:48 +0100
Message-ID: <20171104170548.vkkgp363k2piyufx@earth>
References: <20171031163656.24552-1-andrew.smirnov@gmail.com>
 <20171031163656.24552-2-andrew.smirnov@gmail.com>
 <20171104112431.GA24583@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vjht3kqxsrxxpjnj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171104112431.GA24583@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, cphealy@gmail.com, Guenter Roeck <linux@roeck-us.net>, Lucas Stach <l.stach@pengutronix.de>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org


--vjht3kqxsrxxpjnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sat, Nov 04, 2017 at 12:24:31PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Oct 31, 2017 at 09:36:52AM -0700, Andrey Smirnov wrote:
> > Using devres infrastructure it is possible to write a serdev driver
> > that doesn't have any code that needs to be called as a part of
> > .remove. Add code to make .remove optional.
>=20
> What about manual unbind from userspace through sysfs?  You need to have
> a remove function.  All drivers need that, to not have it is pretty lazy =
:)

Resources,that have been requested via devres are free'd by the
devres framework after the driver specific remove function. This
also works for manual unbind.

If *all* driver resources are allocated using devres, you will end
up with an empty remove function. In that case it makes sense to
remove it completly. This is what quite a few (mainline) i2c and
spi drivers actually do.

-- Sebastian

--vjht3kqxsrxxpjnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAln982sACgkQ2O7X88g7
+po8JhAAisJDdiY4Tb5OBsZi9Gt5G2bMjnZICgxZFmRGrtzrXbdYx0Ut6eDpkLsB
OXWtpCcfskuLZXtu/rb4BYQk5DlVac+ZhN6FqeqZIrFsbubwRvGLpktAdJxICItq
pU+rwRFNN+WF8wYtaPUeGS4qBO9wr4eerdtsXAcmmAxytUQNb6CmlW4NpUJpYt4c
Vm1NJcPYUd0CyCxas9VUmatRTL5TaAB2ROnMVBuVJDCpxJDydo3Xl8/Tv0pWUbPB
gyFvoc2MezSJq3iWFiXAuJ5axwP18EwKz68sD1t84ahSfLmu7dlphwgs5LuUMXpj
MTQxbqTQJGPZlJglNhBgQ0gjqqT3cFPBxtDIB7so5+bDPguUipq7DpVSV6j0A6HJ
79kKqNIuPhvuv9ic4tfc8nFZiln6i93viF/p0IiPfTDY10ovPsHKjNAqBDV9QpnB
UdieFp8l1cH/yOcGfNn8JjOVUeiH0Bs8z2VHp9/V8cjoqjMGvGNOPWHspNUhgUuR
zPOGOjdemwteOtpISay8LHc5mFYAhvG8lXaiPmOs/kZBjTc4gngIzmhi4lzMkfWA
+gNXInyloSAfBYAnLIdovQzWfhkOa9+Zj0haBdnaaBkeIHPWb7rsX8o0Lhlt15D/
TGIHaJsBgICpmmM5uDZyf5tw+wgYE/A0ldfcxMcTqwcR6xnudEI=
=YGFT
-----END PGP SIGNATURE-----

--vjht3kqxsrxxpjnj--
