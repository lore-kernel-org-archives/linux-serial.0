From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Date: Sun, 8 Apr 2018 11:02:59 +0200
Message-ID: <20180408090259.GA8185@amd>
References: <20180407171951.122759-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180407171951.122759-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Michael Scott <michael.scott@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-serial@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Commit ea3d8465ab9b ("tty: n_gsm: Allow ADM response in addition to UA for
> control dlci") added support for DLCI to stay in Asynchronous Disconnected
> Mode (ADM). But we still get long delays waiting for commands to other
> DLCI to complete:
>=20
> --> 5) C: SABM(P)
> Q>  0) C: UIH(F)
> Q>  0) C: UIH(F)
> Q>  0) C: UIH(F)
> ...
>=20
> This happens because gsm_control_send() sets cretries timer to T2 that is
> by default set to 34. This will cause resend for T2 times for the control
> frame. In ADM mode, we will never get a response so the control frame, so
> retries are just delaying all the commands.
>=20
> Let's fix the issue by setting DLCI_MODE_ADM flag after detecting the ADM
> mode for the control DLCI. Then we can use that in gsm_control_send() to
> set retries to 1. This means the control frame will be sent once allowing
> the other end at an opportunity to switch from ADM to ABM mode.
>=20
> Note that retries will be decremented in gsm_control_retransmit() so
> we don't want to set it to 0 here.

Thanks!

I guess I'd like to test this on Droid4; there are fso-gsm0710muxd and
gsm0710muxd packages in Debian, but I assume those do multiplexing in
userspace and thus are not suitable?

Do you have a tool to use and a script?

Thanks and best regards,
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrJ2sMACgkQMOfwapXb+vLBzgCgpiL9rpEz5ljgj/eJaQiuL2V9
n1wAnA1caA+FYvLNcMedg6SMolYx1pUe
=Mwad
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
