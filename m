From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: Support for variable HSCIF hardware RX timeout
Date: Thu, 21 Sep 2017 15:47:04 +0200
Message-ID: <CAMuHMdUebfY7jyC9x-xctZxj6fr1cK3aW+sKT=3MX_tnjSfCKg@mail.gmail.com>
References: <1505835844-3320-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1505835844-3320-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

On Tue, Sep 19, 2017 at 5:44 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> HSCIF has facilities that allow changing the timeout after which an RX
> interrupt is triggered even if the FIFO is not filled. This patch allows
> changing the default (15 bits of silence) using the existing sysfs
> attribute "rx_fifo_timeout".
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -152,6 +152,7 @@ struct sci_port {
>         int                             rx_trigger;
>         struct timer_list               rx_fifo_timer;
>         int                             rx_fifo_timeout;
> +       u16                             hscif_tot;

Shouldn't this field be reset to zero in sci_init_single(), like
rx_fifo_timeout?

> @@ -1107,8 +1108,14 @@ static ssize_t rx_fifo_timeout_show(struct device *dev,
>  {
>         struct uart_port *port = dev_get_drvdata(dev);
>         struct sci_port *sci = to_sci_port(port);
> +       u16 v;

int, to preserve all bits from rx_fifo_timeout.

>
> -       return sprintf(buf, "%d\n", sci->rx_fifo_timeout);
> +       if (port->type == PORT_HSCIF)
> +               v = sci->hscif_tot >> HSSCR_TOT_SHIFT;
> +       else
> +               v = sci->rx_fifo_timeout;
> +
> +       return sprintf(buf, "%d\n", v);
>  }

> @@ -1124,11 +1131,19 @@ static ssize_t rx_fifo_timeout_store(struct device *dev,
>         ret = kstrtol(buf, 0, &r);
>         if (ret)
>                 return ret;
> -       sci->rx_fifo_timeout = r;
> -       scif_set_rtrg(port, 1);
> -       if (r > 0)
> -               setup_timer(&sci->rx_fifo_timer, rx_fifo_timer_fn,
> -                           (unsigned long)sci);
> +
> +       if (port->type == PORT_HSCIF) {
> +               if (r < 0 || r > 3)
> +                       return -EINVAL;
> +               sci->hscif_tot = r << HSSCR_TOT_SHIFT;
> +       } else {
> +               sci->rx_fifo_timeout = r;
> +               scif_set_rtrg(port, 1);
> +               if (r > 0)
> +                       setup_timer(&sci->rx_fifo_timer, rx_fifo_timer_fn,
> +                                   (unsigned long)sci);
> +       }

So this sysfs parameter uses slightly different units depending on serial port
type (HSCIF is in 15 Elementary Time Units aka 1.5 frames, SCIF[AB] is in
frames). Do we care?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
