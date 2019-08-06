From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH 05/14] gpio: lpc32xx: allow building on non-lpc32xx targets
Date: Tue, 6 Aug 2019 16:02:27 -0400
Message-ID: <CA+rxa6p4gD7+6-aRyd4-V4TvkyMiUh9ueMLc6ggBaDC=LG7fQg@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731195713.3150463-6-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731195713.3150463-6-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

On Wed, Jul 31, 2019 at 4:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The driver uses hardwire MMIO addresses instead of the data
> that is passed in device tree. Change it over to only
> hardcode the register offset values and allow compile-testing.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpio/Kconfig        |  8 +++++
>  drivers/gpio/Makefile       |  2 +-
>  drivers/gpio/gpio-lpc32xx.c | 63 ++++++++++++++++++++++++-------------
>  3 files changed, 50 insertions(+), 23 deletions(-)
>
[...]

> diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
> index 24885b3db3d5..548f7cb69386 100644
> --- a/drivers/gpio/gpio-lpc32xx.c
> +++ b/drivers/gpio/gpio-lpc32xx.c

[...]

> @@ -498,6 +509,10 @@ static int lpc32xx_gpio_probe(struct platform_device *pdev)
>  {
>         int i;
>
> +       gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
> +       if (gpio_reg_base)
> +               return -ENXIO;

The probe function will always return an error.
Please replace the previous 2 lines with:
    if (IS_ERR(gpio_reg_base))
        return PTR_ERR(gpio_reg_base);

You can add my acked-by and tested-by in the v2 patch.
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Tested-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

> +
>         for (i = 0; i < ARRAY_SIZE(lpc32xx_gpiochip); i++) {
>                 if (pdev->dev.of_node) {
>                         lpc32xx_gpiochip[i].chip.of_xlate = lpc32xx_of_xlate;
> @@ -527,3 +542,7 @@ static struct platform_driver lpc32xx_gpio_driver = {
>  };
>
>  module_platform_driver(lpc32xx_gpio_driver);
> +
> +MODULE_AUTHOR("Kevin Wells <kevin.wells@nxp.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("GPIO driver for LPC32xx SoC");
> --
> 2.20.0
>
Sylvain
