From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 17:02:46 +0100
Message-ID: <20141117160246.GL27002@pengutronix.de>
References: <20141116214239.GX27002@pengutronix.de>
 <54693A51.5080907@elproma.com.pl>
 <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de>
 <5469BBBD.30003@elproma.com.pl>
 <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
 <20141117095909.GH27002@pengutronix.de>
 <CACQ1gAje6OA_n37jE_WnSqg4R+U5tr-bGnnfxpGM5NE9c=dAVg@mail.gmail.com>
 <20141117155300.GI27002@pengutronix.de>
 <546A1B17.4010600@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <546A1B17.4010600@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Richard Genoud <richard.genoud@gmail.com>, fabio.estevam@freescale.com, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello,

On Mon, Nov 17, 2014 at 04:58:15PM +0100, Janusz U=C5=BCycki wrote:
>=20
> W dniu 2014-11-17 o 16:53, Uwe Kleine-K=C3=B6nig pisze:
> >Hello,
> >
> >On Mon, Nov 17, 2014 at 11:05:51AM +0100, Richard Genoud wrote:
> >>2014-11-17 10:59 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@p=
engutronix.de>:
> >>>Hello Richard,
> >>>
> >>>>>>>>So finally the prototypes would be:
> >>>>>>>>int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
> >>>>>>>>uart_port*, irqhandler_t);
> >>>>>>>>void mctrl_gpio_free_irqs(struct mctrl_gpios*);
> >>>>>>I think:
> >>>>>>
> >>>>>>         struct mctrl_gpios {
> >>>>>>                 struct uart_port *port;
> >>>>>>                 struct {
> >>>>>>                         gpio_desc *gpio;
> >>>>>>                         unsigned int irq;
> >>>>I think it's just "int irq;" there
> >>>irqs are unsigned. Some functions returning an irq use "int", but
> >>>depending on who you ask this only for error reporting or a relict=
=2E
> >>>Use 0 for invalid/unused in mctrl_gpio*.
> >>>
> >>>>>Yes. I tried to assign irq value in mctrl_gpio_init() only.
> >>>>>There was another issue if CONFIG_GPIOLIB is not defined but it =
looks mctrl_
> >>>>>disable/enable_ms()
> >>>>>and mctrl_ irq handler solve the problem.
> >>>>>
> >>>>>>   Not sure there is a corresponding request_irq variant for th=
at.
> >>>>>
> >>>>>What would you propose?
> >>>>In atmel_request_gpio_irq(), the function irq_set_status_flags(ir=
q,
> >>>>IRQ_NOAUTOEN); is used before request_irq to prevent the irq from
> >>>>being enabled when requested.
> >>>I'm not sure this is allowed. How do you handle request_irq failin=
g? (I
> >>>just checked: you don't.) Consider another thread just doing
> >>>request_irq($yourirq, ...) between
> >>>
> >>>         irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
> >>>
> >>>and
> >>>
> >>>         err =3D request_irq(irq[i], ...
> >>well, in this case, request_irq() will fail and all the previously
> >>requested irqs will be freed:
> >>     /*
> >>      * If something went wrong, rollback.
> >>      */
> >>     while (err && (--i >=3D 0))
> >>         if (irq[i] >=3D 0)
> >>             free_irq(irq[i], port);
> >Just in case you didn't notice: Your statement is right, but for the
> >other caller to request_irq there is something fishy. He gets
> >IRQ_NOAUTOEN without being able to notice ...
>=20
> Likely the gpio interrupts will never shared. We can say mctrl_gpio
> is the only owner
> of a gpio after a request.
Right. The important part of your sentence is: "after a request". So at
the time irq_set_status_flags(..., IRQ_NOAUTOEN) is called, you're not
yet owning it. At a minimum you must clear the flag in the error path.

I'd like to have a statement from Thomas here if this is considered OK.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
