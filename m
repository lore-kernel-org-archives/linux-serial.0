From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: serial port read working but not write
Date: Sat, 24 Jul 2004 17:11:37 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040724151137.GF18676@lug-owl.de>
References: <20040724143949.21583.qmail@web8204.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wO3ULb5M+sQS9v8+"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:13233 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S268666AbUGXPLi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 24 Jul 2004 11:11:38 -0400
Content-Disposition: inline
In-Reply-To: <20040724143949.21583.qmail@web8204.mail.in.yahoo.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--wO3ULb5M+sQS9v8+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-07-24 15:39:49 +0100, suresh shenoy <msureshshenoy@yahoo.co.in>
wrote in message <20040724143949.21583.qmail@web8204.mail.in.yahoo.com>:

>        When i ran the write program the output
> increased to 1500-1900 and stayed there.=20

So no data is ever sent out to the hardware. So there seems to be some
kind of hardware-related problem. Could you please once set the IRQ line
to 0? IIRC, that should put the UART into polling mode, which should
help if there's an interrupt problem...

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

--wO3ULb5M+sQS9v8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAnwpHb1edYOZ4bsRAiMcAJ40NHwR4UVNyJN0Rs1j5dOOADgBaACdEnOg
tMRhVfYoPVqvSBvYVHC9R9I=
=TEQm
-----END PGP SIGNATURE-----

--wO3ULb5M+sQS9v8+--
