From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 04/19] Bluetooth: hci_nokia: Add serdev_id_table
Date: Thu, 7 Jun 2018 14:51:01 +0200
Message-ID: <20180607125101.GA8074@amd>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-5-ricardo.ribalda@gmail.com>
 <E848BED5-1D83-47FA-A673-29B366A60227@holtmann.org>
 <20180607102740.GD4372@localhost>
 <22CF0FC7-6DC7-4DD2-9EA1-9F51B40F53E5@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22CF0FC7-6DC7-4DD2-9EA1-9F51B40F53E5@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> >>> +	{ "hp4-bluetooth", },
> >>> +	{},
> >>> +};
> >>> +
> >>> static struct serdev_device_driver nokia_bluetooth_serdev_driver =3D {
> >>> 	.probe =3D nokia_bluetooth_serdev_probe,
> >>> 	.remove =3D nokia_bluetooth_serdev_remove,
> >>> @@ -809,6 +814,7 @@ static struct serdev_device_driver nokia_bluetoot=
h_serdev_driver =3D {
> >>> 		.pm =3D &nokia_bluetooth_pm_ops,
> >>> 		.of_match_table =3D of_match_ptr(nokia_bluetooth_of_match),
> >>> 	},
> >>> +	.id_table =3D nokia_bluetooth_serdev_id,
> >>> };
> >>=20
> >> I would actually skip this hardware. First of all it is such a dedicat=
ed custom Nokia transport and hardware, and secondly it is no longer produc=
ed anyway.
> >>=20
> >=20
> > Would it make sense to cc: sre here? We want good support even for old
> > hardware, and this is n9/n950, it is still on "top ten supported
> > phones" list... Probably even top 5.
>=20
> but that is not what this patch series is about. We do not need new_id ki=
nda support for the existing hardware. My point is there will be no newly d=
esigned hardware using this driver.
>=20

You are right, new hardware with that protocol sounds unlikely at this
point.

Sorry for the noise,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsZKjUACgkQMOfwapXb+vJTiACeLqDgMf0mHp9GAafdvWoq7hf8
oq4An0BpsPFON4XV2mEol/wRhJ5nDXfh
=FwgU
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
