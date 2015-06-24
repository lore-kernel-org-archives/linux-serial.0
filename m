From: Paul Osmialowski <pawelo@king.net.pl>
Subject: Re: [PATCH 7/9] arm: twr-k70f120m: IOMUX driver for Kinetis SoC
Date: Wed, 24 Jun 2015 19:44:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506241944060.32459@localhost.localdomain>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl>  <1435094387-20146-8-git-send-email-pawelo@king.net.pl> <1435141282.4528.71.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435141282.4528.71.camel@tiscali.nl>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Paul Osmialowski <pawelo@king.net.pl>, Andrew Morton <akpm@linux-foundation.org>, Anson Huang <b20788@freescale.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frank Li <Frank.Li@freescale.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingchang Lu <jingchang.lu@freescale.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, Kumar Gala <galak@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm+renesas@opensource.se>, Michael Turquette <mturquette@baylibre.com>, Nathan
List-Id: linux-serial@vger.kernel.org

Hi Paul,

Thanks for your comments. I'll make it tristate.

On Wed, 24 Jun 2015, Paul Bolle wrote:

> On Tue, 2015-06-23 at 23:19 +0200, Paul Osmialowski wrote:
>> --- a/drivers/pinctrl/freescale/Kconfig
>> +++ b/drivers/pinctrl/freescale/Kconfig
>
>> +config PINCTRL_KINETIS
>> +	bool "Kinetis pinctrl driver"
>> +	depends on OF
>> +	depends on SOC_K70
>> +	select PINMUX
>> +	help
>> +	  Say Y here to enable the Kinetis pinctrl driver
>
>> --- a/drivers/pinctrl/freescale/Makefile
>> +++ b/drivers/pinctrl/freescale/Makefile
>
>> +obj-$(CONFIG_PINCTRL_KINETIS)	+= pinctrl-kinetis.o
>
>> --- /dev/null
>> +++ b/drivers/pinctrl/freescale/pinctrl-kinetis.c
>
>> +#include <linux/module.h>
>
>> +static struct pinctrl_desc kinetis_pinctrl_desc = {
>> +	[...]
>> +	.owner = THIS_MODULE,
>> +};
>
>> +static void __exit kinetis_pinctrl_exit(void)
>> +{
>> +	platform_driver_unregister(&kinetis_pinctrl_driver);
>> +}
>> +module_exit(kinetis_pinctrl_exit);
>> +
>> +MODULE_DESCRIPTION("Freescale Kinetis pinctrl driver");
>> +MODULE_LICENSE("GPL v2");
>
> pinctrl-kinetis.o can only be built-in, right? But the code uses a few
> module specific constructs. Did you mean to make PINCTRL_KINETIS
> tristate instead?
>
> Thanks,
>
>
> Paul Bolle
>
