From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 2/5] serdev: Introduce devm_serdev_device_open()
Date: Sat, 28 Oct 2017 11:48:33 +0200
Message-ID: <20171028094833.2r3epv2vms5hmpnu@earth>
References: <20171018170136.12347-1-andrew.smirnov@gmail.com>
 <20171018170136.12347-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mkx7urhy6wuk6nhj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171018170136.12347-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, cphealy@gmail.com, Guenter Roeck <linux@roeck-us.net>, Lucas Stach <l.stach@pengutronix.de>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org


--mkx7urhy6wuk6nhj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 18, 2017 at 10:01:33AM -0700, Andrey Smirnov wrote:
> Add code implementing managed version of serdev_device_open() for
> serdev device drivers that "open" the device during driver's lifecycle
> only once (e.g. opened in .probe() and closed in .remove()).
>=20
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: cphealy@gmail.com
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  Documentation/driver-model/devres.txt |  3 +++
>  drivers/tty/serdev/core.c             | 27 +++++++++++++++++++++++++++
>  include/linux/serdev.h                |  1 +
>  3 files changed, 31 insertions(+)
>=20
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver=
-model/devres.txt
> index 69f08c0f23a8..e9c6b5cfeec1 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -383,6 +383,9 @@ RESET
>    devm_reset_control_get()
>    devm_reset_controller_register()
> =20
> +SERDEV
> +  devm_serdev_device_open()
> +
>  SLAVE DMA ENGINE
>    devm_acpi_dma_controller_register()
> =20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index f500f6a2ca88..b3a785665c6f 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -116,6 +116,33 @@ void serdev_device_close(struct serdev_device *serde=
v)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_close);
> =20
> +static void devm_serdev_device_release(struct device *dev, void *dr)
> +{
> +	serdev_device_close(*(struct serdev_device **)dr);
> +}
> +
> +int devm_serdev_device_open(struct device *dev, struct serdev_device *se=
rdev)
> +{
> +	struct serdev_device **dr;
> +	int ret;
> +
> +	dr =3D devres_alloc(devm_serdev_device_release, sizeof(*dr), GFP_KERNEL=
);
> +	if (!dr)
> +		return -ENOMEM;
> +
> +	ret =3D serdev_device_open(serdev);
> +	if (ret) {
> +		devres_free(dr);
> +		return ret;
> +	}
> +
> +	*dr =3D serdev;
> +	devres_add(dev, dr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_serdev_device_open);
> +
>  void serdev_device_write_wakeup(struct serdev_device *serdev)
>  {
>  	complete(&serdev->write_comp);
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index e69402d4a8ae..9929063bd45d 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -193,6 +193,7 @@ static inline int serdev_controller_receive_buf(struc=
t serdev_controller *ctrl,
> =20
>  int serdev_device_open(struct serdev_device *);
>  void serdev_device_close(struct serdev_device *);
> +int devm_serdev_device_open(struct device *, struct serdev_device *);
>  unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned=
 int);
>  void serdev_device_set_flow_control(struct serdev_device *, bool);
>  int serdev_device_write_buf(struct serdev_device *, const unsigned char =
*, size_t);
> --=20
> 2.13.5
>=20

--mkx7urhy6wuk6nhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAln0Um4ACgkQ2O7X88g7
+po8+g//Z5GbJVE6Ex6Q4meLwFx32ST2oPaeTeXuW9CT7s3Q7kHTSI/xgohmpV7v
NgSCWr9fbTRDY5aOxvk3LaCvGPo1a0xvu5tmZEYKZ8BBpd76YXGtMDbldPxKeAOO
d8jbfNtZczAWYxafSS0BhvtTsmK/KCXShoItjvxh9Zn6NfSNqPSXEicY1eLOqlpX
Zk0tu5FZtr9hkmmkuG5A9rEE2DiVJoxKh0c7Z4W+fZtDuW4g69lBTymP8yYubi28
AdO5ecJ7+NjEgk4UNkvbNd9fIr2SaGC/IgrD4ubxLrZ43rl2v7aKyfZYaCeWijFW
JDNX7epjvzlCerCz9ARFdPEF9Sc2mnJVqiJRwmHJXIRoZSxDAbd2gp3/d3npUT8T
QHUMTY9TlQO5Wcdxh2pdXOrNskYGItCfpOhhPxKqH0/jNJ5s7LRCQMfNJHi84GWL
q5oID8BvBMDUH1YFNYPp+0Q7M+qJxcdZw0rbte44oghWH3vmRqbYSzIeJqbT737+
cBHkx50HxZ6P/64Yi+qi1uPZTGyCkJcZtg5l7Fqg/FsJiwrxf0wm9NsachTJdmM8
muSqQFLhYayMbEPbNuICqmUN+480KHy03mWT4aRbA34XqSquiETmjMigd/9v0lKH
RfLPdoGY2s9fdAX0VudkcEuF6HAad1cJc3W10kRXFwqoZxu5P7U=
=/LrH
-----END PGP SIGNATURE-----

--mkx7urhy6wuk6nhj--
