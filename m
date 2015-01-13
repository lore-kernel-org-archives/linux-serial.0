From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [RFC PATCH v2 1/4] tty: serial_mctrl_gpio: Add irqs helpers for
 input lines
Date: Tue, 13 Jan 2015 15:33:47 +0100
Message-ID: <54B52CCB.3030100@elproma.com.pl>
References: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl> <CACQ1gAibCAwWavjhT8VW8WkjEq0qGobQ9qF=pNtHRu1WUaRigA@mail.gmail.com> <54B52304.1030008@elproma.com.pl> <CACQ1gAipk7mfGdg7fjoGvFaN+1hc8iOhW65i5bkr-avXmtB+8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACQ1gAipk7mfGdg7fjoGvFaN+1hc8iOhW65i5bkr-avXmtB+8g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>, fabio.estevam@freescale.com, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


W dniu 2015-01-13 o 15:30, Richard Genoud pisze:
> 2015-01-13 14:52 GMT+01:00 Janusz U=C5=BCycki <j.uzycki@elproma.com.p=
l>:
>> W dniu 2015-01-13 o 14:04, Richard Genoud pisze:
>>
>>> 2015-01-10 15:32 GMT+01:00 Janusz Uzycki <j.uzycki@elproma.com.pl>:
>>>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h
>>>> b/drivers/tty/serial/serial_mctrl_gpio.h
>>>> index 400ba04..13ba3f4 100644
>>>> --- a/drivers/tty/serial/serial_mctrl_gpio.h
>>>> +++ b/drivers/tty/serial/serial_mctrl_gpio.h
>>>> @@ -21,6 +21,7 @@
>>>>    #include <linux/err.h>
>>>>    #include <linux/device.h>
>>>>    #include <linux/gpio/consumer.h>
>>>> +#include <linux/serial_core.h>
>>>>
>>>>    enum mctrl_gpio_idx {
>>>>           UART_GPIO_CTS,
>>>> @@ -40,6 +41,13 @@ enum mctrl_gpio_idx {
>>>>     */
>>>>    struct mctrl_gpios;
>>>>
>>>> +/*
>>>> + * Return true if gidx is GPIO line, otherwise false.
>>>> + * It assumes that gpios is allocated and not NULL.
>>>> + */
>>>> +inline
>>>> +bool mctrl_gpio_is_gpio(struct mctrl_gpios *gpios, enum mctrl_gpi=
o_idx
>>>> gidx);
>>>> +
>>> This leads to a compile error :
>>>     CC      drivers/tty/serial/atmel_serial.o
>>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>>> drivers/tty/serial/atmel_serial.c: In function 'atmel_disable_ms.pa=
rt.22':
>>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed=
 in
>>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>>> available
>>> drivers/tty/serial/atmel_serial.c:536:25: error: called from here
>>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed=
 in
>>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>>> available
>>> drivers/tty/serial/atmel_serial.c:539:25: error: called from here
>>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed=
 in
>>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>>> available
>>> drivers/tty/serial/atmel_serial.c:542:25: error: called from here
>>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed=
 in
>>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>>> available
>>> drivers/tty/serial/atmel_serial.c:545:25: error: called from here
>>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>>> drivers/tty/serial/atmel_serial.c: In function 'atmel_enable_ms':
>>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed=
 in
>>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>>> available
>>> drivers/tty/serial/atmel_serial.c:503:25: error: called from here
>>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed=
 in
>>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>>> available
>>> drivers/tty/serial/atmel_serial.c:506:25: error: called from here
>>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed=
 in
>>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>>> available
>>> drivers/tty/serial/atmel_serial.c:509:25: error: called from here
>>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed=
 in
>>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>>> available
>>> drivers/tty/serial/atmel_serial.c:512:25: error: called from here
>>> make[3]: *** [drivers/tty/serial/atmel_serial.o] Error 1
>>> make[2]: *** [drivers/tty/serial] Error 2
>>> make[1]: *** [drivers/tty] Error 2
>>> make: *** [drivers] Error 2
>>
>> Do you compile atmel_serial as module? I compiled built-in and it wa=
s fine
>> for me.
>> So the function should be exported like mctrl_gpio_to_gpiod() I gues=
s.
>> An other reason can be you have CONFIG_GPIOLIB=3Dn ?
>> In fact, mctrl_gpio_is_gpio() should depend on CONFIG_GPIOLIB for em=
pty
>> body.
>>
> well, I'm also compiling it built-in (I even have config_module=3DN)

You have no CONFIG_GPIOLIB enabled and it is the bug in the patchset.
Thanks.
Janusz

> kernel is 3.19-rc3 with your patches ontop.
> I attached my .config (saved as a defconfig)
>
> arm-linux-gcc (GCC) 4.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
