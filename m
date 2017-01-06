From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 15/19] serial: sh-sci: Extend sci_port_params with more
 port parameters
Date: Fri, 6 Jan 2017 11:51:12 +0100
Message-ID: <CAMuHMdU=Ky9_EJACTjvKmQfpyEX5eEj14jQ1n3sz+Dk7dEzf9Q@mail.gmail.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-16-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-16-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The fifo size, overrun register and mask, sampling rate mask and error
> mask all depend on the port type only and don't need to be computed at
> runtime. Add them to the sci_port_parameters structure.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -107,6 +107,12 @@ struct plat_sci_reg {
>
>  struct sci_port_params {
>         const struct plat_sci_reg regs[SCIx_NR_REGS];
> +       unsigned int fifosize;
> +       unsigned int overrun_reg;
> +       unsigned int overrun_mask;
> +       unsigned int sampling_rate_mask;
> +       unsigned int error_mask;
> +       unsigned int error_clear;
>  };
>
>  struct sci_port {


> @@ -2649,29 +2687,10 @@ static int sci_init_single(struct platform_device *dev,
>         sci_port->break_timer.function = sci_break_timer;
>         init_timer(&sci_port->break_timer);
>
> -       /*
> -        * Establish some sensible defaults for the error detection.
> -        */
> -       if (p->type == PORT_SCI) {
> -               sci_port->error_mask = SCI_DEFAULT_ERROR_MASK;
> -               sci_port->error_clear = SCI_ERROR_CLEAR;
> -       } else {
> -               sci_port->error_mask = SCIF_DEFAULT_ERROR_MASK;
> -               sci_port->error_clear = SCIF_ERROR_CLEAR;
> -       }
> -
> -       /*
> -        * Make the error mask inclusive of overrun detection, if
> -        * supported.
> -        */
> -       if (sci_port->overrun_reg == SCxSR) {
> -               sci_port->error_mask |= sci_port->overrun_mask;
> -               sci_port->error_clear &= ~sci_port->overrun_mask;
> -       }
> -
>         port->type              = p->type;
>         port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
>         port->regshift          = p->regshift;
> +       port->fifosize          = sci_port->params->fifosize;

You still need this assignment because you didn't convert a handfull
remaining users of port->fifosize to params->fifosize?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
