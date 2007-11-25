From: "Michael H. Warfield" <mhw@WittsEnd.com>
Subject: Re: 2.6.24: Serial disabled in BIOS but serial modules still
	loaded (probably PnP related)
Date: Sat, 24 Nov 2007 22:55:22 -0500
Message-ID: <1195962922.5044.8.camel@canyon.wittsend.com>
References: <200711242336.43712.arvidjaar@mail.ru>
Reply-To: mhw@WittsEnd.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OLvrwGIq5vKAqFhbBq7E"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200711242336.43712.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: mhw@WittsEnd.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--=-OLvrwGIq5vKAqFhbBq7E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-11-24 at 23:36 +0300, Andrey Borzenkov wrote:
> I have no COM port on notebook (without port replicator which I do not ha=
ve)
> so COM is disabled in BIOS. No ttyS* is detected during boot (and no devi=
ce
> created) but I just noticed that serial modules are still loaded. Well, t=
his
> partially defeats the purpose of disabling COM port - the intention was t=
o
> free resources by *not* loading unneeded modules ...

> This may have something to do with (ACPI) PnP which apparently believes C=
OM is alive.
> Notebook is Toshiba Portege 4000.

	Nice...  What's this then?

> 00:09 PNP0501 16550A-compatible serial port
>     state =3D active
>         io 0x3f8-0x3ff
>         irq 5

	0x3f8-0x3ff is COM1 and a 16550A is the most common invocation of the
vernerable serial port.  I haven't seen a real 8250 in ages.  the 16550
is an 8250 with larger FIFO's and better rates.

	Now, it's on IRQ5 instead of IRQ4 but that's all allocatable on PCI.
Unless I'm missing something, it looks like you've got a COM port and it
looks like it's active.

	Might be related to an IR port?

> 00:0a SMCf010 SMC Fast Infrared Port
>     state =3D disabled

> 00:0b PNP0401 ECP printer port
>     state =3D disabled

	:

	Mike
--=20
Michael H. Warfield (AI4NB) | (770) 985-6132 |  mhw@WittsEnd.com
   /\/\|=3Dmhw=3D|\/\/          | (678) 463-0932 |  http://www.wittsend.com=
/mhw/
   NIC whois: MHW9          | An optimist believes we live in the best of a=
ll
 PGP Key: 0xDF1DD471        | possible worlds.  A pessimist is sure of it!


--=-OLvrwGIq5vKAqFhbBq7E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iQCVAwUAR0jyKeHJS0bfHdRxAQK9DgQAl/ScCTRRNfa8T9+FI6as6YQxDC/4S2xW
DtMUXKxjaQS2ccpPCkt0uJyDj/50SkcAfk6rYqo+bXrAnPY1Er/l6d4J2FBjdjRo
NnDpoocxlkRYYTPtFXnlkSyThEshBwVq7c9xeY0dfTKYo7STMzH9VFrjgY8Cmd3Q
0dXaPCYNCws=
=ZmGJ
-----END PGP SIGNATURE-----

--=-OLvrwGIq5vKAqFhbBq7E--

