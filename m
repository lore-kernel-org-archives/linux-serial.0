From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] sh-sci: fix transition from noflow to HW flow control
Date: Tue, 16 Aug 2016 09:44:44 +0200
Message-ID: <CAMuHMdXoLtsknFyJe+FJuW7GJuQaU=3UhZh9kfckPUGxNh6siA@mail.gmail.com>
References: <HE1PR0601MB268306974695DFE9C0C9D0B0D0120@HE1PR0601MB2683.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <HE1PR0601MB268306974695DFE9C0C9D0B0D0120@HE1PR0601MB2683.eurprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Baumann, Christoph (C.)" <cbaumann@visteon.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Christoph,

On Mon, Aug 15, 2016 at 1:20 PM, Baumann, Christoph (C.)
<cbaumann@visteon.com> wrote:
> working on getting RTS/CTS run on r8a7795 I had some annoying issues.

Which port are you using? SCIF or HSCIF?

> Measuring with a scope showed that RTS would become low on opening the tty device (regardless of having CRTSCTS set or not). So far this is expected.
> But if I used tcsetattr() to set/unset the CRTSCTS flag the RTS pin would become hi and stayed so.
> I then looked into the sh-sci driver and added some debug output.
> My analysis was that upon opening the tty device the functions set_termios and set_mctrl are called.
> In the sh-sci driver the set_mctrl function is the only place where the internal 'autorts' flag is actually written to a register.
> As obviously the RTSCTS flow control flag can only be set after the device is opened, the flag isn't propagated to the corresponding register.

You mean sci_set_mctrl() isn't called by the serial core after
sci_set_termios()?

However, uart_set_termios() calls both uart_change_speed() and
uart_{clear,set}_mctrl(), in that order?

> To make it more confusing the flag is kept in .c_cflag even after closing the device and is then taken care of the next time the device is opened again.
> To fix this I set the bit in set_termios after the line where it was previously only stored in the bool variable 'autorts' (see attachment).

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

[ removed unrelated changes]

> @@ -2336,6 +2337,8 @@ done:
>                         port->status |= UPSTAT_AUTOCTS;
>                         /* MCE is enabled when RTS is raised */
>                         s->autorts = true;
> +                       ctrl |= SCFCR_MCE;
> +                       sci_set_rts(port, 1);
>                 }
>
>                 /*

Have you tried using GPIO RTS/CTS instead of hardware-assisted RTS/CTS?
Does it show the same behavior?
When adding support for hardware-assisted RTS/CTS, I used the behavior of
GPIO RTS/CTS as the expected behavior.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
