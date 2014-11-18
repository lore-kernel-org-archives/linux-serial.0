From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Tue, 18 Nov 2014 10:59:03 +0100
Message-ID: <546B1867.30308@elproma.com.pl>
References: <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl> <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl> <54695654.3070209@elproma.com.pl> <20141117082848.GZ27002@pengutronix.de> <546A29B9.5030104@elproma.com.pl> <546A2B69.4010409@elproma.com.pl> <20141117184229.GM27002@pengutronix.de> <546A465E.5080904@elproma.com.pl> <20141117222127.GN27002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20141117222127.GN27002@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Richard Genoud <richard.genoud@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Uwe,

W dniu 2014-11-17 o 23:21, Uwe Kleine-K=C3=B6nig pisze:
> Hello Janusz,
>
> On Mon, Nov 17, 2014 at 08:02:54PM +0100, Janusz U=C5=BCycki wrote:
>> W dniu 2014-11-17 o 19:42, Uwe Kleine-K=C3=B6nig pisze:
>>> On Mon, Nov 17, 2014 at 06:07:53PM +0100, Janusz U=C5=BCycki wrote:
>>>>> It looks there could be one more helper useful.
>>>>> Both atmel_serial.c and mxs-auart.c checks if the line is
>>>>> supported by mctrl_gpio.
>>>>> One time it is eg.:
>>>>> (s->gpio_irq[UART_GPIO_DCD] > 0)
>>>>> another time it is eg.:
>>>>> IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_RTS))
>>>>>
>>>>> The first one is no possible now. The second seems rude.
>>>>> bool mctrl_gpio_is_gpio((struct mctrl_gpios *gpios, enum
>>>>> mctrl_gpio_idx gidx);
>>>>> The name is hard. Moreover the implementation could be very simil=
ar
>>>>> to mctrl_gpio_to_gpiod(). Any ideas?
>>>> The differences:
>>>> - faster
>>>> - not exported
>>>> - used mainly in uart's interrupt
>>>> - assumes that struct mctrl_gpios *gpios exists
>>> I wonder why you need it at all?!
>> If the line is not supported by gpio it could be supported by native
>> uart's hardware
>> if possible. There are different configurations. One port has the
>> lines, other
>> which uses the same driver doesn't have.
>> Let's look at disable/enable_ms() in atmet_serial.c.
>> In mxs-auart DMA is not used if CTS or RTS is gpio line (timming).
> For the atmel driver I would expect that it doesn't hurt to set
> ATMEL_US_CTSIC if CTS is realized using a gpio. But maybe I'm too
> optimistic here. So atmel_enable_ms could look as follows:
>
> 	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
>
> 	/*
> 	 * Interrupt should not be enabled twice
> 	 * ukl: is this check really needed?
> 	 */
> 	if (atmel_port->ms_irq_enabled)
> 		return;
>
> 	atmel_port->ms_irq_enabled =3D true;
>
> 	mctrl_gpio_enable_ms(...);
> 	UART_PUT_IER(port, ATMEL_US_CTSIC | ATMEL_US_DSRIC | ATMEL_US_RIIC |=
 ATMEL_US_DCDIC);

It is too optimistic I think. We shouldn't assume that internal lines=20
are biased if not selected by pinmux.
They should be but it is not ensured in most datasheets. Moreover today=
=20
time to market makes erratas longer
and too often not complete. Sadly but true.

best regards
Janusz
> Best regards
> Uwe
>

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
