From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Date: Tue, 10 Apr 2018 13:09:44 +0200
Message-ID: <20180410110944.GB13697@amd>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
 <20180409134259.GO5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409134259.GO5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Michael Scott <michael.scott@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-serial@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-09 06:42:59, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180409 10:56]:
> > Ok, I should have all that enabled. But droid4-ngsm still fails:
> >=20
> > user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
> > Starting ngsm..
> > Testing ngsm..
> > Could not open /dev/gsmtty1: Level 2 halted
> > Trying to start ngsm again: Level 2 halted
> > Starting ngsm..
>=20
> I guess you must have phy-mapphone-mdm6600 enabled as you a have
> working modem over USB. What do you see in dmesg if you enable n_gsm
> debug with modprobe n_gsm debug=3D0xff or on kernel cmdline?

Ok, I guess I can do that, but first:

Should the modem respond to AT commands on ttyS0? I launched minicom
(115200 8N1) and I'm not getting any responses.

> > commit 984c7706ff180e33096c57183435d925cb644576 says:
> >=20
> >     ARM: dts: omap4-droid4: Configure uart1 pins
> >=20
> >     These are needed to use the n_gsm driver for TS 27.010 UART
> >         multiplexing. Note that support for the OOB wake gpio is still
> > 	    missing so the UART is not yet usable for n_gsm.
> >=20
> > ...am I still missing the OOB wake gpio support?
>=20
> We can get away without OOB wake gpio for a while as mdm6600 is not
> yet suspended over USB. But if you have manually suspended mdm6600
> USB interface via /sys, then it won't respond properly on n_gsm
> either.

Ahha, ok.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrMm3gACgkQMOfwapXb+vIw6gCgnDnIP/cYLwxrnivEeynZwaDh
iMIAn2BaGyGv24+nr5SbOWpWXBHsnUFs
=99rx
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
