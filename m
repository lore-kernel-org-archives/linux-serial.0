From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Best way to detect received call on dumb modem ...
Date: Sat, 1 Nov 2003 22:14:03 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031101211402.GV31376@lug-owl.de>
References: <20030909235153.GB4559@ip68-0-152-218.tc.ph.cox.net> <000001c3a0b8$ce82efa0$0200000a@francois>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gPQW1Pk7T/0rhUBV"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:17312 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261678AbTKAVOE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Nov 2003 16:14:04 -0500
Content-Disposition: inline
In-Reply-To: <000001c3a0b8$ce82efa0$0200000a@francois>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--gPQW1Pk7T/0rhUBV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-11-01 13:43:23 -0700, Lewis Brown <lewisb@denveronline.com>
wrote in message <000001c3a0b8$ce82efa0$0200000a@francois>:
> Hello,
>=20
> I'm trying to detect incoming calls on a dumb modem but dealing with a
> driver that doesn't implement TIOCMIWAIT or TIOCGICOUNT. I'm puzzled how
> best to go forward in an efficient way.

select() on the fd and wait until you receive "RING"? However, what's a
"dumb" modem?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--gPQW1Pk7T/0rhUBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pCIaHb1edYOZ4bsRArh8AJ98cZxwYQP3asas4zuHMmy4ruUJ7ACcCZWi
gZQcXjptY0zneo2CetBKoFM=
=umgU
-----END PGP SIGNATURE-----

--gPQW1Pk7T/0rhUBV--
