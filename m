From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 3/6] ACPI: parse SPCR and enable matching console
Date: Tue, 22 Mar 2016 13:09:33 +0200
Message-ID: <CAHp75VfsayWWSgkvpgrxcER6c2rZyykbvOtm7wBQROR6SFFfWw@mail.gmail.com>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
	<1458643595-14719-4-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1458643595-14719-4-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 22, 2016 at 12:46 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
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
> +       init_earlycon = true;
> +}
> +
> +int __init parse_spcr(void)
> +{
> +       static char opts[64];
> +       struct acpi_table_spcr *table;
> +       acpi_size table_size;
> +       acpi_status status;
> +       char *uart;
> +       char *iotype;
> +       int baud_rate;
> +       int err = 0;
> +
> +       status = acpi_get_table_with_size(ACPI_SIG_SPCR, 0,
> +                                         (struct acpi_table_header **)&table,
> +                                         &table_size);
> +
> +       if (ACPI_FAILURE(status))
> +               return -ENOENT;
> +
> +       if (table->header.revision < 2) {
> +               err = -EINVAL;
> +               pr_err("wrong table version\n");
> +               goto done;
> +       }
> +
> +       iotype = (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) ?
> +                       "mmio" : "io";
> +
> +       switch (table->interface_type) {
> +       case ACPI_DBG2_ARM_SBSA_32BIT:
> +               iotype = "mmio32";
> +               /* fall through */
> +       case ACPI_DBG2_ARM_PL011:
> +       case ACPI_DBG2_ARM_SBSA_GENERIC:
> +       case ACPI_DBG2_BCM2835:
> +               uart = "pl011";
> +               break;
> +       case ACPI_DBG2_16550_COMPATIBLE:
> +       case ACPI_DBG2_16550_SUBSET:
> +               uart = "uart";
> +               break;
> +       default:
> +               err = -ENOENT;
> +               goto done;
> +       }
> +
> +       switch (table->baud_rate) {
> +       case 3:
> +               baud_rate = 9600;
> +               break;
> +       case 4:
> +               baud_rate = 19200;
> +               break;
> +       case 6:
> +               baud_rate = 57600;
> +               break;
> +       case 7:
> +               baud_rate = 115200;
> +               break;
> +       default:
> +               err = -ENOENT;
> +               goto done;
> +       }
> +
> +       sprintf(opts, "%s,%s,0x%llx,%d", uart, iotype,
> +               table->serial_port.address, baud_rate);

You may use snprintf(), though my question here what would happen on
32-bit kernel when you supply 64-bit address as an option?

> +
> +       pr_info("console: %s", opts);
> +
> +       if (init_earlycon)
> +               setup_earlycon(opts);
> +
> +       err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
> +
> +done:
> +       early_acpi_os_unmap_memory((void __iomem *)table, table_size);
> +       return err;
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
>         int err;
>
>         /*
> -        * Just 'earlycon' is a valid param for devicetree earlycons;
> -        * don't generate a warning from parse_early_params() in that case
> +        * Just 'earlycon' is a valid param for devicetree and ACPI SPCR
> +        * earlycons; don't generate a warning from parse_early_params()
> +        * in that case
>          */
> -       if (!buf || !buf[0])
> -               return early_init_dt_scan_chosen_serial();
> +       if (!buf || !buf[0]) {
> +               init_spcr_earlycon();

> +               early_init_dt_scan_chosen_serial();
> +               return 0;

And you hide an error?

> +       }
>
>         err = setup_earlycon(buf);
>         if (err == -ENOENT || err == -EALREADY)

-- 
With Best Regards,
Andy Shevchenko
