From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] tty: serial: 8250_mtk: Add earlycon
Date: Fri, 26 Dec 2014 15:24:47 -0600
Message-ID: <CAL_JsqKp+1ZWPK4rB4_vxrx-dtNCy7Hc3S67uQ9VHdAby8erjg@mail.gmail.com>
References: <1418891601-53769-1-git-send-email-eddie.huang@mediatek.com> <1418891601-53769-2-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418891601-53769-2-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 18, 2014 at 2:33 AM, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> Mediatek UART has highspeed register, but 8250_early.c doesn't
> support this, so add earlycon in 8250_mtk.c

I don't see any highspeed register setup here. More generically,
aren't you just skipping any UART setup? That may be useful on other
platforms with 8250s, too. With the kernel command line version, you
could perhaps add a "noinit" flag. The DT case is harder, and I'm not
sure how we should handle that. We could perhaps add a
"stdout-path-initialized" flag to chosen.

>
> Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index de7aae5..65dd569 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -23,6 +23,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/serial_8250.h>
>  #include <linux/serial_reg.h>
> +#include <linux/console.h>
>
>  #include "8250.h"
>
> @@ -289,6 +290,38 @@ static struct platform_driver mtk8250_platform_driver = {
>  };
>  module_platform_driver(mtk8250_platform_driver);
>
> +#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
> +
> +static void __init mtk8250_serial_putc(struct uart_port *port, int c)
> +{
> +       while ((readl(port->membase + (UART_LSR << 2)) & BOTH_EMPTY) !=
> +               BOTH_EMPTY)
> +               ;
> +       writel(c, port->membase + (UART_TX << 2));
> +}
> +
> +static void __init early_mtk8250_write(struct console *console,
> +                                       const char *s, unsigned int count)

Is there a reason early_serial8250_write can't work for you other than
it is currently static?

Rob

> +{
> +       struct earlycon_device *dev = console->data;
> +
> +       uart_console_write(&dev->port, s, count, mtk8250_serial_putc);
> +}
> +
> +static int __init early_mtk8250_setup(struct earlycon_device *device,
> +                                       const char *options)
> +{
> +       if (!device->port.membase)
> +               return -ENODEV;
> +
> +       device->con->write = early_mtk8250_write;
> +
> +       return 0;
> +}
> +
> +EARLYCON_DECLARE(mtk8250, early_mtk8250_setup);
> +OF_EARLYCON_DECLARE(mtk8250, "mediatek,mt6577-uart", early_mtk8250_setup);
> +
>  MODULE_AUTHOR("Matthias Brugger");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Mediatek 8250 serial port driver");
> --
> 1.8.1.1.dirty
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
