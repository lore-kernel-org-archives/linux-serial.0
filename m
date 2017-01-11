From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1.1 08/19] serial: sh-sci: Fix register offsets for the
 IRDA serial port
Date: Wed, 11 Jan 2017 13:31:49 +0100
Message-ID: <CAMuHMdXfucrNPx7fLODROHTpbTuhpK+GzkLC-SGs_SSmZeMiyA@mail.gmail.com>
References: <CAMuHMdVzm4D=Pdd6PoGzXUoO8Va4g1Y5KncaRS19PnSeGUn9Gw@mail.gmail.com>
 <20170106115235.3919-1-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170106115235.3919-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Fri, Jan 6, 2017 at 12:52 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Even though most of its registers are 8-bit wide, the IRDA has two
> 16-bit registers that make it a 16-bit peripheral and not a 8-bit
> peripheral with addresses shifted by one. Fix the registers offset in
> the driver and the platform data regshift value.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -193,18 +193,17 @@ static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
>         },
>
>         /*
> -        * Common definitions for legacy IrDA ports, dependent on
> -        * regshift value.
> +        * Common definitions for legacy IrDA ports.
>          */
>         [SCIx_IRDA_REGTYPE] = {
>                 [SCSMR]         = { 0x00,  8 },
> -               [SCBRR]         = { 0x01,  8 },
> -               [SCSCR]         = { 0x02,  8 },
> -               [SCxTDR]        = { 0x03,  8 },
> -               [SCxSR]         = { 0x04,  8 },
> -               [SCxRDR]        = { 0x05,  8 },
> -               [SCFCR]         = { 0x06,  8 },
> -               [SCFDR]         = { 0x07, 16 },
> +               [SCBRR]         = { 0x02,  8 },
> +               [SCSCR]         = { 0x04,  8 },
> +               [SCxTDR]        = { 0x06,  8 },
> +               [SCxSR]         = { 0x08,  8 },

SCSCR is a 16-bit register. You did have that correct in v1 of patch 19.

If you fix that:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> +               [SCxRDR]        = { 0x0a,  8 },
> +               [SCFCR]         = { 0x0c,  8 },
> +               [SCFDR]         = { 0x0e, 16 },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
