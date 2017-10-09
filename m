From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Mon, 9 Oct 2017 10:59:03 +0200
Message-ID: <20171009085903.jw25zah3vb5bztcn@earth>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
 <20171007151934.GJ2618@localhost>
 <20171007225311.lvli7rkhv3bebq2j@earth>
 <B8D6C3B8-8108-4372-88E6-6182314C7849@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cfs7mrf75yithqbd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B8D6C3B8-8108-4372-88E6-6182314C7849@holtmann.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hovold <johan@kernel.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, Rob Herring <robh@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--cfs7mrf75yithqbd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 08, 2017 at 10:51:52AM +0200, Marcel Holtmann wrote:
> Hi Sebastian,
>=20
> >>> UART devices is expected to be enumerated by SerDev subsystem.
> >>>=20
> >>> During ACPI scan, serial devices behind SPI, I2C or UART buses are not
> >>> enumerated, allowing them to be enumerated by their respective parent=
s.
> >>>=20
> >>> Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for=
 serial
> >>> devices on serial buses (SPI, I2C or UART).
> >>>=20
> >>> On Macs an empty ResourceTemplate is returned for uart slaves.
> >>> Instead the device properties "baud", "parity", "dataBits", "stopBits=
" are
> >>> provided. Add a check for "baud" in acpi_is_serial_bus_slave().
> >>>=20
> >>> Signed-off-by: Fr=E9d=E9ric Danis <frederic.danis.oss@gmail.com>
> >>=20
> >> So just to reiterate what I just mentioned in a comment to one of Hans=
's
> >> hci_bcm patches:
> >>=20
> >> This one would silently break PM for such devices on any system which
> >> does not have serdev enabled (as the corresponding platform devices
> >> would no longer be registered). And with serdev enabled, hciattach
> >> (btattach) would start failing as the tty device would no longer be
> >> registered (but I assume everyone is aware of that, and fine with it, =
by
> >> now).
> >>=20
> >> Perhaps the hci_bcm driver should start depending on
> >> SERIAL_DEV_CTRL_TTYPORT when ACPI is enabled?
> >=20
> > ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly,
> > since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented
> > for serdev. If any other controller is implemented that one could
> > also be used.
> >=20
> > I wonder if we should just hide SERIAL_DEV_CTRL_TTYPORT and enable
> > it together with SERDEV. I suspect that we won't see any other
> > controller (it would be a UART device, that is not registered as
> > tty device) in the next few years and the extra option seems to
> > confuse people.
>=20
> I wonder if we should just default SERIAL_DEV_CTRL_TTYPORT=3Dy when
> DT or ACPI is enabled. Then no driver would have to select or
> depend on it.

This is not related to DT/ACPI. SERIAL_DEV_CTRL_TTYPORT is a serdev
controller driver, that registers serdev controller devices for each
tty. It will also be used by clients, that are registered via board
code.

-- Sebastian

--cfs7mrf75yithqbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnbOlcACgkQ2O7X88g7
+pq+Sw//fyAJSiFXxHBJ20BamyhXbZrqssnZSjviDwls5XK0esvuxmpASwf48ZNI
VzJYnueQnjfye6/TLiOMgOc/J/mGDbt+GoJfkXFboneRfG152GHqTkAlipTLSajl
lc5oDMUw7YK/ARPH+/fBBBNKndXGBGkIYNdPJ6wBxrofyXeyIzFPLDRKc6D2C4XX
sTqSmxMztaXNV375stb3mKtND9HzFgZN60R50K8hAKTUkSeROoFRol7yYGOyd2WG
T+z8AvRgmtlkX3jO9ebpGgbBfGPvT4siYJ803x2uWoaVaxjltsaDs/ImIcusbAbr
juPc5WSWdOa+O4NEaOOwtoazX2OqbrSISxuRpT49aW/n/A0aYPt5ssvxWc+ZoNDn
c7cVAeKJmzATdBtjnlC0c/nz24Hr6OKIsYH+OLJN5h1ZEb5fTLCREtDG3HRcArSS
7qQoWev7tqh07vhbb7MuJTawmwxpul6cmQ9Ao0teRopT8J8Dlt+rhz03p0+E7eKo
wQcHRAZJp9c4grTR6lLHJ9aElit6R/M8cnf3bhuTQwE4V4zdt3lqblU10HXkpH20
eFzRm7k/FUHGoNdRBCanC6Qj+10N73kvV9NUI/qYRBY3GZvFkZ7QwXJ7YeLa2LvM
cRcdSaqClnPJW11mYR0qJ3aVZ8CKcqD4O4Bfo6KFvOJDRrWiGDc=
=9RWh
-----END PGP SIGNATURE-----

--cfs7mrf75yithqbd--
