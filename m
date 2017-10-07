From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Date: Sat, 7 Oct 2017 13:35:19 +0200
Message-ID: <20171007113518.omxqiurhmapdjmqa@earth>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wf4op3vxttwe2o3a"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1507107090-15992-2-git-send-email-frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--wf4op3vxttwe2o3a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 04, 2017 at 10:51:29AM +0200, Fr=E9d=E9ric Danis wrote:
> This patch allows SerDev module to manage serial devices declared as
> attached to an UART in ACPI table.
>=20
> acpi_serdev_add_device() callback will only take into account entries
> without enumerated flag set. This flags is set for all entries during
> ACPI scan, except for SPI and I2C serial devices, and for UART with
> 2nd patch in the series.
>=20
> Signed-off-by: Fr=E9d=E9ric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

> ---
>  drivers/tty/serdev/core.c | 99 +++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 94 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index c68fb3a..104777d 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -14,6 +14,7 @@
>   * GNU General Public License for more details.
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/errno.h>
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
> @@ -49,13 +50,22 @@ static const struct device_type serdev_ctrl_type =3D {
> =20
>  static int serdev_device_match(struct device *dev, struct device_driver =
*drv)
>  {
> -	/* TODO: ACPI and platform matching */
> +	/* TODO: platform matching */
> +	if (acpi_driver_match_device(dev, drv))
> +		return 1;
> +
>  	return of_driver_match_device(dev, drv);
>  }
> =20
>  static int serdev_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -	/* TODO: ACPI and platform modalias */
> +	int rc;
> +
> +	/* TODO: platform modalias */
> +	rc =3D acpi_device_uevent_modalias(dev, env);
> +	if (rc !=3D -ENODEV)
> +		return rc;
> +
>  	return of_device_uevent_modalias(dev, env);
>  }
> =20
> @@ -260,6 +270,12 @@ static int serdev_drv_remove(struct device *dev)
>  static ssize_t modalias_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> +	int len;
> +
> +	len =3D acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
> +	if (len !=3D -ENODEV)
> +		return len;
> +
>  	return of_device_modalias(dev, buf, PAGE_SIZE);
>  }
>  DEVICE_ATTR_RO(modalias);
> @@ -385,6 +401,74 @@ static int of_serdev_register_devices(struct serdev_=
controller *ctrl)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_ACPI
> +static acpi_status acpi_serdev_register_device(struct serdev_controller =
*ctrl,
> +					    struct acpi_device *adev)
> +{
> +	struct serdev_device *serdev =3D NULL;
> +	int err;
> +
> +	if (acpi_bus_get_status(adev) || !adev->status.present ||
> +	    acpi_device_enumerated(adev))
> +		return AE_OK;
> +
> +	serdev =3D serdev_device_alloc(ctrl);
> +	if (!serdev) {
> +		dev_err(&ctrl->dev, "failed to allocate Serial device for %s\n",
> +			dev_name(&adev->dev));
> +		return AE_NO_MEMORY;
> +	}
> +
> +	ACPI_COMPANION_SET(&serdev->dev, adev);
> +	acpi_device_set_enumerated(adev);
> +
> +	err =3D serdev_device_add(serdev);
> +	if (err) {
> +		dev_err(&serdev->dev,
> +			"failure adding ACPI device. status %d\n", err);
> +		serdev_device_put(serdev);
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
> +				       void *data, void **return_value)
> +{
> +	struct serdev_controller *ctrl =3D data;
> +	struct acpi_device *adev;
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		return AE_OK;
> +
> +	return acpi_serdev_register_device(ctrl, adev);
> +}
> +
> +static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +
> +	handle =3D ACPI_HANDLE(ctrl->dev.parent);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +				     acpi_serdev_add_device, NULL, ctrl, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		dev_warn(&ctrl->dev, "failed to enumerate Serial slaves\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static inline int acpi_serdev_register_devices(struct serdev_controller =
*ctlr)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_ACPI */
> +
>  /**
>   * serdev_controller_add() - Add an serdev controller
>   * @ctrl:	controller to be registered.
> @@ -394,7 +478,7 @@ static int of_serdev_register_devices(struct serdev_c=
ontroller *ctrl)
>   */
>  int serdev_controller_add(struct serdev_controller *ctrl)
>  {
> -	int ret;
> +	int ret_of, ret_acpi, ret;
> =20
>  	/* Can't register until after driver model init */
>  	if (WARN_ON(!is_registered))
> @@ -404,9 +488,14 @@ int serdev_controller_add(struct serdev_controller *=
ctrl)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D of_serdev_register_devices(ctrl);
> -	if (ret)
> +	ret_of =3D of_serdev_register_devices(ctrl);
> +	ret_acpi =3D acpi_serdev_register_devices(ctrl);
> +	if (ret_of && ret_acpi) {
> +		dev_dbg(&ctrl->dev, "serdev%d no devices registered: of:%d acpi:%d\n",
> +			ctrl->nr, ret_of, ret_acpi);
> +		ret =3D -ENODEV;
>  		goto out_dev_del;
> +	}
> =20
>  	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
>  		ctrl->nr, &ctrl->dev);
> --=20
> 2.7.4
>=20

--wf4op3vxttwe2o3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnYu/AACgkQ2O7X88g7
+pqaaxAAkZFA6urAj6CfOvqh4BXM9Torca30g6CbVXwcUcP3JXjx+bXFiPaI57QG
h/i+7AbVPldZ2OC2n5gP1XwQHWTi3J1mlyd7n5/iwt1sYW1x8NnfZIgCEcMdzLAI
R8uzREwRS2rOZ+7PlSJ3+jETNPDcApS9O+DOtcm4D7VEPDyCBlCSf567kCPW9zcd
9uROv5DzJywxKDSMsCBqLySQBRledNd9GpL5amf8e585ASjbdbRQzBcUXNSkltDG
EHe3T5q+WyegMheDIRGCHRzF2ODUQX4i120m0tdfcneIbEfC+SU/0/4j4+aRWlFT
M6wq19C/+sUt4WCKSan3SwoFUs5fJWAE6c3X0k8Ql112KegPS2y3I95v2lQSHjNc
oJJthHmSAX7yc/g55WieiRQWxuCraVCe6IXqFzLIP35OWjLgUH7ZkX7LRXtR/LyV
gDTkYwbgX8UO/H67iMgJMq1Y2TW7+yfFcQdI5bvghfLy1ipnw+HAavSZAkySd2Wa
oaLy/4pKEIWG11OmyCX04H6F3jCL/R5l5fvf7NX499upkyzoUCZBbdsnrklEgLbc
dNuVJqwGJF565BZRa2X5h6g/GCdEgcfZI4x2pG9apaWdfs8BrnDgIIAPpBkGeKA/
nDJrqWf46gWO2dtAnwE/SCyjhVc9O0D1M9u1mTZB11cByAVxXxk=
=GCFF
-----END PGP SIGNATURE-----

--wf4op3vxttwe2o3a--
