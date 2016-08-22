From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 22:00:28 +0200
Message-ID: <20160822200026.4i32vakhzipv7asl@earth>
References: <20160818011445.22726-1-robh@kernel.org>
 <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel>
 <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
 <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
 <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lwgqzkxtdv4gdmn3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--lwgqzkxtdv4gdmn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 12:30:27PM -0500, Rob Herring wrote:
> On Mon, Aug 22, 2016 at 12:02 PM, One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> > I think there are two other valuable features provided by serio:
> >> >
> >> > - an existing set of drivers written to the API
> >> > - the implementation of the tty_ldisc
> >>
> >> True, though I'd expect little of the data flow part of it to be reuse=
d.
> >
> > Then your design is broken.
>=20
> I'm talking about serio, not my design which I already said the
> receive side at least needs work.
>=20
> The serio API for rx and tx is a single character at a time. I thought
> we agreed that's not sufficient for things like BT.
>=20
> >> - a child of the uart node
> >> - a reg property containing the line number if the parent has multiple
> >> uarts (I'd expect this to rarely be used).
> >
> > That surprises me as for current x86 platforms it would be the norm,
> > except that we use ACPI.
>=20
> Exactly, we're talking DT bindings here. Each port will be a separate
> node otherwise things like serial aliases and stdout-path won't work
> correctly. Compatible strings for 8250 uarts are for a single port.
> But if you had h/w such that it has common and per port registers then
> it may be a single node. I'm not aware of any example offhand (maybe
> PPC CPM). But it doesn't matter as reg can handle this case just fine
> if we need to.

I would expect, that your imaginary example h/w also has one node
per port using a mfd style h/w description:

multi-uart-device {
    uart1 {
        child { };
    };
    uart2 {
        child { };
    };
};

> >> - baudrate and other line configuration (though I would expect the
> >> slave driver to know all this and set it w/o DT. Also, we already have
> >> a way to set baudrate in the parent node at least.)

I'm not sure if every slave driver knows this. Maybe some generic
slave drivers will come up, once we have the infrastructure. So
it could be useful to have the settings as optional properties.
OTOH it can also be done once it is needed.

> >> - other standard device properties for interrupt, gpios, regulators.
> >>
> >> Also to consider is whether muxing of multiple slaves is needed. It's
> >> not anything I've seen come up, but it's not hard to imagine. I think
> >> that can be considered later and shouldn't impact the initial binding
> >> or infrastructure.
> >
> > You can describe the child of the serial device as a mux and the childr=
en
> > of the mux as whatever so it comes out fine when you get to that point.
>=20
> Yes, that's what I had in mind.

I guess it can be discussed, when it becomes relevant. Until then
let's not open another topic.

-- Sebastian

--lwgqzkxtdv4gdmn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu1nYAAoJENju1/PIO/qaUE4P/2CHIz1XYi8lprjXVC2F02Kh
WFa1a6nYgJmI6kRv5KP8jYs36t40rLUmh4nv+9UIdDDZhpODr6GvDSaeMWfeFM0j
+/U/q13HRa5ELATwmng4L1IQ7YJy/63clDHI8hgiZ1OLkdzArF3DxuC3qZOh1dqm
zXmJvb4+KtuSXgLmJtItoLS0FmgbHze3LO8grwO7eS32GfaWmrHwWAC7LHJL8Cmf
q8LbUnY+6ewcMnzmNKQKDMmpNBxJkfqDgSWX4tXK43LFW2jrEEpljvnxS+wFBKUe
lnz8G3IX6otzdt2RTSGdFyNYFRn/JP1nlHm13uWM44oFJZvhvd1aKNED1KX5ol1g
Hw1ws/VN1CWWXWH94D708LMAsdC4D9vP+qwKPl8OUAonIQatDbs642pSqgK5CapC
s4kne0KGAPaEVx6gO3oxT7zna4kP7mZ5h88F+Ro3xdWglTs0rAJ5QXOU7E4pgcjR
2n8yp8Y8vtAgDtLPGtlzyhONBS7l91Giqs21V0WI8tzujNZ7DqEI2YVAdwuNGnZB
x5ywogEY0iECXCyWFt2A0sxeOc2az7BciWZUPpghrtaRscTrpd8i2qrpuHec8AX7
YAi1jvZkn6w9tFlk1o4k/Dw++OBQDu25wuv/TjbpbF5glu8FopVHazwvVfJER+sV
0AAKsaL8tBbbRccMOsi7
=7mgv
-----END PGP SIGNATURE-----

--lwgqzkxtdv4gdmn3--
