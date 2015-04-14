From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] serial: of-serial: Remove device_type = "serial" registration
Date: Tue, 14 Apr 2015 07:12:11 +0200
Message-ID: <552CA1AB.1050608@monstr.eu>
References: <b8ba9c125be49a8a70a04807179c5f7fe79b1ae0.1428935724.git.michal.simek@xilinx.com> <552BE5B8.4050204@hurleysoftware.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="H2lFUDnV0FBBFqLJGT2qnRLspEjFNQTEn"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <552BE5B8.4050204@hurleysoftware.com>
Sender: stable-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H2lFUDnV0FBBFqLJGT2qnRLspEjFNQTEn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2015 05:50 PM, Peter Hurley wrote:
> [ + Arnd ]
>=20
> Hi Michal,
>=20
> On 04/13/2015 10:35 AM, Michal Simek wrote:
>> Do not probe all serial drivers by of_serial.c which are using
>> device_type =3D "serial"; property. Only drivers which have valid
>> compatible strings listed in the driver should be probed.
>=20
> What does this fix?
> Is there some kind of probe problem you're trying to address?
> Are you trying to silence the error message?
>=20
>> When PORT_UNKNOWN probe will fail anyway.
>=20
> Ok, but doesn't device_attach() just continue to try to match other
> drivers on the platform bus?


Please look at my response to Greg reply. Hope that explain it.

Thanks,
Michal








--H2lFUDnV0FBBFqLJGT2qnRLspEjFNQTEn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlUsoasACgkQykllyylKDCG1mACeLpcigjZSfhLJNx3w7tCtKAYy
5b0AoILVzc2Kop+WYQT+pOCBQtDcwJKj
=HSiE
-----END PGP SIGNATURE-----

--H2lFUDnV0FBBFqLJGT2qnRLspEjFNQTEn--
