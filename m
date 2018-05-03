From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] tty: implement a rx led trigger
Date: Thu, 3 May 2018 12:10:47 +0200
Message-ID: <20180503101047.GF32180@amd>
References: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-serial@vger.kernel.org


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The trigger fires when data is pushed to the ldisc. This is a bit later
> than the actual receiving of data but has the nice benefit that it
> doesn't need adaption for each driver and isn't in the hot path.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Well, why not, but there certainly should be config option? Because I
really don't see many people wanting to use this trigger.

> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index c996b6859c5e..4d364b77b1a7 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -17,6 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/ratelimit.h>
> +#include <linux/leds.h>
> =20
> =20
>  #define MIN_TTYB_SIZE	256
> @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
>  		struct tty_buffer *head =3D buf->head;
>  		struct tty_buffer *next;
>  		int count;
> +		unsigned long delay =3D 50 /* ms */;
> =20
>  		/* Ldisc or user is trying to gain exclusive access */
>  		if (atomic_read(&buf->priority))
> @@ -521,6 +523,8 @@ static void flush_to_ldisc(struct work_struct *work)
>  			continue;
>  		}
> =20
> +		led_trigger_blink_oneshot(port->led_trigger_rx, &delay, &delay, 0);
> +
>  		count =3D receive_buf(port, head, count);
>  		if (!count)
>  			break;
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 25d736880013..51b78a585417 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -16,6 +16,7 @@
>  #include <linux/wait.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/serdev.h>
> =20
> @@ -157,6 +158,18 @@ struct device *tty_port_register_device_attr_serdev(=
struct tty_port *port,
> =20
>  	tty_port_link_device(port, driver, index);
> =20
> +	port->led_trigger_rx_name =3D kasprintf(GFP_KERNEL, "%s%d-rx",
> +					      driver->name, index);
> +	if (!port->led_trigger_rx_name) {
> +		pr_err("Failed to allocate trigger name for %s%d\n",
> +		       driver->name, index);
> +		goto skip_trigger;
> +	}
> +
> +	led_trigger_register_simple(port->led_trigger_rx_name,
> +				    &port->led_trigger_rx);
> +
> +skip_trigger:
>  	dev =3D serdev_tty_port_register(port, device, driver, index);
>  	if (PTR_ERR(dev) !=3D -ENODEV) {
>  		/* Skip creating cdev if we registered a serdev device */
> @@ -206,6 +219,9 @@ void tty_port_unregister_device(struct tty_port *port,
>  	if (ret =3D=3D 0)
>  		return;
> =20
> +	led_trigger_unregister_simple(port->led_trigger_rx);

Is it ok to unregister if it was not registered in the first place?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrq4CcACgkQMOfwapXb+vKkDgCeJqhQln+cMJ4UzWGgP6Ho7Pe3
zOEAoIZ57G3On5bNOXQKREFXGEt8bxYc
=AyCO
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
