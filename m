From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: How to get a list of all available serial ports?
Date: Thu, 26 Aug 2004 14:09:56 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040826120956.GP18334@lug-owl.de>
References: <200408260924.02123.fmmarzoa@softronica.org> <412DC0EB.1090605@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/qX1VF4Euib7a2dq"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:20443 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S268701AbUHZMKC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Aug 2004 08:10:02 -0400
Content-Disposition: inline
In-Reply-To: <412DC0EB.1090605@wincor-nixdorf.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--/qX1VF4Euib7a2dq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-26 12:52:27 +0200, Salomon, Frank <frank.salomon@wincor-nix=
dorf.com>
wrote in message <412DC0EB.1090605@wincor-nixdorf.com>:
> hi,
>=20
> cat /proc/ioports and serach serial
>=20
[...]
> 02f8-02ff : serial(auto)
[...]
> 03f8-03ff : serial(auto)

That's *very* unreliable. There are a lot of UARTs that handle more than
one serial port within one I/O space or PCI bar, so you'd "miss" those.
To be honest, I think that quite a lot of the non-8250 UARTs will
actually handle more than one serial port...

> or cat /proc/tty/driver/serial
>=20
> serinfo:1.0 driver:5.05c revision:2001-07-08
> 0: uart:16550A port:3F8 irq:4 baud:9600 tx:11 rx:0
> 1: uart:16550A port:2F8 irq:3 baud:9600 tx:11 rx:0

I actually think that this is one of the mest methods to find out about
serial ports from userspace (among letting the user specify the correct
device node for it:-)  Also (just as a hint), don't really worry about
I/O address, uart type (as long as it isn't "unknown") or IRQ. It's
somewhat architecture dependant (eg. Sparc64 used to show off vector
addresses instead of IRQ numbers, so you'd see an address instead...).

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--/qX1VF4Euib7a2dq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLdMUHb1edYOZ4bsRAuwcAJ9RhESCdZiDMrfOColNM1yWWTIaJwCcDASY
vLlntgFDobUSU5BltzgjLgA=
=GwKT
-----END PGP SIGNATURE-----

--/qX1VF4Euib7a2dq--
