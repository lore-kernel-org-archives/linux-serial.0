From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 11:10:53 +0100
Message-ID: <CACQ1gAjCK68qB4iQhyAbfWErpbSC2z0B+SiOWChoqUNamDb-3A@mail.gmail.com>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
 <20141117095909.GH27002@pengutronix.de> <1416218753.520525851@f237.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1416218753.520525851@f237.i.mail.ru>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, fabio.estevam@freescale.com, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2014-11-17 11:05 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> Mon, 17 Nov 2014 10:59:09 +0100 =D0=BE=D1=82 Uwe Kleine-K=C3=B6nig <u=
=2Ekleine-koenig@pengutronix.de>:
>> Hello Richard,
>>
>> > >>>> So finally the prototypes would be:
>> > >>>> int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
>> > >>>> uart_port*, irqhandler_t);
>> > >>>> void mctrl_gpio_free_irqs(struct mctrl_gpios*);
>> > >>
>> > >> I think:
>> > >>
>> > >>         struct mctrl_gpios {
>> > >>                 struct uart_port *port;
>> > >>                 struct {
>> > >>                         gpio_desc *gpio;
>> > >>                         unsigned int irq;
>> > I think it's just "int irq;" there
>> irqs are unsigned. Some functions returning an irq use "int", but
>> depending on who you ask this only for error reporting or a relict.
>> Use 0 for invalid/unused in mctrl_gpio*.
>
> afaik, IRQ 0 is valid irq number.
Unfortunately, that's right. For instance on atmel processors, irq 0
is often used.
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
