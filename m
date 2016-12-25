From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Sun, 25 Dec 2016 22:20:35 +0100
Message-ID: <20161225212034.GC26891@amd>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161123100106.15969-2-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As the serial core layer does not know when the hardware actually sends
> or receives characters, this needs help from the UART drivers. The
> LED triggers are registered in uart_add_led_triggers() called from
> the UART drivers which want to support LED triggers. All the driver
> has to do then is to call uart_led_trigger_[tx|rx] to indicate
> activity.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/serial_core.c | 73 ++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/serial_core.h      | 10 ++++++
>  2 files changed, 83 insertions(+)
>=20

> +	if (!IS_ENABLED(CONFIG_LEDS_TRIGGERS))
> +		return 0;
> +
> +	uport->led_trigger_tx_name =3D kasprintf(GFP_KERNEL, "%s%d-tx",
> +					       drv->dev_name, uport->line);
> +	uport->led_trigger_rx_name =3D kasprintf(GFP_KERNEL, "%s%d-rx",
> +					       drv->dev_name, uport->line);

Is it neccessary to have separate triggers for rx and tx?

Won't most common application be "light a led for rx _or_ tx", which
is something this can not do?

If I have system with 200 serials, this creates 400 triggers, each
trigger name will be about 10 characters AFAICT... and we'll overflow
some buffer when doing "cat triggers", no?

Would it be enough to have 3 triggers? (Any activity, any rx, any tx)?

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhgOCIACgkQMOfwapXb+vJbMQCginbIjK2OxemgW1ZOlCYq5jHD
6RMAoLKNHP6HFHWUJ40k3KaHl4yeip3i
=ICme
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
