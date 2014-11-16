From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 00:59:13 +0100
Message-ID: <54693A51.5080907@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl> <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl> <20141116214239.GX27002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20141116214239.GX27002@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Richard Genoud <richard.genoud@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


W dniu 2014-11-16 o 22:42, Uwe Kleine-K=C3=B6nig pisze:
> Hello Janusz,
>
> On Fri, Nov 14, 2014 at 11:27:06PM +0100, Janusz Uzycki wrote:
>>>> Function gpiod_get_direction() of gpiolib calls get_direction()
>>>> callback. If chip doesn't implement it EINVAL error is returned.
>>>> The function doesn't use for returned value shadowed FLAG_IS_OUT
>>>> bit of gpio_desc.flags field so the callback is required.
>>> This sounds like a bugfix but "required" is wrong as AFAIR this cal=
l is
>>> optional and hardly used. Or did that change? The only drawback is =
that
>>> the debug output for (by Linux) uninitialized gpios is wrong.
>> Yes, the callback is optional but gpiod_get_direction() doesn't work
>> without it.
>> gpiod_get_direction() doesn't seem optional,
>> Documentation/gpio/consumer.txt:
>> "A driver can also query the current direction of a GPIO:
>>           int gpiod_get_direction(const struct gpio_desc *desc)
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
>
> For that another mctrl_ helper function would be nice that does the
> required request_irqs for a given struct mctrl_gpios pointer. That wo=
uld
> be more valuable than adding the same boilerplate to another driver.
> Also note that there is nothing special required in the irq handler i=
n
> this case, just passing your struct uart_port is enough. That also ha=
s
> the nice side effect that not the complete driver's logic to dissect =
the
> irq reason is needed and so probably all drivers using that mctrl_gpi=
o
> stuff could be simplified.
>
> [...]
>
>> at91 had defined get_direction() callback, mxs platform not.
>> The condition helps to find gpio-inputs to set them as interrupts.
>>
>> Likely gpiod_get_direction() was used because
>> drivers/tty/serial/serial_mctrl_gpio.c
>> has no function to read back "dir_out" from mctrl_gpios_desc table.
>>
>> There were the ways to fix it:
>> a) add to serial_mctrl_gpio.c function to read the "dir_out" and use
>> it instead of
>>      gpiod_get_direction()
>> if gpiod_get_direction() still used in the condition:
>> b) modify gpiod_get_direction() implementation in gpiolib.c:
>>      if get_direction() callback is not defined use shadow flag
>> (FLAG_IS_OUT)
> That would be broken.
>
>> c) modify drivers/gpio/gpio-generic.c:
>>     bgpio_init() could assign to get_direction default callback
>>     if BGPIOF_UNREADABLE_REG_DIR is not set
> Not sure this would be correct. I pass the question to Linus.
>
>> d) implement get_direction callback in gpio-mxs.c
> My suggestion isn't included in your list and IMHO is the best.
>
>> Solution d) was selected because it is safe for other drivers.
> That's a poor argument. Sure, implementing a generic solution that is
> used on several platforms is not "safe" as you probably cannot test t=
hem
> all. But the result is better: More generic code, more people using i=
t
> and so find the bugs in it.
>
>> Although a) and b)
>> are also nice the patch doesn't modify neither serial_mctrl_gpio.c a=
nd
>> atmel_serial.c nor gpiolib.c. It focuses on mxs platform as needed f=
or
>> the commit "serial: mxs-auart: add interrupts for modem control line=
s".
> I wouldn't call a) nice because in the presence of my suggested solut=
ion
> there is no need for a driver to use this function. b) is broken and =
so
> cannot be nice.

Thanks Uwe. I fully agree with you.
a) was just a starter to your suggestion. My options were too=20
conservative - I just
wanted to avoid tests on hardware I don't have.
I don't understand why gpiod_get_direction() always requires the callba=
ck
and b) would be broken (I'm not so familiar with gpiolib) but I don't=20
need it now.

So, it looks we can drop the gpio-mxs patch, yes?
And, I or Richard should submit a patch for=20
mctrl_gpio/atmel_serial/mxs-auart
to introduce the irq helper, yes?

You wrote passing uart_port is enough. Argument "name" for request_irq(=
)=20
can be
recovered from dev_name(dev) or dev_driver_string(dev)  where dev =3D=20
port_uart->dev.
But irqhandler and mctrl_gpios must be passed to=20
mctrl_gpio_request_irqs() helper.
The gpio_irq table could be hidden and moved into struct mctrl_gpios. T=
hen
a second helper function is required: mctrl_gpio_free_irqs().
gpio_irq table initialized in mctrl_gpio_request_irqs().

So finally the prototypes would be:
int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct uart_port*,=20
irqhandler_t);
void mctrl_gpio_free_irqs(struct mctrl_gpios*);

Richard, what do you think about?

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
