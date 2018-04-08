From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Date: Sun, 8 Apr 2018 21:06:00 +0200
Message-ID: <20180408190600.GA24342@amd>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408165038.GM5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Michael Scott <michael.scott@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-serial@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Do you have a tool to use and a script?
>=20
> Yes I used the shell script I posted earlier, but forgot it also
> needs the ldattach done.
>=20
> Anyways, last night and today I wrote a quick test utility called
> droid4-ngsm that initializes things and I can use to do some
> experiments to get the ts27010 channel proxying to W3GLTE also
> going:
>=20
> http://github.com/tmlind/droid4-ngsm/

Ok, now i'm confused. It wants to bind to ttyS0, but modem is on
ttyUSB4 AFAICT? Or is the modem connected to serial port, too? (Do I
need to enable some more drivers for that?)

I do have ttyS0, but I don't think there's anything attached there. Or
is ttyS0 for the LTE modem?


> Sorry could not resist adding a test call feature too :)

:-)

> Hmm it might be best to add the ts27010 support and proxying
> eventually to ModemManager? I think ofono and others could still
> use the /dev/gsmtty* ports for the modem as needed too?

I'm not sure how the userland should be designed...

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrKaBgACgkQMOfwapXb+vL4VgCghxzBtCv60qtIOpB2kWurf3wT
nJUAnj+30MbsjKxVN63Cn8RowXsgUfRc
=CtNY
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
