From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 01:10:46 +0200
Message-ID: <20160822231043.y6yqwychgsttd24r@earth>
References: <20160819052125.ze5zilppwoe3f2lx@earth>
 <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
 <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de>
 <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com>
 <20160820143405.04303834@lxorguk.ukuu.org.uk>
 <B4DF8974-1C6B-432E-AD1A-1E6067B9C158@goldelico.com>
 <20160822203947.ksxwnvzhc3tpnnx7@earth>
 <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com>
 <20160822224247.vdh3plda6dxelvzw@earth>
 <20160822235256.2966dd49@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tpj3junt67x2tagu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160822235256.2966dd49@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--tpj3junt67x2tagu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 11:52:56PM +0100, One Thousand Gnomes wrote:
> > There are usb-serial devices, which could benefit from support
> > btw. I would find it really useful, if the Dangerous Prototype's
> > Bus Pirate would expose native /dev/i2c and /dev/spi and it's
> > based on FT232.
>=20
> That should just need an ldisc.

Right, since it does not need any extra resources. Probably not the
best example.

> I2C and SPI should at this point be sane for hotplugging as needed
> for an ldisc.

I guess hotplugging support in the downstream kernel frameworks
would be needed anyway with usb-serial being USB based.

> And having an ldisc also has another nice effect. You can plug the bus
> pirate into a remote machine, run an 8bit clean link over a pty/tty pair
> half way around the world and get a local i2c/spi to the remote machine's
> i2c/spi bus pirate ports and devices.

Right.

> It also means that if Bus Pirate 5 changes USB uart nothing breaks.

And it means no auto-support. Which would be fine in case of Bus
Pirate, since its mainly a developer device and some people may
actually prefer the IMHO anoying serial interface.

Let's forget that example.

-- Sebastian

--tpj3junt67x2tagu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu4ZzAAoJENju1/PIO/qaNusP+wfG5+bD/xQl88QcpW95DplN
gsIAmE8ruvETwgXkA0V3JIrCTCQkGWEu36tqK43KGxERT5yNqLJhhSSvcKHXPLbZ
itmONPK65/9cRFISaddu36X413OULgQWPwrN+JtJ1X1M4WS1neymrVb98A561x8q
okVARY8d1Kw86BLY3UTmQsQ0MCUlLrLepvnVhYXxJROJDUXTVAZxdkxpyFAgedW9
lir958/qGWoPGBbqcAtysiEzwti9iAhxf67Ukw4toWPCxqkrDpLRiwr/Yz19L5oz
yfFgdLzeusmiBoUyB2FumvdDbxpoZq4fy2w5wgOTqA60hUvmnwxwx84TXH43aym1
5dOgcz+9RDlGjqxFtzC1ZiXyddqbe65b8mgXEPAqz9b9cJ486RpX/quUV6q4laPR
kSm9I3a1aFyQWi7lVkOfrxstcXXeBYLr73p/Vp1WxIJnc52iDzjYzTp96HdR+/na
otDzCBjZmUhHUziprBbzJn0wAKKafRiYDt5bmmu1uCBTUOLHsNO+tE7C7eP/52OU
gf7x71eEyqAYW39uqpz3W70m8w6UjBnPx8IZcW4tdzs9ANP89XS1Pp7JSwxKbtpu
IyvM4GqThbz9yv/8DMoAidrDOIbTPt0yIHcNgxYCqlcr+Naa9CwAAXyD+A4d8vKS
TuAqs3boeu43E8frKc7U
=y9H1
-----END PGP SIGNATURE-----

--tpj3junt67x2tagu--
