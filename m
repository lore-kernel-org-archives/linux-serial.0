From: Mark Salter <msalter@redhat.com>
Subject: Re: [Linaro-acpi] [RFC 4/5] tty/console: use SPCR table to define
 console
Date: Thu, 10 Sep 2015 11:28:04 -0400
Message-ID: <1441898884.18796.8.camel@redhat.com>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
	 <1441716217-23786-5-git-send-email-leif.lindholm@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441716217-23786-5-git-send-email-leif.lindholm@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Leif Lindholm <leif.lindholm@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, jcm@redhat.com, torez@redhat.com, lv.zheng@intel.com
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-09-08 at 13:43 +0100, Leif Lindholm wrote:
> From: Torez Smith <torez@redhat.com>
> 
> If console= is not added to the kernel command line, the console
> is not registered until much further into the booting process. This patch
> adds support to parse the SPCR ACPI table to pull console support out,
> then use the appropriate drivers to set up console support earlier in the
> boot process.
> 
> Signed-off-by: Jon Masters <jcm@redhat.com>
> [rebased and cleaned up]
> Signed-off-by: Torez Smith <torez@redhat.com>
> [reworked to use _CRS, moved to drivers/acpi]
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  drivers/acpi/console.c           | 157 +++++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/serial_core.c |  14 +++-
>  include/linux/acpi.h             |  11 ++-
>  3 files changed, 179 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/console.c b/drivers/acpi/console.c
> index a985890..02883a1 100644
> --- a/drivers/acpi/console.c
> +++ b/drivers/acpi/console.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (c) 2012, Intel Corporation
> + * Copyright (c) 2015, Red Hat, Inc.
>   * Copyright (c) 2015, Linaro Ltd.
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -12,11 +13,17 @@
>  #define pr_fmt(fmt) "ACPI: " KBUILD_MODNAME ": " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/console.h>
>  #include <linux/kernel.h>
>  #include <linux/serial_core.h>
> +#include <linux/tty.h>
>  
>  #define NUM_ELEMS(x) (sizeof(x) / sizeof(*x))
>  
> +static u64 acpi_serial_addr;
> +static struct acpi_device *acpi_serial_device;
> +static char *acpi_serial_options;
> +
>  #ifdef CONFIG_SERIAL_EARLYCON
>  static int use_earlycon __initdata;
>  static int __init setup_acpi_earlycon(char *buf)
> @@ -101,3 +108,153 @@ int __init acpi_early_console_probe(void)
>  	return 0;
>  }
>  #endif /* CONFIG_SERIAL_EARLYCON */
> +
> +/*
> + * Parse the SPCR table. If we are not working with version 2 or
> + * higher, bail.
> + * Otherwise, pull out the baud rate and address to the console device.
> + */
> +static int __init acpi_parse_spcr(struct acpi_table_header *table)
> +{
> +	struct acpi_table_spcr *spcr = (struct acpi_table_spcr *)table;
> +
> +	if (table->revision < 2)
> +		return -EOPNOTSUPP;
> +
> +	/* Handle possible alignment issues */
> +	memcpy(&acpi_serial_addr,
> +	       &spcr->serial_port.address, sizeof(acpi_serial_addr));
> +
> +	/*
> +	 * The baud rate the BIOS used for redirection. Valid values are....
> +	 *	3 = 9600
> +	 *	4 = 19200
> +	 *	6 = 57600
> +	 *	7 = 115200
> +	 *	0-2, 5, 8 - 255 = reserved
> +	*/
> +	switch (spcr->baud_rate) {
> +	case 3:
> +		acpi_serial_options = "9600";
> +		break;
> +	case 4:
> +		acpi_serial_options = "19200";
> +		break;
> +	case 6:
> +		acpi_serial_options = "57600";
> +		break;
> +	case 7:
> +		acpi_serial_options = "115200";
> +		break;
> +	default:
> +		acpi_serial_options = "";
> +		break;
> +	}
> +
> +	pr_info("SPCR serial device: 0x%llx (options: %s)\n",
> +	       acpi_serial_addr, acpi_serial_options);
> +
> +	return 0;
> +}
> +
> +/*
> + * Parse an ACPI "Device" to determine if it represents the
> + * data found in the SPCR table. If the associated Device has
> + * and Address entry, and, that Address matches the one found
> + * in our SPCR table, it's the entry we are interested in.
> + *
> + */
> +static acpi_status acpi_spcr_device_scan(acpi_handle handle,
> +					 u32 level, void *context, void **retv)
> +{
> +	unsigned long long addr = 0;
> +	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status = AE_OK;
> +	struct acpi_device *adev;
> +	struct list_head resource_list;
> +	struct resource_entry *rentry;
> +
> +	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &name_buffer);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +

