From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Date: Mon, 9 Apr 2018 12:54:07 +0200
Message-ID: <20180409105407.GA15315@amd>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408235740.GN5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Michael Scott <michael.scott@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-serial@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Do you have a tool to use and a script?
> > >=20
> > > Yes I used the shell script I posted earlier, but forgot it also
> > > needs the ldattach done.
> > >=20
> > > Anyways, last night and today I wrote a quick test utility called
> > > droid4-ngsm that initializes things and I can use to do some
> > > experiments to get the ts27010 channel proxying to W3GLTE also
> > > going:
> > >=20
> > > http://github.com/tmlind/droid4-ngsm/
> >=20
> > Ok, now i'm confused. It wants to bind to ttyS0, but modem is on
> > ttyUSB4 AFAICT? Or is the modem connected to serial port, too? (Do I
> > need to enable some more drivers for that?)
> >=20
> > I do have ttyS0, but I don't think there's anything attached there. Or
> > is ttyS0 for the LTE modem?
>=20
> The ttyS0 is connected to mdm6600, and ttyUSB4 seems to be
> some buggy subset of ttyS0 n_gsm dlci1. You need need at least
> the following commits in current mainline kernel:
>=20
> 984c7706ff18 ("ARM: dts: omap4-droid4: Configure uart1 pins")
> e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
>=20
> And then you need PHY_MAPPHONE_MDM6600 and CONFIG_N_GSM enabled.

Ok, I should have all that enabled. But droid4-ngsm still fails:

user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
Starting ngsm..
Testing ngsm..
Could not open /dev/gsmtty1: Level 2 halted
Trying to start ngsm again: Level 2 halted
Starting ngsm..

commit 984c7706ff180e33096c57183435d925cb644576 says:

    ARM: dts: omap4-droid4: Configure uart1 pins

    These are needed to use the n_gsm driver for TS 27.010 UART
        multiplexing. Note that support for the OOB wake gpio is still
	    missing so the UART is not yet usable for n_gsm.

=2E..am I still missing the OOB wake gpio support?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrLRk8ACgkQMOfwapXb+vKUMACdGCs9We6jp5SjvzBz23cZ2XiO
IgkAn3mi6W4S/ubHSvt/r2yNpMNHpTxQ
=ijUg
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
