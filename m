From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 18:07:53 +0100
Message-ID: <546A2B69.4010409@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl> <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl> <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl> <54695654.3070209@elproma.com.pl> <20141117082848.GZ27002@pengutronix.de> <546A29B9.5030104@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <546A29B9.5030104@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Richard Genoud <richard.genoud@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


W dniu 2014-11-17 o 18:00, Janusz U=C5=BCycki pisze:
>
> W dniu 2014-11-17 o 09:28, Uwe Kleine-K=C3=B6nig pisze:
>> I think:
>>
>>     struct mctrl_gpios {
>>         struct uart_port *port;
>>         struct {
>>             gpio_desc *gpio;
>>             unsigned int irq;
>>         } mctrl_line[UART_GPIO_MAX];
>>     };
>>
>>     struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port,=20
>> unsigned int idx_if_needed);
>>     int mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
>>     int mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
>>     void mctrl_gpio_free(struct mctrl_gpios *gpios);
>
> It looks there could be one more helper useful.
> Both atmel_serial.c and mxs-auart.c checks if the line is supported b=
y=20
> mctrl_gpio.
> One time it is eg.:
> (s->gpio_irq[UART_GPIO_DCD] > 0)
> another time it is eg.:
> IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_RTS))
>
> The first one is no possible now. The second seems rude.
> bool mctrl_gpio_is_gpio((struct mctrl_gpios *gpios, enum=20
> mctrl_gpio_idx gidx);
> The name is hard. Moreover the implementation could be very similar
> to mctrl_gpio_to_gpiod(). Any ideas?

The differences:
- faster
- not exported
- used mainly in uart's interrupt
- assumes that struct mctrl_gpios *gpios exists

Just inline function?

best regards
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
