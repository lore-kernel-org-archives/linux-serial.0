From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: request an irq without enabling? [Was: Re: [PATCH] gpio: mxs:
 implement get_direction callback]
Date: Mon, 17 Nov 2014 10:57:03 +0100
Message-ID: <CACQ1gAh0ZieaqCd5ZOs4WbPso0P_kNnodLNYZZy6Q2Ac+KR0qQ@mail.gmail.com>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl>
 <54695654.3070209@elproma.com.pl> <20141117082848.GZ27002@pengutronix.de>
 <5469BBBD.30003@elproma.com.pl> <20141117095154.GG27002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:37371 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaKQJ50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2014 04:57:26 -0500
In-Reply-To: <20141117095154.GG27002@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>, Thomas Gleixner <tglx@linutronix.de>, fabio.estevam@freescale.com, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-11-17 10:51 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengu=
tronix.de>:
> Hello,
>
> Sorry for the just sent unfinished mail. I pressed "send" instead of
> "reedit" after adding tglx to the recipients. Apart from the topic
> handled in this mail it's complete though.
>
> On Mon, Nov 17, 2014 at 10:11:25AM +0100, Janusz U=C5=BCycki wrote:
>> W dniu 2014-11-17 o 09:28, Uwe Kleine-K=C3=B6nig pisze:
>> >I think mctrl_gpio_init should request the needed irqs, but not ena=
ble
>> >them. Not sure there is a corresponding request_irq variant for tha=
t.
>>
>> What would you propose?
> Thomas: Is there something available among the irq functions for that=
=2E
> The use case is that when probing an uart driver the modem control ir=
qs
> should only be enabled when the enable_ms callback is called by the
> tty/serial framework. So we'd like to have something like
> request_irq_noenable. This way the enable_ms callback would just need
> to call enable_irq without first checking if the handler is already
> setup.
>
> The less nice alternatives are:
>
>  - use request_irq(..); disable_irq(); and handle the short window wh=
ere
>    irqs are on but not yet desired.
>  - only request_irq in the enable_ms callback, and free_irq in
>    disable_ms.
>
> Any ideas?
In atmel_request_gpio_irq(), I used:
irq_set_status_flags(irq,IRQ_NOAUTOEN);
request_irq(...)

[ sorry for repeating myself, but our emails crossed themselves :) ]

Richard.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
