From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 10:46:03 +0100
Message-ID: <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl>
 <54695654.3070209@elproma.com.pl> <20141117082848.GZ27002@pengutronix.de> <5469BBBD.30003@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5469BBBD.30003@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2014-11-17 10:11 GMT+01:00 Janusz U=C5=BCycki <j.uzycki@elproma.com.pl>=
:
>
> W dniu 2014-11-17 o 09:28, Uwe Kleine-K=C3=B6nig pisze:
>>
>> Hello Janusz,
>>
>> On Mon, Nov 17, 2014 at 02:58:44AM +0100, Janusz U=C5=BCycki wrote:
>>>
>>> W dniu 2014-11-17 o 00:59, Janusz U=C5=BCycki pisze:
>>>>
>>>> W dniu 2014-11-16 o 22:42, Uwe Kleine-K=C3=B6nig pisze:
>>>> Thanks Uwe. I fully agree with you.
>>>> a) was just a starter to your suggestion. My options were too
>>>> conservative - I just
>>>> wanted to avoid tests on hardware I don't have.
>>
>> That's something you have to live with and that's why there is a mer=
ge
>> window.
>>
>>>> I don't understand why gpiod_get_direction() always requires the
>>>> callback
>>>> and b) would be broken (I'm not so familiar with gpiolib) but I
>>>> don't need it now.
>>>>
>>>> So, it looks we can drop the gpio-mxs patch, yes?
>>
>> That patch is not wrong, just its motivation. IMHO the only valid
>> usecase for .get_direction is debugging.
>
>
> OK, I will submit v2.
>
>>
>>>> And, I or Richard should submit a patch for
>>>> mctrl_gpio/atmel_serial/mxs-auart
>>>> to introduce the irq helper, yes?
>>>>
>>>> You wrote passing uart_port is enough. Argument "name" for
>>>> request_irq() can be
>>>> recovered from dev_name(dev) or dev_driver_string(dev)  where dev
>>>> =3D port_uart->dev.
>>>> But irqhandler and mctrl_gpios must be passed to
>>
>> You don't need irqhandler. struct mctrl_gpios is needed of course.
>
>
> request_irq() needs a irqhandler. Do you thing about a mctrl_ handler=
 for
> gpios?
>
>>
>>>> mctrl_gpio_request_irqs() helper.
>>>> The gpio_irq table could be hidden and moved into struct
>>>> mctrl_gpios. Then
>>>> a second helper function is required: mctrl_gpio_free_irqs().
>>
>> yes.
>>
>>> After some coding...
>>> gpio_irq cannot be hidden - it is used by disable/enable_ms() and
>>> not only :/
>>
>> mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
>
>
> This makes unable to combine gpio's and chip's lines but it could be
> advantage
> to separate them.
>
>>
>>>> gpio_irq table initialized in mctrl_gpio_request_irqs().
>>>
>>> or it could be nicely done in mctrl_gpio_init() but the problem is
>>> next argument
>>> for the function :/
>>> eg.:
>>> struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned in=
t
>>> idx, int *irqs)
>>
>> What is idx about? I see it already in the mctrl_gpio API, but there=
 is
>> no documentation about how it's used. Is it always 0?
>
>
> dt index
>
>> There is no need to pass an output parameter for irqs. Just save the=
m in
>> struct mctrl_gpios.
>>
>> I'd go and change all struct device * parameters of the mctrl_gpio A=
PI
>> to struct uart_port for consistency or add struct uart_port to struc=
t
>> mctrl_gpios.
>>
>>>> So finally the prototypes would be:
>>>> int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
>>>> uart_port*, irqhandler_t);
>>>> void mctrl_gpio_free_irqs(struct mctrl_gpios*);
>>
>> I think:
>>
>>         struct mctrl_gpios {
>>                 struct uart_port *port;
>>                 struct {
>>                         gpio_desc *gpio;
>>                         unsigned int irq;
I think it's just "int irq;" there
>>                 } mctrl_line[UART_GPIO_MAX];
>>         };
>
>
> Looks good. Richard, do you agree?
yes, seems ok too me !

>>         struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port,
>> unsigned int idx_if_needed);
>>         int mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
>>         int mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
>>         void mctrl_gpio_free(struct mctrl_gpios *gpios);
>>
>> I think mctrl_gpio_init should request the needed irqs, but not enab=
le
>> them.
>
>
> Yes. I tried to assign irq value in mctrl_gpio_init() only.
> There was another issue if CONFIG_GPIOLIB is not defined but it looks=
 mctrl_
> disable/enable_ms()
> and mctrl_ irq handler solve the problem.
>
>>   Not sure there is a corresponding request_irq variant for that.
>
>
> What would you propose?
In atmel_request_gpio_irq(), the function irq_set_status_flags(irq,
IRQ_NOAUTOEN); is used before request_irq to prevent the irq from
being enabled when requested.

>> Another open issue is how mctrl_gpio_init should find out about whic=
h
>> gpios to use if there is no device tree. This doesn't necessarily ne=
eds
>> to be solved now, but maybe rename mctrl_gpio_init to
>> mctrl_gpio_init_dt?
>
>
> Right
>
>
> best regards
> Janusz
>
>>
>> Best regards
>> Uwe
>>
>



--=20
for me, ck means con kolivas and not calvin klein... does it mean I'm a=
 geek ?
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
