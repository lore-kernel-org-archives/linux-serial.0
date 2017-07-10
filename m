From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250_of: Fix regression in reset support
Date: Mon, 10 Jul 2017 20:09:35 +0300
Message-ID: <CAHp75Vc-U4ym_LR2eqU7hVXBCOhnuDFgoXBcMTd5z53JSB=CCg@mail.gmail.com>
References: <20170710152451.5773-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170710152451.5773-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joel Stanley <joel@jms.id.au>
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 10, 2017 at 6:24 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> commit e2860e1f62f2 ("serial: 8250_of: Add reset support")
> introduced reset support for the 8250_of driver.
>
> However it unconditionally uses the assert/deassert pair to
> deassert reset on the device at probe and assert it at
> remove. This does not work with systems that have a
> self-deasserting reset controller, such as Gemini, that
> recently added a reset controller.
>
> As a result, the console will not probe on the Gemini with
> this message:
>
> Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
> of_serial: probe of 42000000.serial failed with error -524
>
> This (-ENOTSUPP) is the error code returned by the
> deassert() operation on self-deasserting reset controllers.
>
> Add some code and comments that will:
>
> - In probe() avoid to bail out if -ENOTSUPP is returned
>   from the reset_deassert() call.
>
> - If reset_assert() bails out with -ENOTSUPP on remove(),
>   try the self-deasserting method as a fallback.
>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: e2860e1f62f2 ("serial: 8250_of: Add reset support")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Philipp: please comment on this or ACK if it is the right
> approach. It sort of sets a precedent for handling
> different reset controllers from the consumer side.
>
> Another possibility is to modify the reset core such
> that .deassert() bails out silently if the controller only
> has .reset(), and .assert() just calls .reset() if the
> controller does not have .assert().
>
> Actually I think the latter is more intuitive but it is
> also more intrusive.
> ---
>  drivers/tty/serial/8250/8250_of.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 0cf95fddccfc..927ee8561c8d 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -138,7 +138,12 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>         if (IS_ERR(info->rst))
>                 goto out;
>         ret = reset_control_deassert(info->rst);
> -       if (ret)
> +       /*
> +        * If the deassert operation is not supported, this could be because
> +        * the reset controller is self-deasserting and onlt supports the

only

> +        * .reset() operation, so this is not a probe error.
> +        */
> +       if (ret && (ret != -ENOTSUPP))
>                 goto out;
>
>         port->type = type;
> @@ -235,10 +240,14 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
>  static int of_platform_serial_remove(struct platform_device *ofdev)
>  {
>         struct of_serial_info *info = platform_get_drvdata(ofdev);
> +       int ret;
>
>         serial8250_unregister_port(info->line);
>
> -       reset_control_assert(info->rst);
> +       ret = reset_control_assert(info->rst);
> +       /* If the assert operation is not supported, use pure reset() */
> +       if (ret == -ENOTSUPP)
> +               reset_control_reset(info->rst);
>         if (info->clk)
>                 clk_disable_unprepare(info->clk);
>         kfree(info);
> --
> 2.9.4
>



-- 
With Best Regards,
Andy Shevchenko
