From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Saving the port settings to restore later
Date: Wed, 25 Aug 2004 13:04:15 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040825110415.GW18334@lug-owl.de>
References: <200408251134.48158.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dQ+ozEaLk2y6HH72"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:55745 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266692AbUHYLEQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Aug 2004 07:04:16 -0400
Content-Disposition: inline
In-Reply-To: <200408251134.48158.fmmarzoa@softronica.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--dQ+ozEaLk2y6HH72
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-25 11:34:48 +0200, Francisco M. Marzoa Alonso <fmmarzoa@sof=
tronica.org>
wrote in message <200408251134.48158.fmmarzoa@softronica.org>:
> Usually I use an struct termios and a call to tcgetattr to do that, but n=
ow I=20
> set the ASYNC_LOW_LATENCY flag throug a ioctl using  an struct serial_str=
uct=20
> and I think termios does not store this data, so... What's the best manne=
r to=20
> save the status of a serial port? only through termios? only through=20
> serial_struct? both?

"Restore anything you've changed."  So normally, restoring the initially
fetched struct termios would be sufficient, but you also access the
serial_struct, so restore that, too:)

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

--dQ+ozEaLk2y6HH72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLHIvHb1edYOZ4bsRAn79AJ4pipc+pYxN7U5o/4eNxzxU+nd3kQCcDh1D
mGw6wpcC2e5mrvMp2DKgR5Q=
=Fwos
-----END PGP SIGNATURE-----

--dQ+ozEaLk2y6HH72--
