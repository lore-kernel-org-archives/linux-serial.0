From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Sat, 15 Nov 2014 20:29:04 +0100
Message-ID: <5467A980.5090204@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl> <20141114232601.GW27002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20141114232601.GW27002@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Richard Genoud <richard.genoud@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Uwe,

W dniu 2014-11-15 o 00:26, Uwe Kleine-K=C3=B6nig pisze:
> Hello,
>
> On Fri, Nov 14, 2014 at 11:27:06PM +0100, Janusz Uzycki wrote:
>> Function gpiod_get_direction() of gpiolib calls get_direction()
>> callback. If chip doesn't implement it EINVAL error is returned.
>> The function doesn't use for returned value shadowed FLAG_IS_OUT
>> bit of gpio_desc.flags field so the callback is required.
> This sounds like a bugfix but "required" is wrong as AFAIR this call =
is
> optional and hardly used. Or did that change? The only drawback is th=
at
> the debug output for (by Linux) uninitialized gpios is wrong.

Yes, the callback is optional but gpiod_get_direction() doesn't work=20
without it.
gpiod_get_direction() doesn't seem optional,=20
Documentation/gpio/consumer.txt:
"A driver can also query the current direction of a GPIO:
          int gpiod_get_direction(const struct gpio_desc *desc)
This function will return either GPIOF_DIR_IN or GPIOF_DIR_OUT.
Be aware that there is no default direction for GPIOs. Therefore,=20
**using a GPIO
without setting its direction first is illegal and will result in undef=
ined
behavior!**"
There is nothing about EINVAL error. It happens despite direction was
set before. The reason is undefined get_direction callback.

The commit f9e42397d79b6e810437ba1130b0b4b594f5e56c
("serial: mxs-auart: add interrupts for modem control lines")
is based on Richard's commit ab5e4e4108ca5d8326cb6b4b3a21b096a002f68f
("tty/serial: at91: add interrupts for modem control lines").
Both patches use the condition:
"if (gpiod && (gpiod_get_direction(gpiod) =3D=3D GPIOF_DIR_IN))"

at91 had defined get_direction() callback, mxs platform not.
The condition helps to find gpio-inputs to set them as interrupts.

Likely gpiod_get_direction() was used because=20
drivers/tty/serial/serial_mctrl_gpio.c
has no function to read back "dir_out" from mctrl_gpios_desc table.

There were the ways to fix it:
a) add to serial_mctrl_gpio.c function to read the "dir_out" and use it=
=20
instead of
     gpiod_get_direction()
if gpiod_get_direction() still used in the condition:
b) modify gpiod_get_direction() implementation in gpiolib.c:
     if get_direction() callback is not defined use shadow flag=20
(FLAG_IS_OUT)
c) modify drivers/gpio/gpio-generic.c:
    bgpio_init() could assign to get_direction default callback
    if BGPIOF_UNREADABLE_REG_DIR is not set
d) implement get_direction callback in gpio-mxs.c

Solution d) was selected because it is safe for other drivers. Although=
=20
a) and b)
are also nice the patch doesn't modify neither serial_mctrl_gpio.c and
atmel_serial.c nor gpiolib.c. It focuses on mxs platform as needed for
the commit "serial: mxs-auart: add interrupts for modem control lines".

Maybe Richard will be interested in a).

> Also the grammar of you sentence isn't German enough to sound correct=
=2E
Right, I was tired, sorry.
What about the following description for the patch?

gpiolib's function gpiod_get_direction() returns the EINVAL error
if get_direction() callback is not defined.
The patch implements the callback for mxs chip as commit
f9e42397d79b ("serial: mxs-auart: add interrupts for modem control line=
s")
uses the gpiod_get_direction() function.

best regards
Janusz

>
> Best regards
> Uwe
>

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
