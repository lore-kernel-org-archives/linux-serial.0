From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: 8250_dw: 8250_dw need to depend on COMMON_CLK
Date: Tue, 12 Jun 2018 10:31:51 +0200
Message-ID: <CAMuHMdVZjPRknHY-3b7qr+FgwWmK3g3rCgjjK09Thh2EOLXbcQ@mail.gmail.com>
References: <1528310824-12706-1-git-send-email-clabbe@baylibre.com> <CAHp75Ve3nDsoEh0dL=xF3oei_GM9tPn_72=je+FESO=hJFm4uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ve3nDsoEh0dL=xF3oei_GM9tPn_72=je+FESO=hJFm4uA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Corentin Labbe <clabbe@baylibre.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 11, 2018 at 11:03 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 6, 2018 at 10:27 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> > This patch fix the following build error on M68K:

Not plain m68k, but coldfire only (and MIPS AR7, I guess).

> > drivers/tty/serial/8250/8250_dw.o: In function `dw8250_set_termios':
> > 8250_dw.c:(.text+0x50c): undefined reference to `clk_round_rate'
> > 8250_dw.c:(.text+0x594): undefined reference to `clk_set_rate'
> >
> > So 8250_dw need to depend on COMMON_CLK.
> >
>
> Makes sense.
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Please see "[PATCH 0/3] Legacy clock drivers: Normalize clk API"
(https://lkml.org/lkml/2018/6/11/122).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
