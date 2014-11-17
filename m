From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 10:17:06 +0000
Message-ID: <20141117101706.GO4042@n2100.arm.linux.org.uk>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
 <20141117095909.GH27002@pengutronix.de>
 <1416218753.520525851@f237.i.mail.ru>
 <CACQ1gAjCK68qB4iQhyAbfWErpbSC2z0B+SiOWChoqUNamDb-3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:42713 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751863AbaKQKRW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2014 05:17:22 -0500
Content-Disposition: inline
In-Reply-To: <CACQ1gAjCK68qB4iQhyAbfWErpbSC2z0B+SiOWChoqUNamDb-3A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>, fabio.estevam@freescale.com, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 17, 2014 at 11:10:53AM +0100, Richard Genoud wrote:
> 2014-11-17 11:05 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> > Mon, 17 Nov 2014 10:59:09 +0100 =D0=BE=D1=82 Uwe Kleine-K=C3=B6nig =
<u.kleine-koenig@pengutronix.de>:
> >> Hello Richard,
> >>
> >> > >>>> So finally the prototypes would be:
> >> > >>>> int mctrl_gpio_request_irqs(struct mctrl_gpios*, struct
> >> > >>>> uart_port*, irqhandler_t);
> >> > >>>> void mctrl_gpio_free_irqs(struct mctrl_gpios*);
> >> > >>
> >> > >> I think:
> >> > >>
> >> > >>         struct mctrl_gpios {
> >> > >>                 struct uart_port *port;
> >> > >>                 struct {
> >> > >>                         gpio_desc *gpio;
> >> > >>                         unsigned int irq;
> >> > I think it's just "int irq;" there
> >> irqs are unsigned. Some functions returning an irq use "int", but
> >> depending on who you ask this only for error reporting or a relict=
=2E
> >> Use 0 for invalid/unused in mctrl_gpio*.
> >
> > afaik, IRQ 0 is valid irq number.
> Unfortunately, that's right. For instance on atmel processors, irq 0
> is often used.

=2E.. which means Atmel SoCs need fixing not to use IRQ0 as a valid
interrupt.

--=20
=46TTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
