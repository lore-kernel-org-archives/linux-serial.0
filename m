From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: serial port read working but not write.
Date: Mon, 26 Jul 2004 10:12:39 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040726081239.GX18676@lug-owl.de>
References: <20040724233650.78426.qmail@web8201.mail.in.yahoo.com> <4104B1AB.7090005@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L7j14VgZ+PGuoIvj"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:9966 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265029AbUGZIMk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Jul 2004 04:12:40 -0400
Content-Disposition: inline
In-Reply-To: <4104B1AB.7090005@wincor-nixdorf.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--L7j14VgZ+PGuoIvj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-07-26 09:24:27 +0200, Salomon, Frank <frank.salomon@wincor-nix=
dorf.com>
wrote in message <4104B1AB.7090005@wincor-nixdorf.com>:
> suresh shenoy wrote:

> You can try to run the command:
>=20
> setserial /dev/ttySx autoconfig auto_irq
>=20
> before you perform the test. That command will set the correct interrupt.

*cogh* that should possibly at least work for PC's standard two serial
ports. Specifically autoconfig and auto_irq were IIRC discussed several
times for removal, because they don't work reliable in all situations.

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

--L7j14VgZ+PGuoIvj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBLz3Hb1edYOZ4bsRArXRAJ9pKMG4z1v4w/XyTVe+BUFwBy6adQCeOUx2
MnYSjTopbiV/3RuUaspLqmE=
=kr9g
-----END PGP SIGNATURE-----

--L7j14VgZ+PGuoIvj--
