From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: serial port read working but not write.
Date: Wed, 28 Jul 2004 22:08:40 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040728200840.GA13671@lug-owl.de>
References: <20040726081239.GX18676@lug-owl.de> <20040728192943.44863.qmail@web8201.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:44235 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262744AbUG1UIl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Jul 2004 16:08:41 -0400
Content-Disposition: inline
In-Reply-To: <20040728192943.44863.qmail@web8201.mail.in.yahoo.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-07-28 20:29:43 +0100, suresh shenoy <msureshshenoy@yahoo.co.in>
wrote in message <20040728192943.44863.qmail@web8201.mail.in.yahoo.com>:
>    Also does any one have a write program that i could
> use??

Easy: Just configure the port correctly (using stty), then simply use
"echo" or "printf" (right, there's a printf fos shell use) with output
redirection. printf helps you to send binary data.

Oh, I just today learned (the hard way...) that CR and LF may get
mangled at the sender's and/or receiver's side. I think

"-ocrnl -onlcr onocr -onlret -icanon -echo -echoe -echok -echonl"

may be a start against that:)

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

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCAfIHb1edYOZ4bsRApADAJ9VAawrDsosy6pU3j5WwaYwM/YP5QCfRIo6
AYfve5rw3IFEjvXBUNvbIjc=
=7A7G
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
