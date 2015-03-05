From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH -next 05/12] of: earlycon: Initialize port fields from DT properties
Date: Thu, 5 Mar 2015 10:16:43 -0600
Message-ID: <CAL_JsqKD2+_MvJO83Jgr3YTqxnPym=WL6BT-AzUauYkQEoXZ2A@mail.gmail.com>
References: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com> <1425489871-22415-6-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425489871-22415-6-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 4, 2015 at 11:24 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Read the optional "reg-offset", "reg-shift" and "reg-io-width" properties
> and initialize the respective struct uart_port field if found.
>
> NB: These bindings are common to several drivers and the values merely
> indicate the default value; the registering earlycon setup() method can
> simply override the values if required.
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/fdt.c              |  2 +-
>  drivers/tty/serial/earlycon.c | 27 +++++++++++++++++++++++++++
>  include/linux/serial_core.h   |  1 +
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bdb74a8..a732890 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -802,7 +802,7 @@ int __init early_init_dt_scan_chosen_serial(void)
>                 if (!addr)
>                         return -ENXIO;
>
> -               of_setup_earlycon(addr, match, options);
> +               of_setup_earlycon(addr, match, offset, options);
>                 return 0;
>         }
>         return -ENODEV;
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 436ac88..019010f 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -21,6 +21,10 @@
>  #include <linux/sizes.h>
>  #include <linux/mod_devicetable.h>
>
> +#ifdef CONFIG_OF_EARLY_FLATTREE
> +#include <linux/of_fdt.h>
> +#endif
> +
>  #ifdef CONFIG_FIX_EARLYCON_MEM
>  #include <asm/fixmap.h>
>  #endif
> @@ -219,17 +223,40 @@ early_param("earlycon", param_setup_earlycon);
>
>  int __init of_setup_earlycon(unsigned long addr,
>                              const struct of_device_id *match,
> +                            unsigned long node,
>                              const char *options)
>  {
>         int err;
>         struct uart_port *port = &early_console_dev.port;
>         int (*setup)(struct earlycon_device *, const char *) = match->data;
> +       const __be32 *val;
>
>         port->iotype = UPIO_MEM;
>         port->mapbase = addr;
>         port->uartclk = BASE_BAUD * 16;
>         port->membase = earlycon_map(addr, SZ_4K);
>
> +       val = of_get_flat_dt_prop(node, "reg-offset", NULL);
> +       if (val)
> +               port->mapbase += be32_to_cpu(*val);
> +       val = of_get_flat_dt_prop(node, "reg-shift", NULL);
> +       if (val)
> +               port->regshift = be32_to_cpu(*val);
> +       val = of_get_flat_dt_prop(node, "reg-io-width", NULL);
> +       if (val) {
> +               switch (be32_to_cpu(*val)) {
> +               case 1:
> +                       port->iotype = UPIO_MEM;
> +                       break;
> +               case 4:
> +                       port->iotype = UPIO_MEM32;
> +                       break;
> +               default:
> +                       pr_warn("[%s] unsupported reg-io-width\n", match->name);
> +                       return -EINVAL;
> +               }
> +       }
> +
>         if (options) {
>                 strlcpy(early_console_dev.options, options,
>                         sizeof(early_console_dev.options));
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index ebbcd43..c8e4e8f 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -347,6 +347,7 @@ struct earlycon_id {
>  extern int setup_earlycon(char *buf);
>  extern int of_setup_earlycon(unsigned long addr,
>                              const struct of_device_id *match,
> +                            unsigned long node,
>                              const char *options);
>
>  #define EARLYCON_DECLARE(_name, func)                                  \
> --
> 2.3.1
>
