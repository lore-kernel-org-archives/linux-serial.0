From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: low_latency flag
Date: Fri, 21 Nov 2003 23:43:38 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031121224338.GI1037@lug-owl.de>
References: <11E89240C407D311958800A0C9ACF7D1A34049@EXCHANGE> <3FBD7CD7.1060902@rochester.rr.com> <bpm18m$73f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0YvPcIOsea23f0hb"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:1220 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261606AbTKUWnk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Nov 2003 17:43:40 -0500
Content-Disposition: inline
In-Reply-To: <bpm18m$73f$1@sea.gmane.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--0YvPcIOsea23f0hb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-11-21 16:59:50 -0500, Chuck Messenger <chuckm@rochester.rr.com>
wrote in message <bpm18m$73f$1@sea.gmane.org>:
> Luckily, I happened to notice a recent message on this list with the=20
> word "low_latency".  This led me to discover the low_latency flag, which=
=20
> you can set with "setserial /dev/ttyS0 low_latency".  This sets a=20
> special mode on the port, which defeats some kernel-level buffering.  I=
=20
> don't (yet) know how to set this mode programmatically -- I just call=20
> system("...") from my code (yech!).

Looking at setserial's sources, something like this:

struct serial_struct serinfo;
fd =3D open ("/dev/ttySxx");
ioctl (fd, TIOCGSERIAL, &serinfo);
serinfo.flags |=3D 0x4000;
ioctl (fd, TIOCSSERIAL, &serinfo);
close (fd);

should do. Of course, not tested and missing all error handling:-(

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--0YvPcIOsea23f0hb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/vpUaHb1edYOZ4bsRAnKUAJoDEbHJDVfVlTv5vgG4P4u5I+I0/QCdHBxZ
mcnHHanF+PpAdwdZEWjxErw=
=gKYc
-----END PGP SIGNATURE-----

--0YvPcIOsea23f0hb--
