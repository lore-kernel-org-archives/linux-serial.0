Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFE8C43217
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 09:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABAB61B1E
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 09:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhKSJiv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhKSJiu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 04:38:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC1FC061574;
        Fri, 19 Nov 2021 01:35:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w1so40030555edd.10;
        Fri, 19 Nov 2021 01:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOEcdwHQ+PAvApwiKSd7BaF4YuOnM9kQOm5Gyj6Se2M=;
        b=ilJ1zBY+7DzVoqWAacyU1cSWIiYTdnwitojxRCr6cljaYXkqqBUHl4RYmrIC2P3MOu
         neZh9rOPgNpACSYD2rn7O8TUKQPvniOQpmXCQx94UnoVYOdrQHtmxOR+qFYjAxVzAiB4
         y4TgyT6EdcIvVGsqPSpxFIauMOuso8x3sbg9BHG22LwA+/b4BTKtoRiuT+5gJVXz8SMK
         UMb0swG6ezqN1WLqp/gA5q8/K62TZ/AnD5qcphWRRUw8ZsjXVXKprUclOx7elrnT7CTW
         cEFxmXPRdLQg6VBFFtItX4IgIv+opftYZS6PPzuqKo8z8sRDxVexnCrogYsrSvLZZX+I
         1Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOEcdwHQ+PAvApwiKSd7BaF4YuOnM9kQOm5Gyj6Se2M=;
        b=3gOLkMPnv70X+gKm+XKkiWkEP91Yqh7hEaO6CAlrKZklqmLo4/si/NosyyeaRyo7+B
         4f/UEb/YOcUmEc625l+irBQrhkeuBfNPEZjVvn2YKtAGtte0epOGdnplodVbCQwupeaj
         jsONNDfv6ZjCRP47/X1iAd2NnmCFrOytHApqJDvh0ZVZ20guy/3mDyGW0yjWQeeELDJL
         I633SdepCWmDjKSB7li40I7csBQCDUMZ5uaX0XaRVZ59nYppdbDVEtLJwUe0OYRqt8l2
         3QW7VkOYo6aBlfbKH1furAzfeFTN3MpouZuMeJQQE9eJ6STt6bp/B28aD23aFeXqP8fe
         lzfQ==
X-Gm-Message-State: AOAM530dI2uph6xzLmcDlSp4/0F/NozWLy414nVuCe65ibWlVlF0lHoE
        ql6wdeVmrCyFqTAa9HuYvjuaaDKhsi7VpQQqc/d/8uIwn9QAEw==
X-Google-Smtp-Source: ABdhPJyxpAbx/RyimD//CMRG/BJQqxwyuy9Nif6bBCwRwl48SNSgHXgAmydib4HaXDI40qsRdW93VGsNiklCa2+qYJo=
X-Received: by 2002:a05:6402:2067:: with SMTP id bd7mr22193403edb.240.1637314547181;
 Fri, 19 Nov 2021 01:35:47 -0800 (PST)
MIME-Version: 1.0
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
 <1637299163-6460-1-git-send-email-hammer.hsieh@sunplus.com> <1637299163-6460-3-git-send-email-hammer.hsieh@sunplus.com>
In-Reply-To: <1637299163-6460-3-git-send-email-hammer.hsieh@sunplus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Nov 2021 11:35:07 +0200
Message-ID: <CAHp75Vca4r6uZm2Gdas+_Aj5pNgemKjZJj0U35A_g3_sbmCjSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, tony.huang@sunplus.com,
        wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 19, 2021 at 8:14 AM Hammer Hsieh <hammerh0314@gmail.com> wrote:
>
> Add Sunplus SoC UART Driver

Thanks for update, my comments below.

...

>  drivers/tty/serial/sunplus-uart.c | 903 ++++++++++++++++++++++++++++++++++++++

I believe 50 LOCs easily can be removed (see below for a few examples
I caught just by looking into this for less than 1 minute).

...

>  include/soc/sunplus/sp_uart.h     |  93 ++++

Why do you need this header?

...

> +config SERIAL_SUNPLUS
> +       bool "Sunplus UART support"

No module? Why?

> +       depends on OF

No COMPILE_TEST, why?

> +       select SERIAL_CORE
> +       help
> +         Select this option if you would like to use Sunplus serial port on
> +         Sunplus SoC SP7021.
> +         If you enable this option, Sunplus serial ports in the system will
> +         be registered as ttySx.

If it's ttySx, it most probably 8250 compatible, no?

...

> +/*
> + * Sunplus SoC UART driver
> + *
> + * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>
> + * Tony Huang <tony.huang@sunplus.com>
> + * Wells Lu <wells.lu@sunplus.com>

> + *

Redundant.

> + */

...

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/of_platform.h>
> +#include <asm/irq.h>
> +#include <linux/sysrq.h>
> +#include <linux/serial_core.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/delay.h>

Sort above alphabetically and get rid of unneeded headers.

> +#include <soc/sunplus/sp_uart.h>

...

> +#define UART_NR                        5

We have this as a config option, why do you need a separate one?

...

> +static struct uart_driver sunplus_uart_driver;

Why global variables?

...
> +struct sunplus_uart_port {
> +       char name[16];

uart_port has a name, what is this one for?

> +       struct uart_port port;

It's better to make it first in the structure to optimize container_of() away.

> +       struct clk *clk;
> +       struct reset_control *rstc;
> +};

...

> +static inline u32 sp_uart_line_status_tx_buf_not_full(struct uart_port *port)
> +{
> +       return ((readl(port->membase + SP_UART_LSR) & SP_UART_LSR_TX)
> +               ? SP_UART_LSR_TX_NOT_FULL : 0);

Use temporary variables for better reading. Here and everywhere else
where it's applicable.

> +}

