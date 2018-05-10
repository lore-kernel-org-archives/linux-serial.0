From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
Date: Thu, 10 May 2018 13:21:01 +0200
Message-ID: <20180510112101.GD6977@amd>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-serial@vger.kernel.org, linux-leds@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This allows one to simplify drivers that provide a trigger with a
> non-constant name (e.g. one trigger per device with the trigger name
> depending on the device's name).
>=20
> Internally the memory the name member of struct led_trigger points to
> now always allocated dynamically instead of just taken from the caller.
>=20
> The function led_trigger_rename_static() must be changed accordingly and
> was renamed to led_trigger_rename() for consistency, with the only user
> adapted.

Well, I'm not sure if we want to have _that_ many trigger. Trigger
interface is going to become.. "interesting".

We have 4K limit on total number of triggers. We use rather strange
interface to select trigger.

> @@ -115,13 +115,13 @@ static int can_led_notifier(struct notifier_block *=
nb, unsigned long msg,
> =20
>  	if (msg =3D=3D NETDEV_CHANGENAME) {
>  		snprintf(name, sizeof(name), "%s-tx", netdev->name);
> -		led_trigger_rename_static(name, priv->tx_led_trig);
> +		led_trigger_rename(priv->tx_led_trig, name);
> =20
>  		snprintf(name, sizeof(name), "%s-rx", netdev->name);
> -		led_trigger_rename_static(name, priv->rx_led_trig);
> +		led_trigger_rename(priv->rx_led_trig, name);
> =20
>  		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
> -		led_trigger_rename_static(name, priv->rxtx_led_trig);
> +		led_trigger_rename(priv->rxtx_led_trig, name);
>  	}
> =20

I know this is not your fault, but if you have a space or "[]" in
netdev names, confusing things will happen.

I believe we should have triggers "net-rx, net-tx" and it should have
parameter "which device it acts on".=20
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0Kx0ACgkQMOfwapXb+vLW1QCgnozST91ktpRM+xqluM5IlXl3
vRIAoJ2T07nh8amp5NEYb4mjacqZSeYx
=mG9E
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
