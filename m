From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Serial port read working but not write.
Date: Fri, 23 Jul 2004 14:41:49 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040723124149.GY18676@lug-owl.de>
References: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com> <4100DAA3.7060205@wincor-nixdorf.com> <20040723100226.GU18676@lug-owl.de> <410100C1.5030404@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I/+EtO164iqGPpU0"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dvmwest.gt.owl.de ([62.52.24.140]:10653 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267689AbUGWMlv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2004 08:41:51 -0400
Content-Disposition: inline
In-Reply-To: <410100C1.5030404@wincor-nixdorf.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--I/+EtO164iqGPpU0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-07-23 14:12:49 +0200, Salomon, Frank <frank.salomon@wincor-nix=
dorf.com>
wrote in message <410100C1.5030404@wincor-nixdorf.com>:
> Jan-Benedict Glaw wrote:
> >On Fri, 2004-07-23 11:30:11 +0200, Salomon, Frank=20
> ><frank.salomon@wincor-nixdorf.com>
> >wrote in message <4100DAA3.7060205@wincor-nixdorf.com>:
> >>the problem is you need a procedure which find out what the problem is.
> >>Hardware check:
> >>Your hole hardware you can divided in:
> >>- PC - com port
> >>- cable
> >>- external Hardware
[...]
> >This doesn't need to work, depending on handshake settings. Also, (at
> >least in theory), you can have different sending and receiving speeds...
> >
> >man stty

> it there any linux OS on which that test does not work after reboot ?

The point is like this: something in your serial settings *is* already
broken, so the last thing you want is to *rely* on the serial port's
config state. With a good chance (especially in this case), exactly this
is what is wrong.

I hope you don't do C programming with depending on undefined
behavior...

MfG, JBG
PS: Please trim messages properly...

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--I/+EtO164iqGPpU0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAQeNHb1edYOZ4bsRAnyoAJ0Uknp3XqhnGYO7Pr2Mjjp8BPE9PgCdGtSg
YS3j2MrrGqhYoWWPp+tTol8=
=u4Pw
-----END PGP SIGNATURE-----

--I/+EtO164iqGPpU0--
