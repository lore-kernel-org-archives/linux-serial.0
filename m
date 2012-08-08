From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [rtc-linux] [PATCH 8/8] ARM: vt8500: gpio: Devicetree support for arch-vt8500
Date: Wed, 8 Aug 2012 11:11:45 +0200
Message-ID: <CACRpkdbYxpN9RCu8j8KMBgrb=-DsYZHq7hx-ifmHhJ0ZZcRYjw@mail.gmail.com>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
	<1344389967-8465-9-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34911 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600Ab2HHJLq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Aug 2012 05:11:46 -0400
Received: by weyx8 with SMTP id x8so321944wey.19
        for <linux-serial@vger.kernel.org>; Wed, 08 Aug 2012 02:11:45 -0700 (PDT)
In-Reply-To: <1344389967-8465-9-git-send-email-linux@prisktech.co.nz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: vt8500-wm8505-linux-kernel@googlegroups.com, Tony Prisk <linux@prisktech.co.nz>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Alessandro Zummo <a.zummo@towertech.it>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Hauke Mehrtens <hauke@hauke-m.de>, Felipe Balbi <balbi@ti.com>, Neil Zhang <zhangwm@marvell.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Rob Landley <rob@landley.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, Eric Andersson <eric.andersson@unixphere.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@

On Wed, Aug 8, 2012 at 3:39 AM, Tony Prisk <linux@prisktech.co.nz> wrote:

> Converted the existing arch-vt8500 gpio to a platform_device.
> Added support for WM8505 and WM8650 GPIO controllers.
(...)
> +++ b/drivers/gpio/gpio-vt8500.c

This driver looks very one-bit-per-gpio typed. Are you sure you cannot
just reuse drivers/gpio/gpio-generic.c? Make a compelling case please...

> +struct vt8500_gpio_bank_regs {
> +       int     en;
> +       int     dir;
> +       int     data_out;
> +       int     data_in;

Why are all these members int? They should be u8 from reading your code.

> +       int     ngpio;
> +};


> +static struct vt8500_gpio_data vt8500_data = {
> +       .num_banks      = 7,
> +       .banks  = {
> +               VT8500_BANK(0x00, 0x20, 0x40, 0x60, 26),
> +               VT8500_BANK(0x04, 0x24, 0x44, 0x64, 28),
> +               VT8500_BANK(0x08, 0x28, 0x48, 0x68, 31),
> +               VT8500_BANK(0x0C, 0x2C, 0x4C, 0x6C, 19),
> +               VT8500_BANK(0x10, 0x30, 0x50, 0x70, 19),
> +               VT8500_BANK(0x14, 0x34, 0x54, 0x74, 23),
> +               VT8500_BANK(-1, 0x3C, 0x5C, 0x7C, 9),    /* external gpio */

What on earth are all those magic numbers?

I *guess* they're enabling some default GPIO settings etc.

But it really needs better structure, #defines for each one or
atleast include <linux/bitops.h> and say:

= BIT(4) | /* Enable GPIO pin 5 on this bank */
   BIT(5); /* Enable GPIO pin 6 on this bank */

However I suspect this is board specific and should
be taken from device tree. Please elaborate on this...

Ditto for the different instances.

(...)
> +       unsigned val;

Looks like all of these should be u8.

> +       val = readl(vt8500_chip->base + vt8500_chip->regs->en +
> +                                                       vt8500_chip->regoff);

val = (u8) readl(...);

usw

> +       val |= (1 << offset);

Use <linux/bitops.h>

val |= BIT(offset);

Apart from these remarks it's looking good...

Yours,
Linus Walleij
