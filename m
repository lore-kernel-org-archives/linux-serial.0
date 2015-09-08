From: Mark Salter <msalter@redhat.com>
Subject: Re: [Linaro-acpi] [RFC 3/5] acpi/serial: add DBG2 earlycon support
Date: Tue, 08 Sep 2015 12:38:59 -0400
Message-ID: <1441730339.5459.8.camel@redhat.com>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
	 <1441716217-23786-4-git-send-email-leif.lindholm@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441716217-23786-4-git-send-email-leif.lindholm@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Leif Lindholm <leif.lindholm@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, jcm@redhat.com, torez@redhat.com, lv.zheng@intel.com
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-09-08 at 13:43 +0100, Leif Lindholm wrote:
> The ACPI DBG2 table defines a debug console. Add support for parsing it
> and using it to select earlycon destination when no arguments provided.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c      |   2 +
>  drivers/acpi/Makefile         |   1 +
>  drivers/acpi/console.c        | 103 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/fdt.c              |   2 +-
>  drivers/tty/serial/earlycon.c |  16 ++++---
>  include/linux/acpi.h          |   4 ++
>  include/linux/serial_core.h   |   9 ++--
>  7 files changed, 126 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/acpi/console.c
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index b9a5623..be7600a 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -207,6 +207,8 @@ void __init acpi_boot_table_init(void)
>  		if (!param_acpi_force)
>  			disable_acpi();
>  	}
> +
> +	acpi_early_console_probe();
>  }
>  
>  void __init acpi_gic_init(void)
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index b5e7cd8..a89587d 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -10,6 +10,7 @@ ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
>  #
>  obj-y				+= tables.o
>  obj-$(CONFIG_X86)		+= blacklist.o
> +obj-y				+= console.o

obj-$(CONFIG_SERIAL_EARLYCON) += console.o

to eliminate whole-file #ifdef

