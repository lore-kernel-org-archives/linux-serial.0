From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] serial: sh-sci: Support for HSCIF RX sampling point adjustment
Date: Mon, 2 Oct 2017 10:05:04 +0200
Message-ID: <CAMuHMdWhrzEX8vr2uhSuzUcAAnyJgB3Fjb1dbMQ4QFWAqoMR+A@mail.gmail.com>
References: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1506690534-27302-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1506690534-27302-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Uli,

On Fri, Sep 29, 2017 at 3:08 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> HSCIF has facilities that allow moving the RX sampling point by between
> -8 and 7 sampling cycles (one sampling cycles equals 1/15 of a bit
> by default) to improve the error margin in case of slightly mismatched
> bit rates between sender and receiver.
>
> This patch allows changing the default (0, meaning center) using the
> sysfs attribute "rx_sampling_point".
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

Have you noticed any improvements by fiddling with the sampling point?

While this patch is useful as an investigation tool due to the sysfs
interface, I don't think it should be applied as-is.

I guess the goal is to select automatically the optimal sampling point,
based on requested bit rate and available clock input rates, right?

Or perhaps you want to keep the sysfs interface, to accommodate a sender
that uses an off bit rate, unbeknownst to Linux (and unsupported by Linux,
as software can request standard bit rates only) and thus needs user
configuration?
If that is the case, perhaps the sysfs interface should not be provided the
raw sampling point offset, but the actual bit rate used by the other side,
so the driver can calculate the offset?

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -153,6 +153,7 @@ struct sci_port {
>         struct timer_list               rx_fifo_timer;
>         int                             rx_fifo_timeout;
>         u16                             hscif_tot;
> +       u16                             hscif_srhp;

s16, or even s8?

>
>         bool has_rtscts;
>         bool autorts;
> @@ -992,6 +993,42 @@ static int sci_handle_breaks(struct uart_port *port)
>         return copied;
>  }
>
> +static ssize_t rx_sampling_point_show(struct device *dev,
> +                              struct device_attribute *attr,
> +                              char *buf)
> +{
> +       struct uart_port *port = dev_get_drvdata(dev);
> +       struct sci_port *sci = to_sci_port(port);
> +
> +       return sprintf(buf, "%d\n", sci->hscif_srhp);

... else it will not output negative numbers here.

> +}
> +
> +static ssize_t rx_sampling_point_store(struct device *dev,
> +                               struct device_attribute *attr,
> +                               const char *buf,
> +                               size_t count)
> +{
> +       struct uart_port *port = dev_get_drvdata(dev);
> +       struct sci_port *sci = to_sci_port(port);
> +       int ret;
> +       long r;

s8 or just int?

> +
> +       ret = kstrtol(buf, 0, &r);

kstrtos8() or kstrtoint()?

> +       if (ret)
> +               return ret;
> +
> +       if (r < -8 || r > 7)
> +               return -EINVAL;
> +
> +       sci->hscif_srhp = r;
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR(rx_sampling_point, 0644,
> +                  rx_sampling_point_show,
> +                  rx_sampling_point_store);
> +
>  static int scif_set_rtrg(struct uart_port *port, int rx_trig)
>  {
>         unsigned int bits;
> @@ -2378,8 +2415,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
>                 serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
>                 serial_port_out(port, SCSMR, smr_val);
>                 serial_port_out(port, SCBRR, brr);
> -               if (sci_getreg(port, HSSRR)->size)
> -                       serial_port_out(port, HSSRR, srr | HSCIF_SRE);

Why have you moved the setting of HSSRR?
AFAIK all bit rate settings should be completed before the one bit delay below.

>                 /* Wait one bit interval */
>                 udelay((1000000 + (baud - 1)) / baud);
> @@ -2393,6 +2428,18 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
>                 serial_port_out(port, SCSMR, smr_val);
>         }
>
> +       if (sci_getreg(port, HSSRR)->size) {
> +               u16 hssrr = srr | HSCIF_SRE;
> +
> +               if (s->hscif_srhp) {
> +                       u16 srhp = (s->hscif_srhp << HSCIF_SRHP_SHIFT) &
> +                                  HSCIF_SRHP_MASK;
> +
> +                       hssrr |= HSCIF_SRDE | srhp;
> +               }
> +               serial_port_out(port, HSSRR, hssrr);
> +       }
> +
>         sci_init_pins(port, termios->c_cflag);
>
>         port->status &= ~UPSTAT_AUTOCTS;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
