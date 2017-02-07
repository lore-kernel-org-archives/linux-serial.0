From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 3/4] serial: sh-sci: make RX FIFO parameters tunable
 via sysfs
Date: Tue, 7 Feb 2017 15:40:50 +0100
Message-ID: <CAMuHMdVc3eyXCZfASUst4Kd93WWNVi05q-L32yta8rDDrBLhOQ@mail.gmail.com>
References: <1486118300-12633-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1486118300-12633-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1486118300-12633-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

On Fri, Feb 3, 2017 at 11:38 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Allows tuning of the RX FIFO fill threshold and timeout. (The latter is
> only applicable to SCIFA and SCIFB).
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 4a165ed..f95a56c 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1055,6 +1055,66 @@ static void rx_fifo_timer_fn(unsigned long arg)
>         scif_set_rtrg(port, 1);
>  }
>
> +static ssize_t rx_trigger_show(struct device *dev,
> +                              struct device_attribute *attr,
> +                              char *buf)
> +{
> +       struct uart_port *port = dev_get_drvdata(dev);
> +       struct sci_port *sci = to_sci_port(port);
> +
> +       return sprintf(buf, "%d\n", sci->rx_trigger);
> +}
> +
> +static ssize_t rx_trigger_store(struct device *dev,
> +                               struct device_attribute *attr,
> +                               const char *buf,
> +                               size_t count)
> +{
> +       struct uart_port *port = dev_get_drvdata(dev);
> +       struct sci_port *sci = to_sci_port(port);
> +       long r;
> +
> +       if (kstrtol(buf, 0, &r) == -EINVAL)
> +               return -EINVAL;
> +       sci->rx_trigger = scif_set_rtrg(port, r);
> +       scif_set_rtrg(port, 1);

I seem to have missed the above function call during my earlier review.
What's the purpose of resetting the trigger immediately to 1?

This means I can change the value of scif->rx_trigger on the fly, but the
actual value programmed in the hardware is always 1?

I.e. "echo 1 > /sys/class/tty/ttySC0/device/rx_fifo_trigger" fixes serial
console input on e.g. armadillo, but echoing 32 into rx_fifo_trigger doesn't
break it again.

> +       return count;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
