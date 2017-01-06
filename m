From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 11/19] sh: Don't set the sh-sci platform data REIE bit
 when not implemented
Date: Fri, 6 Jan 2017 11:27:05 +0100
Message-ID: <CAMuHMdVz9FCjTOBExbA3J32xiS03enUtCXwouHfDwM4r2o-ehw@mail.gmail.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-12-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-12-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> According to the datasheets, the sh7760 SIM and sh7723 SCIFA instances
> don't implement the REIE bit. Don't set it in platform data.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  arch/sh/kernel/cpu/sh4/setup-sh7760.c  | 1 -
>  arch/sh/kernel/cpu/sh4a/setup-sh7723.c | 3 ---
>  2 files changed, 4 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
> index 6dbcbf1621aa..e51fe1734e13 100644
> --- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
> +++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
> @@ -200,7 +200,6 @@ static struct platform_device scif2_device = {
>  };
>
>  static struct plat_sci_port scif3_platform_data = {
> -       .scscr          = SCSCR_REIE,

Note that this bit does have a function (WAIT_IE --- Enables wait error
interrupt (SIMERI) requests), so this may impact behavior.

>         /*
>          * This is actually a SIM card module serial port, based on an SCI with
>          * additional registers. The sh-sci driver doesn't support the SIM port

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
