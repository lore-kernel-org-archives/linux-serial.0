From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Sun, 8 Oct 2017 00:53:11 +0200
Message-ID: <20171007225311.lvli7rkhv3bebq2j@earth>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
 <20171007151934.GJ2618@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w6zxr37su6uwuyy7"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171007151934.GJ2618@localhost>
Sender: linux-acpi-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, robh@kernel.org, marcel@holtmann.org, loic.poulain@gmail.com, lukas@wunner.de, hdegoede@redhat.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--w6zxr37su6uwuyy7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 07, 2017 at 05:19:34PM +0200, Johan Hovold wrote:
> On Wed, Oct 04, 2017 at 10:51:30AM +0200, Fr=E9d=E9ric Danis wrote:
> > UART devices is expected to be enumerated by SerDev subsystem.
> >=20
> > During ACPI scan, serial devices behind SPI, I2C or UART buses are not
> > enumerated, allowing them to be enumerated by their respective parents.
> >=20
> > Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for s=
erial
> > devices on serial buses (SPI, I2C or UART).
> >=20
> > On Macs an empty ResourceTemplate is returned for uart slaves.
> > Instead the device properties "baud", "parity", "dataBits", "stopBits" =
are
> > provided. Add a check for "baud" in acpi_is_serial_bus_slave().
> >=20
> > Signed-off-by: Fr=E9d=E9ric Danis <frederic.danis.oss@gmail.com>
>=20
> So just to reiterate what I just mentioned in a comment to one of Hans's
> hci_bcm patches:
>=20
> This one would silently break PM for such devices on any system which
> does not have serdev enabled (as the corresponding platform devices
> would no longer be registered). And with serdev enabled, hciattach
> (btattach) would start failing as the tty device would no longer be
> registered (but I assume everyone is aware of that, and fine with it, by
> now).
>=20
> Perhaps the hci_bcm driver should start depending on
> SERIAL_DEV_CTRL_TTYPORT when ACPI is enabled?

ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly,
since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented
for serdev. If any other controller is implemented that one could
also be used.

I wonder if we should just hide SERIAL_DEV_CTRL_TTYPORT and enable
it together with SERDEV. I suspect that we won't see any other
controller (it would be a UART device, that is not registered as
tty device) in the next few years and the extra option seems to
confuse people.

-- Sebastian

--w6zxr37su6uwuyy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnZWtIACgkQ2O7X88g7
+ppeCQ/+NS4F2sjsj3X1tKY0nFNrdt7Z/yRgHLPw/dKygmqMEp5EfX4S2Xao5vsQ
fnMgndg7wRYg4j87VfQS6EKB8rIafR3+97vb2GegWAIAVoTdnc/kIrpTAfUmKPrf
22jtA5DZbqlyHGfiDTyWHQnBXbE0grGVoHZhg+CfmkSH4uryx4pPhN7SyyHNjRsW
+nDiV/RvmvIqX7qpvR4iQ0jXxCCMZAzv8OTucUVvSrSTqWgSRs0qMh+Zmgero3tI
tZXAc2VP6VyVT033I7SBtj5j9V76tRjhGdiUcfC6fIuq91mJUK/ofNzlct5ej7M0
HAFTy+mvNlmEm9DIHDYYF3Enm8hI4oArvYhnXrNf47HtFfgXbxG0BuPeLfwHAjwk
6OlcJ+p96SUIvtKyMiYMYDqAbSS5M6B29glfNAtjYFP74CeDJFZB3RTteFpS3LDa
cFAIQGKC3PncXdPWJpsncwWuq2zJ6VygehYXfjl0vwfFfILnmDcKuTM12JBkV/Sh
P2dZqFq+kDUPN/jxLD71J80F0TKVl6IMI4CK5WbSxPxmLrIfP200KuyqmpSJ94vX
nhmH45sa0F94HfwN/L5aIfr+8bhl9FPwaMmEZ/Swr9iKUpGwm1S1Z5iz4RDnIaNu
agzYQ3Cow0PfvrKaDA5RAjcnkmPFHevf0yDEVU5D/ZEwd9xjBHc=
=vRL5
-----END PGP SIGNATURE-----

--w6zxr37su6uwuyy7--
