From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] tty: implement led triggers
Date: Thu, 10 May 2018 13:14:34 +0200
Message-ID: <20180510111434.GC6977@amd>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
 <20180507092710.GQ2285@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180507092710.GQ2285@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-serial@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *=
work)
> > > >  		struct tty_buffer *head =3D buf->head;
> > > >  		struct tty_buffer *next;
> > > >  		int count;
> > > > +		unsigned long delay =3D 50 /* ms */;
> > >=20
> > > Comment after the semicolon?
> >=20
> > Given that this comment is about the 50 and not the delay member, I
> > prefer it before the ;.
>=20
> Hmm. I personally find it hard to read and can only find about 30
> instances of this comment style (for assignments) in the kernel. And
> arguably the comment applies equally well to the delay variable in this
> case too.

It is not too traditional, but I believe it makes sense....

(and yes, I wish we had kernel in Rust, so we could have real units
attached to our variables...)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0KZoACgkQMOfwapXb+vIrzgCfU4fdJn727jPwFygVxCwyEHzA
VngAnjVhVAdDKuEEc4AX6AS3tRyM9gtG
=dshO
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
