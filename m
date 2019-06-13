From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: fix uninitialized variable warning
Date: Thu, 13 Jun 2019 22:13:07 +0200
Message-ID: <CAMuHMdWVbPVRp3tFMVA6HLLESMBp3qdEFUftPGK=Sd8pF_GorA@mail.gmail.com>
References: <20190613180824.6ajwjelzr5fmjnie@debie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613180824.6ajwjelzr5fmjnie@debie>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles <18oliveira.charles@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rodrigosiqueiramelo@gmail.com
List-Id: linux-serial@vger.kernel.org

Hi Charles,

On Thu, Jun 13, 2019 at 8:09 PM Charles <18oliveira.charles@gmail.com> wrote:
> Avoid following compiler warning on uninitialized variable
>
> In file included from ./include/linux/rwsem.h:16:0,
>                  from ./include/linux/notifier.h:15,
>                  from ./include/linux/clk.h:17,
>                  from drivers/tty/serial/sh-sci.c:24:
> drivers/tty/serial/sh-sci.c: In function ‘sci_dma_rx_submit’:
> ./include/linux/spinlock.h:288:3: warning: ‘flags’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/sh-sci.c:1353:16: note: ‘flags’ was declared here
>   unsigned long flags;
>                 ^~~~~
>
> Signed-off-by: Charles Oliveira <18oliveira.charles@gmail.com>

Thanks for your patch, but this is a false positive: the compiler is not
smart enough to realize that both initialization and use depend on
the same condition.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
