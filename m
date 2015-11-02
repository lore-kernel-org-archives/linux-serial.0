From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] serial: sh-sci: Add calculation recive margin for HSCIF
Date: Mon, 2 Nov 2015 14:56:13 +0100
Message-ID: <CAMuHMdUmChU0G1RcDOtSbCwzRZ9LTcQfZwjiSKBKVGhiAqjn1w@mail.gmail.com>
References: <1405321800-18114-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
	<1405321800-18114-3-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1405321800-18114-3-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Iwamatsu-san,

On Mon, Jul 14, 2014 at 9:10 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> When the error of the same bit rate is detected, we will need to select
> the recive margin is large. Current code holds the minimum error, it does
> not have to check the recive margin. This adds this calculation.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

I know this patch was applied a while ago.

> ---
>  drivers/tty/serial/sh-sci.c | 77 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 7f571a8..d879c0c 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1783,13 +1783,30 @@ static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
>         return ((freq + 16 * bps) / (32 * bps) - 1);
>  }
>
> +/* calculate frame length from SMR */
> +static int sci_baud_calc_frame_len(unsigned int smr_val)
> +{
> +       int len = 10;
> +
> +       if (smr_val & SCSMR_CHR)
> +               len--;
> +       if (smr_val & SCSMR_PE)
> +               len++;
> +       if (smr_val & SCSMR_STOP)
> +               len++;
> +
> +       return len;
> +}

The above function isn't needed...

>  /* calculate sample rate, BRR, and clock select for HSCIF */
>  static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq,
>                                 int *brr, unsigned int *srr,
> -                               unsigned int *cks)
> +                               unsigned int *cks, int frame_len)

... because the new "frame_len" parameter is unused...

> @@ -1858,8 +1907,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
>         baud = uart_get_baud_rate(port, termios, old, 0, max_baud);
>         if (likely(baud && port->uartclk)) {
>                 if (s->cfg->type == PORT_HSCIF) {
> +                       int frame_len = sci_baud_calc_frame_len(smr_val);

... hence calculating this isn't needed.

>                         sci_baud_calc_hscif(baud, port->uartclk, &t, &srr,
> -                                           &cks);
> +                                           &cks, frame_len);
>                 } else {
>                         t = sci_scbrr_calc(s, baud, port->uartclk);
>                         for (cks = 0; t >= 256 && cks <= 3; cks++)

Is there some follow-up patch missing?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
