From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 01:41:46 +0200
Message-ID: <20160822234145.5irlglqecdki3vly@earth>
References: <20160818011445.22726-1-robh@kernel.org>
 <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel>
 <20160822164533.688a6aec@lxorguk.ukuu.org.uk>
 <FAD4CEF6-93F4-41D1-915E-823867F740F7@holtmann.org>
 <20160822220313.wc47q7c4vub2cxmt@earth>
 <20160822234610.39d33dda@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3pjphqgiqjmyh2m6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160822234610.39d33dda@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Marcel Holtmann <marcel@holtmann.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--3pjphqgiqjmyh2m6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 11:46:10PM +0100, One Thousand Gnomes wrote:
> > It's not enough to automatically set a ldisc. There is also need for
> > additional resouces. For example the Nokia bluetooth driver needs
> > some extra GPIOs. The same is true for the in-tree hci_bcm, which
> > misuses the platform_device exactly like Greg doesn't want it.
>=20
> This is one of those cases where ACPI gets it right. For the device tree
> case you will also need to describe the GPIO lines as part of your power
> management for that slave device.
>
> > I think the problem with line disciplines is, that they do
> > not follow the Linux device model. UART slaves may have extra
>=20
> They follow it exactly.
>=20
> You have a tty_port which wraps a device, and has the lifetime of the
> hardware and lives on busses and can support enumeration.
>=20
> You have a tty which is a file system object with a lifetime determined
> by the use of the file handle, it's like any other file->private_data but
> quite complex because we must comply with POSIX and historic Unix tty
> behaviour.
>=20
> You have an ldisc, which is simply a modularisation of the current
> protocol handler and is carefully engineered not to include any device
> specific knowledge. That's how you make it scale and actually work sanely.

I think the current support is far from sane for hardwired
serial-based bluetooth devices. I open the serial device,
set the line disector, set the vendor and maybe some other
extra information and then do nothing, since the kernel
handles everything for me. All of the information given to
the kernel could be done automatically using the firmware
information. Why should I care how my bluetooth device is
connected?

> > resources like gpios or regulators.=20
>=20
> Any resources belong to the tty_port or a child of the tty_port because
> only it has the correct lifetime. And yes it's perfectly reasonable for
> us to attach other resources to a tty_port or give it a child that is the
> device the other end of the fixed link. Everything the DT describes
> belongs hanging off the tty_port or a child thereof.

Right we need a _child_, since we describe the other end of the
fixed link. Adding random remote end resources to the tty_port
looks like a huge hack.

> We don't get this problem in ACPI space in general because as far as ACPI
> is concerned the tty has a child device and the child device describes
> its own power management so you just power the child on or off through
> ACPI and ACPI describes power sanely.
>
> Eveything you have that is device specific belongs in the tty_port driver
> for that hardware, or maybe shared library helpers if common.
>=20
> Everything you have which involves invoking device defined policy
> according to protocol defined behaviour belongs in the ldisc.

ACPI is not better in this regard. Have a look at
drivers/bluetooth/hci_bcm.c and you will see a platform device
providing the GPIOs, which is then accessed by the line discipline.

> Unix has worked like this for well over 30 years and it works very
> well as a model.

TBH I don't think it does.

Why should I need to tell the kernel something, that it could know
automatically. Let's think about hci_bcm. The firmware tells the
kernel, that some bluetooth device is connected to the uart port.
The kernel ignores that information until the user also tells it,
that the bluetooth chip is connected to some tty. If the kernel had
done the right job, the user wouldn't even know, that bluetooth is
connected via UART.

-- Sebastian

--3pjphqgiqjmyh2m6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu422AAoJENju1/PIO/qa1BcP/R3hVj0sjVHlyKb1cUjvfEkf
lzI7/wOlloXEMkXCIEWtfWhmtP7VY70LXcJZ4taHfmCaXmYP9HcKrvgm03nk5Fgj
n3NbQb1UN/4U77ncgkFedNMceABHq+h7YeJCoXdhNpCxQ6UctFCV7C+s/F2KLUEm
j/dFX5YEY8eTCp/VDywKFekHXdFvrvK/AEH/+XEPvwJ0qORXojx8j+BFIpXJU0l5
gjU6LgsO9HfMp2X8pPuozosIkcD5ySwKFO4jmDuvM90denKVv7zy2ZYMpjZtTv5H
CE2ovEt6aBPK6v6kujYUPUE5V9mddi6uw61u+5tMVElV5MLVm0OYvtc+sJY4brpP
wRcJo2sViXic0dXCXy8giCsHOIAQRNp9NKzJ4z+VnEPyXVWcbKsHXfRq9xBxfKNG
aTAmj4CAw9Sx7C8DwBeenz70G4krGxT38+LBHkIxKKWBnAY2TAbt6bEHpOiiivTD
xYXGrPbXWESeq+v3LaYTOPGzAJ52+wQ6KsSfUtm1AdTu4IcTRz85T2C3Hs3jx9sp
sn7/zLlMPpoQm88nBqi4ThPR6z9HYwzQjbwfyo0kF73nHG29xgONpIqZ8V0pkZYi
xtyRE4dz5oxBK9lRPvG8Fdv72zgkN0d/DCZ5C7SdwCtWNAhw96bI6oOtl/Fy4Cef
NFffLcZE/HaPgPIsrcKC
=xoJZ
-----END PGP SIGNATURE-----

--3pjphqgiqjmyh2m6--
