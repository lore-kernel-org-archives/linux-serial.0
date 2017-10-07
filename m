From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Sat, 7 Oct 2017 13:36:00 +0200
Message-ID: <20171007113600.5r5niw3uhwbvytud@earth>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mcwbzmjx4wyzrkpg"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, marcel@holtmann.org, loic.poulain@gmail.com, johan@kernel.org, lukas@wunner.de, hdegoede@redhat.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--mcwbzmjx4wyzrkpg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 04, 2017 at 10:51:30AM +0200, Fr=E9d=E9ric Danis wrote:
> UART devices is expected to be enumerated by SerDev subsystem.
>=20
> During ACPI scan, serial devices behind SPI, I2C or UART buses are not
> enumerated, allowing them to be enumerated by their respective parents.
>=20
> Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for ser=
ial
> devices on serial buses (SPI, I2C or UART).
>=20
> On Macs an empty ResourceTemplate is returned for uart slaves.
> Instead the device properties "baud", "parity", "dataBits", "stopBits" are
> provided. Add a check for "baud" in acpi_is_serial_bus_slave().
>=20
> Signed-off-by: Fr=E9d=E9ric Danis <frederic.danis.oss@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/acpi/scan.c     | 37 +++++++++++++++++--------------------
>  include/acpi/acpi_bus.h |  2 +-
>  2 files changed, 18 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 602f8ff..860b698 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1505,41 +1505,38 @@ static void acpi_init_coherency(struct acpi_devic=
e *adev)
>  	adev->flags.coherent_dma =3D cca;
>  }
> =20
> -static int acpi_check_spi_i2c_slave(struct acpi_resource *ares, void *da=
ta)
> +static int acpi_check_serial_bus_slave(struct acpi_resource *ares, void =
*data)
>  {
> -	bool *is_spi_i2c_slave_p =3D data;
> +	bool *is_serial_bus_slave_p =3D data;
> =20
>  	if (ares->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS)
>  		return 1;
> =20
> -	/*
> -	 * devices that are connected to UART still need to be enumerated to
> -	 * platform bus
> -	 */
> -	if (ares->data.common_serial_bus.type !=3D ACPI_RESOURCE_SERIAL_TYPE_UA=
RT)
> -		*is_spi_i2c_slave_p =3D true;
> +	*is_serial_bus_slave_p =3D true;
> =20
>  	 /* no need to do more checking */
>  	return -1;
>  }
> =20
> -static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
> +static bool acpi_is_serial_bus_slave(struct acpi_device *device)
>  {
>  	struct list_head resource_list;
> -	bool is_spi_i2c_slave =3D false;
> +	bool is_serial_bus_slave =3D false;
> =20
>  	/* Macs use device properties in lieu of _CRS resources */
>  	if (x86_apple_machine &&
>  	    (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
> -	     fwnode_property_present(&device->fwnode, "i2cAddress")))
> +	     fwnode_property_present(&device->fwnode, "i2cAddress") ||
> +	     fwnode_property_present(&device->fwnode, "baud")))
>  		return true;
> =20
>  	INIT_LIST_HEAD(&resource_list);
> -	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
> -			       &is_spi_i2c_slave);
> +	acpi_dev_get_resources(device, &resource_list,
> +			       acpi_check_serial_bus_slave,
> +			       &is_serial_bus_slave);
>  	acpi_dev_free_resource_list(&resource_list);
> =20
> -	return is_spi_i2c_slave;
> +	return is_serial_bus_slave;
>  }
> =20
>  void acpi_init_device_object(struct acpi_device *device, acpi_handle han=
dle,
> @@ -1557,7 +1554,7 @@ void acpi_init_device_object(struct acpi_device *de=
vice, acpi_handle handle,
>  	acpi_bus_get_flags(device);
>  	device->flags.match_driver =3D false;
>  	device->flags.initialized =3D true;
> -	device->flags.spi_i2c_slave =3D acpi_is_spi_i2c_slave(device);
> +	device->flags.serial_bus_slave =3D acpi_is_serial_bus_slave(device);
>  	acpi_device_clear_enumerated(device);
>  	device_initialize(&device->dev);
>  	dev_set_uevent_suppress(&device->dev, true);
> @@ -1841,10 +1838,10 @@ static acpi_status acpi_bus_check_add(acpi_handle=
 handle, u32 lvl_not_used,
>  static void acpi_default_enumeration(struct acpi_device *device)
>  {
>  	/*
> -	 * Do not enumerate SPI/I2C slaves as they will be enumerated by their
> -	 * respective parents.
> +	 * Do not enumerate SPI/I2C/UART slaves as they will be enumerated by
> +	 * their respective parents.
>  	 */
> -	if (!device->flags.spi_i2c_slave) {
> +	if (!device->flags.serial_bus_slave) {
>  		acpi_create_platform_device(device, NULL);
>  		acpi_device_set_enumerated(device);
>  	} else {
> @@ -1941,7 +1938,7 @@ static void acpi_bus_attach(struct acpi_device *dev=
ice)
>  		return;
> =20
>  	device->flags.match_driver =3D true;
> -	if (ret > 0 && !device->flags.spi_i2c_slave) {
> +	if (ret > 0 && !device->flags.serial_bus_slave) {
>  		acpi_device_set_enumerated(device);
>  		goto ok;
>  	}
> @@ -1950,7 +1947,7 @@ static void acpi_bus_attach(struct acpi_device *dev=
ice)
>  	if (ret < 0)
>  		return;
> =20
> -	if (!device->pnp.type.platform_id && !device->flags.spi_i2c_slave)
> +	if (!device->pnp.type.platform_id && !device->flags.serial_bus_slave)
>  		acpi_device_set_enumerated(device);
>  	else
>  		acpi_default_enumeration(device);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index fa15052..f849be2 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -211,7 +211,7 @@ struct acpi_device_flags {
>  	u32 of_compatible_ok:1;
>  	u32 coherent_dma:1;
>  	u32 cca_seen:1;
> -	u32 spi_i2c_slave:1;
> +	u32 serial_bus_slave:1;
>  	u32 reserved:19;
>  };
> =20
> --=20
> 2.7.4
>=20

--mcwbzmjx4wyzrkpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnYvCAACgkQ2O7X88g7
+pqDsQ//Y19nb2hp1Pb1FNGnGjXcpqyqalyBcVTpboFohEqt9XLCzyGwJdhr226B
SzmrSNZ5+4fWyMUmglF7NYW1bheU1rwp0tUhgtGNISTUFZYqVCRkFsMGx9AR0HCn
AOPEQ5uh4r0vPg0WYwHGX0WwjV5S/LxU79NkbOATXhzTEjaST5QAFK3BSVdkXIQV
AZdGQ7dQB+YimmXi/8rcToc+2XuELuH4o8CwfX6M/uGYJ7V3h4O7ubGrbcTnd3HE
hUYGOwKChCNp1eNg4H56q6gxKkTQ7c1UhwxNnAtkT9AeG6j+oTw8rHbSTMDlhHvZ
LuozCI9ml8uxis+nyKN7m/0qCykP1gkTt9xXIJfhwR+gPyWTzBzAOPpSYhozkY4h
ayMrDN4hMdxHQAQk5g5ljMjGZ4wRnbW6hyQZLbN6eng9NBghHMvgFuZ9OxWvyMo9
VxQZoko08mc7Rk046N7rL8CfyVSpJMnQ6y7jbzNPxeRC9sjWbn+05yTFBJFpSYHU
Ur3LWbuCX6SF+76TizhBD/xBt+pkQHkeiBv1hZy8cVid0aBkdWICBfoL2qPB6loQ
lJDYIyd4XDUdiXFyeVyr0TVsCe6oM5+GQvJUA/L9y7AC7/CX/wcxFtBjf6JriQGt
dNk7XEtjjlZB29rBw/E3Ui/qZWPBW/d9Qn1DUFVDiIDmMjzmvCk=
=xq0O
-----END PGP SIGNATURE-----

--mcwbzmjx4wyzrkpg--
