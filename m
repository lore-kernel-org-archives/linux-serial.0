From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v5 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Tue, 4 Mar 2014 12:37:59 +0100
Message-ID: <CACQ1gAgURezr+Oqd6mX4D4K_C1LtmVh4a2fOnie0Xfj9sfYjQQ@mail.gmail.com>
References: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
 <1393845120-6340-2-git-send-email-richard.genoud@gmail.com> <1393846030.273217958@f113.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:61013 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757006AbaCDLiW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Mar 2014 06:38:22 -0500
Received: by mail-lb0-f175.google.com with SMTP id w7so5453500lbi.6
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2014 03:38:21 -0800 (PST)
In-Reply-To: <1393846030.273217958@f113.i.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Richard Genoud <noreply.rgenoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-03-03 12:27 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> Hello.
>
> =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA,  =
3 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2014, 12:11 +01:00 =D0=BE=D1=82 Richar=
d Genoud <noreply.rgenoud@gmail.com>:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) =
via
>> GPIO.
>> This will be useful for many boards which have a serial controller t=
hat
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ...
>> +struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned in=
t idx)
>> +{
>> +     struct mctrl_gpios *gpios;
>> +     enum mctrl_gpio_idx i;
>> +     int err;
>> +
>> +     gpios =3D devm_kzalloc(dev, sizeof(*gpios), GFP_KERNEL);
>> +     if (!gpios)
>> +             goto out;
>
> if (!gpios)
>   return ERR_PTR(-ENOMEM);
I think we are looping here...
If I returns a ERR_PTR(-ENOMEM), I'll have to change back all tests
from if (!gpios) to if (IS_ERR_OR_NULL(gpios))
So, I'll just return NULL here, and change the test in atmel_serial.c
(that was wrong anyway, as you pointed out)

>
>> +     for (i =3D 0; i < UART_GPIO_MAX; i++) {
>> +             gpios->gpio[i] =3D devm_gpiod_get_index(dev,
>> +                                                   mctrl_gpios_desc=
[i].name,
>> +                                                   idx);
>> +
>> +             /*
>> +              * The GPIOs are maybe not all filled,
>> +              * this is not an error.
>> +              */
>> +             if (IS_ERR_OR_NULL(gpios->gpio[i]))
>> +                     continue;
>> +
>> +             if (mctrl_gpios_desc[i].dir_out)
>> +                     err =3D gpiod_direction_output(gpios->gpio[i],=
 0);
>> +             else
>> +                     err =3D gpiod_direction_input(gpios->gpio[i]);
>> +             if (err) {
>> +                     dev_warn(dev, "Unable to set direction for %s =
GPIO",
>> +                              mctrl_gpios_desc[i].name);
>> +                     devm_gpiod_put(dev, gpios->gpio[i]);
>> +                     gpios->gpio[i] =3D NULL;
>> +             }
>> +     }
>> +
>> +out:
>> +     return gpios;
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_init);
>> +
>> +void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
>> +{
>> +     enum mctrl_gpio_idx i;
>> +
>> +     if (!gpios)
>> +             return;
>> +
>> +     for (i =3D 0; i < UART_GPIO_MAX; i++)
>> +             if (!IS_ERR_OR_NULL(gpios->gpio[i])) {
>> +                     devm_gpiod_put(dev, gpios->gpio[i]);
>> +                     gpios->gpio[i] =3D NULL;
>
> No need to NULL this variable. Instead, you should NULL
> "gpios" entirely at the end of this function.
that's right, setting to NULL here is now useless.

>> +             }
>> +     devm_kfree(dev, gpios);
>
> gpios =3D NULL;
> So this will indicate that its no more valid.
well, this won't help...
to do that, we'll have to pass a struct mctrl_gpios** instead of a
struct mctrl_gpios *

>> +}
> ...
>
> Thanks.
> ---

thanks !
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
