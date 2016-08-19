From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 19 Aug 2016 07:21:26 +0200
Message-ID: <20160819052125.ze5zilppwoe3f2lx@earth>
References: <20160818011445.22726-1-robh@kernel.org>
 <20160818202900.hyvm4hfxedifuefn@earth>
 <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="henxg5cothif7yv2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--henxg5cothif7yv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 18, 2016 at 06:08:24PM -0500, Rob Herring wrote:
> On Thu, Aug 18, 2016 at 3:29 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Thanks for going forward and implementing this. I also started,
> > but was far from a functional state.
> >
> > On Wed, Aug 17, 2016 at 08:14:42PM -0500, Rob Herring wrote:
> >> Currently, devices attached via a UART are not well supported in
> >> the kernel. The problem is the device support is done in tty line
> >> disciplines, various platform drivers to handle some sideband, and
> >> in userspace with utilities such as hciattach.
> >>
> >> There have been several attempts to improve support, but they suffer f=
rom
> >> still being tied into the tty layer and/or abusing the platform bus. T=
his
> >> is a prototype to show creating a proper UART bus for UART devices. It=
 is
> >> tied into the serial core (really struct uart_port) below the tty layer
> >> in order to use existing serial drivers.
> >>
> >> This is functional with minimal testing using the loopback driver and
> >> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the sla=
ve
> >> device). It still needs lots of work and polish.
> >>
> >> TODOs:
> >> - Figure out the port locking. mutex plus spinlock plus refcounting? I=
'm
> >>   hoping all that complexity is from the tty layer and not needed here.
> >> - Split out the controller for uart_ports into separate driver. Do we =
see
> >>   a need for controller drivers that are not standard serial drivers?
> >> - Implement/test the removal paths
> >> - Fix the receive callbacks for more than character at a time (i.e. DM=
A)
> >> - Need better receive buffering than just a simple circular buffer or
> >>   perhaps a different receive interface (e.g. direct to client buffer)?
> >> - Test with other UART drivers
> >> - Convert a real driver/line discipline over to UART bus.
> >>
> >> Before I spend more time on this, I'm looking mainly for feedback on t=
he
> >> general direction and structure (the interface with the existing serial
> >> drivers in particular).
> >
> > I had a look at the uart_dev API:
> >
> > int uart_dev_config(struct uart_device *udev, int baud, int parity, int=
 bits, int flow);
> > int uart_dev_connect(struct uart_device *udev);
> >
> >   The flow control configuration should be done separately. e.g.:
> >   uart_dev_flow_control(struct uart_device *udev, bool enable);
>=20
> No objection, but out of curiosity, why?

Nokia's bluetooth uart protocol disables flow control during speed
changes.

> > int uart_dev_tx(struct uart_device *udev, u8 *buf, size_t count);
> > int uart_dev_rx(struct uart_device *udev, u8 *buf, size_t count);
> >
> >   UART communication does not have to be host-initiated, so this
> >   API requires polling. Either some function similar to poll in
> >   userspace is needed, or it should be implemented as callback.
>=20
> What's the userspace need?

I meant "Either some function similar to userspace's poll() is
needed, ...". Something like uart_dev_wait_for_rx()

Alternatively the rx function could be a callback, that
is called when there is new data.

> I'm assuming the only immediate consumers are in-kernel.

Yes, but the driver should be notified about incoming data.

-- Sebastian

--henxg5cothif7yv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtpdTAAoJENju1/PIO/qaCjgQAIQDP+hEvxcbpGJGHcrLan0O
3M2Piv7KCess3my+LQ7ipCzCXVKV3L96t70v/3AqWbK1VrfY68X6FhvWNZtlj3KP
0yK1mhBZdqU3fzHBhRHFVHO0uiD/lBf4MNXRa1xi4m5haZvVryp2j7cA0DrRHyOM
bb2TxewGmIyZ8zMRGEsbEF9JSEwMRb9Nga1+hW8mldshRPqgTALuRfdfAoOOOxsZ
GxtqjAxMEEL+OEvaNN52315nA8AGF+dkifla/RZvksTy54tmMpxO/njwkC1kzmEH
DxLvNzDarA6ohdYpHp0x+twb3Iu3n61eN8eg/V/mWWLOqwZUAEahmiPBTYOFeDuF
n5Z4pfDGLeyvPcEVIncE8q1GsM4fqfX6vPWHR153CjgYxuzok00u//IU/DB6uAS+
oS3+MaX8y4nqdIEVk0WSkPk/aP6zT+0jyFkSuGzYlRmFh3RnItCWQtjsKQNhdg6H
3nwZXjprcky2gDj4NM774fRJhECqrwwNwOEUKvmPvnANmQ+/gVoh2n8KN9Jo+/i8
yBzXz1LdFcd8m0pk6yCFtoIEt/uR800aPUxy1x23TXBMAZ3sou3X5HKQUsxG+Yqz
3RHtd/ExCcmQ5+DxoXV35seczPd2WZLtaBWFTTNefvCa6+6wesb26OnfUROVwqC/
wsWzV3MfZyCCPU58n06I
=ItwL
-----END PGP SIGNATURE-----

--henxg5cothif7yv2--
