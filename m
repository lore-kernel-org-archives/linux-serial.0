From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 2/4] serdev: add GPIO-based multiplexer support
Date: Thu, 15 Jun 2017 11:34:56 +0200
Message-ID: <CAMuHMdUe1dvjc54=NwBxP=-3L6zVGzRY3JDPV6ERMT0GxvvQcA@mail.gmail.com>
References: <1497451130-7741-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1497451130-7741-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1497451130-7741-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Rob Herring <robh@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

On Wed, Jun 14, 2017 at 4:38 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Adds an interface for slave device multiplexing, and an implementation
> for GPIO-based multiplexers.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/tty/serdev/mux-gpio.c

> +int of_serdev_register_gpio_mux(struct serdev_controller *ctrl)
> +{
> +       int i, ngpios;
> +       struct serdev_mux *mux;
> +       struct device_node *np = ctrl->dev.of_node;
> +
> +       ngpios = of_gpio_named_count(np, "mux-select-gpios");

To make if OF-agnostic, you probably want to use gpiod_count() instead...

> +       for (i = 0; i < ngpios; ++i)
> +               mux->gpios[i] = of_get_named_gpio(np, "mux-select-gpios", i);

... and (devm_)gpiod_get_index().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
