From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Date: Fri, 3 Mar 2017 19:58:36 +0100
Message-ID: <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170303142201.16452-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>
List-Id: linux-serial@vger.kernel.org

Hi Richard,

On Fri, Mar 3, 2017 at 3:22 PM, Richard Genoud <richard.genoud@gmail.com> wrote:
> Since commit 1d267ea6539f ("serial: mctrl-gpio: simplify init routine"),
> the mctrl_gpio_to_gpiod() function can't return an error anymore.
> So, just testing for a NULL pointer is ok.

If CONFIG_GPIOLIB=n, mctrl_gpio_to_gpiod() always returns ERR_PTR(-ENOSYS).
That case should be handled correctly, too.

Perhaps mctrl_gpio_to_gpiod() should always return NULL if !CONFIG_GPIOLIB?

This may apply to the other 2 patches, too:
[PATCH 2/4] tty/serial: atmel: remove uneeded IS_ERR_OR_NULL calls
[PATCH 3/4] tty/serial: mxs-auart: remove uneeded IS_ERR_OR_NULL calls

> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/tty/serial/sh-sci.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 9a47cc4f16a2..36fde6f24040 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1934,12 +1934,12 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
>         if (s->autorts) {
>                 if (sci_get_cts(port))
>                         mctrl |= TIOCM_CTS;
> -       } else if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS))) {
> +       } else if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS)) {
>                 mctrl |= TIOCM_CTS;
>         }
> -       if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR)))
> +       if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR))
>                 mctrl |= TIOCM_DSR;
> -       if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD)))
> +       if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD))
>                 mctrl |= TIOCM_CAR;
>
>         return mctrl;
> @@ -3072,10 +3072,8 @@ static int sci_probe_single(struct platform_device *dev,
>                 return PTR_ERR(sciport->gpios);
>
>         if (sciport->has_rtscts) {
> -               if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
> -                                                       UART_GPIO_CTS)) ||
> -                   !IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
> -                                                       UART_GPIO_RTS))) {
> +               if (mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_CTS) ||
> +                   mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_RTS)) {
>                         dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
>                         return -EINVAL;
>                 }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
