From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 01:57:59 +0200
Message-ID: <20160822235758.gh33xupgyroye5wa@earth>
References: <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel>
 <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
 <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
 <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
 <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
 <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org>
 <20160822223223.398ee72d@lxorguk.ukuu.org.uk>
 <20160822220017.GA10689@amd>
 <20160822235414.4b2f8712@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z2xuyqkzrqtqmspz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160822235414.4b2f8712@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--z2xuyqkzrqtqmspz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 11:54:14PM +0100, One Thousand Gnomes wrote:
> On Tue, 23 Aug 2016 00:00:17 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > On Mon 2016-08-22 22:32:23, One Thousand Gnomes wrote:
> > > > why would we even have it create a /dev/ttyX for these devices in t=
he first place. Lets just not create an uevent for it and lets not create a=
 dev_t for it. =20
> > >=20
> > > Because if you don't it's a regression. It's not permissible to break
> > > existing userspace. =20
> >=20
> > Well... it would be good to do the right thing, at least in the places
> > where we can.
> >=20
> > Yes, renumbering people's serials is bad, OTOH for new platforms it
> > would be nice not to expose ttyS15 which can only return -EBUSY.
>=20
> That would still be a regression. Not everyone even uses the kernel
> bluetooth stack. It would only return EBUSY if you had done an "up"
> on it via the direct bluetooth stack.

So it returns EBUSY when uart-bus is used. Since uart-bus is about
hardwired devices that's basically always.

Also I wonder how relevant your "I want to handle all UART stuff out of
kernel" scenario is for uart-bus, which is about in-kernel UART
drivers.

-- Sebastian

--z2xuyqkzrqtqmspz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu5GEAAoJENju1/PIO/qavLAP/RhkbuywO8MbocXB5/wxiqsj
XvU55UKS9O8yNpQAOHKo9gO0FRtYElIwGG34uYt3aiJwKdqblG7B/ErWKYu64ubg
Vz29/CmStRIJEfSaxK86uavhWkWXNMxWqZz4TzBSEGXb6QG44UAEQV5GeQkdtich
urUjZjSWj8YPz0EoGJOve7Y+dB3tij2FtSIauJ2mMbSt/Nds5uQ/ZiWVUw58WgkA
XQc3PlmAV/mEdJdKq3kyObGU9xciKGjyYZd0bO/YwukmyApX0mdb4Bf4VgpSALaj
HDGWN8ANMDK62sW6hdN5UJOGV+JZM21Pg3PfaSJPKVxvrUPQEO2ZBhcjg29Lfs3u
l32zbp/RlGslPV0bTuus9FoC1W2VkjqpScXL/0uOumYDgInGw1DFqfxDIUn3AMnA
OnScFoV98TClGYUxx8xCRjqe2VtXTSjVilOzIJoj4rEURHssCTDkbvo3bMeGVhLg
6bvkAcW72Yh3bkKkkcI3ScCo0LHmdhv/NsQO6ILfDA8kXlDOoCOn2HP+CDug5ghu
JH5MXpR4kexRrIkndtNmVVsTc9hjkDCt/+y0T1RyvpArQtZYsYRrsIWxee79HBGU
4tYF/QoG/oEmWF4LNIKxSCmArdhXDUQJK9j8XyOQgPY/vGdFzgeCM8x+FflXN7mM
K8iPRbu9CG/mlO7kln42
=oosx
-----END PGP SIGNATURE-----

--z2xuyqkzrqtqmspz--
