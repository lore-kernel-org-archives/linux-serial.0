From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] serial: 8250_uniphier: add UniPhier serial driver
Date: Mon, 18 May 2015 10:43:15 +0200
Message-ID: <CABuKBe+goF4OFWUeeJ_okUL9ys0RO7HwHW3jg938a1xKoY9azA@mail.gmail.com>
References: <1431920711-1953-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431920711-1953-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, John Crispin <blogic@openwrt.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-serial@vger.kernel.org

2015-05-18 5:45 GMT+02:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Add the driver for on-chip UART used on UniPhier SoCs.
>
> This hardware is similar to 8250 with a slightly different register
> mapping, so it should go into drivers/tty/serial/8250 directory.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Drop unnecessary #include <linux/init.h>
>   - Sort includes in alphabetical order
>   - Use devm_clk_get() rather than of_clk_get()
>   - Delete unneeded clk_put() from uniphier_uart_remove callback
>   - Delete unneeded IS_ERR_OR_NULL check from uniphier_uart_remove callback
>   - Use UNIPHIER_UART_*_SHIFT instead of hard-coded shift values
>   - Change the first argument type of uniphier_of_serial_setup()
>     from (struct platform_device *) to (struct device *) for code-cleanup.
>
>  drivers/tty/serial/8250/8250_uniphier.c | 247 ++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig         |   7 +
>  drivers/tty/serial/8250/Makefile        |   1 +
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_uniphier.c
>
> diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
> new file mode 100644
> index 0000000..aabb64b
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_uniphier.c
> @@ -0,0 +1,247 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial_8250.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include "8250.h"
> +
> +/* Most (but not all) of UniPhier UART devices have 64-depth FIFO. */
> +#define UNIPHIER_UART_DEFAULT_FIFO_SIZE        64
> +
> +#define UNIPHIER_UART_CHAR_FCR 3
> +#define     UNIPHIER_UART_CHAR_SHIFT   8       /* Character Register */

Do you use this define? If not, please delete it.

> +#define     UNIPHIER_UART_FCR_SHIFT    0       /* FIFO Control Register */
> +#define UNIPHIER_UART_LCR_MCR  4
> +#define     UNIPHIER_UART_LCR_SHIFT    8       /* Line Control Register */
> +#define     UNIPHIER_UART_MCR_SHIFT    0       /* Modem Control Register */
> +#define UNIPHIER_UART_DLR      9               /* Divisor Latch Register */
> +
> +/*
> + * The register map is slightly different from that of 8250.
> + * IO callbacks must be overridden for correct access to FCR, LCR, and MCR.
> + */
> +static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
> +{
> +       int valshift = 0;
> +
> +       switch (offset) {
> +       case UART_LCR:
> +               offset = UNIPHIER_UART_LCR_MCR;
> +               valshift = UNIPHIER_UART_LCR_SHIFT;
> +               break;
> +       case UART_MCR:
> +               offset = UNIPHIER_UART_LCR_MCR;
> +               valshift = UNIPHIER_UART_MCR_SHIFT;


Sorry for insisting on this, but please just add defines for the special case.
Don't add defines for valshift which does not shift nothing. To me it
makes the code less clear.


> +               break;
> +       default:
> +               break;
> +       }
> +
> +       offset <<= p->regshift;
> +
> +       /*
> +        * The return value must be masked with 0xff because LCR and MCR reside
> +        * in the same register that must be accessed by 32-bit write/read.
> +        * 8 or 16 bit access to this hardware result in unexpected behavior.
> +        */
> +       return (readl(p->membase + offset) >> valshift) & 0xff;
> +}
> +
> +static void uniphier_serial_out(struct uart_port *p, int offset, int value)
> +{
> +       int valshift = 0;
> +       bool normal = false;
> +
> +       switch (offset) {
> +       case UART_FCR:
> +               offset = UNIPHIER_UART_CHAR_FCR;
> +               valshift = UNIPHIER_UART_FCR_SHIFT;
> +               break;
> +       case UART_LCR:
> +               offset = UNIPHIER_UART_LCR_MCR;
> +               valshift = UNIPHIER_UART_LCR_SHIFT;
> +               /* Divisor latch access bit does not exist. */
> +               value &= ~(UART_LCR_DLAB << valshift);
> +               break;
> +       case UART_MCR:
> +               offset = UNIPHIER_UART_LCR_MCR;
> +               valshift = UNIPHIER_UART_MCR_SHIFT;

Same here.
Apart from that the driver looks good to me.

Cheers,
Matthias

-- 
motzblog.wordpress.com
