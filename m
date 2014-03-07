From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v5 0/3] tty/serial: Add helpers to use GPIOs to control
 modem lines and implement atmel_serial.c
Date: Fri, 7 Mar 2014 09:37:36 +0100
Message-ID: <CACQ1gAhVAMXab6T_nQudPR9+CMy_Sv_JpeGNfY9Su+453yGf-A@mail.gmail.com>
References: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36289 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbaCGIh6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Mar 2014 03:37:58 -0500
Received: by mail-lb0-f175.google.com with SMTP id w7so2526817lbi.6
        for <linux-serial@vger.kernel.org>; Fri, 07 Mar 2014 00:37:56 -0800 (PST)
In-Reply-To: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <noreply.rgenoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-03-03 12:11 GMT+01:00 Richard Genoud <noreply.rgenoud@gmail.com>:
> The USART controller on sam9x5 chips (and also all AT91/SAMA5 chips
> but at91rm9200) are not capable of handling DTR/DSR/DCD/RI signal.
> Moreover, even if the controller can handle CTS/RTS, the dedicated
> CTS/RTS pins are already muxed for other peripherals (LCDC/EMAC/MMC).
>
> So this patchset adds the possibility to control those lines via GPIO,
> as it is done for RTS in the patch "switch atmel serial to use gpiolib"
>
> As it was suggested by Alexander Shiyan, I made that available for
> every board.
>
> Patch 1 implements the generic helpers to control modem lines via GPIO
> Patch 2 implements modem control lines in atmel_serial atmel_serial.
> Patch 3 implement the interrupts of CTS/DSR/DCD/RI.
>
> This is based on next-20140303 + [PATCH v3 5/7] ARM: at91: gpio: implement get_direction
> (It has been acked by Linus, but I don't think it has been applied in a tree yet)
>
> Tested on at91sam9g35, with a null modem cable between 2 serial ports,
> one with CTS/RTS controlled by the USART controller, the other via GPIO,
> full duplex transfers.
> Did some tests also with null modem cables on a PC, and with real modems.
>
> Updates from v4:
>         - patches "tty/serial: at91: remove unused open/close hooks" and
>         "tty/serial: at91: use dev_err instead of printk" have been picked
>         by Greg on tty tree.
>         - As Alexander pointed out, IS_ERR_OR_NULL() was replaced by a simple
>         check againts NULL in patch 1/3
>         - in path 1/3, a warning is produced instead of an error when we can't set
>         the direction of a GPIO.
>
> Updates from v3:
>         - add static keyword on struct uart0_gpios_table.
>         - add use an index at the mctrl_gpio_init() function to make it
>         usable by driver that allocates several ports at once.
>         - hide struct gpio_desc from users.
>         - patch "pinctrl: at91: implement get_direction" has been picked by Linus.
>         - patch "ARM: at91: gpio: implement get_direction" has been acked by Linus.
>
> Updates from v2:
>         - remove UART_GPIO_MIN/UART_GPIO_MAX_INPUT and use a direction
>         boolean instead.
>         - implement get_direction in at91 pinctrl and mach-at91/gpio.c.
>         - remove the get_mctrl_gpio_name() function that was used for
>         logs only.
>         - split atmel_serial.c patch in 2.
>         - use a gpio lookup table to declare modem gpios in platform
>         devices boards. So there's no more special case for platform
>         data gpios in atmel_serial.c.
>
> Updates from v1:
>         - Instead of controlling modem signal only on atmel board, the
>         code is now available for every board.
>         - The active low flag from device tree is now used.

I'll send a v6 with (last) corrections next week.
