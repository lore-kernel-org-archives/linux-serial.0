From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/7] serial: sh-sci: increase RX FIFO trigger defaults for (H)SCIF
Date: Wed, 14 Dec 2016 14:58:04 +0100
Message-ID: <CAMuHMdVoa53E8SOhgQwN+L337rbiUvUxTwAaQGju6GkWJ6ff2w@mail.gmail.com>
References: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1481286971-16667-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481286971-16667-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Uli,

On Fri, Dec 9, 2016 at 1:36 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/tty/serial/sh-sci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 844288f..ce3cf03 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

> @@ -2729,6 +2734,7 @@ static int sci_init_single(struct platform_device *dev,
>                 sci_port->overrun_reg = SCLSR;
>                 sci_port->overrun_mask = SCLSR_ORER;
>                 sci_port->sampling_rate_mask = SCI_SR_RANGE(8, 32);
> +               sci_port->rx_trigger = 64;
>                 break;
>         case PORT_SCIFA:
>                 port->fifosize = 64;
> @@ -2747,12 +2753,14 @@ static int sci_init_single(struct platform_device *dev,
>                         sci_port->overrun_mask = SCLSR_ORER;
>                         sci_port->sampling_rate_mask = SCI_SR(32);
>                 }
> +               sci_port->rx_trigger = 8;

PORT_SCIF is also used with SCIx_SH7705_SCIF_REGTYPE, so this should
be moved inside the "else" branch above.
Then, what to do with the "if" branch?

>From the sh7705/sh7720/sh7721 datasheets, it looks a lot like SCIFA, and thus
would need "sci_port->rx_trigger = 32", and the same handling as SCIFA in
scif_set_rtrg().

See also "[RFC] serial: sh-sci: Correct FIFO stages on sh7705/sh7720/sh7721"
(https://patchwork.kernel.org/patch/6810191/).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