...

> +       writel(mcr, port->membase + SP_UART_MCR);
> +

Redundant blank line. Check everywhere you have no such waste space.

...

> +static void sunplus_enable_ms(struct uart_port *port)
> +{
> +       /* Do nothing */
> +}

Is this stub needed at all?

...

> +
> +

One blank line is enough.

...

> +                               if (port->cons == NULL)

Don't we have a special API to check if the port is a console or not?

> +                                       dev_err(port->dev, "UART%d, SP_UART_LSR_FE\n", port->line);

...

> +#ifdef CONFIG_PM_RUNTIME_UART
> +       if (port->line > 0) {
> +               ret = pm_runtime_get_sync(port->dev);
> +               if (ret < 0)
> +                       goto out;
> +       }
> +#endif

Can we postpone implementation of it right now, please?
Can you test this [1] series instead?

[1]: https://lore.kernel.org/linux-serial/20211115084203.56478-1-tony@atomide.com/T/#u

...

> +       /* Disable flow control of Tx, so that queued data can be sent out
> +        * There is no way for s/w to let h/w abort in the middle of
> +        * transaction.
> +        * Don't reset module except it's in idle state. Otherwise, it might

the module unless
in an idle

> +        * cause bus to hang.
> +        */

...

> +       /*
> +        * Send all data in Tx FIFO before changing clock source,
> +        * it should be UART0 only
> +        */
> +       while (!(readl(port->membase + SP_UART_LSR) & SP_UART_LSR_TXE))
> +               ;

We do not allow busyloops in the kernel. Consider readl_poll_timeout()
or its atomic variant.

...

> +       clk += baud >> 1;
> +       div = clk / baud;
> +       ext = div & 0x0F;
> +       div = (div >> 4) - 1;
> +       div_l = (div & 0xFF) | (ext << 12);
> +       div_h = div >> 8;

Divisor voodoo should be explained in the comment.

...

> +static void sunplus_release_port(struct uart_port *port)
> +{
> +}
> +
> +static int sunplus_request_port(struct uart_port *port)
> +{
> +       return 0;
> +}

> +static int sunplus_verify_port(struct uart_port *port, struct serial_struct *serial)
> +{
> +       return -EINVAL;
> +}

Why the stubs?

...

> +static inline void wait_for_xmitr(struct uart_port *port)
> +{
> +       while (1) {
> +               if (sp_uart_line_status_tx_buf_not_full(port))
> +                       break;
> +       }

read_poll_timeout() or its atomic variant.

> +}

...

> +       if (pdev->dev.of_node) {

Redundant check

> +               pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
> +               if (pdev->id < 0)
> +                       pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
> +       }

> +

Redundant blank line.

> +       if (pdev->id < 0 || pdev->id >= UART_NR)
> +               return -EINVAL;

...

> +       sup = devm_kzalloc(&pdev->dev, sizeof(struct sunplus_uart_port),
> +                         GFP_KERNEL);

sizeof(*sup) and make it one line.

> +       if (!sup)
> +               return -ENOMEM;

...

> +       sup->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(sup->clk)) {
> +               dev_err(&pdev->dev, "unable to get UART clock\n");
> +               return PTR_ERR(sup->clk);

Respect deferred probe by

return dev_err_probe(...);

> +       }

...

> +       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);

> +       if (!res_mem)
> +               return -ENODEV;
> +

Redundant check, besides that...

> +       port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
> +       if (IS_ERR(port->membase))
> +               return PTR_ERR(port->membase);

...there is an API that does these two in one.

...

> +       port->uartclk = clk_get_rate(sup->clk);
> +       if (!port->uartclk) {
> +               ret = -EINVAL;

> +               goto err_disable_clk;

Instead use devm_add_action_or_reset() as many other drivers do in the kernel.

> +       }

...

> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return -ENODEV;

What's wrong with the error code in the irq variable?

...

> +       port->private_data = container_of(&sup->port,
> +               struct sunplus_uart_port, port);

What does this mean?

...

> +static const struct of_device_id sp_uart_of_match[] = {
> +       { .compatible = "sunplus,sp7021-uart" },

> +       {},

No comma for terminator entries.

> +};

...

> +static struct platform_driver sunplus_uart_platform_driver = {
> +       .probe          = sunplus_uart_probe,
> +       .remove         = sunplus_uart_remove,
> +       .suspend        = sunplus_uart_suspend,
> +       .resume         = sunplus_uart_resume,
> +       .driver = {
> +               .name   = "sunplus-uart",

> +               .owner  = THIS_MODULE,

This is done by registration call, no?

> +               .of_match_table = of_match_ptr(sp_uart_of_match),

Effectively a warning (but you don't see it since COMPILE_TEST is missed).
Hint: drop of_match_ptr() completely.

> +#ifdef CONFIG_PM_RUNTIME_UART
> +               .pm     = sunplus_uart_pm_ops,
> +#endif
> +       }
> +};

...

> +       ret = platform_driver_register(&sunplus_uart_platform_driver);

> +       if (ret != 0) {

Keep the same style over the driver.

> +               uart_unregister_driver(&sunplus_uart_driver);
> +               return ret;
> +       }

...

> +       for (;;) {
> +               status = readl(port->membase + SP_UART_LSR);
> +               if ((status & SP_UART_LSR_TXE) == SP_UART_LSR_TXE)
> +                       break;
> +               cpu_relax();
> +       }

real_poll_timeout*()

-- 
With Best Regards,
Andy Shevchenko
