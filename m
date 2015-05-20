From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] serial: sh-sci: Remove schedule_work in sci_dma_rx_complete
Date: Wed, 20 May 2015 10:50:10 +0200
Message-ID: <CAMuHMdW7dTbEQ6WDZ4fAdoXefn+hRVYfDK_pXX+_xwRY8GDufg@mail.gmail.com>
References: <1431877830-4877-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1431877830-4877-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Kaneko-san, Mizuguchi-san,

On Sun, May 17, 2015 at 5:50 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> This patch calls work_fn_rx() directly so that the driver can avoid
> executing of next sci_dma_rx_complete() before work_fn_rx() completes.

What happened when sci_dma_rx_complete() was executed again before
work_fn_rx() completed? Anything bad?

> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
> tree.
>
> v2 [Yoshihiro Kaneko]
> * Move work_fn_rx() up and remove a function prototype accorded
>
>  drivers/tty/serial/sh-sci.c | 225 ++++++++++++++++++++++----------------------
>  1 file changed, 113 insertions(+), 112 deletions(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index e7d6566..5b216ea 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

> @@ -1341,7 +1453,7 @@ static void sci_dma_rx_complete(void *arg)
>         if (count)
>                 tty_flip_buffer_push(&port->state->port);
>
> -       schedule_work(&s->work_rx);
> +       work_fn_rx(&s->work_rx);
>  }

There's still a call to schedule_work(&s->work_rx) in rx_timer_fn().
Which means that if work_fn_rx() in the DMA callback takes longer than the
expiration of the timer, work_fn_rx() may be re-entered through the workqueue.
Oops...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