acpi_get_name() is asked to allocate a buffer for the name, but that
buffer doesn't get freed below. The name is only used in the pr_info
call, so the acpi_get_name() call should probably be moved inside that
if block and a kfree(name_buffer.pointer) added.

> +	adev = acpi_bus_get_acpi_device(handle);
> +	if (!adev) {
> +		pr_err("Err locating SPCR device from ACPI handle\n");
> +		return AE_OK; /* skip this one */
> +	}
> +
> +	/*
> +	 * Read device address from _CRS.
> +	 */
> +	INIT_LIST_HEAD(&resource_list);
> +	if (acpi_dev_get_resources(adev, &resource_list, NULL, NULL) <= 0)
> +		return AE_OK;
> +
> +	list_for_each_entry(rentry, &resource_list, node) {
> +		if (resource_type(rentry->res) == IORESOURCE_MEM)
> +			addr = rentry->res->start;
> +	}
> +	acpi_dev_free_resource_list(&resource_list);
> +
> +	if (addr == acpi_serial_addr) {
> +		acpi_serial_device = adev;
> +
> +		pr_info("SPCR serial console: %s (0x%llx)\n",
> +		       (char *)(name_buffer.pointer), addr);
> +
> +		return AE_OK; /* harmless to continue */
> +	}
> +
> +	/* continue */
> +	return AE_OK; /* continue */
> +}
> +
> +static int __init acpi_setup_spcr(void)
> +{
> +	if (0 != acpi_table_parse(ACPI_SIG_SPCR, acpi_parse_spcr)) {
> +		pr_warn("SPCR table not found - auto console disabled\n");
> +		return -ENODEV;
> +	}
> +
> +	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +			    ACPI_UINT32_MAX, acpi_spcr_device_scan,
> +			    NULL, NULL, NULL);
> +
> +	return 0;
> +}
> +
> +static int __init acpi_spcr_setup(void)
> +{
> +	/*
> +	 * If ACPI is enabled, scan the tables for
> +	 * automatic console configuration
> +	 */
> +	if (!acpi_disabled)
> +		acpi_setup_spcr();
> +
> +	return 0;
> +}
> +subsys_initcall_sync(acpi_spcr_setup);
> +
> +/**
> + * acpi_console_check() - Check for and configure console from ACPI information
> + * @adev - Pointer to device
> + * @name - Name to use for preferred console without index. ex. "ttyS"
> + * @index - Index to use for preferred console.
> + *
> + * Check if the given device matches the information provided in the SPCR table
> + * If it does then register it as the preferred console and return TRUE.
> + * Otherwise return FALSE.
> + */
> +bool acpi_console_check(struct acpi_device *adev, char *name, int index)
> +{
> +	if (acpi_disabled || !adev || adev != acpi_serial_device
> +	    || console_set_on_cmdline)
> +		return false;
> +
> +	pr_info("adding preferred console [%s]\n", name);
> +
> +	return !add_preferred_console(name, index,
> +				      kstrdup(acpi_serial_options, GFP_KERNEL));
> +}
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 603d2cc..4b20bc6 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -34,6 +34,7 @@
>  #include <linux/serial_core.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> @@ -2696,9 +2697,18 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  		spin_lock_init(&uport->lock);
>  		lockdep_set_class(&uport->lock, &port_lock_key);
>  	}
> -	if (uport->cons && uport->dev)
> -		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
>  
> +	/*
> +	 * Support both open FW and ACPI access to console definitions.
> +	 * Both of_console_check() and acpi_console_check() will call
> +	 * add_preferred_console() if a console definition is found.
> +	 */
> +	if (uport->cons && uport->dev) {
> +		if (!acpi_console_check(ACPI_COMPANION(uport->dev),
> +					uport->cons->name, uport->line))
> +			of_console_check(uport->dev->of_node,
> +					 uport->cons->name, uport->line);
> +	}
>  	uart_configure_port(drv, state, uport);
>  
>  	num_groups = 2;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 88cb9c1..f1b9a64 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -811,8 +811,17 @@ static inline struct acpi_device *acpi_get_next_child(struct device *dev,
>  
>  #endif
>  
> -#if defined(CONFIG_ACPI) && defined(CONFIG_SERIAL_EARLYCON)
> +#if defined(CONFIG_ACPI)
> +# if defined(CONFIG_SERIAL_EARLYCON)
>  int __init acpi_early_console_probe(void);
> +# endif
> +bool acpi_console_check(struct acpi_device *adev, char *name, int index);
> +#else
> +static inline bool acpi_console_check(struct acpi_device *adev, char *name,
> +				      int index)
> +{
> +	return FALSE;
> +}
>  #endif
>  
>  #endif	/*_LINUX_ACPI_H*/
