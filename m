From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 00:18:04 +0200
Message-ID: <20160822221801.mqwajt5qktqmcicp@earth>
References: <20160818011445.22726-1-robh@kernel.org>
 <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel>
 <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
 <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
 <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
 <20160822200026.4i32vakhzipv7asl@earth>
 <CAL_JsqJTbAri_7j5DWA2s1psyXMHu83MFXvEwB7tJGkwSwfU9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6jtqwxh4r6ldada3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJTbAri_7j5DWA2s1psyXMHu83MFXvEwB7tJGkwSwfU9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--6jtqwxh4r6ldada3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 05:00:40PM -0500, Rob Herring wrote:
> On Mon, Aug 22, 2016 at 3:00 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Mon, Aug 22, 2016 at 12:30:27PM -0500, Rob Herring wrote:
> >> On Mon, Aug 22, 2016 at 12:02 PM, One Thousand Gnomes
> >> <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> >> > I think there are two other valuable features provided by serio:
> >> >> >
> >> >> > - an existing set of drivers written to the API
> >> >> > - the implementation of the tty_ldisc
> >> >>
> >> >> True, though I'd expect little of the data flow part of it to be re=
used.
> >> >
> >> > Then your design is broken.
> >>
> >> I'm talking about serio, not my design which I already said the
> >> receive side at least needs work.
> >>
> >> The serio API for rx and tx is a single character at a time. I thought
> >> we agreed that's not sufficient for things like BT.
> >>
> >> >> - a child of the uart node
> >> >> - a reg property containing the line number if the parent has multi=
ple
> >> >> uarts (I'd expect this to rarely be used).
> >> >
> >> > That surprises me as for current x86 platforms it would be the norm,
> >> > except that we use ACPI.
> >>
> >> Exactly, we're talking DT bindings here. Each port will be a separate
> >> node otherwise things like serial aliases and stdout-path won't work
> >> correctly. Compatible strings for 8250 uarts are for a single port.
> >> But if you had h/w such that it has common and per port registers then
> >> it may be a single node. I'm not aware of any example offhand (maybe
> >> PPC CPM). But it doesn't matter as reg can handle this case just fine
> >> if we need to.
> >
> > I would expect, that your imaginary example h/w also has one node
> > per port using a mfd style h/w description:
> >
> > multi-uart-device {
> >     uart1 {
> >         child { };
> >     };
> >     uart2 {
> >         child { };
> >     };
> > };
>=20
> Yes, that is certainly possible too.

That way aliases and stdout-path also works. I think I would just
make one-node-per-uart-port mandatory and skip the reg part.

Let's assume your imaginary example h/w would be and i2c master with
two ports and some shared registers. Then it immidiatly becomes
clear, that one wants to somehow expose two ports in the DT instead
of using some port selection property (and reg would already be
taken).

> >> >> - baudrate and other line configuration (though I would expect the
> >> >> slave driver to know all this and set it w/o DT. Also, we already h=
ave
> >> >> a way to set baudrate in the parent node at least.)
> >
> > I'm not sure if every slave driver knows this. Maybe some generic
> > slave drivers will come up, once we have the infrastructure. So
> > it could be useful to have the settings as optional properties.
> > OTOH it can also be done once it is needed.
>=20
> Yes, you could have devices that do autobaud detect and don't care
> other than some max baudrate which could be limited by either the host
> or device. Then you have others that are fixed or start at a fixed
> baud and then switch.
>=20
> As for generic slaves, no doubt they will come up and I will be
> nak'ing the generic slave bindings. The "generic slave" is already
> supported via tty devices in userspace IMO.

Ok I didn't meant that generic. I meant something like "I have a
remote controller with specific protocol, baudrate is board
specific". Anyways it can be discussed once needed

-- Sebastian

--6jtqwxh4r6ldada3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu3oXAAoJENju1/PIO/qaw68QAJgiuRWtmlZJp3gN9RHVZzQK
XiVAmN5tRWyi3rLUlV1Yc86HFJMR4b/eBAEWMdVKoYQK5lkaV3mv0ydjrjsfVhr1
grho6fRvy0daxKJRMzqukJn9fZuEd0erBAP7o8UjJ594kw02gCbAda/4mma/QYPq
a9zrtPg4SYqqw2YaqZu0oEL+ljv/5WTupZkJUrz6yVxx+s+YFdfimF2Nw9l8DtMz
VL+eeBPVcKrKQTIGa0cJt656+LR62bbzTrad5RcUy8GDEZLdiewPqTmjMC7xt1+k
JkN1jzPvvxaUTRXBhMXXNlv+6rW4XcTFr+7U3qcq+CfTzC15ZBKvvRpkTbtltOGd
vJdXQJDisLG036gFFxeurFFrVBREY7ZKhA9dwkDWTqwJkm8GuO8ZW+Q0SYhF79Oe
i5J2lluswtwEvB8xYe1VNML3x6TkKejp3fJXk1KfrShbCOSV28LMKOjpKFcqLgvC
jL1vIJtzujr2iu4bIxJEMKK3uKTuKaijiYO8Ja2zjfT+6+EZjhop3kq3cn4gyUSa
T7Yvbv9TcjVyXpQ/WtHoppUG8BvdUyzbO058TUH9yCmnP7SmfOOHKH3NqUH1YXcr
JVq7oxFbHIyxKIwT69vxygyfhk1G7Dbz17EM/65eTVr7c4Fcll44XPRUrK9ArEsd
g/N0RX4XVu79MdLGDLCB
=ESXE
-----END PGP SIGNATURE-----

--6jtqwxh4r6ldada3--
