From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 19 Aug 2016 17:36:25 +0200
Message-ID: <20160819153625.oqwkj7rx23bmqji7@earth>
References: <20160818011445.22726-1-robh@kernel.org>
 <20160818152528.569eb426@lxorguk.ukuu.org.uk>
 <CAL_Jsq+_uyycf+_eGr+864juxM4153ctoUMz9r=+tZG_Or7zUw@mail.gmail.com>
 <20160819123808.05b9dc3c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ce7b3myenlvgczx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160819123808.05b9dc3c@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--4ce7b3myenlvgczx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 19, 2016 at 12:38:08PM +0100, One Thousand Gnomes wrote:
> There are also some other slight complications when you look at
> real world implementations. Android devices tend to keep the GPS
> in userspace so most of them can't use some magic extra API but
> just drive GPIO lines via the sysfs GPIO interface. Most Android
> doesn't use the kernel BT stack either.

I don't get the reasoning for this one. What has it to do with
an in-kernel API? People are also using libusb or doing i2c/spi
=66rom userspace. Nevertheless we have an in-kernel API for those.

> Quite a few Android and other embedded devices also do power
> management by shutting off the UART, routing the rx line to an
> edge triggered GPIO and on the interrupt flipping the UART back
> on and losing the first byte, picking a protocol that can recover
> from it.
>
> Your model doesn't I think cover that, although I am somewhat at a
> loss as to how to do that nicely!

On OMAP this is supported by the serial driver via runtime PM and
wakeirq.

Actually my usecase for the API (bluetooth on Nokia N900, N950, N9),
there is an extra GPIO for the power management (high =3D uart
should be able to receive sth., low =3D uart can sleep). For this
I can just disable the wakeirq in the UART by not adding it to DT
and instead runtime manage it from the uart_dev child device.

While we are on that topic: The omap-serial driver does not enable
runtime PM by default, since it does not know if the remote side is
ok with loosing the first byte(s). One is expected to enable it
using the sysfs API.
But I think it should be safe to enable runtime PM for the serial
device in uart_dev_connect(). Due to the child device it will still
be kept disabled, except when the uart_dev also implements runtime_pm.

-- Sebastian

--4ce7b3myenlvgczx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtyd3AAoJENju1/PIO/qaboAP/1onyGUR1ttOiGK5fUYXBo/L
KNbXwdYt19+HimKlCtMgk73dLOigMuU06bsKfouX/EfGT0Z+NEDMigs6zOdtccW2
QCdK4F/Eb++V7v+7Nf5BCeGq7PR+N0bDFpR9kMClZocI6/g5sS+ShHumUgXwSvwa
vzqMEzDF58fyMfydIfns50ot2RaQHgVK6wZhPEVO4atRQzLlEOBagZazEPL5rack
05+w9UdJslDd8N5n9uUR5JFzf5dKQd4Ms5zYAVWXhBgUItYMbiCEdc+h/25ezK1z
2fgmN2I0GRINohh9q8oCINujE8QkNJ3GXT5yZ5DKmlxOgI7w7D3DIjCkUd/L3fg3
FN/ChbXaXV8D48Q/tS8vzQhacCJ4yI/HTxG0ntKCuDC93Bga0ketJ5j0dGFrGthI
Xz6ZxeQLuVJCl/24gbuFaigA+2iCPdyfvEbnKeEK+0gt/YhUU572umcWltXVSE44
J7Sec0VdELOVNQ5hU1u6aH2YN0cf8MFDVg6ZtNIPP3tLlw3S2dadeCvpCmBgs2fV
feb/c0CyqrxKd9xkZ6OHbi802NbSj/8L1tA3QmXDicrXykkq9/w8hixw4pH6J82I
NVNqTQhpovPMJx8y5QbbGoeReesOhF3DEVCItFGXI1cSA8+Ux9wJqCbem3Qa8Jdu
omwWV6y/nJ79NRjjRe1W
=zouI
-----END PGP SIGNATURE-----

--4ce7b3myenlvgczx--
