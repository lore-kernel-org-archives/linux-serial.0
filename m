From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] serial: 8250_uniphier: add UniPhier serial driver
Date: Sat, 16 May 2015 11:17:31 +0200
Message-ID: <CABuKBeJnMcyH7TGtYcUToRhLnu_qcxHtwEedS2JgGjX8EiX1Gw@mail.gmail.com>
References: <1431692764-17576-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431692764-17576-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Crispin <blogic@openwrt.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2015-05-15 14:26 GMT+02:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
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
> +static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
> +{
> +       int valshift = 0;
> +
> +       switch (offset) {
> +       case UART_LCR:
> +               valshift = 8;

Please use a define for the value. Something like UNIPHIER_UART_LCR_SHIFT maybe.

Cheers,
Matthias



-- 
motzblog.wordpress.com
