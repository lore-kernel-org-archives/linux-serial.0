From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: remote serial console problem
Date: Tue, 27 Apr 2004 10:19:36 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040427081936.GA29503@lug-owl.de>
References: <Pine.GSO.4.30.0404271306500.13975-100000@sunops2.sasken.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2490 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263895AbUD0ITh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Apr 2004 04:19:37 -0400
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0404271306500.13975-100000@sunops2.sasken.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-04-27 13:18:48 +0530, Vijaymahantesh Kalakoti <vijayck@sasken.=
com>
wrote in message <Pine.GSO.4.30.0404271306500.13975-100000@sunops2.sasken.c=
om>:

> The PROBLEM is :
> 	1. I see that sometimes it echoes back logout command what i had
> sent & sometimes it doesn't echo back ( echoes only "lo" ).

Probably handshake wires are missing, wrongly soldered or handshake is
ignored at all.

Also, if you want to log in (by sending username and password), don't
send both as fast as possible. Only send password after you've received
the password prompt. Many login commands throw all input away that was
queued to them before they switched to non-echo mode.

> This message may contain confidential, proprietary or legally Privileged =
information. In case you are not the original intended Recipient of the mes=
sage, you must not, directly or indirectly, use, Disclose, distribute, prin=
t, or copy any part of this message and you are requested to delete it and =
inform the sender. Any views expressed in this message are those of the ind=
ividual sender unless otherwise stated. Nothing contained in this message s=
hall be construed as an offer or acceptance of any offer by Sasken Communic=
ation Technologies Limited ("Sasken") unless sent with that express intent =
and with due authority of Sasken. Sasken has taken enough precautions to pr=
event the spread of viruses. However the company accepts no liability for a=
ny damage caused by any virus transmitted by this email.

This is an acchived, public mailing list. If you don't want your
postings to show up on the web, feel free to not use this mailing list
(if this disclaimer is added by your company, maybe some free mail
services may help)...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAjheYHb1edYOZ4bsRAmC/AKCGP9yHyfUXsBAzjWfYNd0zunj54QCcCpft
E/Xvji193ACBsXHCX7vdO0o=
=vYE4
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
