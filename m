From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] serial: 8250_uniphier: add UniPhier serial driver
Date: Sat, 16 May 2015 00:28:43 +0200
Message-ID: <CAGhQ9VweeoE8WtBH_M1oJi106rXRThDRBGr0E6K5rMTtNRrzaQ@mail.gmail.com>
References: <1431692764-17576-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431692764-17576-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, John Crispin <blogic@openwrt.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 15 May 2015 at 14:26, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> Add the driver for on-chip UART used on UniPhier SoCs.
> The register map of this hardware is similar to that of 8250
> (but the address for FCR, LCR is different), so it should go
> into drivers/tty/serial/8250 directory.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/tty/serial/8250/8250_uniphier.c | 243 ++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig         |   7 +
>  drivers/tty/serial/8250/Makefile        |   1 +
>  3 files changed, 251 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_uniphier.c
>
> diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
> new file mode 100644
> index 0000000..f108d81
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_uniphier.c
> @@ -0,0 +1,243 @@
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
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_8250.h>

Please put the includes in alphabetic order.

Do you really need init.h?

> +#include "8250.h"
> +
> +/*
> + * Most (but not all) of UniPhier UART devices have 64-depth FIFO.
> + * Set this value if "fifo-size" property is missing from the device tree node.
> + */
> +#define UNIPHIER_UART_DEFAULT_FIFO_SIZE        64
> +
> +#define UNIPHIER_UART_CHAR_FCR 3       /* Character / FIFO Control Register */
> +#define UNIPHIER_UART_LCR_MCR  4       /* Line/Modem Control Register */
> +#define UNIPHIER_UART_DLR      9       /* Divisor Latch Register */
> +
> +/*
> + * The register map is slightly different from that of 8250.
> + * IO callbacks must be overridden for correct access to FCR, LCR, and MCR.
> + */

<snip>

> +static int uniphier_of_serial_setup(struct platform_device *pdev,
> +                                   struct uart_port *port,
> +                                   struct uniphier8250_priv *priv)
> +{
> +       int ret;
> +       u32 prop;
> +       struct device_node *np = pdev->dev.of_node;
> +
> +       ret = of_alias_get_id(np, "serial");
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to get alias id\n");
> +               return ret;
> +       }
> +       port->line = priv->line = ret;
> +
> +       /* Get clk rate through clk driver */
> +       priv->clk = of_clk_get(np, 0);
> +       if (IS_ERR(priv->clk)) {
> +               dev_err(&pdev->dev, "failed to get clock\n");
> +               return PTR_ERR(priv->clk);
> +       }

Use devm_clk_get() if possible.

> +
> +       ret = clk_prepare_enable(priv->clk);
> +       if (ret < 0)
> +               return ret;
> +
> +       port->uartclk = clk_get_rate(priv->clk);
> +
> +       /* Check for fifo size */
> +       if (of_property_read_u32(np, "fifo-size", &prop) == 0)
> +               port->fifosize = prop;
> +       else
> +               port->fifosize = UNIPHIER_UART_DEFAULT_FIFO_SIZE;
> +
> +       return 0;
> +}

<snip>

> +static int uniphier_uart_remove(struct platform_device *pdev)
> +{
> +       struct uniphier8250_priv *priv = platform_get_drvdata(pdev);
> +
> +       serial8250_unregister_port(priv->line);
> +       if (!IS_ERR_OR_NULL(priv->clk)) {
> +               clk_disable_unprepare(priv->clk);
> +               clk_put(priv->clk);
> +       }

If you use devm_clk_get() in uniphier_of_serial_setup() you only need
to call clk_disable_unprepare() here.

Calling clk_disable_unprepare() with NULL is allowed and you already
check for IS_ERR in your setup function.

> +       return 0;
> +}


regards,
Joachim Eastwood
