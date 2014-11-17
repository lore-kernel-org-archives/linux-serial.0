From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 09:31:21 +0100
Message-ID: <CACQ1gAjjQuiThoTP9D3igmrZyCDpyH7iWCnP5T29K4b-n4FXVg@mail.gmail.com>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl> <20141116214239.GX27002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20141116214239.GX27002@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi all,

2014-11-16 22:42 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengu=
tronix.de>:
> Hello Janusz,
>
> On Sat, Nov 15, 2014 at 08:29:04PM +0100, Janusz U=C5=BCycki wrote:
>> W dniu 2014-11-15 o 00:26, Uwe Kleine-K=C3=B6nig pisze:
>> >Hello,
>> >
>> >On Fri, Nov 14, 2014 at 11:27:06PM +0100, Janusz Uzycki wrote:
>> >>Function gpiod_get_direction() of gpiolib calls get_direction()
>> >>callback. If chip doesn't implement it EINVAL error is returned.
>> >>The function doesn't use for returned value shadowed FLAG_IS_OUT
>> >>bit of gpio_desc.flags field so the callback is required.
>> >This sounds like a bugfix but "required" is wrong as AFAIR this cal=
l is
>> >optional and hardly used. Or did that change? The only drawback is =
that
>> >the debug output for (by Linux) uninitialized gpios is wrong.
>>
>> Yes, the callback is optional but gpiod_get_direction() doesn't work
>> without it.
>> gpiod_get_direction() doesn't seem optional,
>> Documentation/gpio/consumer.txt:
>> "A driver can also query the current direction of a GPIO:
>>          int gpiod_get_direction(const struct gpio_desc *desc)
>> This function will return either GPIOF_DIR_IN or GPIOF_DIR_OUT.
>> Be aware that there is no default direction for GPIOs. Therefore,
>> **using a GPIO
>> without setting its direction first is illegal and will result in un=
defined
>> behavior!**"
>> There is nothing about EINVAL error. It happens despite direction wa=
s
>> set before. The reason is undefined get_direction callback.
> I still think you must not rely on gpiod_get_direction working. Some
> controllers might not be able to provide this info and if you know th=
at
> the direction was set before, there is no need to ask the framework.
> (Although I admit it might be comfortable at times.)
>
>> The commit f9e42397d79b6e810437ba1130b0b4b594f5e56c
>> ("serial: mxs-auart: add interrupts for modem control lines")
>> is based on Richard's commit ab5e4e4108ca5d8326cb6b4b3a21b096a002f68=
f
>> ("tty/serial: at91: add interrupts for modem control lines").
>> Both patches use the condition:
>> "if (gpiod && (gpiod_get_direction(gpiod) =3D=3D GPIOF_DIR_IN))"
> This is broken. Actually you want to loop only over the functions in
> mctrl_gpios_desc that are inputs (i.e. CTS, DSR, DCD and RNG) and don=
't
> depend on the hardware state and/or a working gpiod_get_direction.
Yes, it seemed a convenient test to locate inputs in atmel_serial's
probe function.
But you're right, looping on a
enum mctrl_gpio_idx [] =3D {
        UART_GPIO_CTS, UART_GPIO_DSR,
        UART_GPIO_DCD, UART_GPIO_RNG, UART_GPIO_RI
};
Would better describe what is done, without using gpiod_get_direction()=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
