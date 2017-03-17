From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/10] ARM: dts: N9/N950: add bluetooth
Date: Fri, 17 Mar 2017 16:25:29 +0100
Message-ID: <20170317152529.GA8723@amd>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-2-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170304115833.3538-2-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The Nokia N950 and N9 have a wl1271 (with nokia bootloader) bluetooth
> module connected to second UART.

I don't get it. We are describing hardware, what does it have to do
with bootloader? Is there something not described here, because it is
already initialized by bootloader?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljL/+kACgkQMOfwapXb+vLB3QCgp5TGT0oJLkiY3tuW50h9wTfE
Pg4An3xAHgySI20T3wZJLlhHMu6gpZTZ
=7zxc
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
