From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 07/19] sh: Don't set sh-sci port_reg
Date: Fri, 6 Jan 2017 11:17:36 +0100
Message-ID: <CAMuHMdVecX9LbSQcNtTPBo9uDTyEiojr1LCDULN3QBuPL7A-Sg@mail.gmail.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-8-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-8-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The driver considers all negative or zero values of the port_reg field
> as invalid. The four platforms that set the field to a register address
> all use an address higher than 0x7fffffff, which is thus considered by
> the driver as invalid. The feature is thus never used, remove it.

Yeah, it's been broken since v3.1
(commit 514820eb982eb856 ("serial: sh-sci: Consolidate RXD pin handling")).

> The feature could be implemented properly in the future using the
> pinctrl and GPIO APIs if desired.
>
> While at it, don't set the field to SCIx_NOT_SUPPORTED (-1) either,
> leaving it unset leads to the same result. This will allow removing the
> SCIx_NOT_SUPPORTED macro.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
