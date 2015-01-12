From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [RFC PATCH v2 1/4] tty: serial_mctrl_gpio: Add irqs helpers for
 input lines
Date: Tue, 13 Jan 2015 07:25:44 +0900
Message-ID: <CAAVeFu+1=rF1P3Ro2kVTn=6-LvDtcOG0UcTJnKXsN-FQK9b7+Q@mail.gmail.com>
References: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>, fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 10, 2015 at 11:32 PM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:
> A driver using mctrl_gpio called gpiod_get_direction() to check if
> gpio is input line. However .get_direction callback is not available
> for all platforms. The patch allows to avoid the function.
> The patch introduces the following helpers:
> - mctrl_gpio_request_irqs
> - mctrl_gpio_free_irqs
> - mctrl_gpio_enable_ms
> - mctrl_gpio_disable_ms
> They allow to:
> - simplify drivers which use mctrl_gpio
> - hide irq table in mctrl_gpio
> - use default irq handler for gpios
> - better separate code for gpio modem lines from uart's code
> In addition mctrl_gpio_init() has been renamed to mctrl_gpio_init_dt()
> to focus DT usage. Also mctrl_gpio_init_dt() initializes irq table for
> gpios now and passes struct uart_port into struct mctrl_gpios.
> This resulted in changed mctrl_gpio_init_dt() parameter.
> It also requires port->dev is set before the function is called.
>
> There were also fixed:
> - irq = 0 means invalid/unused (-EINVAL no more used)
> - mctrl_gpio_request_irqs() doesn't use negative enum value
>   if request_irq() failed. It just calls mctrl_gpio_free_irqs().
>
> The mctrl_gpio_is_gpio() inline function is under discussion
> and likely it can replace exported mctrl_gpio_to_gpiod() function.
>
> IRQ_NOAUTOEN setting and request_irq() order was not commented
> but it looks right according to other drivers.

I cannot provide a full review on this part of the kernel, but this
series is also useful in that it will allow us to make
gpiod_get_direction() private. This function should never have been
public in the first place.

The series,

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