>  
>  #
>  # ACPI Core Subsystem (Interpreter)
> diff --git a/drivers/acpi/console.c b/drivers/acpi/console.c
> new file mode 100644
> index 0000000..a985890
> --- /dev/null
> +++ b/drivers/acpi/console.c
> @@ -0,0 +1,103 @@
> +/*
> + * Copyright (c) 2012, Intel Corporation
> + * Copyright (c) 2015, Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#define DEBUG
> +#define pr_fmt(fmt) "ACPI: " KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/serial_core.h>
> +
> +#define NUM_ELEMS(x) (sizeof(x) / sizeof(*x))
> +
> +#ifdef CONFIG_SERIAL_EARLYCON
> +static int use_earlycon __initdata;
> +static int __init setup_acpi_earlycon(char *buf)
> +{
> +	if (!buf)
> +		use_earlycon = 1;
> +
> +	return 0;
> +}
> +early_param("earlycon", setup_acpi_earlycon);
> +
> +extern struct earlycon_id __earlycon_table[];
> +
> +static __initdata struct {
> +	int id;
> +	const char *name;
> +} subtypes[] = {
> +	{0, "uart8250"},
> +	{1, "uart8250"},
> +	{2, NULL},
> +	{3, "pl011"},
> +};

Instead of having a table here, why not have an ACPI_EARLYCON_DECLARE()
where individual drivers can provide an id similar to OF_EARLYCON_DECLARE()
providing compatible strings?

> +
> +static int __init acpi_setup_earlycon(unsigned long addr, const char *driver)
> +{
> +	const struct earlycon_id *match;
> +
> +	for (match = __earlycon_table; match->name[0]; match++)
> +		if (strcmp(driver, match->name) == 0)
> +			return setup_earlycon_driver(addr, match->setup);
> +
> +	return -ENODEV;
> +}
> +
> +static int __init acpi_parse_dbg2(struct acpi_table_header *table)
> +{
> +	struct acpi_table_dbg2 *dbg2;
> +	struct acpi_dbg2_device *entry;
> +	void *tbl_end;
> +
> +	dbg2 = (struct acpi_table_dbg2 *)table;
> +	if (!dbg2) {
> +		pr_debug("DBG2 not present.\n");
> +		return -ENODEV;
> +	}
> +
> +	tbl_end = (void *)table + table->length;
> +
> +	entry = (struct acpi_dbg2_device *)((void *)dbg2 + dbg2->info_offset);
> +
> +	while (((void *)entry) + sizeof(struct acpi_dbg2_device) < tbl_end) {
> +		struct acpi_generic_address *addr;
> +
> +		if (entry->revision != 0) {
> +			pr_debug("DBG2 revision %d not supported.\n",
> +				 entry->revision);
> +			return -ENODEV;
> +		}
> +
> +		addr = (void *)entry + entry->base_address_offset;
> +
> +		pr_debug("DBG2 PROBE - console (%04x:%04x).\n",
> +			 entry->port_type, entry->port_subtype);
> +
> +		if (use_earlycon &&
> +		    (entry->port_type == ACPI_DBG2_SERIAL_PORT) &&
> +		    (entry->port_subtype < NUM_ELEMS(subtypes)))
> +			acpi_setup_earlycon(addr->address,
> +					    subtypes[entry->port_subtype].name);

Don't we need to handle space_id (and bit width) as well as address?

> +
> +		entry = (struct acpi_dbg2_device *)
> +			((void *)entry + entry->length);
> +	}
> +
> +	return 0;
> +}
> +
> +int __init acpi_early_console_probe(void)
> +{
> +	acpi_table_parse(ACPI_SIG_DBG2, acpi_parse_dbg2);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_SERIAL_EARLYCON */
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index fcfc4c7..a96209f 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -829,7 +829,7 @@ int __init early_init_dt_scan_chosen_serial(void)
>  		if (!addr)
>  			return -ENXIO;
>  
> -		of_setup_earlycon(addr, match->data);
> +		setup_earlycon_driver(addr, match->data);
>  		return 0;
>  	}
>  	return -ENODEV;
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 2bda09a..c063cbb 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -13,6 +13,7 @@
>  
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/console.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> @@ -184,12 +185,16 @@ static int __init param_setup_earlycon(char *buf)
>  	int err;
>  
>  	/*
> -	 * Just 'earlycon' is a valid param for devicetree earlycons;
> -	 * don't generate a warning from parse_early_params() in that case
> +	 * Just 'earlycon' is a valid param for devicetree or ACPI earlycons;
> +	 * ACPI cannot be parsed yet, so return without action if enabled.
> +	 * Otherwise, attempt initialization using DT.
>  	 */
> -	if (!buf || !buf[0])
> -		if (IS_ENABLED(CONFIG_OF_FLATTREE))
> +	if (!buf || !buf[0]) {
> +		if (!acpi_disabled)

How do we know for sure that "acpi" has been parsed before "earlycon"?

> +			return 0;
> +		else if (IS_ENABLED(CONFIG_OF_FLATTREE))
>  			return early_init_dt_scan_chosen_serial();
> +	}
>  
>  	err = setup_earlycon(buf);
>  	if (err == -ENOENT || err == -EALREADY)
> @@ -198,8 +203,7 @@ static int __init param_setup_earlycon(char *buf)
>  }
>  early_param("earlycon", param_setup_earlycon);
>  
> -int __init of_setup_earlycon(unsigned long addr,
> -			     int (*setup)(struct earlycon_device *, const char *))
> +int __init setup_earlycon_driver(unsigned long addr, earlycon_initfunc_t setup)
>  {
>  	int err;
>  	struct uart_port *port = &early_console_dev.port;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 7235c48..88cb9c1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -811,4 +811,8 @@ static inline struct acpi_device *acpi_get_next_child(struct device *dev,
>  
>  #endif
>  
> +#if defined(CONFIG_ACPI) && defined(CONFIG_SERIAL_EARLYCON)
> +int __init acpi_early_console_probe(void);
> +#endif
> +
>  #endif	/*_LINUX_ACPI_H*/
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 297d4fa..39e99b0 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -339,14 +339,15 @@ struct earlycon_device {
>  	unsigned int baud;
>  };
>  
> +typedef int (*earlycon_initfunc_t)(struct earlycon_device *, const char *);
> +
>  struct earlycon_id {
> -	char	name[16];
> -	int	(*setup)(struct earlycon_device *, const char *options);
> +	char			name[16];
> +	earlycon_initfunc_t	setup;
>  } __aligned(32);
>  
>  extern int setup_earlycon(char *buf);
> -extern int of_setup_earlycon(unsigned long addr,
> -			     int (*setup)(struct earlycon_device *, const char *));
> +extern int setup_earlycon_driver(unsigned long addr, earlycon_initfunc_t setup);
>  
>  #define EARLYCON_DECLARE(_name, func)					\
>  	static const struct earlycon_id __earlycon_##_name		\
