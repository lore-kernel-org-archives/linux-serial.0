From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Remote serial port configuration.
Date: Thu, 4 Mar 2004 16:46:44 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040304154643.GQ21482@lug-owl.de>
References: <Pine.LNX.4.44.0403042021001.5144-100000@pcz-vijayck.sasken.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSqBvbptTjRvY2y2"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:15815 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261940AbUCDPqp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Mar 2004 10:46:45 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403042021001.5144-100000@pcz-vijayck.sasken.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--VSqBvbptTjRvY2y2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-03-04 20:33:58 +0530, Vijaymahantesh Kalakoti <vijayck@sasken.=
com>
wrote in message <Pine.LNX.4.44.0403042021001.5144-100000@pcz-vijayck.saske=
n.com>:
> I have connected two pc's through serial port. And one of the pc is=20
> configured to run a terminal on the serial port( ttyS0 ) by configuring=
=20
> the getty to run on serial port.=20
>=20
> I have written a program to send the username & password from the other=
=20
> computer. The configuration of serial port on both the systems are same.
>=20
> But I am not able to login to the system. But when I give a delay 1/100 t=
h=20
> of a second or more between sending of username & password, then it is=20
> getting logging into the system.
>=20
> Can I log in without introducing any delays?

Sounds a bit like

	- Handshake wires are missing (so some data is lost)
	- UART type is configured wrongly

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--VSqBvbptTjRvY2y2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAR09jHb1edYOZ4bsRAoouAJ9skvv+TpUqyQo6PJIRPhRNCXYZZgCfZpSV
Ar/SdIskD1hLHVAI/JX46UU=
=x7/X
-----END PGP SIGNATURE-----

--VSqBvbptTjRvY2y2--
