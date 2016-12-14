From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/7] serial: sh-sci: SCIFA/B RX FIFO software timeout
Date: Wed, 14 Dec 2016 15:02:28 +0100
Message-ID: <CAMuHMdWmCgiAH3hnAQJVxhz70bLOMccsWOR1gmSmbKeEwW_Fgg@mail.gmail.com>
References: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1481286971-16667-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481286971-16667-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Uli.

On Fri, Dec 9, 2016 at 1:36 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Implements support for FIFO fill thresholds greater than one with software
> timeout.
>
> This mechanism is not possible (or at least not useful) on SCIF family
> hardware other than SCIFA and SCIFB because they do not support turning off
> the DR hardware timeout interrupt separately from the RI interrupt.

What about HSCIF? Your code does handle HSCIF (cfr. HSRTRGR below)?

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

> @@ -1159,6 +1162,24 @@ static int scif_set_rtrg(struct uart_port *port, int rx_trig)
>         return rx_trig;
>  }
>
> +static int scif_rtrg_enabled(struct uart_port *port)
> +{
> +       if (sci_getreg(port, HSRTRGR)->size)
> +               return serial_port_in(port, HSRTRGR) != 0;
> +       else
> +               return (serial_port_in(port, SCFCR) &
> +                       (SCFCR_RTRG0 | SCFCR_RTRG1)) != 0;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
