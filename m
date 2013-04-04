From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v6] ACPI / serial: Add peripheral PnP IDs enumeration
 support
Date: Thu, 4 Apr 2013 10:12:56 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88015CC828@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <eb535db4b040bbe8712a975ed70cb3899b5b0fea.1364954385.git.lv.zheng@intel.com>
 <20130403161431.GB21383@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60633 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757063Ab3DDKNB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Apr 2013 06:13:01 -0400
In-Reply-To: <20130403161431.GB21383@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

> > ACPI 5.0 specification introduces mechanisms of enumerating the
> > peripherals connected on the serial buses. It will look like:
> >   Device (BTH0)
> >   {
> >       Name (_HID, "IBMF001")  // _HID: Hardware ID
> >       Name (_CID, "PNPF001")  // _CID: Compatible ID
> >       Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >       {
> >           Name (UBUF, ResourceTemplate ()
> >           {
> >               UartSerialBus (0x0001C200, DataBitsEight, StopBitsOne,
> >                   0xC0, LittleEndian, ParityTypeNone,
> FlowControlHardware,
> >                   0x0020, 0x0020, "\\_SB.PCI0.UA00",
> >                   0x00, ResourceConsumer, ,
> >               )
> >           }
> >           Return (UBUF)
> >       }
> >   }
> > This patch follows the specification, implementing such UART
> > enumeration machanism by exporting current peripheral HID/CIDs for the
> UART devices.
> > A userspace udev rule may look like:
> >  SUBSYSTEM=tty, ATTR{peripheral_type}=="*:IBMF001:*",
> >  RUN+="/bin/userprog --devpath=%p"
> > Thanks for the internal composers:
> >   Mika Westerberg <mika.westerberg@intel.com>
> >   Huang Ying <ying.huang@intel.com>
> >   Zhang Rui <rui.zhang@intel.com>
> > Thanks for the internal reviewers:
> >   Alan Cox <alan@linux.intel.com>
> >   Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >   Heikki Krogerus <heikki.krogerus@intel.com>
> >   Andriy Shevchenko <andriy.shevchenko@intel.com>
> >   Fengguang Wu <fengguang.wu@intel.com>
> 
> Why are these names not on the list below?

I obtained help from them on old revisions.
Mika is the key person for the acpi serial enumeration.
He has implemented the acpi i2c/spi serial enumeration.

> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Acked-by: Huang Ying <ying.huang@intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> 
> > ---
> >  drivers/acpi/Kconfig             |    6 ++
> >  drivers/acpi/Makefile            |    1 +
> >  drivers/acpi/acpi_uart.c         |  135
> ++++++++++++++++++++++++++++++++++++++
> >  drivers/acpi/internal.h          |    2 +
> >  drivers/acpi/scan.c              |    8 +--
> >  drivers/tty/serial/serial_core.c |   15 +++++
> >  include/linux/tty.h              |   11 ++++
> >  7 files changed, 174 insertions(+), 4 deletions(-)  create mode
> > 100644 drivers/acpi/acpi_uart.c
> >
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
> > 92ed969..42233f6 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -186,6 +186,12 @@ config ACPI_I2C
> >  	help
> >  	  ACPI I2C enumeration support.
> >
> > +config ACPI_UART
> > +	def_tristate TTY
> > +	depends on TTY
> > +	help
> > +	  ACPI UART enumeration support.
> 
> Please provide more information here.

OK.

> As this is primarily an ACPI patch, I need an ack from a ACPI maintainer before I
> can take this.

OK, I'll ask for this.

> > +
> >  config ACPI_PROCESSOR
> >  	tristate "Processor"
> >  	select THERMAL
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile index
> > 474fcfe..4db5470 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -72,6 +72,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
> >  obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
> >  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
> >  obj-$(CONFIG_ACPI_I2C)		+= acpi_i2c.o
> > +obj-$(CONFIG_ACPI_UART)		+= acpi_uart.o
> >
> >  # processor has its own "processor." module_param namespace
> >  processor-y			:= processor_driver.o processor_throttling.o
> > diff --git a/drivers/acpi/acpi_uart.c b/drivers/acpi/acpi_uart.c new
> > file mode 100644 index 0000000..dd5ac2e
> > --- /dev/null
> > +++ b/drivers/acpi/acpi_uart.c
> > @@ -0,0 +1,135 @@
> > +/*
> > + * acpi_uart.c - ACPI UART enumeration support
> > + *
> > + * Copyright (c) 2013, Intel Corporation
> > + * Author: Lv Zheng <lv.zheng@intel.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify it
> > + * under the terms of the GNU General Public License as published by
> > +the
> > + * Free Software Foundation; version 2 of the License.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/tty.h>
> > +#include <linux/module.h>
> > +#include <linux/acpi.h>
> > +
> > +#include "internal.h"
> > +
> > +struct acpi_uart_buf {
> > +	char *buf;
> > +	size_t size;
> > +	int *len;
> > +};
> > +
> > +struct acpi_uart_enum {
> > +	void *context;
> > +	acpi_status status;
> > +
> > +	struct acpi_device *adev;
> > +};
> > +
> > +static acpi_status
> > +acpi_uart_enum_pnpids(struct acpi_device *adev,
> > +		      struct acpi_resource_uart_serialbus *sb,
> > +		      void *context);
> > +
> > +static int acpi_uart_enum_resources(struct acpi_resource *ares,
> > +				    void *context)
> > +{
> > +	struct acpi_uart_enum *ctx = context;
> > +	struct acpi_resource_uart_serialbus *sb;
> > +
> > +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> > +		return 1;
> > +	sb = &ares->data.uart_serial_bus;
> > +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_UART)
> > +		return 1;
> > +
> > +	ctx->status = acpi_uart_enum_pnpids(ctx->adev, sb, ctx->context);
> > +	return 1;
> > +}
> > +
> > +static acpi_status acpi_uart_enum_devices(acpi_handle handle, u32 level,
> > +					  void *context,
> > +					  void **return_value)
> > +{
> > +	struct acpi_uart_enum *ctx = context;
> > +	struct acpi_device *adev;
> > +	struct list_head resource_list;
> > +
> > +	if (acpi_bus_get_device(handle, &adev))
> > +		return AE_OK;
> > +	if (acpi_bus_get_status(adev) || !adev->status.present)
> > +		return AE_OK;
> > +
> > +	/* Enumerate resources. */
> > +	ctx->adev = adev;
> > +	ctx->status = AE_OK;
> > +	INIT_LIST_HEAD(&resource_list);
> > +	acpi_dev_get_resources(adev, &resource_list,
> > +			       acpi_uart_enum_resources, ctx);
> > +	acpi_dev_free_resource_list(&resource_list);
> > +
> > +	return ctx->status;
> > +}
> > +
> > +static int acpi_uart_walk_port(struct device *parent,
> > +			       void *context)
> > +{
> > +	acpi_handle handle;
> > +	acpi_status status;
> > +	struct acpi_uart_enum ctx;
> > +
> > +	handle = parent ? ACPI_HANDLE(parent) : NULL;
> > +	if (!handle)
> > +		return -ENODEV;
> > +
> > +	ctx.context = context;
> > +
> > +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> > +				     acpi_uart_enum_devices, NULL,
> > +				     &ctx, NULL);
> > +	if (ACPI_FAILURE(status))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static acpi_status
> > +acpi_uart_enum_pnpids(struct acpi_device *adev,
> > +		      struct acpi_resource_uart_serialbus *sb,
> > +		      void *context)
> > +{
> > +	int len;
> > +	struct acpi_uart_buf *ctx = context;
> > +
> > +	len = acpi_device_create_modalias(adev, ctx->buf, ctx->size);
> > +	*ctx->len = len;
> > +
> > +	return len < 0 ? AE_CTRL_DEPTH : AE_OK; }
> > +
> > +/**
> > + * acpi_uart_get_peripheral_type - get peripheral HID/CIDs
> > + * @dev: the tty class device
> > + * @buf: the string buffer containing HID/CIDs
> > + * @size: the size of the string buffer
> > + *
> > + * Obtain UART peripheral HID/CIDs.  Return buffer size on success,
> > + * -errno on failure.
> > + */
> > +int acpi_uart_get_peripheral_type(struct device *dev,
> > +				  char *buf, size_t size)
> > +{
> > +	int ret;
> > +	int len = 0;
> > +	struct acpi_uart_buf ctx = { buf, size, &len };
> > +
> > +	ret = acpi_uart_walk_port(dev->parent, &ctx);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return len;
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_uart_get_peripheral_type);
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h index
> > 3c94a73..30d7440 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -61,6 +61,8 @@ void acpi_init_device_object(struct acpi_device *device,
> acpi_handle handle,
> >  			     int type, unsigned long long sta);  void
> > acpi_device_add_finalize(struct acpi_device *device);  void
> > acpi_free_ids(struct acpi_device *device);
> > +int acpi_device_create_modalias(struct acpi_device *acpi_dev,
> > +				char *modalias, int size);
> >
> >  /* --------------------------------------------------------------------------
> >                                    Power Resource diff --git
> > a/drivers/acpi/scan.c b/drivers/acpi/scan.c index 5e7e991..0d7d49f
> > 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -68,8 +68,8 @@ int acpi_scan_add_handler(struct acpi_scan_handler
> *handler)
> >   * e.g. on a device with hid:IBM0001 and cid:ACPI0001 you get:
> >   * char *modalias: "acpi:IBM0001:ACPI0001"
> >  */
> > -static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
> > -			   int size)
> > +int acpi_device_create_modalias(struct acpi_device *acpi_dev,
> > +				char *modalias, int size)
> >  {
> >  	int len;
> >  	int count;
> > @@ -99,7 +99,7 @@ acpi_device_modalias_show(struct device *dev, struct
> device_attribute *attr, cha
> >  	int len;
> >
> >  	/* Device has no HID and no CID or string is >1024 */
> > -	len = create_modalias(acpi_dev, buf, 1024);
> > +	len = acpi_device_create_modalias(acpi_dev, buf, 1024);
> >  	if (len <= 0)
> >  		return 0;
> >  	buf[len++] = '\n';
> > @@ -567,7 +567,7 @@ static int acpi_device_uevent(struct device *dev,
> > struct kobj_uevent_env *env)
> >
> >  	if (add_uevent_var(env, "MODALIAS="))
> >  		return -ENOMEM;
> > -	len = create_modalias(acpi_dev, &env->buf[env->buflen - 1],
> > +	len = acpi_device_create_modalias(acpi_dev, &env->buf[env->buflen -
> > +1],
> >  			      sizeof(env->buf) - env->buflen);
> >  	if (len >= (sizeof(env->buf) - env->buflen))
> >  		return -ENOMEM;
> > diff --git a/drivers/tty/serial/serial_core.c
> > b/drivers/tty/serial/serial_core.c
> > index a400002..17e104e 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2515,6 +2515,19 @@ static ssize_t
> uart_get_attr_iomem_reg_shift(struct device *dev,
> >  	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.iomem_reg_shift);  }
> >
> > +static ssize_t uart_get_attr_peripheral_type(struct device *dev,
> > +		struct device_attribute *attr, char *buf) {
> > +	int len;
> > +
> > +	len = acpi_uart_get_peripheral_type(dev, buf, 1024);
> > +	if (len > 0) {
> > +		buf[len++] = '\n';
> > +		return len;
> > +	}
> > +	return snprintf(buf, PAGE_SIZE, "uart\n");
> 
> What is the "uart" part for?  Isn't that kind of obvious?

It is the default "peripheral_type" content.
Before sending next revision out, let me ask a question here:
Shall I leave this empty as my previous revisions?

> > +}
> 
> You are creating a new sysfs file, you must create a new Documentation/ABI
> entry as well.

OK.

> > +
> >  static DEVICE_ATTR(type, S_IRUSR | S_IRGRP, uart_get_attr_type,
> > NULL);  static DEVICE_ATTR(line, S_IRUSR | S_IRGRP,
> > uart_get_attr_line, NULL);  static DEVICE_ATTR(port, S_IRUSR |
> > S_IRGRP, uart_get_attr_port, NULL); @@ -2528,6 +2541,7 @@ static
> > DEVICE_ATTR(custom_divisor, S_IRUSR | S_IRGRP,
> > uart_get_attr_custom_divis  static DEVICE_ATTR(io_type, S_IRUSR |
> > S_IRGRP, uart_get_attr_io_type, NULL);  static DEVICE_ATTR(iomem_base,
> > S_IRUSR | S_IRGRP, uart_get_attr_iomem_base, NULL);  static
> > DEVICE_ATTR(iomem_reg_shift, S_IRUSR | S_IRGRP,
> > uart_get_attr_iomem_reg_shift, NULL);
> > +static DEVICE_ATTR(peripheral_type, S_IRUSR | S_IRGRP,
> > +uart_get_attr_peripheral_type, NULL);
> >
> >  static struct attribute *tty_dev_attrs[] = {
> >  	&dev_attr_type.attr,
> > @@ -2543,6 +2557,7 @@ static struct attribute *tty_dev_attrs[] = {
> >  	&dev_attr_io_type.attr,
> >  	&dev_attr_iomem_base.attr,
> >  	&dev_attr_iomem_reg_shift.attr,
> > +	&dev_attr_peripheral_type.attr,
> >  	NULL,
> >  	};
> >
> > diff --git a/include/linux/tty.h b/include/linux/tty.h index
> > 367a9df..723fdd01 100644
> > --- a/include/linux/tty.h
> > +++ b/include/linux/tty.h
> > @@ -692,4 +692,15 @@ do {									\
> >  } while (0)
> >
> >
> > +#ifdef CONFIG_ACPI_UART
> > +int acpi_uart_get_peripheral_type(struct device *dev,
> > +	char *buf, size_t size);
> > +#else
> > +static inline int acpi_uart_get_peripheral_type(struct device *dev,
> > +	char *buf, size_t size)
> > +{
> > +	return -ENODEV;
> > +}
> > +#endif
> 
> I see you never tested this code without the configuration option enabled :(
> 
> {sigh}

Yes, I rely too much on an internal test system as it can do this for me automatically.
OK, I'll take care of this next time.
I've a plan and a TODO to offer a complete test framework for this as I've done 10 years ago.
Hope you will like it.

Thanks and best regards
-Lv

