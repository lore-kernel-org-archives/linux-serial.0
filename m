From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Strange sniffer behaviour
Date: Mon, 23 Aug 2004 19:12:22 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040823171222.GI18334@lug-owl.de>
References: <200408231331.29869.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YhFoJY/gx7awiIuK"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:17817 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266155AbUHWRMY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Aug 2004 13:12:24 -0400
Content-Disposition: inline
In-Reply-To: <200408231331.29869.fmmarzoa@softronica.org>
List-Id: linux-serial@vger.kernel.org
To: "Francisco M. Marzoa Alonso" <fmmarzoa@softronica.org>
Cc: linux-serial@vger.kernel.org


--YhFoJY/gx7awiIuK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-23 13:31:29 +0200, Francisco M. Marzoa Alonso <fmmarzoa@sof=
tronica.org>
wrote in message <200408231331.29869.fmmarzoa@softronica.org>:
> int CommReadChar (HANDLE HND, int Wait, unsigned char* Data) {
> 	struct timeval TOut;
> 	fd_set readfs;
>=20
> 	FD_ZERO(&readfs);
> 	FD_SET (HND, &readfs);
>=20
> 	TOut.tv_sec =3D Wait / 1000;
> 	TOut.tv_usec =3D Wait % 1000;

So "Wait" is in milli-seconds? That doesn't look correct, then:)

	TOut.tv_sec =3D Wait / 1000;
	TOut.tv_usec =3D (Wait % 1000) * 1000;

> 	if ( select ( FD_SETSIZE, &readfs, NULL, NULL, &TOut ) ) {

That's most probably wrong. "FD_SETSIZE" should be "HND + 1". ...and the
"if" should fire like "if (select (...) > 0)"

> 		return ( read (HND, &Data, 1) );
> 	} else {
> 		perror ("CommReadChar TIMEOUT while waiting for reading");
> 		return 0;
> 	}
> }
>=20
> int CommWriteChar (HANDLE HND, const unsigned char Data) {
>         int bcount;
> 	char aux;
>=20
> 	//----
> 	struct timeval TOut;
> 	fd_set writefs;
>=20
> 	FD_ZERO(&writefs);
> 	FD_SET (HND, &writefs);
>=20
> 	TOut.tv_sec =3D 1000;

A timeout of 1000 seconds?

> 	TOut.tv_usec =3D 0;
> 	//----
>=20
> 	aux =3D Data;
>=20
> 	bcount =3D write ( HND, &aux, 1 );

This could hand because you didn't select() on HND *before* writing to
it.

> 	if ( bcount !=3D 1 ) {
> 		perror ("Cannot write char to serial port");
> 		return 0;
> 	}
>=20
> 	//---
> 	//tcflush ( HND, TCOFLUSH );
> 	if ( ! select ( FD_SETSIZE, NULL, &writefs, NULL, &TOut ) ) {
> 		perror ( "Timeout waiting on CommWriteChar");
> 		return 0;
> 	}

select() checks if the next access won't hand (but may return
successfull or with an error instead). It doesn't make much sense to do
that *after* having something written down there:)

> 	//---
>=20
>=20
> 	return ( bcount );
> }

Btw: return isn't a function. It's return value doesn't need an own pair
of parentheses.

> I've also tested changing FD_SETSIZE by (HND+1) with identical results.=
=20

That's actually *needed*.

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

--YhFoJY/gx7awiIuK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBKiV2Hb1edYOZ4bsRAovuAJwNsWaN1NeTU8mTkWg3p9UI6bGuowCfbPLj
0VbTllMtbDRcLWeY+uQ5di0=
=ZfGY
-----END PGP SIGNATURE-----

--YhFoJY/gx7awiIuK--
