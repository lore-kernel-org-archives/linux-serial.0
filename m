From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 00:03:17 +0200
Message-ID: <20160822220313.wc47q7c4vub2cxmt@earth>
References: <20160818011445.22726-1-robh@kernel.org>
 <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel>
 <20160822164533.688a6aec@lxorguk.ukuu.org.uk>
 <FAD4CEF6-93F4-41D1-915E-823867F740F7@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kkgpwgotjxlc6lsh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <FAD4CEF6-93F4-41D1-915E-823867F740F7@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--kkgpwgotjxlc6lsh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 05:07:06PM -0400, Marcel Holtmann wrote:
> >> Would it make sense then to define a DT binding that can cover these
> >> four cases independent of the Linux usage:
> >>=20
> >> a) an existing tty line discipline matched to a tty port
> >> b) a serio device using the N_MOUSE line discipline (which
> >>   happens to cover non-mouse devices these days)
> >=20
> > These two are the same basic thing
> >=20
> > 	port x expects ldisc y {with properties ...}
> >=20
> >> c) a uart_port slave attached directly to the uart (like in your
> >>   current code)
> >=20
> > c) needs to be a tty_port slave attached directly to a tty_port.
> > Important detail, but as uart_port is just a subset of tty_port it's a
> > trivial detail to the DT.
> >=20
> >> d) the same slave drivers using a new tty line discipline
> >=20
> > and this is also just a/b again.
> >=20
> >=20
> > What use cases and connectivity do you need to describe. Looking at the
> > ACPI platforms we have
> >=20
> > - the expected serial port configuration
> > - the properties of the port (FIFO etc)
> > - the power management for the port
> >=20
> > - the children of the port
> > - the power management of the children (at a very simplistic abstracted
> >  level)
> >=20
> > So we want to be able to describe something like
> >=20
> >  ttyS0 {
> > 	baud: 1152008N1
> > 	protocol: bluetooth hci
> > 	fixed: yes
> > 	powermanagement: { ... }
> >  }
>=20
> we also need to know what Bluetooth vendor is there. Since we need
> to match the vendor to the firmware loading and configuration.
>=20
> Additionally there might be PCM audio configurations that need to
> be considered. Since we have to configure direct PCM interconnect
> with the audio codec.

It's not enough to automatically set a ldisc. There is also need for
additional resouces. For example the Nokia bluetooth driver needs
some extra GPIOs. The same is true for the in-tree hci_bcm, which
misuses the platform_device exactly like Greg doesn't want it.

> > and if I look at the usermode crapfest on a lot of Android systems it
> > looks similar but with the notion of things like being able to describe
> >=20
> > -	Use GPIO mode sleeping and assume first char is X to save power
> >=20
> > -	Power up, wait n ms, write, read, wait n ms, power down (which
> > 	has to be driven at the ldisc/user level as only the ldisc
> > 	understands transactions, or via ioctls (right now Android user
> > 	space tends to do hardcoded writes to /sys.. gpio to drive power
> >=20
> > -	And a few variants thereof (power up on write, off on a timer
> >  	etc)
>=20
> Actually the sad part about the Android mess is that we can fix it
> for Bluetooth. We have HCI User Channel that allows to grab a HCI
> device and assign it to Bluedroid stack on Android. So it would
> work with whatever bus or whatever vendor is underneath. All this
> hacking would go away. And we have used this successfully for
> Intel based Android platforms. We know this works.
>=20
> > So I can imagine wanting to describe something like
> >=20
> > -	The bluetooth HCI hardware is managed by gpio 11 (or UART DTR,
> > 	or PMIC n etc)
> > 	The uart can switch into GPIO mode and is gpio 15
> >=20
> > or
> >=20
> > -	Raise gpio 4 when writing, drop it after 50mS with no read/write
> >=20
> > Then the ldisc needs to make port->ops. calls for enabling/disabling low
> > power mode and expected char, and the uarts that can do it need to
> > implement the gpio/uart switching and any timers.
>=20
> I now wonder if we can not just turn the ldisc into a bus. So we
> have a ldisc bus that exposes devices that have no business of
> having a userspace /dev/ttyX exposed. And our Bluetooth UART
> support just turns into a ldisc driver on the ldisc bus.
>=20
> One of the problems is that attaching the ldisc from userspace you
> still need to figure out what /dev/ttyX you get assigned in the
> end. And figure out which one is the Bluetooth UART. If we want
> single images where things just work out of the box, we need to
> get extra information for doing auto-detection. So some sort of
> bus enumeration is key to make this work smoothly.

I don't understand your propsoal. First you write, that no ttyX
needs to be exported at all, then you need to figure out what ttyX
got assigned in the end.

I think the problem with line disciplines is, that they do
not follow the Linux device model. UART slaves may have extra
resources like gpios or regulators. The current workaround from
the drivers is an additional platform device, which only is
used as resource storage and accessed by the line discipline.

I think having a proper slave devices would be better in the long
run than adding more hacks to work around the problem of line
discplines not being devices. It probably makes sense to make the
API similar to the line discipline API, though. That way old code
can be reused.

-- Sebastian

--kkgpwgotjxlc6lsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu3aeAAoJENju1/PIO/qa7TUP/A9hYZmZ8GSDFFsc/SNuVQ2o
jiiVpyTGFBZKehJzUU2lGvXmL/T6yCzV0qEswOqRozmxuME5oNOjf2/5xB/Nx4YS
BXrPrP8WVjWcVxbaGGEG0WAB0Bbl4TkPaAplGtkmLJDFuLVbe9JUDax4RGv/B1gl
sMPTIUL/oL71fN6cuLob8EuR8eKPjlm2Xu8BZEAqj1VTkS91t7hv8CNMzIrgInov
Cd2tkoujmGtbrRysIQKPn1nQ3H0a01A3NMmoEUB4PcU12Jm9oM0qNJOOy+zIACqp
hPL8tS5/lv+KmqMINkcWQUJ3pyGL5YD6Dhbru3AUaVnFM7G1VE6qyHZsTG+ldveS
IwJvlzI9yUdQmo21wQfpdy/gO7L1zBuo7VJWJQY+B4p//sqpfuQ1aUziBJcQTRYr
lf16v3MVriiJ7PUFGN/d1S3bUiSOb+7/bzMgEMdOdoTX8W+SLZj4pAA7ndGyPS+H
2dcIsGWyDyKcwpEh8MH7ss+rYBT4JYyKDre2myan8tl6Cc0UsNxtQPmnDLcsQFh2
eZnrglAlEN5nOdlIf5PKHMb8zFp7aiN66YTc/PZX9YsOG42vBQltsqyAhY7Ie4Vh
TjoXGg1vkEoxrXKYQVMy8hL5f+IKxsm14/q9ORyz+GLPfTjyrqNYYQTfniVpv3Jw
5Ru9/XJWU8WtdOXO/a9G
=ycLq
-----END PGP SIGNATURE-----

--kkgpwgotjxlc6lsh--
