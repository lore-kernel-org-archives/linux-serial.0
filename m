From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/7] serial: sh-sci: consider DR (data ready) bit adequately
Date: Wed, 14 Dec 2016 14:45:28 +0100
Message-ID: <CAMuHMdU=bqsrT=YEj1W8Ru9nj6OFz5_zFkpRAhXZz=8V077grg@mail.gmail.com>
References: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1481286971-16667-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481286971-16667-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Uli,

On Fri, Dec 9, 2016 at 1:36 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> To allow operation with a higher RX FIFO interrupt threshold in PIO
> mode, it is necessary to consider the DR bit ("FIFO not full, but no
> data received for 1.5 frames") as an indicator that data can be read.
> Otherwise the driver will let data rot in the FIFO until the threshold
> is reached.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -677,7 +677,7 @@ static int sci_poll_get_char(struct uart_port *port)
>                 break;
>         } while (1);
>
> -       if (!(status & SCxSR_RDxF(port)))
> +       if (!(status & (SCxSR_RDxF(port) | SCxSR_DR(port))))
>                 return NO_POLL_CHAR;
>
>         c = serial_port_in(port, SCxRDR);

> --- a/drivers/tty/serial/sh-sci.h
> +++ b/drivers/tty/serial/sh-sci.h
> @@ -156,6 +156,7 @@ enum {
>  #define SCxSR_FER(port)                (((port)->type == PORT_SCI) ? SCI_FER    : SCIF_FER)
>  #define SCxSR_PER(port)                (((port)->type == PORT_SCI) ? SCI_PER    : SCIF_PER)
>  #define SCxSR_BRK(port)                (((port)->type == PORT_SCI) ? 0x00       : SCIF_BRK)
> +#define SCxSR_DR(port)         (((port)->type == PORT_SCI) ? 0x00       : SCIF_DR)

Makes sense, as SCIF_RDxF_CLEAR already includes SCIF_DR, and we thus already
clear both RDF and DR.

However, if you would handle this inside the SCxSR_RDxF() macro, your patch
would reduce to a single line:

-#define SCxSR_RDxF(port)        (((port)->type == PORT_SCI) ?
SCI_RDRF   : SCIF_RDF)
+#define SCxSR_RDxF(port)        (((port)->type == PORT_SCI) ?
SCI_RDRF   : SCIF_DR | SCIF_RDF)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
