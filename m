From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 3/5] ACPI: parse SPCR and enable matching console
Date: Sat, 26 Mar 2016 01:01:14 +0100
Message-ID: <2160795.F46RpZK5Xk@vostro.rjw.lan>
References: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org> <1458823925-19560-4-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1458823925-19560-4-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Thursday, March 24, 2016 03:52:01 PM Aleksey Makarov wrote:
> 'ARM Server Base Boot Requiremets' [1] mentions SPCR (Serial Port
> Console Redirection Table) [2] as a mandatory ACPI table that
> specifies the configuration of serial console.
> 
> Defer initialization of DT earlycon until ACPI/DT decision is made.
> 
> If ACPI is enabled, parse the table, setup earlycon
> and enable the specified console.
> 
> If it is disabled, try to set up earlycon from DT.
> 
> Thanks to Peter Hurley for explaining how this should work.
> 
> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
> [2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  drivers/acpi/Kconfig          |   3 +
>  drivers/acpi/Makefile         |   1 +
>  drivers/acpi/spcr.c           | 125 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/earlycon.c |  11 +++-
>  include/linux/acpi.h          |   8 +++
>  5 files changed, 146 insertions(+), 2 deletions(-)
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
> index 0000000..31e667e
> --- /dev/null
> +++ b/drivers/acpi/spcr.c
> @@ -0,0 +1,125 @@
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
> +#include <linux/of_fdt.h>
> +
> +static bool earlycon_init_is_deferred __initdata;
> +
> +void __init defer_earlycon_init(void)
> +{
> +	earlycon_init_is_deferred = true;
> +}
> +
> +/**
> + * parse_spcr() - parse ACPI SPCR table and add preferred console
> + *
> + * For the architectures with support for ACPI, CONFIG_ACPI_SPCR_TABLE may be
> + * defined to parse ACPI SPCR table.  As a result of the parsing preferred
> + * console is registered.
> + *
> + * When CONFIG_ACPI_SPCR_TABLE is defined, this function should should be called
> + * from arch inintialization code as soon as the DT/ACPI decision is made.
> + *
> + * When CONFIG_ACPI_SPCR_TABLE is defined, "earlycon" without parameters in
> + * command line does not start DT earlycon immediately, instead it defers
> + * starting it until DT/ACPI decision is made.  If ACPI is enabled at that time,
> + * parse_spcr() parses the table, adds preferred console and sets up it as an
> + * earlycon.  If ACPI is disabled at that time, it tries to set up earlycon
> + * from DT.
> + */
> +int __init parse_spcr(void)
> +{
> +#define OPTS_LEN 64

I'm not sure if you need that symbol.

ISTR that sizeof(opts) will give you the size of the array (but maybe I'm
confusing this with something else).

> +	static char opts[OPTS_LEN];
> +	struct acpi_table_spcr *table;
> +	acpi_size table_size;
> +	acpi_status status;
> +	char *uart;
> +	char *iotype;
> +	int baud_rate;
> +	int err;
> +
> +	if (acpi_disabled)
> +		return earlycon_init_is_deferred ?
> +			early_init_dt_scan_chosen_stdout() : 0;

I would prefer this to be arranged differently, so a specific error value is
returned when ACPI is disabled and the the fallback to DT happens in the
caller (if it cares about DT, that is).

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

Why -EINVAL?

> +		pr_err("wrong table version\n");
> +		goto done;
> +	}
> +
> +	iotype = (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) ?

The parens are not necessary.

Thanks,
Rafael

