From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Date: Mon, 14 Jan 2019 10:38:27 +0100
Message-ID: <20190114093827.GA20510@amd>
References: <20190114012528.2367-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190114012528.2367-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-01-13 17:25:25, Tony Lindgren wrote:
> Hi all,
>=20
> Here's a series of patches to add initial serdev support to n_gsm
> TS 27.010 line discipline.
>=20
> This allows handling vendor specific protocols on top of TS 27.010 and
> allows creating simple serdev drivers where it makes sense. So far I've
> tested it with droid 4 for it's modem to provide char devices for AT
> ports, modem PM support, and serdev drivers for GNSS and Alsa ASoC.
>=20
> I'll be posting the related MFD, GNSS and Alsa ASoC drivers separately.
> For reference, the MFD driver is at [0], the GNSS driver at [1], and
> the Alsa ASoC driver at [2] below.

For the series:

Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks for doing this!
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw8WJMACgkQMOfwapXb+vKm5wCfcgQc/RoV7ugMqwQ/9ftNQuFK
KggAnj+WGa+X3casYnsEbEIhVrJK4CG9
=vRKC
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
