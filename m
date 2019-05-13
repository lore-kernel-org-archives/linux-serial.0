From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: disable DMA for uart_console
Date: Mon, 13 May 2019 13:13:16 +0200
Message-ID: <CAMuHMdUCcxfVdY1PqfYRZMjHN2eP_-NAsniCY39XyrDysAu1Pw@mail.gmail.com>
References: <20190506194233.GA32430@vmlxhi-102.adit-jv.com> <1557413011-1662-1-git-send-email-george_davis@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557413011-1662-1-git-send-email-george_davis@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "George G. Davis" <ggdavisiv@gmail.com>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Andy Lowe <andy_lowe@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "George G. Davis" <george_davis@mentor.com>
List-Id: linux-serial@vger.kernel.org

Hi George,

On Thu, May 9, 2019 at 4:44 PM George G. Davis <ggdavisiv@gmail.com> wrote:
> As noted in commit 84b40e3b57ee ("serial: 8250: omap: Disable DMA for
> console UART"), UART console lines use low-level PIO only access functions
> which will conflict with use of the line when DMA is enabled, e.g. when
> the console line is also used for systemd messages. So disable DMA
> support for UART console lines.
>
> Fixes: https://patchwork.kernel.org/patch/10929511/
> Reported-by: Michael Rodin <mrodin@de.adit-jv.com>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>

I think this makes sense.  In addition to OMAP 8250, the same approach
is used in the Mediatek 8250 and iMX serial drivers.

Regardless, this is definitely better than removing the "dmas" properties
from DT, as DT describes hardware, not usage policies.

Anyone else with a comment?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
