From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 5/8] tty/serial: at91: add dtr control via gpio
Date: Mon, 10 Feb 2014 11:37:56 +0100
Message-ID: <52F8AC04.50103@atmel.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com> <1391785155-18525-6-git-send-email-richard.genoud@gmail.com> <1391786494.259974704@f81.i.mail.ru> <CACQ1gAjQi+g0=HcR9K0rBQxBUZ_cN783sCWx40P5Hec-BdRtVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:4599 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbaBJKiJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 05:38:09 -0500
In-Reply-To: <CACQ1gAjQi+g0=HcR9K0rBQxBUZ_cN783sCWx40P5Hec-BdRtVg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 10/02/2014 11:24, Richard Genoud :
> 2014-02-07 16:21 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
>> Hello.
>>
>> =D0=9F=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D0=B0,  7 =D1=84=D0=B5=D0=B2=D1=
=80=D0=B0=D0=BB=D1=8F 2014, 15:59 +01:00 =D0=BE=D1=82 Richard Genoud <r=
ichard.genoud@gmail.com>:
>>> On sam9x5, the USART controller doesn't handle DTR/DSR/DCD/RI signa=
ls,
>>> so we have to control them via GPIO.
>>>
>>> This patch permits to use a GPIO to control the DTR signal.
>>>
>>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>>> ---
>> ...
>>> +     if (gpio_is_valid(atmel_port->gpio.dtr)) {
>>> +             if (mctrl & TIOCM_DTR)
>>> +                     gpio_set_value(atmel_port->gpio.dtr, 0);
>>> +             else
>>> +                     gpio_set_value(atmel_port->gpio.dtr, 1);
>>> +     }
>>
>> So, if you use GPIO for such purpose (here and in the other patches)=
,
>> you should take and use GPIO active level from bindings.
>> It will make use of GPIO more flexible and deliver us from further s=
pecial
>> possible bindings to declare the active level.
> Yes, I could do that. I'll have to change the alreday merged RTS
> binding so that it gets it's active level from DTS, but I don't think
> it's a problem, since it's not already in mainline.
> Linus, Nicolas, what do you think ?

Yes I agree. It is not used yet, so the sooner we move to this
specification, the better.

>> Actually, it would be good to have a separate unit for mctrl GPIOs,
>> which could be used for other drivers.
> good idea, I can add them in serial_core.c

That would be great. Thanks Richard!

Bye,
--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
