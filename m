From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/7] serial: sh-sci: implement FIFO threshold register setting
Date: Wed, 14 Dec 2016 14:50:59 +0100
Message-ID: <CAMuHMdWtXjx485oO_yhw2apYJAZxk6EqV4RwpPuKr8vC5yWxBQ@mail.gmail.com>
References: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1481286971-16667-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481286971-16667-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Uli,

On Fri, Dec 9, 2016 at 1:36 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Sets the closest match for a desired RX trigger level.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> index de25db8..844288f 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1103,6 +1103,61 @@ static int sci_handle_breaks(struct uart_port *port)
>         return copied;
>  }
>
> +static int scif_set_rtrg(struct uart_port *port, int rx_trig)
> +{

> +       if (port->type == PORT_SCIF) {

> +       } else if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {

> +       } else {
> +               WARN(1, "unknown FIFO configuration");

This cannot happen, right?

> +               return 1;
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
