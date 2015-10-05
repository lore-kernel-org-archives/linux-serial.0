From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] sc16is7xx: null ptr check
Date: Mon, 5 Oct 2015 09:10:04 +0100
Message-ID: <20151005081004.GG12635@sirena.org.uk>
References: <1441015287-14240-1-git-send-email-sean.nyekjaer@prevas.dk>
 <20151004202316.GV3982@pengutronix.de>
 <56120E09.7060702@prevas.dk>
 <20151005063127.GX3982@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wQkw7DhpL9hyPo7K"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151005063127.GX3982-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean.nyekjaer-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--wQkw7DhpL9hyPo7K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2015 at 08:31:28AM +0200, Uwe Kleine-K=F6nig wrote:

> So in the broken case the device in question was bound to the
> sc16is7xx driver because the compatible name was matched by the
> id_table and not the of_match_table. My first thought was that in this
> case the spi_device's dev->of_node should not be set, but after having
> thought a bit more I think this is right.

Yes, it's intended behaviour - the DT is buggy here.

> But the .probe routine could be a tad more clever here:

> 	devtype =3D of_device_get_match_data(&spi->dev);
> 	if (!devtype) {
> 		const struct spi_device_id *id_entry =3D spi_get_device_id(spi);
>=20
> 		/* Do I need to check id_entry being !=3D NULL here? */
> 		devtype =3D (struct sc16is7xx_devtype *)id_entry->driver_data;
> 		flags =3D IRQF_TRIGGER_FALLING;
> 	}

That's pretty much a requirement - the driver should work no matter
which binding method gets used, OF only drivers aren't great practice at
the best of times and for off-SoC devices like this one it's definitely
not appropriate.

> Apart from that using "flags =3D IRQF_TRIGGER_FALLING" iff the device was
> probed via spi_id_table is strange.

That seems like an obvious bug.

--wQkw7DhpL9hyPo7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEjBXAAoJECTWi3JdVIfQiIcH/i9tDKu+ht4ADXo8+nn4Ufc6
VH2/QYSu+R65fEZUk4fie0+FUQ7gFRLRt4866zk4VBNTYOekG7mcO9PQMDLY5I6G
rxe2TBptXmicg1yC2jiDfFSr2Gg7lO+hb5iICbKpJzQ1u+bavpPjZtE2l6nFgnDM
+ABb1ogM0z3yyFAwE6RA5Bj98IzXltbZaFJlzLR1j+Ku8yF2uI/aRookTqaihMQl
L2J6iWf+V4MYv+WIrpCuBDwh1E8ef08iN8P75kvM7M5kTRsPGKTjI0+TTVrY1y9W
ZpK+yJbkjLDjtxWUiSULZviPqepHsgoMwoyIlFPL0NfTvlzxf8iBKpXl5PpDZ3E=
=RlCL
-----END PGP SIGNATURE-----

--wQkw7DhpL9hyPo7K--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
