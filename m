From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: your mail
Date: Tue, 24 Aug 2004 11:39:46 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040824093942.GO18334@lug-owl.de>
References: <200408240805.08811.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="88pBQ1/6ie/nQzMF"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:42408 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267348AbUHXJkU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Aug 2004 05:40:20 -0400
Content-Disposition: inline
In-Reply-To: <200408240805.08811.fmmarzoa@softronica.org>
List-Id: linux-serial@vger.kernel.org
To: "Francisco M. Marzoa Alonso" <fmmarzoa@softronica.org>
Cc: linux-serial@vger.kernel.org


--88pBQ1/6ie/nQzMF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-24 08:05:08 +0200, Francisco M. Marzoa Alonso <fmmarzoa@sof=
tronica.org>
wrote in message <200408240805.08811.fmmarzoa@softronica.org>:
> >>       TOut.tv_sec =3D Wait / 1000;
> >>       TOut.tv_usec =3D Wait % 1000;
> >
> >So "Wait" is in milli-seconds? That doesn't look correct, then:)
> >
> >        TOut.tv_sec =3D Wait / 1000;
> >        TOut.tv_usec =3D (Wait % 1000) * 1000;
>=20
> Sure you're right, but this is a thing that I do not understand. I made a=
=20
> function GetTickCount to emulate Window's one based on gettimeofday and s=
ee=20
> that milliseconds on timeval structure can have values up to 999999 when =
I=20
> expect to found a maximum value of 999 as there are only 1000 millisecond=
s in=20
> a second.

Notice, it's not "tv_msec" but "tv_usec", which is micro-seconde and
not milli-seconds. A small 'u' is commonly used instead of the greek
'=B5', because '=B5' won't be properly handled by all email clients, let
alone in code to be compiled.

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

--88pBQ1/6ie/nQzMF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBKwzbHb1edYOZ4bsRAiezAJ9cFpg8uAwZsAfyxb6wXs136hkLEQCfdweU
DPS/tkDQq6ccLx6K2vP7Ddo=
=bLQ1
-----END PGP SIGNATURE-----

--88pBQ1/6ie/nQzMF--
