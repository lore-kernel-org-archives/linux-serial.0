From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/28] serial: earlycon: allow MEM32 I/O for DT earlycon
Date: Mon, 30 Nov 2015 16:52:53 -0600
Message-ID: <CAL_JsqJ3cZEbWT_Ycrb1euWJ05cN31wOYikbwKhZSEyFu2rkrA@mail.gmail.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com> <1448900513-20856-2-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448900513-20856-2-git-send-email-paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 30, 2015 at 10:21 AM, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:
> Read the reg-io-width property when earlycon is setup via device tree,
> and set the I/O type to UPIO_MEM32 when 4 is read. This behaviour
> matches that of the of_serial driver, and is needed for DT configured
> earlycon on the MIPS Boston board.
>
> Note that this is only possible when CONFIG_LIBFDT is enabled, but
> enabling it everywhere seems like overkill. Thus systems that need this
> functionality should select CONFIG_LIBFDT for themselves.

libfdt is enabled if you are booting from DT, so checking this
property should not add anything.

>
> Signed-off-by: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>
>  drivers/of/fdt.c              |  2 +-
>  drivers/tty/serial/Makefile   |  1 +
>  drivers/tty/serial/earlycon.c | 15 ++++++++++++++-
>  include/linux/serial_core.h   |  2 +-
>  4 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d243029..71c7f0d 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -833,7 +833,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
>                 if (addr == OF_BAD_ADDR)
>                         return -ENXIO;
>
> -               of_setup_earlycon(addr, match->data);
> +               of_setup_earlycon(fdt, offset, addr, match->data);
>                 return 0;
>         }
>         return -ENODEV;
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 5ab4111..1d290d6 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_SERIAL_21285) += 21285.o
>
>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
>  obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
> +CFLAGS_earlycon.o += -I$(srctree)/scripts/dtc/libfdt

This is no longer necessary.

>
>  # These Sparc drivers have to appear before others such as 8250
>  # which share ttySx minor node space.  Otherwise console device
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index f096360..2b936a7 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -17,6 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/libfdt.h>
>  #include <linux/serial_core.h>
>  #include <linux/sizes.h>
>  #include <linux/mod_devicetable.h>
> @@ -196,17 +197,29 @@ static int __init param_setup_earlycon(char *buf)
>  }
>  early_param("earlycon", param_setup_earlycon);
>
> -int __init of_setup_earlycon(unsigned long addr,
> +int __init of_setup_earlycon(const void *fdt, int offset, unsigned long addr,

I would add iotype as a parameter instead, and then...

>                              int (*setup)(struct earlycon_device *, const char *))
>  {
>         int err;
>         struct uart_port *port = &early_console_dev.port;
> +       const __be32 *prop;
>
>         port->iotype = UPIO_MEM;
>         port->mapbase = addr;
>         port->uartclk = BASE_BAUD * 16;
>         port->membase = earlycon_map(addr, SZ_4K);
>
> +       if (config_enabled(CONFIG_LIBFDT)) {
> +               prop = fdt_getprop(fdt, offset, "reg-io-width", NULL);
> +               if (prop) {
> +                       switch (be32_to_cpup(prop)) {
> +                       case 4:
> +                               port->iotype = UPIO_MEM32;
> +                               break;
> +                       }
> +               }

...move this parsing into fdt.c where we parse the address.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
