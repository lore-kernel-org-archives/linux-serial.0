From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Serial port read working but not write.
Date: Fri, 23 Jul 2004 15:14:09 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040723131409.GZ18676@lug-owl.de>
References: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com> <4100DAA3.7060205@wincor-nixdorf.com> <20040723100226.GU18676@lug-owl.de> <410100C1.5030404@wincor-nixdorf.com> <20040723124149.GY18676@lug-owl.de> <4101097F.4020205@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NctWKJLgDreUm1FS"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:31133 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267704AbUGWNOK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2004 09:14:10 -0400
Content-Disposition: inline
In-Reply-To: <4101097F.4020205@wincor-nixdorf.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--NctWKJLgDreUm1FS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-07-23 14:50:07 +0200, Salomon, Frank <frank.salomon@wincor-nix=
dorf.com>
wrote in message <4101097F.4020205@wincor-nixdorf.com>:
> @Jan-Benedict,
> sorry, is there any linux OS on which that test does not work after=20
> reboot ? If you don't know any linux system, we can go back to the=20
> origin problem from Suresh.

:-)  Serial programming is about getting a good number of settings
correct. If only one doesn't fit, it either won't really work at all, or
it'll break in strance situations (like buffer full, or like in this
case, where only one direction seems to work).

In this situation, you try to bring in some statement like "If an
adopted child had never seen their real parents, these won't exist at
all?" Sorry, please don't feed the trolls...

This situation requires to get hard facts, not to accept more
uncontrolled variables! (Try to drive a ND77 with a simple 3-wire serial
cable, you'll be convinced soon:)

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

--NctWKJLgDreUm1FS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAQ8hHb1edYOZ4bsRAhudAKCFubBpqGysKKmSaGyzGA2HUtK5+ACggbVs
7FHqhNiMBk5DaJw/SurE7bI=
=Rpp5
-----END PGP SIGNATURE-----

--NctWKJLgDreUm1FS--
