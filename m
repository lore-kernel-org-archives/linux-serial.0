From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 02:57:52 +0200
Message-ID: <20160823005749.io6x4oi7muttkhfx@earth>
References: <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
 <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
 <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
 <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
 <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org>
 <20160822223223.398ee72d@lxorguk.ukuu.org.uk>
 <20160822220017.GA10689@amd>
 <20160822235414.4b2f8712@lxorguk.ukuu.org.uk>
 <20160822235758.gh33xupgyroye5wa@earth>
 <20160823011521.0ed94283@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u2zngpcsc4golgp6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160823011521.0ed94283@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--u2zngpcsc4golgp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 23, 2016 at 01:15:21AM +0100, One Thousand Gnomes wrote:
> > > That would still be a regression. Not everyone even uses the kernel
> > > bluetooth stack. It would only return EBUSY if you had done an "up"
> > > on it via the direct bluetooth stack. =20
> >=20
> > So it returns EBUSY when uart-bus is used. Since uart-bus is about
> > hardwired devices that's basically always.
>=20
> That would only be when the bluetooth port in question was active via the
> hardwired interface - which is not always. You choose to turn on/off
> bluetooth interfaces. If you boot with an older user space you'd use
> hciattach instead.

So you mean if I do "hciconfig hci0 down", then the uart-bus should
"down" the tty and only on "hciconfig hci0 up" it should "up" the
tty? I would expect a uart-bus slave-device takes control of the
device ("up" it) on probe. It's hardwired anyway.

Also what should happen if old userspace use hciattach while
uart-bus slave-device doesn't have control over it? Do you
suggest to implement some dummy code, that detects uart-bus already
registered a hci device and returns success without doing anything?
Then "hciconfig hci0 up" will fail, since the tty is already taken
by hciattach.

Or do you suggest to register hci1 and one cannot use hci0? I guess
this breaks even more devices, as the device number changes.

Also note, that there is a chance, that hci0 will go up by some
script before hciattach has been called in your legacy userspace.
Then it will also fail.

So yes, from your point of view there is a regression, just because
it's working automatically. So let's just not convert existing boards
with working hciattach based bluetooth devices. New devices can use
the uart-bus, as it's not a regression for them and Nokia N series
can also do it, since they have no working bluetooth at all at the
moment.

> In many cases you'll also still need the tty interface to do
> things like firmware upgrades.

I would expect the uart-slave driver to know how to do firmware
updates. Actually most bluetooth chips are initialized by uploading
a firmware to them.

And there are definitely uart drivers not caring about having a tty
device. Nokia's vendor driver for their bluetooth protocol contains
a custom omap-serial driver combined with the actual bluetooth
driver. There is nothing related to the tty framework. I think the
same would work for the other hardwired bluetooth chips perfectly
fine.

Note: I'm not in favour of merging uart and bluetooth drivers. This
is really bad design. But it shows, that /dev/tty interface is not
needed by in-kernel drivers.

Of course tty is needed by userland drivers, but I expect, that
those do not use the uart-bus. They already require all kind of
hardware knowledge and don't work out-of-the-box anyway, so they
do not gain from this framework.

-- Sebastian

--u2zngpcsc4golgp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu5+LAAoJENju1/PIO/qadHsP/RaZBZw/9qgLzpjMD9zqalIk
ljCZESUhnkkzHTViLnz+0ghTmaJtV5DvtK4KPInrTc/+0tXaTTXnW3EBONze/ydX
3+cxscC4fLL9ZIkipeSYkhTNB1DQTLbO7NueHhMpbmdUkSU+LWxQLg5uYIXDQ9lJ
Pv0GCc+ZjKksRNOrv6L7kZsoZBXSXUG+IesV48W0iLlJhPAWZEzfgD6LAQBnEv/n
g+IVtUt7gPNUbKWyHStIEmQ1Fh2deNLTQPKeLZSPTxAjQO6iOtI/y2i4eAecOyb2
TiNwijWyI77MVyTpALuq4B2fXFGRULpxtIfQb+T/RbyXLFBqllGYzj5HRTK7CoCg
n5yW1k8rsRtmjjbDXhZzhf+otfu54qAk6dOfngtMX/26awGhKirwtFfWijHc8goj
1z1CUqC0Wm+Eo0+bNB+IVHAX1KR4Jqf01frW8K19YNXmVAVJWybl74OTfwyKfR+u
SmNgd+IEdjV8azuAUyawZ3k2KIcE6vFpB7PWC9B+C6BLMDedLFbUuS+WWMXaF1C0
XIN/XM70n35hmjecDztLoUKwJXL4m9HCnEBmazjJ8x6sRnGIT/ATc0vnexgX21fx
ElJVp6vtYbFmkc1D3otmJ4EiuMHkvHzYt6GXYTF5/y6uii7wxIvOIiTz2Eo0gPfJ
rNxcWPifOMQjjkN+g5A/
=DJ9Z
-----END PGP SIGNATURE-----

--u2zngpcsc4golgp6--
