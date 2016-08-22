From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 01:02:18 +0200
Message-ID: <20160822230216.4fdvqmm4aruxmppi@earth>
References: <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel>
 <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
 <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
 <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
 <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
 <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org>
 <20160822223223.398ee72d@lxorguk.ukuu.org.uk>
 <20160822220017.GA10689@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6gccjhclxmbojkch"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160822220017.GA10689@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--6gccjhclxmbojkch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 23, 2016 at 12:00:17AM +0200, Pavel Machek wrote:
> On Mon 2016-08-22 22:32:23, One Thousand Gnomes wrote:
> > > why would we even have it create a /dev/ttyX for these devices
> > > in the first place. Lets just not create an uevent for it and
> > > lets not create a dev_t for it.
> >=20
> > Because if you don't it's a regression. It's not permissible to break
> > existing userspace.

I guess there are three classes

1.) support for uart-slaves on new devices -> tty can be safely
    disabled, as it was never exposed
2.) support for uart-slaves on devices, which exported a useless
    tty (-> port could not be used from userspace without kernel
    modifications) [this is what N900 falls under]
3.) support for uart-slaves on devices, which could use hciattach
    or similar tools previously. I think these devices can't
    switch to the new API without a regression anyways. If the
    kernel already registered the bluetooth stuff hciattach will
    fail due to the -EBUSY (or whatever is returned).

So from my point of view there is no real regression when we avoid
exporting the tty at all.

> Yes, renumbering people's serials is bad, OTOH for new platforms it
> would be nice not to expose ttyS15 which can only return -EBUSY.

No need to renumber, there is the serial mapping in DT. We can just
export ttyS0, ttyS2 and ttyS3 (and skip ttyS1, which is used for
hardwired serial device).

> And we may want to do incompatible change at some point. People should
> not have to use hciattach on n900 from now

Don't worry, since platform_driver approach has been NAK'd by Greg,
the N900 bluetooth driver can only proceed once this patchset has
gone into the kernel. So N900 will never use hciattach.

> on until end of time, just because we exposed USB port as ttyO1 in
> past.

USB port as ttyO1?

> ...actually. I guess we should disable that ttyO1 in the device tree
> for now, so nobody can start using it. As we currently have 2-3 people
> in world who got that bluetooth to work with out-of-tree patches,
> breakage should be quite acceptable :-).

If you just disable ttyO1 in the N900's DT, you break runtime PM,
since the kernel does not access disabled devices. We could add
some kernel quirk, but who should use ttyO1 (which is btw named
ttyS1 with 8251 based omap driver)? It's basically unusable from
userspace.

-- Sebastian

--6gccjhclxmbojkch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu4R1AAoJENju1/PIO/qal1UP/15ZKNC1rkvPARk0wMK2y9ma
RYJkVcl6GlYi6SBCxb/q4mhUe5ct41eWlkihfy681VUjT9mZdXMqgh2WuxGBg62H
qs5ZXURCGb2aejcB2QIgNWeWH/UgMF3HakE/dTiwxLg45LBdHdVjUvIBGiaL0bnP
x5CuGRN1tXc3ugt3Xpjx6EHTOqfMVo5kBPOZCZddoznnzNvbiH9mUrSEGGipmju8
M3vL/EUVToYp/Q0zYSJ693jlgnS5YXSOtOLMNWGBa2Bg77Q1kiBmxBQNIH7jXh2G
v6h+CppZu1ejmiB9Qi6wGfRwKcYgGy5coOyObaPNqwse5Gm2cZm2W0hNhmc76pwX
d+bTLHRiOkx7rRs3yJYym8AKH1cn6r0t2xjz2Rstha1maOLrqRupH1b7YVFRLVs9
jQpACK/T+THLGU8Gm5XVEoJqrqHtwBB8zOiz4foMEnp35j7GyoHeYWfpOBZ/jrKY
oWhLpKNiL4t2TqXRdWzfDc/wILWCMM/SGj8k4FgcmRX+660JIDHuN7TXIv8Q0EXj
rvfPMZotWhr3p8El8r7kVP2LHgsrbgmBjm6FDXlYBytRN+fSVg6k+lY19VNCWun6
cBcqu94prL3Mh9PG+wwLWL/msRjIlcWBxz8HgeHQeh6h89YsZMoiTiC3U2vS0KF7
BwcJDgtm0v1Z3WuYIyel
=k91G
-----END PGP SIGNATURE-----

--6gccjhclxmbojkch--
