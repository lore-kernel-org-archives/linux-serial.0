From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v2 1/4] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Wed, 12 Feb 2014 09:33:57 +0100
Message-ID: <CACQ1gAjM7n3Zs_XapmMuS83A+X_yde5+iJ9F28SCfOCGA7Bdmg@mail.gmail.com>
References: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
 <1392140715-15295-2-git-send-email-richard.genoud@gmail.com> <1392142986.607813065@f171.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:37044 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbaBLIeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Feb 2014 03:34:18 -0500
Received: by mail-lb0-f182.google.com with SMTP id w7so6723577lbi.41
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2014 00:34:17 -0800 (PST)
In-Reply-To: <1392142986.607813065@f171.i.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-02-11 19:23 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> Hello.
Hi !
>
> =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA, 11 =D1=84=D0=B5=D0=B2=D1=80=
=D0=B0=D0=BB=D1=8F 2014, 18:45 +01:00 =D0=BE=D1=82 Richard Genoud <rich=
ard.genoud@gmail.com>:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) =
via
>> GPIO.
>> This will be useful for many boards which have a serial controller t=
hat
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>
> OK, a few comments below.
>
> ...
>> +config SERIAL_MCTRL_GPIO
>> +     def_bool y
>> +     depends on GPIOLIB
>
> I suggest to move GPIOLIB dependency to serial_mctrl_gpio.h header, s=
o
> unit can be used with or without GPIOLIB, so Kconfig will look someth=
ing like this:
>
> config SERIAL_MCTRL_GPIO
>   tristate
>
> Then, you can select this option for particular UART:
> config SERIAL_ATMEL
>   ...
>   select SERIAL_MCTRL_GPIO
Yes, you're right, it seems better like that.

> ...
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> ...
>> +static const char *mctrl_gpio_of_names[UART_GPIO_MAX] =3D {
>> +     "cts", "dsr", "dcd", "ri", "rts", "dtr"
>> +};
>
> Make a combined array. This will use cycles for set/get operations.
>
> static struct {
>   const char *name;
>   unsigned int mctrl;
> } mctrl_gpios[] =3D {
>   { "cts", TIOCM_CTS, },
>   ...
> };
yes, good idea !

> ...
>> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
>> +{
>
> I'm not sure whether to make a non-DT support at all ...
I don't understand what you mean.
You would like another _init() function for non-DT board ?
Well, I thought that non DT board could handle their GPIO init (like I
did in atmel_serial.c for platform_data based boards), but still use
the mctrl_gpio_{get,set} functions.


>> +     enum mctrl_gpio_idx i;
>> +     int err =3D 0;
>> +     int ret =3D 0;
>> +
>> +     for (i =3D UART_GPIO_MIN; i < UART_GPIO_MAX; i++) {
>> +             gpios->gpio[i] =3D gpiod_get(dev, mctrl_gpio_of_names[=
i]);
>
> What a reason to using gpiod_xxx() ?
> Why we cannot use standart devm_gpio_request/get/set etc. ?
Ah ! I missed devm_gpiod_get()
I'll use it.

>
> In addition, I recommend create this patch as separate,
> because it will most likely still be comments later.
Well, I'd rather not separate this patch from at least "patch 4/4
tty/serial: at91: use mctrl_gpio helpers"
because if the patch 4/4 is merged before this one, the compilation
will fail, and git bisecting will be a pain.
Or there's another solution ?

> Thanks.

Thanks !
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
