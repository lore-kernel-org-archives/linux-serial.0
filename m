From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v4 1/5] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Thu, 27 Feb 2014 09:43:28 +0100
Message-ID: <CACQ1gAhF805ZjPGenb7UWi6z4jMF+p2bW8Z63DfMtNuyB5BLkg@mail.gmail.com>
References: <1393431588-25977-1-git-send-email-richard.genoud@gmail.com>
 <1393431588-25977-2-git-send-email-richard.genoud@gmail.com> <1393432624.955150590@f282.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:58157 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbaB0Int convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Feb 2014 03:43:49 -0500
Received: by mail-lb0-f175.google.com with SMTP id w7so1440646lbi.20
        for <linux-serial@vger.kernel.org>; Thu, 27 Feb 2014 00:43:48 -0800 (PST)
In-Reply-To: <1393432624.955150590@f282.i.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-02-26 17:37 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> Hello Richard.
>
> =D0=A1=D1=80=D0=B5=D0=B4=D0=B0, 26 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=
=D1=8F 2014, 17:19 +01:00 =D0=BE=D1=82 Richard Genoud <richard.genoud@g=
mail.com>:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) =
via
>> GPIO.
>> This will be useful for many boards which have a serial controller t=
hat
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> Better, but I found few bugs... :)
> ...
>> +Modem control lines via GPIO
>> +----------------------------
>> +
>> +Some helpers are provided in order to set/get modem control lines v=
ia GPIO.
>> +
>> +mctrl_gpio_init(dev, idx):
>
> I think we should indicate variable types used in these functions.
In the whole file, the variable type are not indicated. So, for
consistency, I think it's better like that.

 ...
>> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
>> +{
>> +     enum mctrl_gpio_idx i;
>> +
>> +     if (IS_ERR_OR_NULL(gpios))
>> +             return;
>
> No. IS_ERR_OR_NULL() is not valid here. This is allocated by kzalloc(=
),
> so you should check valid pointer only, ie (!gpios).
> Same in other places.
You're right !

>
>> +             if (err) {
>> +                     dev_err(dev, "Unable to set direction for %s G=
PIO",
>> +                             mctrl_gpios_desc[i].name);
>> +                     devm_gpiod_put(dev, gpios->gpio[i]);
>> +                     gpios->gpio[i] =3D NULL;
>> +             }
>> +     }
>
> Let's use dev_dbg().
Why dbg ? I agree that _err may be a bit strong, we could use
dev_warn() instead.
But as it really should not happen, I'm a bit reluctant to set it as de=
bug.
Or have you something else in mind ?

> Thanks.
> ---

Thanks for reviewing !
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
