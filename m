From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: How to get a list of all available serial ports?
Date: Thu, 26 Aug 2004 12:51:30 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040826105130.GN18334@lug-owl.de>
References: <200408260924.02123.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D5HQcwfjqNcvOcn2"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:22490 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S268378AbUHZKvb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Aug 2004 06:51:31 -0400
Content-Disposition: inline
In-Reply-To: <200408260924.02123.fmmarzoa@softronica.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--D5HQcwfjqNcvOcn2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-26 09:24:02 +0200, Francisco M. Marzoa Alonso <fmmarzoa@sof=
tronica.org>
wrote in message <200408260924.02123.fmmarzoa@softronica.org>:
> Under Windows my program is able to perform an autodetection of the devic=
e=20
> with which it work. For that it takes a list of all available serial port=
s=20
> from Windows registry.=20
>=20
> Is there any manner to do the same under LiNUX that works on all=20
> distributions?

There are several solutions:

- opendir()/readdir()/closedir() "/dev/" and strncmp(ent->d_name, "ttyS", 4=
),
  then open all matches with O_NONBLOCK to see if you not get ENODEV
  from errno. This works on "traditional" systems not using something
  like devfs. Also, you'd better stat() all hits to not get false
  positives from things like symlinks.
- opendir/readdir/closedir "/dev/ttyS/" and iterate through all entries.
  These are solely serial ports, so not that much postprocessing
  involved. However, that would only work with devfs...
- open /proc/tty/driver/serial, check the format (first line), read all
  further lines and check if uart is !=3D "unknown".

For sure, there are more techniques, like
	- if you're runnung with root privileges, you'd temporarily
	  create new device nodes for char devices, and mojor/minor
	  number from /proc/tty/drivers (the "^serial" lines).
	- check major/minor from /sys/class/tty/ttyS* (open() checking
	  for ENODEV in errno...), but that'd require creating temporary
	  device nodes and also having a 2.6.x kernel...

Personally, I don't like software that tries to "know better" than I do.
I'd like telling a program "use this device node and shut up!" and
possibly others would like to have it work that way, too...

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

--D5HQcwfjqNcvOcn2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLcCyHb1edYOZ4bsRAnjtAJ9qDwbuKMt8/3yU/ANXclK3PdIKzwCgg7NP
Jns0agM3ZlAGCa+URtPQHAc=
=uXyj
-----END PGP SIGNATURE-----

--D5HQcwfjqNcvOcn2--
