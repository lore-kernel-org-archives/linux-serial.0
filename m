From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 10:09:05 +0000
Message-ID: <20141117100905.GN4042@n2100.arm.linux.org.uk>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
 <20141117095909.GH27002@pengutronix.de>
 <1416218753.520525851@f237.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416218753.520525851@f237.i.mail.ru>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, fabio.estevam@freescale.com, Alexandre Courbot <gnurou@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 17, 2014 at 01:05:53PM +0300, Alexander Shiyan wrote:
> Mon, 17 Nov 2014 10:59:09 +0100 =D0=BE=D1=82 Uwe Kleine-K=C3=B6nig <u=
=2Ekleine-koenig@pengutronix.de>:
> > Hello Richard,
> >=20
> > > >>>> So finally the prototypes would be:
> > > >>>> int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
> > > >>>> uart_port*, irqhandler_t);
> > > >>>> void mctrl_gpio_free_irqs(struct mctrl_gpios*);
> > > >>
> > > >> I think:
> > > >>
> > > >>         struct mctrl_gpios {
> > > >>                 struct uart_port *port;
> > > >>                 struct {
> > > >>                         gpio_desc *gpio;
> > > >>                         unsigned int irq;
> > > I think it's just "int irq;" there
> > irqs are unsigned. Some functions returning an irq use "int", but
> > depending on who you ask this only for error reporting or a relict.
> > Use 0 for invalid/unused in mctrl_gpio*.
>=20
> afaik, IRQ 0 is valid irq number.

No.  IRQ0 is not a valid IRQ number, it's a historical mistake to think=
 it
is (and it is something which needs correcting.)

--=20
=46TTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
