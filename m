From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Fw: serial to ethernet converter
Date: Fri, 16 Jan 2004 20:30:22 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040116193021.GQ14285@lug-owl.de>
References: <005301c3dc5a$34133ff0$432f61c8@infinity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQ9+pp1H06jzY73Z"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:37275 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263697AbUAPTaX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Jan 2004 14:30:23 -0500
Content-Disposition: inline
In-Reply-To: <005301c3dc5a$34133ff0$432f61c8@infinity.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--pQ9+pp1H06jzY73Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-16 15:57:22 -0200, Edgar <edgom77@yahoo.com.br>
wrote in message <005301c3dc5a$34133ff0$432f61c8@infinity.com>:
> I need some code, some idea, anything that help me to build a software ba=
sed
> gateway (C language) to connect serial devices on a Ethernet bus using a =
PC
> whith Linux. Can someone help me?

Well, there are several things that could be done, but you're a bit too
unspecific to really help you.

The most important question remaining is: how do you physically want to
connect serial (rs232 or something like that?!) to ethernet?

There are some realls small microcontrollers available doing this. Then,
you'll need the software port. There's an extension to the telnet
protocol that encapsulates serial data for (networked) devices. I think
this is the (software) way you should walk down. That'll increase
interoperability a lot...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--pQ9+pp1H06jzY73Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFACDvNHb1edYOZ4bsRAtNHAJ0bdOwixOmdErd0zDgXWbgBHpgWmwCfaN3q
jky+Bl+GhLsHPEhaKfdahmA=
=OPId
-----END PGP SIGNATURE-----

--pQ9+pp1H06jzY73Z--
