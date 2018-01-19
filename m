From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] serdev: add method to set parity
Date: Fri, 19 Jan 2018 11:23:02 +0100
Message-ID: <20180119102302.p2nolnz7mwjoa6wp@earth.universe>
References: <1516203739-4705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uhnrsjoxbcbgeto6"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1516203739-4705-1-git-send-email-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--uhnrsjoxbcbgeto6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 17, 2018 at 04:42:19PM +0100, Ulrich Hecht wrote:
> Adds serdev_device_set_parity() and an implementation for ttyport.
>=20
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

> Broken out of the "[PATCH 0/6] serdev multiplexing support" series
> because this kind of functionality is apparently also required
> for "[RFC v2 0/9] Realtek Bluetooth serdev support (H5 protocol)",
> which contains an earlier revision of this patch.
>=20
> CU
> Uli
>=20
>=20
>  drivers/tty/serdev/core.c           | 12 ++++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++++++
>  include/linux/serdev.h              | 10 ++++++++++
>  3 files changed, 40 insertions(+)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 5dc88f6..1f25896 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -290,6 +290,18 @@ int serdev_device_set_tiocm(struct serdev_device *se=
rdev, int set, int clear)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
> =20
> +int serdev_device_set_parity(struct serdev_device *serdev,
> +			     enum serdev_parity parity)
> +{
> +	struct serdev_controller *ctrl =3D serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->set_parity)
> +		return -ENOTSUPP;
> +
> +	return ctrl->ops->set_parity(ctrl, parity);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_set_parity);
> +
>  static int serdev_drv_probe(struct device *dev)
>  {
>  	const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(dev=
->driver);
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index a5abb05..710e9a9 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -224,6 +224,23 @@ static int ttyport_set_tiocm(struct serdev_controlle=
r *ctrl, unsigned int set, u
>  	return tty->driver->ops->tiocmset(tty, set, clear);
>  }
> =20
> +static int ttyport_set_parity(struct serdev_controller *ctrl,
> +			      enum serdev_parity parity)
> +{
> +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty =3D serport->tty;
> +	struct ktermios ktermios =3D tty->termios;
> +
> +	ktermios.c_cflag &=3D ~(PARENB | PARODD);
> +	if (parity !=3D SERDEV_PARITY_NONE) {
> +		ktermios.c_cflag |=3D PARENB;
> +		if (parity =3D=3D SERDEV_PARITY_ODD)
> +			ktermios.c_cflag |=3D PARODD;
> +	}
> +
> +	return tty_set_termios(tty, &ktermios);
> +}
> +
>  static const struct serdev_controller_ops ctrl_ops =3D {
>  	.write_buf =3D ttyport_write_buf,
>  	.write_flush =3D ttyport_write_flush,
> @@ -235,6 +252,7 @@ static const struct serdev_controller_ops ctrl_ops =
=3D {
>  	.wait_until_sent =3D ttyport_wait_until_sent,
>  	.get_tiocm =3D ttyport_get_tiocm,
>  	.set_tiocm =3D ttyport_set_tiocm,
> +	.set_parity =3D ttyport_set_parity,
>  };
> =20
>  struct device *serdev_tty_port_register(struct tty_port *port,
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 48d8ce2..4dd3cb7 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -78,6 +78,12 @@ static inline struct serdev_device_driver *to_serdev_d=
evice_driver(struct device
>  	return container_of(d, struct serdev_device_driver, driver);
>  }
> =20
> +enum serdev_parity {
> +	SERDEV_PARITY_NONE,
> +	SERDEV_PARITY_EVEN,
> +	SERDEV_PARITY_ODD,
> +};
> +
>  /*
>   * serdev controller structures
>   */
> @@ -92,6 +98,7 @@ struct serdev_controller_ops {
>  	void (*wait_until_sent)(struct serdev_controller *, long);
>  	int (*get_tiocm)(struct serdev_controller *);
>  	int (*set_tiocm)(struct serdev_controller *, unsigned int, unsigned int=
);
> +	int (*set_parity)(struct serdev_controller *, enum serdev_parity);
>  };
> =20
>  /**
> @@ -301,6 +308,9 @@ static inline int serdev_device_set_rts(struct serdev=
_device *serdev, bool enabl
>  		return serdev_device_set_tiocm(serdev, 0, TIOCM_RTS);
>  }
> =20
> +int serdev_device_set_parity(struct serdev_device *serdev,
> +			     enum serdev_parity parity);
> +
>  /*
>   * serdev hooks into TTY core
>   */
> --=20
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--uhnrsjoxbcbgeto6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlphxwMACgkQ2O7X88g7
+pqfBg//fGVhK3NOhHCvDii6J5mJsYOF+gUtSOy04aek6u/tZGOD14ktkmVX6Ab2
1o9DCFA1Jc7/YUnT6av3TzYD639CPS7AcXH7uz/DMxuQJi6DcMDptNtJARR1TBXf
o8lbG0sWuH9jax8Rw3Eri7iOnX2jIeaHsA5SZ1MQ7/G303dVqMsdKY2MqlMqWTsN
75spFuYqcsCFCJSaH9Gp6WhkgGIKWO9R6K13ogTMj5hnPSnUovDEYw1ggtEsxEmp
H8UrMNNXYGgKszR0xgN5F/z2EZBWaZ1hXJuQyGidd1qq/L14K4g6eIL0VV1RVDn+
ee+eAWUXoSQ+23pXugnDx7mXq9laLlGGocT59dtHNs2ZX0NmGrjjJKrlsGlRdiac
7SQ0TgKUfUhAeZEpDbMRWVbyDzTdbBM/Si3sjLnV7SWDDnCCZPLG8PlFWwN4EpHa
xDbPZfG1FgnJcnTiAecWXNw9DdM/EmkVx5eiymNemDaOAw/6M9+Ad0hkgWHmXXgZ
24oxuAh8AzPS1z2vKFYO/K5yu1RY8kZqZjfiKdi8KF7IvHjSJGKeQfrzt1RS4qpE
NnNYvbuJRdLEgfhPs+I41AI0/2dyY65Fcs+Z6YUxzgz7EJIcuLpBZsXWd7eVXswZ
XFbNRH3HqEJGnQssvnkF2FM1cnQEBE83BWuSDspa2u+LTvv0t/o=
=LS9F
-----END PGP SIGNATURE-----

--uhnrsjoxbcbgeto6--
