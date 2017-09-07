From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 2/3] ACPI / scan: Fix enumeration for special UART devices
Date: Thu, 7 Sep 2017 19:25:18 +0200
Message-ID: <2C6832A9-2BA5-42CD-A398-CD7BA5AE7C8E@holtmann.org>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-3-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1504786214-1866-3-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, sre@kernel.org, loic.poulain@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Fred,

> UART devices is expected to be enumerated by SerDev subsystem.
> Rename spi_i2c_slave to serial_slave as this is no more specific to spi or
> i2c buses.
> 
> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> ---
> drivers/acpi/scan.c     | 29 ++++++++++++-----------------
> include/acpi/acpi_bus.h |  2 +-
> 2 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 70fd550..04c5ecc 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1429,35 +1429,30 @@ static void acpi_init_coherency(struct acpi_device *adev)
> 	adev->flags.coherent_dma = cca;
> }
> 
> -static int acpi_check_spi_i2c_slave(struct acpi_resource *ares, void *data)
> +static int acpi_check_serial_slave(struct acpi_resource *ares, void *data)
> {
> -	bool *is_spi_i2c_slave_p = data;
> +	bool *is_serial_slave_p = data;
> 
> 	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> 		return 1;
> 
> -	/*
> -	 * devices that are connected to UART still need to be enumerated to
> -	 * platform bus
> -	 */
> -	if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)
> -		*is_spi_i2c_slave_p = true;
> +	*is_serial_slave_p = true;
> 
> 	 /* no need to do more checking */
> 	return -1;
> }
> 

isn’t this disabled the I2C support? I mean serial bus doesn’t always mean UART. There are other serial buses and even USB is actually a serial bus.

> -static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
> +static bool acpi_is_serial_slave(struct acpi_device *device)
> {
> 	struct list_head resource_list;
> -	bool is_spi_i2c_slave = false;
> +	bool is_serial_slave = false;
> 
> 	INIT_LIST_HEAD(&resource_list);
> -	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
> -			       &is_spi_i2c_slave);
> +	acpi_dev_get_resources(device, &resource_list, acpi_check_serial_slave,
> +			       &is_serial_slave);
> 	acpi_dev_free_resource_list(&resource_list);
> 
> -	return is_spi_i2c_slave;
> +	return is_serial_slave;
> }
> 
> void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
> @@ -1476,7 +1471,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
> 	acpi_bus_get_flags(device);
> 	device->flags.match_driver = false;
> 	device->flags.initialized = true;
> -	device->flags.spi_i2c_slave = acpi_is_spi_i2c_slave(device);
> +	device->flags.serial_slave = acpi_is_serial_slave(device);
> 	acpi_device_clear_enumerated(device);
> 	device_initialize(&device->dev);
> 	dev_set_uevent_suppress(&device->dev, true);
> @@ -1763,7 +1758,7 @@ static void acpi_default_enumeration(struct acpi_device *device)
> 	 * Do not enumerate SPI/I2C slaves as they will be enumerated by their
> 	 * respective parents.
> 	 */
> -	if (!device->flags.spi_i2c_slave) {
> +	if (!device->flags.serial_slave) {
> 		acpi_create_platform_device(device, NULL);
> 		acpi_device_set_enumerated(device);
> 	} else {
> @@ -1860,7 +1855,7 @@ static void acpi_bus_attach(struct acpi_device *device)
> 		return;
> 
> 	device->flags.match_driver = true;
> -	if (ret > 0 && !device->flags.spi_i2c_slave) {
> +	if (ret > 0 && !device->flags.serial_slave) {
> 		acpi_device_set_enumerated(device);
> 		goto ok;
> 	}
> @@ -1869,7 +1864,7 @@ static void acpi_bus_attach(struct acpi_device *device)
> 	if (ret < 0)
> 		return;
> 
> -	if (!device->pnp.type.platform_id && !device->flags.spi_i2c_slave)
> +	if (!device->pnp.type.platform_id && !device->flags.serial_slave)
> 		acpi_device_set_enumerated(device);
> 	else
> 		acpi_default_enumeration(device);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 68bc6be..49a82f8 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -211,7 +211,7 @@ struct acpi_device_flags {
> 	u32 of_compatible_ok:1;
> 	u32 coherent_dma:1;
> 	u32 cca_seen:1;
> -	u32 spi_i2c_slave:1;
> +	u32 serial_slave:1;
> 	u32 reserved:19;
> };

I am not an ACPI expert, but wouldn’t we better have a serial_bus_slave here. And the serial_bus_slave can be either UART or I2C? Or have a pretty good commit message explaining why this is serial_slave only.

Regards

Marcel

