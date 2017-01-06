From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 08/19] sh: sh3: sh770x: Fix platform data for the IRDA
 serial port
Date: Fri, 6 Jan 2017 11:18:32 +0100
Message-ID: <CAMuHMdVzm4D=Pdd6PoGzXUoO8Va4g1Y5KncaRS19PnSeGUn9Gw@mail.gmail.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-9-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-9-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Even though most of its registers are 8-bit wide, the IRDA has two
> 16-bit registers that make it a 16-bit peripheral and not a 8-bit
> peripheral with addresses shifted by one. Fix the memory resource size
> and the platform data regshift value.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/sh/kernel/cpu/sh3/setup-sh770x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
> index e1e54258b822..084a91e6027e 100644
> --- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
> +++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
> @@ -157,11 +157,10 @@ static struct platform_device scif1_device = {
>  static struct plat_sci_port scif2_platform_data = {
>         .type           = PORT_IRDA,
>         .ops            = &sh770x_sci_port_ops,
> -       .regshift       = 1,

According to my sh7707 and sh7709 datasheets. regshift = 1 is correct.

SCIx_IRDA_REGTYPE uses:

                [SCSMR]         = { 0x00,  8 },
                [SCBRR]         = { 0x01,  8 },
                [SCSCR]         = { 0x02,  8 },
                [SCxTDR]        = { 0x03,  8 },
                [SCxSR]         = { 0x04,  8 },
                [SCxRDR]        = { 0x05,  8 },
                [SCFCR]         = { 0x06,  8 },
                [SCFDR]         = { 0x07, 16 },

While the datasheet says:

        SCSMR1  H'A4000140      8 bits
        SCBRR1  H'A4000142      8 bits
        SCSCR1  H'A4000144      8 bits
        SCFTDR1 H'A4000146      8 bits
        SCSSR1  H'A4000148      16 bits
        SCFRDR1 H'A400014A      8 bits
        SCFCR1  H'A400014C      8 bits
        SCFDR1  H'A400014E      16 bits

So you do need regshift = 1 to handle the gaps.

Note that SCSSR1 is a 16-bit registers, while SCIx_IRDA_REGTYPE
declares it as 8-bit, so it may not work at all...

Ah, you're fixing all this in "[PATCH 19/19] serial: sh-sci: Compute the
regshift value for SCI ports".
I think that part should be moved to this patch, to not break bisection.

>  static struct resource scif2_resources[] = {
> -       DEFINE_RES_MEM(0xa4000140, 0x10),
> +       DEFINE_RES_MEM(0xa4000140, 0x20),
>         DEFINE_RES_IRQ(evt2irq(0x880)),
>  };

According to the register list above, resource size 0x10 is correct.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
