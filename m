From: Graeme Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [v3,2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Wed, 31 Jan 2018 14:21:00 +0000
Message-ID: <20180131142100.GE26342@xora-haswell>
References: <1507710734-32520-3-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1507710734-32520-3-git-send-email-frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 11, 2017 at 10:32:14AM +0200, Frédéric Danis wrote:
> UART devices is expected to be enumerated by SerDev subsystem.
> 
> During ACPI scan, serial devices behind SPI, I2C or UART buses are not
> enumerated, allowing them to be enumerated by their respective parents.
> 
> Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for serial
> devices on serial buses (SPI, I2C or UART).
> 
> On Macs an empty ResourceTemplate is returned for uart slaves.
> Instead the device properties "baud", "parity", "dataBits", "stopBits" are
> provided. Add a check for "baud" in acpi_is_serial_bus_slave().
> 

This patch appears to break UART probing in ACPI on xgene based
plaforms.

The appropriate chunks of DSDT.

    Device (_SB.AHBC)
    {
        OperationRegion (SRST, SystemMemory, 0x1F2AC000, 0x04)
        OperationRegion (CLKE, SystemMemory, 0x1F2AC004, 0x04)
        OperationRegion (SRRM, SystemMemory, 0x1F2AD070, 0x04)
        OperationRegion (RD2F, SystemMemory, 0x1F2AE014, 0x04)

    ...

        Device (UAR0)
        {
            Name (_HID, "APMC0D08")  // _HID: Hardware ID
            Name (_DDN, "UAR0")  // _DDN: DOS Device Name
            Name (_UID, "UAR0")  // _UID: Unique ID
            Name (_STR, Unicode ("APM88xxxx UART0 Controller"))  // _STR: Description String
            Name (_ADR, 0x1C021000)  // _ADR: Address
            Name (_CID, "NS16550A")  // _CID: Compatible ID

    ...

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x1C021000,         // Address Base
                    0x00000100,         // Address Length
                    )
                UartSerialBusV2 (0x00002580, DataBitsEight, StopBitsOne,
                    0x00, LittleEndian, ParityTypeNone, FlowControlHardware,
                    0x0010, 0x0010, "UAR0",
                    0x00, ResourceConsumer, , Exclusive,
                    )
                Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000006D,
                }
            })

Thanks

Graeme

> Signed-off-by: Frédéric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> Tested-by: Ronald Tschalär <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>
> Tested-by: Peter Y. Chuang <peteryuchuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/scan.c     | 37 +++++++++++++++++--------------------
>  include/acpi/acpi_bus.h |  2 +-
>  2 files changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 602f8ff..860b698 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1505,41 +1505,38 @@ static void acpi_init_coherency(struct acpi_device *adev)
>  	adev->flags.coherent_dma = cca;
>  }
>  
> -static int acpi_check_spi_i2c_slave(struct acpi_resource *ares, void *data)
> +static int acpi_check_serial_bus_slave(struct acpi_resource *ares, void *data)
>  {
> -	bool *is_spi_i2c_slave_p = data;
> +	bool *is_serial_bus_slave_p = data;
>  
>  	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
>  		return 1;
>  
> -	/*
> -	 * devices that are connected to UART still need to be enumerated to
> -	 * platform bus
> -	 */
> -	if (ares->data.common_serial_bus.type != ACPI_RESOURCE_SERIAL_TYPE_UART)
> -		*is_spi_i2c_slave_p = true;
> +	*is_serial_bus_slave_p = true;
>  
>  	 /* no need to do more checking */
>  	return -1;
>  }
>  
> -static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
> +static bool acpi_is_serial_bus_slave(struct acpi_device *device)
>  {
>  	struct list_head resource_list;
> -	bool is_spi_i2c_slave = false;
> +	bool is_serial_bus_slave = false;
>  
>  	/* Macs use device properties in lieu of _CRS resources */
>  	if (x86_apple_machine &&
>  	    (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
> -	     fwnode_property_present(&device->fwnode, "i2cAddress")))
> +	     fwnode_property_present(&device->fwnode, "i2cAddress") ||
> +	     fwnode_property_present(&device->fwnode, "baud")))
>  		return true;
>  
>  	INIT_LIST_HEAD(&resource_list);
> -	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
> -			       &is_spi_i2c_slave);
> +	acpi_dev_get_resources(device, &resource_list,
> +			       acpi_check_serial_bus_slave,
> +			       &is_serial_bus_slave);
>  	acpi_dev_free_resource_list(&resource_list);
>  
> -	return is_spi_i2c_slave;
> +	return is_serial_bus_slave;
>  }
>  
>  void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
> @@ -1557,7 +1554,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
>  	acpi_bus_get_flags(device);
>  	device->flags.match_driver = false;
>  	device->flags.initialized = true;
> -	device->flags.spi_i2c_slave = acpi_is_spi_i2c_slave(device);
> +	device->flags.serial_bus_slave = acpi_is_serial_bus_slave(device);
>  	acpi_device_clear_enumerated(device);
>  	device_initialize(&device->dev);
>  	dev_set_uevent_suppress(&device->dev, true);
> @@ -1841,10 +1838,10 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_not_used,
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
> @@ -1941,7 +1938,7 @@ static void acpi_bus_attach(struct acpi_device *device)
>  		return;
>  
>  	device->flags.match_driver = true;
> -	if (ret > 0 && !device->flags.spi_i2c_slave) {
> +	if (ret > 0 && !device->flags.serial_bus_slave) {
>  		acpi_device_set_enumerated(device);
>  		goto ok;
>  	}
> @@ -1950,7 +1947,7 @@ static void acpi_bus_attach(struct acpi_device *device)
>  	if (ret < 0)
>  		return;
>  
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
>  
