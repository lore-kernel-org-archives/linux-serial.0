From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3] serial: 8250_uniphier: add UniPhier serial driver
Date: Sat, 23 May 2015 21:55:35 +0900
Message-ID: <CAK7LNARuczTPCwJ9gZMoUU3f7o++8vMnVuqeZyjFY1BAdmbgXw@mail.gmail.com>
References: <1431997900-18390-1-git-send-email-yamada.masahiro@socionext.com>
	<1432126581.28073.87.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432126581.28073.87.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joachim Eastwood <manabian@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, John Crispin <blogic@openwrt.org>, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

Thanks for reviewing my patch.


2015-05-20 21:56 GMT+09:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> On Tue, 2015-05-19 at 10:11 +0900, Masahiro Yamada wrote:
>> Add the driver for on-chip UART used on UniPhier SoCs.
>>
>> This hardware is similar to 8250 with a slightly different register
>> mapping, so it should go into drivers/tty/serial/8250 directory.
>
> Few comments below.
>
> First of all what is the differences with the original 8250? It worth to
> list them here in the changelog.
>

I noted this in the git-log


>> +
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/serial_8250.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/serial_reg.h>
>
> Shouldn't be enough to have only serial_8250.h here?
>
> + empty line between #include <> and "".


I did so in v4.




>> +static int uniphier_uart_probe(struct platform_device *pdev)
>> +{
>> +     struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>
> Please use platform_get_irq().

OK. Fixed.


>> +     struct device *dev = &pdev->dev;
>> +     struct uniphier8250_priv *priv;
>> +     struct uart_8250_port up;
>> +     int ret;
>> +     void __iomem *membase;
>> +
>> +     if (!regs || !irq) {
>> +             dev_err(dev, "missing registers or irq\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     membase = devm_ioremap(dev, regs->start, resource_size(regs));
>
> Shouldn't be devm_ioremap_resource() ?


I tried this, but it broke my driver.

It looks like the cause of error is in the devm_request_mem_region()
called from that function,


8250_core.c also calls request_mem_region().
I think it fails if the memory region is already reserved
before calling serial8250_register_8250_port().

So, I am sticking to devm_ioremap().


-- 
Best Regards
Masahiro Yamada
