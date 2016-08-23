From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 09:28:40 +0200
Message-ID: <E6228980-6EC9-49BB-84FD-9F13C2DC4612@goldelico.com>
References: <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com> <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de> <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com> <20160820143405.04303834@lxorguk.ukuu.org.uk> <B4DF8974-1C6B-432E-AD1A-1E6067B9C158@goldelico.com> <20160822203947.ksxwnvzhc3tpnnx7@earth> <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com> <20160822224247.vdh3plda6dxelvzw@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_261411A7-0D54-441B-B2D1-000A1F6ED635"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822224247.vdh3plda6dxelvzw@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--Apple-Mail=_261411A7-0D54-441B-B2D1-000A1F6ED635
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

> Am 23.08.2016 um 00:42 schrieb Sebastian Reichel <sre@kernel.org>:
>=20
>> I am not a specialist for such things, but  I think you have three
>> options to connect bluetooth:
>>=20
>> a) SoC-UART <-> BT-Chip-UART-port
>> b) USB-UART (FT232, PL2303 etc.) <-> BT-Chip-UART-port
>> c) USB <-> BT-Chip-USB-port (not UART involved at all)
>>=20
>> Case c) IMHO means you anyways need a special USB driver for the =
BT-Chip connected
>> through USB and plugging it into a non-embedded USB port does not =
automatically
>> show it as a tty interface. So you can't use it for testing the UART =
drivers.
>>=20
>> BTW: the Wi2Wi W2CBW003 chip comes in two firmware variants: one for =
UART and
>> one for USB. So they are also not exchangeable.
>=20
> Yes, let's ignore option c).

> I'm talking about UART only. If the
> chip has native USB support, then that's a different driver.

Exactly.

>=20
>> Variant b) is IMHO of no practical relevance (but I may be wrong)
>> because it would mean to add some costly FT232 or PL2302 chip
>> where a different firmware variant works with direct USB
>> connection.
>=20
> Well for some chips there is not native USB support. But my scenario
> was about development. Let's say I have a serial-chip and I want to
> develop a driver for it. It would be nice if I can develop the
> driver with a USB-UART

Yes it would be nice, but is this a thing with significant practical =
relevance?

Usually you have to write drivers for a complete device where the slave
chip is already wired up to a SoC-UART.

Sometimes you can get a bare chip where you can connect to an
USB-UART. But someone has to design that piece of special hardware
for you. If you are really lucky there is an evaluation board.

And in that case I would use a RasPi or BeagleBone and tie up directly
to some SoC-UART instead of using an intermediate USB-UART adapter.
Because it is more close to timing relations to the final SoC based =
design.

> and then use it on my embedded system.
>=20
> There are usb-serial devices, which could benefit from support
> btw. I would find it really useful, if the Dangerous Prototype's
> Bus Pirate would expose native /dev/i2c and /dev/spi and it's
> based on FT232.

Oh, that is an interesting device I didn't know yet.

>=20
>> So to me it looks as if you need to develop different low-level
>> drivers anyways.
>=20
> No. You say, that option b) is irrelevant and assume, that every
> serial chip also has native USB support.

I just assume that b) is rarely used because there are alternatives.
Although it would be a nice option.

Anyways, while following the discussion this is not the most important
facet of the overall topic.

BR,
Nikolaus



--Apple-Mail=_261411A7-0D54-441B-B2D1-000A1F6ED635
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJXu/spAAoJEIl79TGLgAm6sQcP/R0xqIYmPEXN2uMshzvZ4kpa
JIQxz6W2E8bNdcBF4CV7yBUBDg4daQ1mUMtOqPyjOoCTpysdBHcqwdBnkGXCjXnm
fkhBrg7iGgBVNbJEEfTm+0x+xPvpysjY2wm2uaqeqgsrLOFqoDNYs+WsM0JSNNzJ
yNfLrTB9/RwGhIfNR5a1oBPYlDYBRQmZqrPhSbFEfz8q+6OBNpkzp8yRkhr9K3A1
pq6Z9OIdWVgUHbvJXr632l1j/gmEXOnrjtOUfXNDwpiCfNYHCtHozvkTlXwFKlEC
F9t5E6b0Gwl23l5wTUEFjDJObcf8iPu7ikRt4natAHjMNSTzDQl+rUOfI2BW3CWS
CWuRF96YPuyxx11/SerpxwFKRMs51NgD+1MhgBuRtmaFJFcnPlhSzdjncCE8e3I/
IZ9CfguZBnMl7JN5v4Hv7Ex++YRV9IKoYSvMmabefJkp7E/fMH9MY3B9aaakWrHo
IyRR4/bRoTJZrHBjsFYhQP0drr1uXcXSRaOEqMsrQV9RMh1deLzXPC7Dp2XbPDYC
hrcSmHM6VDnlFJNNao60g4d+sS1o5P1JWsABtxVukSSoM3t3/zbQx7VORNLxQJSx
mvs0vz4hLMwV4bXnWzpUJvOW2LmLlT24CG7eTus8vyJfVcD/ZGQw+ToByfxh/j3D
9LjcAGrqiSoZ50rieIMc
=Tt6A
-----END PGP SIGNATURE-----

--Apple-Mail=_261411A7-0D54-441B-B2D1-000A1F6ED635--
