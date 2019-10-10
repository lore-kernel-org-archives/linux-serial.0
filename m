From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] serdev: Add ACPI devices by ResourceSource field
Date: Thu, 10 Oct 2019 12:22:42 +0200
Message-ID: <03d11e04-aaad-4851-c7d6-feaf62793670@redhat.com>
References: <20190924162226.1493407-1-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924162226.1493407-1-luzmaximilian@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 24-09-2019 18:22, Maximilian Luz wrote:
> When registering a serdev controller, ACPI needs to be checked for
> devices attached to it. Currently, all immediate children of the ACPI
> node of the controller are assumed to be UART client devices for this
> controller. Furthermore, these devices are not searched elsewhere.
>=20
> This is incorrect: Similar to SPI and I2C devices, the UART client
> device definition (via UARTSerialBusV2) can reside anywhere in the ACPI
> namespace as resource definition inside the _CRS method and points to
> the controller via its ResourceSource field. This field may either
> contain a fully qualified or relative path, indicating the controller
> device. To address this, we need to walk over the whole ACPI namespace,
> looking at each resource definition, and match the client device to the
> controller via this field.
>=20
> This patch is based on the existing acpi serial bus implementations in
> drivers/i2c/i2c-core-acpi.c and drivers/spi/spi.c, specifically commit
> 4c3c59544f33e97cf8557f27e05a9904ead16363 ("spi/acpi: enumerate all SPI
> slaves in the namespace").
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for the new version.

This patch looks good to me and it works on my test hw with serial
attached BT HCI:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> Changes compared to v1:
> - Patch now reflects the behavior of the existing ACPI serial bus
>    implementations (drivers/i2c/i2c-core-acpi.c and drivers/spi/spi.c),
>    with a maximum of one serdev client device per ACPI device node
>    allocated.
>=20
> - Ignores and continues on errors from AML code execution and resource
>    parsing.
>=20
> Notes:
>    The resource lookup is kept generic (similarly to the implementations
>    it is based on), meaning that it should be fairly simple to extend
>    acpi_serdev_parse_resource and acpi_serdev_check_resources to get and
>    return more information about the serdev client device (e.g. initial
>    baud rate) once this is required.
>=20
>    If multiple device definitions inside a single _CRS block ever become
>    a concern, the lookup function can be instructed as to which
>    UARTSerialBusV2 resource should be considered by spefifying its index
>    in acpi_serdev_lookup.index. This is again based on the I2C
>    implementation. Currently the last resource definition is chosen (i.e.
>    index =3D -1) to reflect the behavior of the other ACPI serial bus
>    implementations.
> ---
>   drivers/tty/serdev/core.c | 111 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 99 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index a0ac16ee6575..226adeec2aed 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -552,16 +552,97 @@ static int of_serdev_register_devices(struct serdev=
_controller *ctrl)
>   }
>  =20
>   #ifdef CONFIG_ACPI
> +
> +#define SERDEV_ACPI_MAX_SCAN_DEPTH 32
> +
> +struct acpi_serdev_lookup {
> +=09acpi_handle device_handle;
> +=09acpi_handle controller_handle;
> +=09int n;
> +=09int index;
> +};
> +
> +static int acpi_serdev_parse_resource(struct acpi_resource *ares, void *=
data)
> +{
> +=09struct acpi_serdev_lookup *lookup =3D data;
> +=09struct acpi_resource_uart_serialbus *sb;
> +=09acpi_status status;
> +
> +=09if (ares->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +=09=09return 1;
> +
> +=09if (ares->data.common_serial_bus.type !=3D ACPI_RESOURCE_SERIAL_TYPE_=
UART)
> +=09=09return 1;
> +
> +=09if (lookup->index !=3D -1 && lookup->n++ !=3D lookup->index)
> +=09=09return 1;
> +
> +=09sb =3D &ares->data.uart_serial_bus;
> +
> +=09status =3D acpi_get_handle(lookup->device_handle,
> +=09=09=09=09 sb->resource_source.string_ptr,
> +=09=09=09=09 &lookup->controller_handle);
> +=09if (ACPI_FAILURE(status))
> +=09=09return 1;
> +
> +=09/*
> +=09 * NOTE: Ideally, we would also want to retreive other properties her=
e,
> +=09 * once setting them before opening the device is supported by serdev=
.
> +=09 */
> +
> +=09return 1;
> +}
> +
> +static int acpi_serdev_do_lookup(struct acpi_device *adev,
> +                                 struct acpi_serdev_lookup *lookup)
> +{
> +=09struct list_head resource_list;
> +=09int ret;
> +
> +=09lookup->device_handle =3D acpi_device_handle(adev);
> +=09lookup->controller_handle =3D NULL;
> +=09lookup->n =3D 0;
> +
> +=09INIT_LIST_HEAD(&resource_list);
> +=09ret =3D acpi_dev_get_resources(adev, &resource_list,
> +=09=09=09=09     acpi_serdev_parse_resource, lookup);
> +=09acpi_dev_free_resource_list(&resource_list);
> +
> +=09if (ret < 0)
> +=09=09return -EINVAL;
> +
> +=09return 0;
> +}
> +
> +static int acpi_serdev_check_resources(struct serdev_controller *ctrl,
> +=09=09=09=09       struct acpi_device *adev)
> +{
> +=09struct acpi_serdev_lookup lookup;
> +=09int ret;
> +
> +=09if (acpi_bus_get_status(adev) || !adev->status.present)
> +=09=09return -EINVAL;
> +
> +=09/* Look for UARTSerialBusV2 resource */
> +=09lookup.index =3D -1;=09// we only care for the last device
> +
> +=09ret =3D acpi_serdev_do_lookup(adev, &lookup);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* Make sure controller and ResourceSource handle match */
> +=09if (ACPI_HANDLE(ctrl->dev.parent) !=3D lookup.controller_handle)
> +=09=09return -ENODEV;
> +
> +=09return 0;
> +}
> +
>   static acpi_status acpi_serdev_register_device(struct serdev_controller=
 *ctrl,
> -=09=09=09=09=09    struct acpi_device *adev)
> +=09=09=09=09=09       struct acpi_device *adev)
>   {
> -=09struct serdev_device *serdev =3D NULL;
> +=09struct serdev_device *serdev;
>   =09int err;
>  =20
> -=09if (acpi_bus_get_status(adev) || !adev->status.present ||
> -=09    acpi_device_enumerated(adev))
> -=09=09return AE_OK;
> -
>   =09serdev =3D serdev_device_alloc(ctrl);
>   =09if (!serdev) {
>   =09=09dev_err(&ctrl->dev, "failed to allocate serdev device for %s\n",
> @@ -583,7 +664,7 @@ static acpi_status acpi_serdev_register_device(struct=
 serdev_controller *ctrl,
>   }
>  =20
>   static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level=
,
> -=09=09=09=09       void *data, void **return_value)
> +=09=09=09=09=09  void *data, void **return_value)
>   {
>   =09struct serdev_controller *ctrl =3D data;
>   =09struct acpi_device *adev;
> @@ -591,22 +672,28 @@ static acpi_status acpi_serdev_add_device(acpi_hand=
le handle, u32 level,
>   =09if (acpi_bus_get_device(handle, &adev))
>   =09=09return AE_OK;
>  =20
> +=09if (acpi_device_enumerated(adev))
> +=09=09return AE_OK;
> +
> +=09if (acpi_serdev_check_resources(ctrl, adev))
> +=09=09return AE_OK;
> +
>   =09return acpi_serdev_register_device(ctrl, adev);
>   }
>  =20
> +
>   static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
>   {
>   =09acpi_status status;
> -=09acpi_handle handle;
>  =20
> -=09handle =3D ACPI_HANDLE(ctrl->dev.parent);
> -=09if (!handle)
> +=09if (!has_acpi_companion(ctrl->dev.parent))
>   =09=09return -ENODEV;
>  =20
> -=09status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +=09status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +=09=09=09=09     SERDEV_ACPI_MAX_SCAN_DEPTH,
>   =09=09=09=09     acpi_serdev_add_device, NULL, ctrl, NULL);
>   =09if (ACPI_FAILURE(status))
> -=09=09dev_dbg(&ctrl->dev, "failed to enumerate serdev slaves\n");
> +=09=09dev_warn(&ctrl->dev, "failed to enumerate serdev slaves\n");
>  =20
>   =09if (!ctrl->serdev)
>   =09=09return -ENODEV;
>=20
