From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 23:23:26 +0200
Message-ID: <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com> <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de> <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com> <20160820143405.04303834@lxorguk.ukuu.org.uk> <B4DF8974-1C6B-432E-AD1A-1E6067B9C158@goldelico.com> <20160822203947.ksxwnvzhc3tpnnx7@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_B8E38301-1A40-45ED-B7E9-652C33E3B2ED"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822203947.ksxwnvzhc3tpnnx7@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--Apple-Mail=_B8E38301-1A40-45ED-B7E9-652C33E3B2ED
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,

> Am 22.08.2016 um 22:39 schrieb Sebastian Reichel <sre@kernel.org>:
>=20
> Hi,
>=20
> On Sun, Aug 21, 2016 at 09:50:57AM +0200, H. Nikolaus Schaller wrote:
>>> Am 20.08.2016 um 15:34 schrieb One Thousand Gnomes =
<gnomes@lxorguk.ukuu.org.uk>:
>>>> What it is not about are UART/RS232 converters connected through =
USB or virtual
>>>> serial ports created for WWAN modems (e.g. /dev/ttyACM, =
/dev/ttyHSO). Or BT devices
>>>> connected through USB (even if they also run HCI protocol).
>>>=20
>>> It actually has to be about both because you will find the exact =
same
>>> device wired via USB SSIC/HSIC to a USB UART or via a classic UART. =
Not is
>>> it just about embedded boards.
>>=20
>> Not necessarily.
>>=20
>> We often have two interface options for exactly the sam sensor chips. =
They can be connected
>> either through SPI or I2C. Which means that there is a core driver =
for the chip and two different
>> transport glue components (see e.g. iio/accel/bmc150).
>>=20
>> This does not require I2C to be able to handle SPI or vice versa or =
provide a common API.
>=20
> I don't understand this comparison. I2C and SPI are different
> protocols,

Yes, they are different on protocol level, but on both you transfer =
blocks of data from/to a slave device
which usually can be addressed. And for some chips they are just two =
slightly alternative serial interfaces.

> while native UART and USB-connected UART are both UART.

I see what you mean, but kernel divides between directly connected UART =
and USB-connected UART.

drivers/usb/serial/ vs. drivers/tty/serial/

to implement two different groups of UARTs. Although on user space level =
they are harmonized again.
This is why I compare with i2c and spi. But each such comparison is not =
perfect.

Anyways, to me it looks as if everybody wants to make the solution work =
for usb-uarts as well
(although I still would like to see a real world use-case).

>=20
>> And most Bluetooth devices I know have either UART or a direct
>> USB interface. So in the USB case there is no need to connect
>> it through some USB-UART bridge and treat it as an UART at all.
>=20
> I think having support for USB-UART dongles is useful for
> driver development and testing on non-embedded HW.

Hm. I assume you mean the Bluetooth situation where both, embedded UART
connected chips and USB dongles are available. I am not a specialist for =
such things,
but  I think you have three options to connect bluetooth:

a) SoC-UART <-> BT-Chip-UART-port
b) USB-UART (FT232, PL2303 etc.) <-> BT-Chip-UART-port
c) USB <-> BT-Chip-USB-port (not UART involved at all)

Case c) IMHO means you anyways need a special USB driver for the BT-Chip =
connected
through USB and plugging it into a non-embedded USB port does not =
automatically
show it as a tty interface. So you can't use it for testing the UART =
drivers.

BTW: the Wi2Wi W2CBW003 chip comes in two firmware variants: one for =
UART and
one for USB. So they are also not exchangeable.

Variant b) is IMHO of no practical relevance (but I may be wrong) =
because it would
mean to add some costly FT232 or PL2302 chip where a different firmware =
variant works
with direct USB connection.

So to me it looks as if you need to develop different low-level drivers =
anyways.

BR,
Nikolaus


--Apple-Mail=_B8E38301-1A40-45ED-B7E9-652C33E3B2ED
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJXu21PAAoJEIl79TGLgAm6koAP/0tKd2aB9CPnQCGP8697+8Tn
NPDtFMHfEf6IGZBhpXASyoK2LSJWNXsvGOgUKiFx6iBSI5QqYSbBrBklDvlsme9X
hlmRdnPa+bqypmjAfVpSQnIUzcnrYzOBpzNrh6nabknj7uChzB1uG3Zx0y1aBjFE
UoluIf0gxVtv1nffvZyGA1Q9y07+kQJgusNMCDKvlgNjzcgpEhydTjNeDUmVm6x0
o++SSiTLiYgN15DKivt/onEe+9wkAdP7/cRHjnGcmopyuhDNEkN9GOrYbUP9b+vg
I+rgu7tF/iekf1lQb65Gc659/XL+LH+Ubr3yTmf56xgGaqjRiGAs/8SgIacGJZKW
vXAcdJ1iB5HSbb9bpcMIavNhM/SnH3LxGRgFubkjZarRU/ENWxPaspxwG4ZybX/5
j0tmX5zG8FxpIkQltxRpWdqrI5pg76KtJqPcB7CvWaELwQf+0I6rWgpu8eJsPsNa
k74P++8usExoC6iMgUOO2VSinilQ38Vun5l+/saG3MpMbyCR1QCoeeDYaNIm3rNJ
MwzPHfrNu1oIMQs6lqSb0pp9UP/pMFpRuOT23YoSLtXIBJUqSsMaD6J8CcDOaoG2
x7FwmN/dGuocXAt/8pboyfwwP3sDBwclYuZNegfATVOQcOdGBjtn3+z3olkcOv7x
hALlhQoLetWpASHiw3ER
=sjI0
-----END PGP SIGNATURE-----

--Apple-Mail=_B8E38301-1A40-45ED-B7E9-652C33E3B2ED--
