From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] serial: sh-sci: Support for variable HSCIF hardware
 RX timeout
Date: Mon, 2 Oct 2017 09:30:32 +0200
Message-ID: <CAMuHMdU09tfxyK4r2mGv+njkcSP28Wu+wtZM-h9QkHfXA9GO9w@mail.gmail.com>
References: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1506690534-27302-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1506690534-27302-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Uli,

On Fri, Sep 29, 2017 at 3:08 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> HSCIF has facilities that allow changing the timeout after which an RX
> interrupt is triggered even if the FIFO is not filled. This patch allows
> changing the default (15 bits of silence) using the existing sysfs
> attribute "rx_fifo_timeout".

Thanks for the update!

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
