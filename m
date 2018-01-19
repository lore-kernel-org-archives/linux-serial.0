From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/2] serdev: do not generate modaliases for controllers
Date: Fri, 19 Jan 2018 12:06:37 +0100
Message-ID: <20180119110637.gfaxyla7jy3hu5kj@earth.universe>
References: <20180109160917.30752-1-johan@kernel.org>
 <20180109160917.30752-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phib6xzm4aee3vlh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180109160917.30752-2-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-serial@vger.kernel.org


--phib6xzm4aee3vlh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 09, 2018 at 05:09:16PM +0100, Johan Hovold wrote:
> Serdev controllers are not bound to any drivers and it therefore makes
> no sense to generate modaliases for them.
>=20
> This has already been fixed separately for ACPI controllers for which
> uevent errors were also being logged during probe due to the missing
> ACPI companions (from which ACPI modaliases are generated).
>=20
> This patch moves the modalias handling from the bus type to the client
> device type. Specifically, this means that only serdev devices (a.k.a.
> clients or slaves) will have have MODALIAS fields in their uevent
> environments and corresponding modalias sysfs attributes.
>=20
> Also add the missing static keyword for the modalias device attribute
> when moving the definition.
>=20
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/tty/serdev/core.c | 72 ++++++++++++++++++++++-------------------=
------
>  1 file changed, 34 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 5dc88f61f506..c8c43834477b 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -19,6 +19,38 @@
>  static bool is_registered;
>  static DEFINE_IDA(ctrl_ida);
> =20
> +static ssize_t modalias_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	int len;
> +
> +	len =3D acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
> +	if (len !=3D -ENODEV)
> +		return len;
> +
> +	return of_device_modalias(dev, buf, PAGE_SIZE);
> +}
> +static DEVICE_ATTR_RO(modalias);
> +
> +static struct attribute *serdev_device_attrs[] =3D {
> +	&dev_attr_modalias.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(serdev_device);
> +
> +static int serdev_device_uevent(struct device *dev, struct kobj_uevent_e=
nv *env)
> +{
> +	int rc;
> +
> +	/* TODO: platform modalias */
> +
> +	rc =3D acpi_device_uevent_modalias(dev, env);
> +	if (rc !=3D -ENODEV)
> +		return rc;
> +
> +	return of_device_uevent_modalias(dev, env);
> +}
> +
>  static void serdev_device_release(struct device *dev)
>  {
>  	struct serdev_device *serdev =3D to_serdev_device(dev);
> @@ -26,6 +58,8 @@ static void serdev_device_release(struct device *dev)
>  }
> =20
>  static const struct device_type serdev_device_type =3D {
> +	.groups		=3D serdev_device_groups,
> +	.uevent		=3D serdev_device_uevent,
>  	.release	=3D serdev_device_release,
>  };
> =20
> @@ -49,23 +83,6 @@ static int serdev_device_match(struct device *dev, str=
uct device_driver *drv)
>  	return of_driver_match_device(dev, drv);
>  }
> =20
> -static int serdev_uevent(struct device *dev, struct kobj_uevent_env *env)
> -{
> -	int rc;
> -
> -	/* TODO: platform modalias */
> -
> -	/* ACPI enumerated controllers do not have a modalias */
> -	if (!dev->of_node && dev->type =3D=3D &serdev_ctrl_type)
> -		return 0;
> -
> -	rc =3D acpi_device_uevent_modalias(dev, env);
> -	if (rc !=3D -ENODEV)
> -		return rc;
> -
> -	return of_device_uevent_modalias(dev, env);
> -}
> -
>  /**
>   * serdev_device_add() - add a device previously constructed via serdev_=
device_alloc()
>   * @serdev:	serdev_device to be added
> @@ -305,32 +322,11 @@ static int serdev_drv_remove(struct device *dev)
>  	return 0;
>  }
> =20
> -static ssize_t modalias_show(struct device *dev,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	int len;
> -
> -	len =3D acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
> -	if (len !=3D -ENODEV)
> -		return len;
> -
> -	return of_device_modalias(dev, buf, PAGE_SIZE);
> -}
> -DEVICE_ATTR_RO(modalias);
> -
> -static struct attribute *serdev_device_attrs[] =3D {
> -	&dev_attr_modalias.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(serdev_device);
> -
>  static struct bus_type serdev_bus_type =3D {
>  	.name		=3D "serial",
>  	.match		=3D serdev_device_match,
>  	.probe		=3D serdev_drv_probe,
>  	.remove		=3D serdev_drv_remove,
> -	.uevent		=3D serdev_uevent,
> -	.dev_groups	=3D serdev_device_groups,
>  };
> =20
>  /**
> --=20
> 2.15.1
>=20

--phib6xzm4aee3vlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlph0TkACgkQ2O7X88g7
+ppftw//SWS8FJtOIxMVsA1VdeN+VkxxHORdvaBR1ekbn4ViT3HBUOQjpXblWcuO
72XCCmHPRq582UQISYnbLbIjH4vWE/lHpf71w7mQF+L186ZYbhiHelEC4TQkPpnd
Y+2/olI3lCzbHbiwj2EBIrv9bU9xnzDTIlxTDf3RywOiX6jqvJPMpKRp50hPwtcK
kXmasGMR+wlEI/J6+RGet5vtrEN6qSt2SRlzHVqeex7ia68ixhL2xe5LHM704JiR
i9gHydbdke0o6dXY94hkeHz45lHdKAtY4doOXo8Pf+6sHzkLeaip0w0Ne/gNbKvx
ntGXJIA4KoW5puS1UKCxN907l2RrmYKQbE7InJVuBCiAUBSJOW8SX5FrIk7NiH6l
XO+Fi01NPIpy0I2Gdbm5mAvmZbfkP7jAIa8ZNofOIwSk9T4DaREKNBq1aIr2n0cT
mooqZCDijBQP7j9l524R1F3ecgzocA0b4am5F61vuJHjsjnUKZQ+CbtScDns4tCP
SnOzI4Vq9WzPQR5YpbztapafmZfaQFiMJOFpeyfm8mAgFmowYqbPCFM0akI1LdBX
ymLFGN2sJ6j4iWc93Y+DwVYFiQRl1wUQ6gynyS/VvAQ1wd/ykh9noT2aXMGd9IIF
Bj4kCcW/QJf3M4PVCjMHQbzg9shRRLT//yRAH/Ae0QWaELviZlE=
=79TK
-----END PGP SIGNATURE-----

--phib6xzm4aee3vlh--
