From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Serial port read working but not write.
Date: Fri, 23 Jul 2004 16:16:21 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040723141621.GB18676@lug-owl.de>
References: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com> <4100DAA3.7060205@wincor-nixdorf.com> <20040723100226.GU18676@lug-owl.de> <410100C1.5030404@wincor-nixdorf.com> <20040723124149.GY18676@lug-owl.de> <4101097F.4020205@wincor-nixdorf.com> <20040723131409.GZ18676@lug-owl.de> <41011758.8050000@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e3HNah56eoWqGn2Q"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:4766 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267742AbUGWOQW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2004 10:16:22 -0400
Content-Disposition: inline
In-Reply-To: <41011758.8050000@wincor-nixdorf.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--e3HNah56eoWqGn2Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-07-23 15:49:12 +0200, Salomon, Frank <frank.salomon@wincor-nix=
dorf.com>
wrote in message <41011758.8050000@wincor-nixdorf.com>:
> @Jan-Benedict,
> Hi,
> you are right, but do you forget we discus a simple "hardware check"?

"serial" and "simple" won't match, ever.

> I only explain a simple procedure to check the hardware, to make sure=20
> that it is not a hardware failure. You answer : my hardware check does=20
> not need to work and give no example in which way it work correct. You=20
> don't answer my question.

If you see no output with such a short-circuit plug, what does that tell
you? Nothing. Hardware may be quite okay, but it's just settings. If you
use a device, make sure you match the prerequisites.

> @all,
> Again:
> - reboot the system
> - perform the hardware check
> - and we know more

You don't. It may (accidentally, because you rely on unspecified
behaviour) or may not work.

Just set _correct_ settings with stty, then you know *for sure*.
That is, at least:

	- set matching ispeed/ospeed
	- disable xon/xoff, disable crtscts
	- set CS8
	- set clocal and cread
	- set vmin to 1, vtim to 0
	- disable hupctl

=2E..to only name the most important ones. "stty -F /dev/ttyS<something>
-a" will tell you more.

If this test (without setting appropriate valies before trying it)
fails, you can conclude *nothing* from that.

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

--e3HNah56eoWqGn2Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAR20Hb1edYOZ4bsRAl3+AJ9sKS/bqiWqy5sXnZlurMQ8KtRerQCff2X1
SRh/vmEg1203OzwT6ZLO91I=
=KDWJ
-----END PGP SIGNATURE-----

--e3HNah56eoWqGn2Q--
