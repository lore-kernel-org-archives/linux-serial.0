From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] serial: sh-sci: disable DMA for uart_console
Date: Tue, 14 May 2019 10:28:34 +0200
Message-ID: <CAMuHMdVaNWa=Q-7K-+_rM-8yYWB0-+4_o4hgACK6o-4BOrY07A@mail.gmail.com>
References: <1557762446-23811-1-git-send-email-george_davis@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557762446-23811-1-git-send-email-george_davis@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "George G. Davis" <george_davis@mentor.com>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Chris Brandt <chris.brandt@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Andy Lowe <andy_lowe@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi George,

On Mon, May 13, 2019 at 5:48 PM George G. Davis <george_davis@mentor.com> wrote:
> As noted in commit 84b40e3b57ee ("serial: 8250: omap: Disable DMA for
> console UART"), UART console lines use low-level PIO only access functions
> which will conflict with use of the line when DMA is enabled, e.g. when
> the console line is also used for systemd messages. So disable DMA
> support for UART console lines.
>
> Fixes: https://patchwork.kernel.org/patch/10929511/

I don't think this is an appropriate reference, as it points to a patch that
was never applied.

As the problem has basically existed forever, IMHO no Fixes tag
is needed.

> Reported-by: Michael Rodin <mrodin@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> ---
> v2: Clarify comment regarding DMA support on kernel console,
>     add {Tested,Reviewed}-by:, and Cc: linux-stable lines.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
