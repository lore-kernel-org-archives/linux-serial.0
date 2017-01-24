From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 4/7] serial: sh-sci: increase RX FIFO trigger defaults
 for (H)SCIF
Date: Tue, 24 Jan 2017 09:00:37 +0100
Message-ID: <CAMuHMdVu+f=FY+1R98FLqSHseQ=WnazGhTXcyLqsW9CPY7YfgQ@mail.gmail.com>
References: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1485187458-8195-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485187458-8195-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 23, 2017 at 5:04 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> @@ -2736,15 +2742,19 @@ static int sci_init_single(struct platform_device *dev,
>                 sci_port->sampling_rate_mask = SCI_SR_SCIFAB;
>                 break;
>         case PORT_SCIF:
> -               port->fifosize = 16;
>                 if (p->regtype == SCIx_SH7705_SCIF_REGTYPE) {
> +                       port->fifosize = 64;

Note that you forgot to mention that you also corrected the FIFO size for
sh7705, ssh7720, and sh7721. Not that we can easily test that, though.

>                         sci_port->overrun_reg = SCxSR;
>                         sci_port->overrun_mask = SCIFA_ORER;
>                         sci_port->sampling_rate_mask = SCI_SR(16);
> +                       /* RX triggering not implemented for this IP */
> +                       sci_port->rx_trigger = 1;
>                 } else {
> +                       port->fifosize = 16;
>                         sci_port->overrun_reg = SCLSR;
>                         sci_port->overrun_mask = SCLSR_ORER;
>                         sci_port->sampling_rate_mask = SCI_SR(32);
> +                       sci_port->rx_trigger = 8;
>                 }
>                 break;
>         default:




-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
