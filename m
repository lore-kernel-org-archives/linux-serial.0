From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/2] serdev: only match serdev devices
Date: Fri, 19 Jan 2018 12:07:26 +0100
Message-ID: <20180119110726.ot76nyctgd2hy64b@earth.universe>
References: <20180109160917.30752-1-johan@kernel.org>
 <20180109160917.30752-3-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktxa3irqdwaghv4x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180109160917.30752-3-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-serial@vger.kernel.org


--ktxa3irqdwaghv4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 09, 2018 at 05:09:17PM +0100, Johan Hovold wrote:
> Only serdev devices (a.k.a. clients or slaves) are bound to drivers so
> bail out early from match() in case the device is not a serdev device
> (i.e. if it's a serdev controller).
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/tty/serdev/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index c8c43834477b..f710862f5c06 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -63,6 +63,11 @@ static const struct device_type serdev_device_type =3D=
 {
>  	.release	=3D serdev_device_release,
>  };
> =20
> +static bool is_serdev_device(const struct device *dev)
> +{
> +	return dev->type =3D=3D &serdev_device_type;
> +}
> +
>  static void serdev_ctrl_release(struct device *dev)
>  {
>  	struct serdev_controller *ctrl =3D to_serdev_controller(dev);
> @@ -76,6 +81,9 @@ static const struct device_type serdev_ctrl_type =3D {
> =20
>  static int serdev_device_match(struct device *dev, struct device_driver =
*drv)
>  {
> +	if (!is_serdev_device(dev))
> +		return 0;
> +
>  	/* TODO: platform matching */
>  	if (acpi_driver_match_device(dev, drv))
>  		return 1;
> --=20
> 2.15.1
>=20

--ktxa3irqdwaghv4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlph0W4ACgkQ2O7X88g7
+pqVsA//Zd2LAHm98A6i0ejK2F5VxgRcX6Ky2SI5EwV0JLAOQAtbeH41bxeUzYNf
dHQqPGVP55U8FYBMNJQ+zoLicIWw/dAJmPJIp4GkMhXSmcWfF9e3ixnye4y8/Zkc
HlqytId0JkCDFlSt3+27vGU1DidhHqPyAs23S5LzVaTyD+M+4rwgAvdb9BTl9VSj
7/dWHXT6q7Kq8h5doyTaS1va4bMaBn8g9k4tB9KibXmcEEkRdB5tP3eTZ5/zlvao
wA2TtkbPVxffhHo/+lRxjqc3s3w9uO8h1EginhSpaAGxN6z44L9FWxib+OqqgVsT
SeDYvFOB6XbG4tQZLOO8hUoj3zZ0TyVwdEAIhRcFX0/AGraQDj8d7sNcgt4ndofV
C97tyThfCL/XfBK8gp3WWKyyz64awR8e7lNbWQgttYSGn00hPaNrb91q27ofOVCj
owWjfnXFGLFNJTInMLjsDQCOqx5AlULMGSWLia/agQKysPTr7a698BxFTlvRgdvl
EEPmHnYgnUZs5jyE1gtFmHpwDmmNm0GadOHg/MAyGixxVzBrla0XMa7+iPmn50/O
vYmiQEpRoxvH9qmTmx99doEt5oMaBemZPdKxmEXcnWthoDCXUQyKWRtyYSmRXVhr
cC6AbN2Env6v2eYOUwsuIGhx07OwdJ9ypaseoPQp4rdSEWQiATo=
=moUF
-----END PGP SIGNATURE-----

--ktxa3irqdwaghv4x--
