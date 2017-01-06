From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 19/19] serial: sh-sci: Compute the regshift value for SCI ports
Date: Fri, 6 Jan 2017 12:00:05 +0100
Message-ID: <CAMuHMdVgTMb56mogTSCA0ePCMoy4SCW-5qKCasZYDPU3TJRsKQ@mail.gmail.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-20-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-20-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> SCI instances found in SH SoCs have different spacing between registers
> depending on the SoC. The platform data contains a regshift field that
> tells the driver by how many bits to shift the register offset to
> compute its address. We can compute the regshift value automatically
> based on the memory resource size, there's no need to pass the value
> through platform data.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/tty/serial/sh-sci.c | 25 +++++++++++++++----------
>  include/linux/serial_sci.h  |  1 -
>  2 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 5fc2606fc525..fbffe89b493f 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -187,19 +187,18 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
>         },
>
>         /*
> -        * Common definitions for legacy IrDA ports, dependent on
> -        * regshift value.
> +        * Common definitions for legacy IrDA ports.
>          */
>         [SCIx_IRDA_REGTYPE] = {
>                 .regs = {
>                         [SCSMR]         = { 0x00,  8 },
> -                       [SCBRR]         = { 0x01,  8 },
> -                       [SCSCR]         = { 0x02,  8 },
> -                       [SCxTDR]        = { 0x03,  8 },
> -                       [SCxSR]         = { 0x04,  8 },
> -                       [SCxRDR]        = { 0x05,  8 },
> -                       [SCFCR]         = { 0x06,  8 },
> -                       [SCFDR]         = { 0x07, 16 },
> +                       [SCBRR]         = { 0x02,  8 },
> +                       [SCSCR]         = { 0x04,  8 },
> +                       [SCxTDR]        = { 0x06,  8 },
> +                       [SCxSR]         = { 0x08, 16 },
> +                       [SCxRDR]        = { 0x0a,  8 },
> +                       [SCFCR]         = { 0x0c,  8 },
> +                       [SCFDR]         = { 0x0e, 16 },

This hunk is not documented, and belongs in "[PATCH 08/19] sh: sh3: sh770x:
Fix platform data for the IRDA serial port" to avoid breaking bisection.

The rest looks OK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
