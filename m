From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/19] sh-sci: Platform data simplification
Date: Fri, 6 Jan 2017 12:01:40 +0100
Message-ID: <CAMuHMdU+e+_2b7N258zGYgyw_abGrkug_kH_f_2jBP-QArK4fw@mail.gmail.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Most of the patches in this series have been sitting in my development tree
> for three years now. While rebasing all my development branches I decided it
> was time to send them out in case they're considered useful. I've then thrown
> a few additional patches in to move the driver further in the right direction
> (or at least the direction I consider right).
>
> The idea behind this series is to move towards removal of the sh-sci platform
> data. This won't be possible until SH platforms move to DT (and I won't hold
> my breath), but we can get rid of most of the platform data fields already and
> cleanup the sh-sci driver at the same time.

Thanks for your series!

Most of it looks sane to me (cfr. my Reviewed-by tags).

Who's got a SuperH farm to regression test this? ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
