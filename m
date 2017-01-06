From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 04/19] sh: Don't set sh-sci pdata scscr TIE and RIE bits
Date: Fri, 6 Jan 2017 11:11:56 +0100
Message-ID: <CAMuHMdVw5icWzY0G8b1QW+EsNG_u-8F=CP1B9a_odBQWCKzEfw@mail.gmail.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-5-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-5-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The scscr platform data field is used by the driver in three locations.
> One of them masks out all bits except SCSCR_REIE. The two other are the
> set_termios handler and the console write handler.
>
> The set_termios handler calls sci_start_rx() to enable the receiver,
> which sets the RIE bit unconditionally. It then calls sci_port_disable()
> that effectively disables both the transmitter and the receiver. The
> TIE bit will thus get set later when the serial cores reenables the
> serial port.
>
> The console write handler runs with interrupts disabled, and saves and
> restores the SCSCR register value. The RIE and TIE bits are thus not
> needed there.
>
> The bits are thus not necessary in platform data, remove them.
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
