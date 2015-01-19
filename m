From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2 3/4] serial: at91: Use helpers for gpio irqs
Date: Mon, 19 Jan 2015 11:14:06 +0100
Message-ID: <CACRpkdY9hQTrh4C1bQdtjysNKcEd4nXUiw4DRFF+81t7tvy+VA@mail.gmail.com>
References: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
	<1420900366-9169-3-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1420900366-9169-3-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 10, 2015 at 3:32 PM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:

> The patch updates atmel_serial driver to use new mctrl_gpio helpers for
> gpio irqs. The code is simpler now.
>
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
