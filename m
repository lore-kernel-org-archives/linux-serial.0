From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] serial: 8250_uniphier: add UniPhier serial driver
Date: Mon, 18 May 2015 12:23:29 +0900
Message-ID: <CAK7LNARrYGQ=O4wNU7OJCEgmwYx6Y0FkkHs661a4BzB9y5kHhg@mail.gmail.com>
References: <1431692764-17576-1-git-send-email-yamada.masahiro@socionext.com>
	<CAGhQ9VweeoE8WtBH_M1oJi106rXRThDRBGr0E6K5rMTtNRrzaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGhQ9VweeoE8WtBH_M1oJi106rXRThDRBGr0E6K5rMTtNRrzaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, John Crispin <blogic@openwrt.org>
List-Id: linux-serial@vger.kernel.org

Hi Joachim,




2015-05-16 7:28 GMT+09:00 Joachim  Eastwood <manabian@gmail.com>:

>> +
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/of.h>
>> +#include <linux/io.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/serial_reg.h>
>> +#include <linux/serial_8250.h>
>
> Please put the includes in alphabetic order.

OK.



> Do you really need init.h?

Not really.  Will remove it.


>> +static int uniphier_of_serial_setup(struct platform_device *pdev,
>> +                                   struct uart_port *port,
>> +                                   struct uniphier8250_priv *priv)
>> +{
>> +       int ret;
>> +       u32 prop;
>> +       struct device_node *np = pdev->dev.of_node;
>> +
>> +       ret = of_alias_get_id(np, "serial");
>> +       if (ret < 0) {
>> +               dev_err(&pdev->dev, "failed to get alias id\n");
>> +               return ret;
>> +       }
>> +       port->line = priv->line = ret;
>> +
>> +       /* Get clk rate through clk driver */
>> +       priv->clk = of_clk_get(np, 0);
>> +       if (IS_ERR(priv->clk)) {
>> +               dev_err(&pdev->dev, "failed to get clock\n");
>> +               return PTR_ERR(priv->clk);
>> +       }
>
> Use devm_clk_get() if possible.

Sure.



>
>> +static int uniphier_uart_remove(struct platform_device *pdev)
>> +{
>> +       struct uniphier8250_priv *priv = platform_get_drvdata(pdev);
>> +
>> +       serial8250_unregister_port(priv->line);
>> +       if (!IS_ERR_OR_NULL(priv->clk)) {
>> +               clk_disable_unprepare(priv->clk);
>> +               clk_put(priv->clk);
>> +       }
>
> If you use devm_clk_get() in uniphier_of_serial_setup() you only need
> to call clk_disable_unprepare() here.
>
> Calling clk_disable_unprepare() with NULL is allowed and you already
> check for IS_ERR in your setup function.



Yes.

Thank you for your review!



-- 
Best Regards
Masahiro Yamada
