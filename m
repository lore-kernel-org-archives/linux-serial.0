From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Mon, 9 Oct 2017 10:55:34 +0200
Message-ID: <20171009085534.c5smytfgckyx7mqy@earth>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
 <20171007151934.GJ2618@localhost>
 <20171007225311.lvli7rkhv3bebq2j@earth>
 <20171009073526.GL2618@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j7e4pzcivprtkvfp"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171009073526.GL2618@localhost>
Sender: linux-acpi-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, robh@kernel.org, marcel@holtmann.org, loic.poulain@gmail.com, lukas@wunner.de, hdegoede@redhat.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--j7e4pzcivprtkvfp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 09, 2017 at 09:35:26AM +0200, Johan Hovold wrote:
> On Sun, Oct 08, 2017 at 12:53:11AM +0200, Sebastian Reichel wrote:
> > On Sat, Oct 07, 2017 at 05:19:34PM +0200, Johan Hovold wrote:
> > > On Wed, Oct 04, 2017 at 10:51:30AM +0200, Fr=E9d=E9ric Danis wrote:
> > > > UART devices is expected to be enumerated by SerDev subsystem.
> > > >=20
> > > > During ACPI scan, serial devices behind SPI, I2C or UART buses are =
not
> > > > enumerated, allowing them to be enumerated by their respective pare=
nts.
> > > >=20
> > > > Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used f=
or serial
> > > > devices on serial buses (SPI, I2C or UART).
> > > >=20
> > > > On Macs an empty ResourceTemplate is returned for uart slaves.
> > > > Instead the device properties "baud", "parity", "dataBits", "stopBi=
ts" are
> > > > provided. Add a check for "baud" in acpi_is_serial_bus_slave().
> > > >=20
> > > > Signed-off-by: Fr=E9d=E9ric Danis <frederic.danis.oss@gmail.com>
> > >=20
> > > So just to reiterate what I just mentioned in a comment to one of Han=
s's
> > > hci_bcm patches:
> > >=20
> > > This one would silently break PM for such devices on any system which
> > > does not have serdev enabled (as the corresponding platform devices
> > > would no longer be registered). And with serdev enabled, hciattach
> > > (btattach) would start failing as the tty device would no longer be
> > > registered (but I assume everyone is aware of that, and fine with it,=
 by
> > > now).
> > >=20
> > > Perhaps the hci_bcm driver should start depending on
> > > SERIAL_DEV_CTRL_TTYPORT when ACPI is enabled?
> >=20
> > ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly,
> > since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented
> > for serdev. If any other controller is implemented that one could
> > also be used.
>=20
> Not for hci_bcm, right? This particular driver specifically depends on
> SERIAL_DEV_CTRL_TTYPORT for the ACPI devices and not just any (future)
> serdev controller (or currently working systems soon breaks silently).
>=20
> I don't think the same is true for the DT case where we do not already
> have child nodes defined in firmware (and in fact, this driver did not
> really support DT before serdev).

The serdev ACPI support has been added to the core and not to
the ttyport and the hci_bcm driver only uses functions from the
core. As far as I can see the ACPI part would also work fine with
a different serdev controller.

Of course DT and ACPI currently require SERIAL_DEV_CTRL_TTYPORT,
since it's the only serdev controller implementation. Also it
covers most use cases. When SERIAL_DEV_BUS is selected it's
very likely, that you also want SERIAL_DEV_CTRL_TTYPORT.

> > I wonder if we should just hide SERIAL_DEV_CTRL_TTYPORT and enable
> > it together with SERDEV. I suspect that we won't see any other
> > controller (it would be a UART device, that is not registered as
> > tty device) in the next few years and the extra option seems to
> > confuse people.
>=20
> I agree that it is somewhat confusing. But now that we have both,
> perhaps simply having SERIAL_DEV_CTRL_TTYPORT default to "y" when
> SERIAL_DEV_BUS is selected could be a compromise. The Kconfig entry
> might need to be amended as well (e.g. if only to mention that you
> need to select a controller as well).

I think we should at least add a default "y" if SERIAL_DEV_BUS.

> And the bluetooth uart drivers already depend on SERIAL_DEV_BUS.

Yes and that's the correct dependency. They only need the serdev
core and controller. The only reason they do not work without
SERIAL_DEV_CTRL_TTYPORT is, that there won't be any serdev
controller.

Note, that the default "y" if SERIAL_DEV_BUS in SERIAL_DEV_CTRL_TTYPORT's
config entry is only a partial fix. There is still the problem,
that SERIAL_DEV_CTRL_TTYPORT can only be enabled if SERIAL_DEV_BUS
is configured builtin. This is a limitation of the ttyport
implementation, that hooks into builtin TTY core code.

-- Sebastian

--j7e4pzcivprtkvfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnbOYMACgkQ2O7X88g7
+prZlA//bTLSHjto6YCllMxj78GI7HmyRhFYWDbhoaRo6mDDyorYu4GeG+xTgk4h
lhWU/gpdSllAJHo2cA9soGMOl5ZO9HQ0mrMlpK9cp/GDyvQfcdE4M0lAlzZAJOOt
LRuwEYyQ+PhiT8lzr1JrBkcmzjdCmd0WS/ACi11rquuvNUIYjOAnl6PJa5pPCU4Q
yEtziBrJBcZdEHlubQ0QcBWdg2M7LzX6GXxKNixH1xW7fKTVYQlG+D0l96eZO5ze
CwuLkcj5JhATkmYZSIw+dIbtwJW/xsK+BBkn5Hw0O8fJSCM9UaPHGo2aBe1YZr5u
nWMtDYOARLe3h1HGlx8k96oVrAzPAPtk5KcRcthruz4UmJmPALIkviOJbt5wsyNV
plAkWMBkPtO/0RZcOcFiXNe2w1oUYBo4ja4cfxfJaOnlQXRdT202IinUeKgyWMHR
PGsZfgnJvE3z5qRilU+rV3EbNFRy8EtY1K6sgj2+NV3Viq0lR086hkMoUAvh4Iyl
49sIKPjnbQypYShok+8PeMcsXUnGDmtIfwq89YGeMJh/KMxpzBpbN8lS8iuL9KDK
/NRWCgERbgNVtl3Zc0OK06PTFgT1ewic4a599uyJsazQH0fcaaTWCGYCojDKVljE
G3J29y/qco/9z1c+Vuh2Z2aoDh6etgAmJmrYn7eoQxuQqvzoDok=
=8k78
-----END PGP SIGNATURE-----

--j7e4pzcivprtkvfp--
