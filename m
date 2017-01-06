From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 02/19] serial: sh-sci: Don't rely on platform data flags
 when not needed
Date: Fri, 6 Jan 2017 11:11:19 +0100
Message-ID: <CAMuHMdX99iS-gn3szuRTTyTmGHfkorV9ExK4JpvsVPrG345MHw@mail.gmail.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-3-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-3-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The UPF_BOOT_AUTOCONF platform data flag is set by all platforms,
> hardcode it.
>
> The UPF_IOREMAP flag is set by a single SH platform and thus needs to be
> kept. However, for ARM platforms, we can base the decision on whether an
> OF node is present and bypass the platform data flags completely.
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
