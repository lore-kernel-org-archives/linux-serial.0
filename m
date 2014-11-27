From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] gpio: mxs: implement get_direction callback
Date: Thu, 27 Nov 2014 15:22:10 +0100
Message-ID: <CACRpkdZDCap5s8UvnYd1zf9hc7szQNfwdq+sv9BpFgsd-8_2mA@mail.gmail.com>
References: <1416387322-17320-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1416387322-17320-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 19, 2014 at 9:55 AM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:

> gpiolib's gpiod_get_direction() function returns the EINVAL error
> if .get_direction callback is not defined.
> The patch implements the callback for mxs chip which is useful
> for debugging.
>
> Inspired by arch/arm/mach-at91/gpio.c
>
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

This v3 version applied with Alexandre's ACK.

Yours,
Linus Walleij
