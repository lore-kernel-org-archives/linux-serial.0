From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: interrupt programming
Date: Thu, 22 Jul 2004 14:20:34 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040722122034.GH18676@lug-owl.de>
References: <BAY15-F22wSs3yoW3Al0005522c@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:21379 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263117AbUGVMUg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Jul 2004 08:20:36 -0400
Content-Disposition: inline
In-Reply-To: <BAY15-F22wSs3yoW3Al0005522c@hotmail.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-22 12:02:37 +0200, Sayang Oin <sayangoin@hotmail.com>
wrote in message <BAY15-F22wSs3yoW3Al0005522c@hotmail.com>:
> I've written a programm to communicate with a external UART device throug=
h=20
> /dev/ttyS0.
> I use POSIX and Timer but unfortunately is not working well.

What do you need timers for? If you're waiting for data, just use
select(). That even allows you to perform other actions every now and
then.

> Is it possible to use Interrupt to read and write datas through the seria=
l=20
> port?

Linux' serial driver should work interrupt-driven most of the time. Only
in rare cases it'll poll the serial chip, but I think that's not really
your problem.

Please tell us what you *really* need to do. Then, we'd help you.
Sources of your application to comment on weren't wrong, too...

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

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/7ESHb1edYOZ4bsRAqeMAJ9zb7OSwsiIWT55m43zDXjps1KPtACcCuVs
75rnl0fqpXu24YBT2pPubRM=
=zMOV
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--
