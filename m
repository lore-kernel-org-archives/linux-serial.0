From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: result=read(fd,buffer,200);
Date: Tue, 20 Jul 2004 19:09:32 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040720170931.GB4690@lug-owl.de>
References: <BAY15-F17edoJhTahSR0009232d@hotmail.com> <20040720174142.7b8b6525@emig4.heisch.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:48054 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266023AbUGTRJd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jul 2004 13:09:33 -0400
Content-Disposition: inline
In-Reply-To: <20040720174142.7b8b6525@emig4.heisch.inka.de>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-20 17:41:42 +0200, Gerald Emig <gme@emig-software.de>
wrote in message <20040720174142.7b8b6525@emig4.heisch.inka.de>:
> According to the documentation provided in info:libc, read=20
> returns the number of character it actually has read.
> Especially if you are using serial ports, the amount read is often fewer
> as you expected.

That's a general thing to keep in mind.

Additionally, keep in mind that c_cc[VMIN] will control how long to
wait, too...

> Additionally, checking errno is stronly recommended.

As always:)

> Use something like the following to read exactly 200 chars:
>=20
>=20
> int read_amount (int iwantread)

This int should have been size_t.

> {
> 	int readpointer, fetch;

=2E..and fetch needs to be ssize_t.

> readpointer=3D0;
> while (iwantread>0) {
> 	fetch=3Dread (fd,&buffer[readpointer],iwantread);
> 	if (fetch >=3D 0) {
> 		readpointer +=3D fetch;
> 		iwantread -=3D fetch;
> 	} else 	if ((errno!=3DEINTR) && (errno!=3DEAGAIN)) return -1;
> 	}
> 	return iwantread; // should be 0 on success
> }

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/VHLHb1edYOZ4bsRAs7VAJ0cq3CdsxGlepbIOczw8QOUFKkCgwCeO1FN
hHvy2JKx0g+BOMHekgu8Y54=
=HA2L
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
