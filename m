From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Serial port read working but not write.
Date: Fri, 23 Jul 2004 12:02:26 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040723100226.GU18676@lug-owl.de>
References: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com> <4100DAA3.7060205@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Y6L//1es8ezVqBy"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:9115 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267591AbUGWKC2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2004 06:02:28 -0400
Content-Disposition: inline
In-Reply-To: <4100DAA3.7060205@wincor-nixdorf.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--/Y6L//1es8ezVqBy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-07-23 11:30:11 +0200, Salomon, Frank <frank.salomon@wincor-nix=
dorf.com>
wrote in message <4100DAA3.7060205@wincor-nixdorf.com>:
> Hi,
> the problem is you need a procedure which find out what the problem is.
> Hardware check:
> Your hole hardware you can divided in:
> - PC - com port
> - cable
> - external Hardware
>=20
> Check the com-port:
> create a cable bridge between pin 2 and 3 of you port.
> run # dd bs=3D1 count=3D1 if=3D/dev/ttySx | hexdump
> on an other vt run # cat /dev/inittab > /dev/ttySx
>=20
> If you don't see any output on the vt, which is running "dd bs=3D1 count=
=3D1=20
> if=3D/dev/ttySx | hexdump", your com port is not working correct.

This doesn't need to work, depending on handshake settings. Also, (at
least in theory), you can have different sending and receiving speeds...

> Next you can connect your cable to the PC and pug the bridge to the
> end of the cable and perform the same test.

=2E..which also depends on tty settings.

man stty

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

--/Y6L//1es8ezVqBy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAOIyHb1edYOZ4bsRAly2AJ4pjxzIq3RWDHQPTNmxPaDr5kAqvwCfdYEo
EdIsZptICZN1iFAc7YJxUJw=
=WV3b
-----END PGP SIGNATURE-----

--/Y6L//1es8ezVqBy--
