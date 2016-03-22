From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v5 3/6] ACPI: parse SPCR and enable matching console
Date: Tue, 22 Mar 2016 15:26:50 +0300
Message-ID: <20160322122650.GA10616@yury-N73SV>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
 <1458643595-14719-4-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458643595-14719-4-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 22, 2016 at 01:46:30PM +0300, Aleksey Makarov wrote:
> 'ARM Server Base Boot Requiremets' [1] mentions SPCR (Serial Port
> Console Redirection Table) [2] as a mandatory ACPI table that
> specifies the configuration of serial console.
> 
> Parse this table, setup earlycon and enable the specified console.
> 
> Thanks to Peter Hurley for explaining how this should work.
> 
> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
> [2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  drivers/acpi/Kconfig          |   3 ++
>  drivers/acpi/Makefile         |   1 +
>  drivers/acpi/spcr.c           | 102 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/earlycon.c |  13 ++++--
>  include/linux/acpi.h          |   8 ++++
>  5 files changed, 123 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/acpi/spcr.c
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 65fb483..5611eb6 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -77,6 +77,9 @@ config ACPI_DEBUGGER_USER
>  
>  endif
>  
> +config ACPI_SPCR_TABLE
> +	bool
> +
>  config ACPI_SLEEP
>  	bool
>  	depends on SUSPEND || HIBERNATION
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 7395928..f70ae14 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>  obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
> +obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  
>  # processor has its own "processor." module_param namespace
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> new file mode 100644
> index 0000000..1ec82f9
> --- /dev/null
> +++ b/drivers/acpi/spcr.c
> @@ -0,0 +1,102 @@
> +/*
> + * Copyright (c) 2012, Intel Corporation
> + * Copyright (c) 2015, Red Hat, Inc.
> + * Copyright (c) 2015, 2016 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#define pr_fmt(fmt) "ACPI: SPCR: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/console.h>
> +#include <linux/kernel.h>
> +#include <linux/serial_core.h>
> +
> +static bool init_earlycon;
> +
> +void __init init_spcr_earlycon(void)
> +{
> +	init_earlycon = true;
> +}
> +

1. I see you keep in mind multiple access. Then you'd worry about race
conditions as well. In this case, I'd consider atomic access to
variable.
2. It seems you need is_init() helper too.

> +int __init parse_spcr(void)
> +{
> +	static char opts[64];
> +	struct acpi_table_spcr *table;
> +	acpi_size table_size;
> +	acpi_status status;
> +	char *uart;
> +	char *iotype;
> +	int baud_rate;
> +	int err = 0;

You can do not initialize 'err'.

> +
> +	status = acpi_get_table_with_size(ACPI_SIG_SPCR, 0,
> +					  (struct acpi_table_header **)&table,
> +					  &table_size);
> +
> +	if (ACPI_FAILURE(status))
> +		return -ENOENT;
> +
> +	if (table->header.revision < 2) {
> +		err = -EINVAL;
> +		pr_err("wrong table version\n");
> +		goto done;
> +	}
> +
> +	iotype = (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) ?
> +			"mmio" : "io";
> +
> +	switch (table->interface_type) {
> +	case ACPI_DBG2_ARM_SBSA_32BIT:
> +		iotype = "mmio32";
> +		/* fall through */
> +	case ACPI_DBG2_ARM_PL011:
> +	case ACPI_DBG2_ARM_SBSA_GENERIC:
> +	case ACPI_DBG2_BCM2835:
> +		uart = "pl011";
> +		break;
> +	case ACPI_DBG2_16550_COMPATIBLE:
> +	case ACPI_DBG2_16550_SUBSET:
> +		uart = "uart";
> +		break;
> +	default:
> +		err = -ENOENT;
> +		goto done;
> +	}
> +
> +	switch (table->baud_rate) {
> +	case 3:
> +		baud_rate = 9600;
> +		break;
> +	case 4:
> +		baud_rate = 19200;
> +		break;
> +	case 6:
> +		baud_rate = 57600;
> +		break;
> +	case 7:
> +		baud_rate = 115200;
> +		break;
> +	default:
> +		err = -ENOENT;
> +		goto done;
> +	}
> +
> +	sprintf(opts, "%s,%s,0x%llx,%d", uart, iotype,
> +		table->serial_port.address, baud_rate);

As 'opts' is static, don't you need to take some measures to prevent
concurrent access. The simpler measure for me is to declare it on
stack.

> +
> +	pr_info("console: %s", opts);
> +
> +	if (init_earlycon)
> +		setup_earlycon(opts);
> +
> +	err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
> +
> +done:
> +	early_acpi_os_unmap_memory((void __iomem *)table, table_size);
> +	return err;
> +}
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index d217366..ec030c9 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -22,6 +22,7 @@
>  #include <linux/sizes.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> +#include <linux/acpi.h>
>  
>  #ifdef CONFIG_FIX_EARLYCON_MEM
>  #include <asm/fixmap.h>
> @@ -206,11 +207,15 @@ static int __init param_setup_earlycon(char *buf)
>  	int err;
>  
>  	/*
> -	 * Just 'earlycon' is a valid param for devicetree earlycons;
> -	 * don't generate a warning from parse_early_params() in that case
> +	 * Just 'earlycon' is a valid param for devicetree and ACPI SPCR
> +	 * earlycons; don't generate a warning from parse_early_params()
> +	 * in that case
>  	 */
> -	if (!buf || !buf[0])
> -		return early_init_dt_scan_chosen_serial();
> +	if (!buf || !buf[0]) {
> +		init_spcr_earlycon();
> +		early_init_dt_scan_chosen_serial();
> +		return 0;
> +	}
>  
>  	err = setup_earlycon(buf);
>  	if (err == -ENOENT || err == -EALREADY)
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 06ed7e5..ebbb212 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1004,4 +1004,12 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
>  #define acpi_probe_device_table(t)	({ int __r = 0; __r;})
>  #endif
>  
> +#ifdef CONFIG_ACPI_SPCR_TABLE
> +int parse_spcr(void);
> +void init_spcr_earlycon(void);
> +#else
> +static inline  int parse_spcr(void) { return 0; }
> +static inline void init_spcr_earlycon(void) {}
> +#endif
> +
>  #endif	/*_LINUX_ACPI_H*/
> -- 
> 2.7.4
