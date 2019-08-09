From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/14] gpio: lpc32xx: allow building on non-lpc32xx targets
Date: Fri, 9 Aug 2019 16:19:46 +0200
Message-ID: <CAK8P3a0Do2=80bOEgi2=773rtek3wkHuQNESePZijy8f6pWJAg@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731195713.3150463-6-arnd@arndb.de>
 <CA+rxa6p4gD7+6-aRyd4-V4TvkyMiUh9ueMLc6ggBaDC=LG7fQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+rxa6p4gD7+6-aRyd4-V4TvkyMiUh9ueMLc6ggBaDC=LG7fQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: soc@kernel.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 6, 2019 at 10:02 PM Sylvain Lemieux <slemieux.tyco@gmail.com> wrote:

> >
> > +       gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (gpio_reg_base)
> > +               return -ENXIO;
>
> The probe function will always return an error.
> Please replace the previous 2 lines with:
>     if (IS_ERR(gpio_reg_base))
>         return PTR_ERR(gpio_reg_base);
>
> You can add my acked-by and tested-by in the v2 patch.
> Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Tested-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

Ok, fixed now, along with addressing Bartosz' concerns.

       Arnd
