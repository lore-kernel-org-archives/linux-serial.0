From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] serial: sh-sci: Fix exclusion of work_fn_rx and sci_dma_rx_complete
Date: Wed, 15 Jul 2015 14:53:56 +0200
Message-ID: <CAMuHMdXMLaNUYg4zNu5WoyEE2_shTVxuc5ksfLPZvxzbYjNSyA@mail.gmail.com>
References: <1434302839-31216-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1434302839-31216-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Kaneko-san, Mizuguchi-san,

On Sun, Jun 14, 2015 at 7:27 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> There is a problem when the sci_dma_rx_complete() is processed
> before cancel process of work_fn_rx() completes by rx_timer_fn().
> This patch locks work_fn_rx().
>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thanks for your patch!

Unfortunately this is not sufficient. work_fn_rx() may race with
sci_rx_dma_release(), too.

> ---
>
> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
> tree.
>
>  drivers/tty/serial/sh-sci.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index b74a644..ef59842 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1423,14 +1423,16 @@ static void work_fn_rx(struct work_struct *work)
>         struct uart_port *port = &s->port;
>         struct dma_async_tx_descriptor *desc;
>         int new;
> +       unsigned long flags;
>
> +       spin_lock_irqsave(&port->lock, flags);
>         if (s->active_rx == s->cookie_rx[0]) {
>                 new = 0;
>         } else if (s->active_rx == s->cookie_rx[1]) {
>                 new = 1;
>         } else {
>                 dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
> -               return;
> +               goto out;
>         }
>         desc = s->desc_rx[new];
>
> @@ -1440,36 +1442,35 @@ static void work_fn_rx(struct work_struct *work)
>                 struct dma_chan *chan = s->chan_rx;
>                 struct shdma_desc *sh_desc = container_of(desc,
>                                         struct shdma_desc, async_tx);
> -               unsigned long flags;
>                 int count;
>
>                 dmaengine_terminate_all(chan);
>                 dev_dbg(port->dev, "Read %zu bytes with cookie %d\n",
>                         sh_desc->partial, sh_desc->cookie);
>
> -               spin_lock_irqsave(&port->lock, flags);
>                 count = sci_dma_rx_push(s, sh_desc->partial);
> -               spin_unlock_irqrestore(&port->lock, flags);
>
>                 if (count)
>                         tty_flip_buffer_push(&port->state->port);
>
>                 sci_submit_rx(s);
>
> -               return;
> +               goto out;
>         }
>
>         s->cookie_rx[new] = desc->tx_submit(desc);
>         if (s->cookie_rx[new] < 0) {
>                 dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
>                 sci_rx_dma_release(s, true);
> -               return;
> +               goto out;
>         }
>
>         s->active_rx = s->cookie_rx[!new];
>
>         dev_dbg(port->dev, "%s: cookie %d #%d, new active #%d\n",
>                 __func__, s->cookie_rx[new], new, s->active_rx);
> +out:
> +       spin_unlock_irqrestore(&port->lock, flags);
>  }
>
>  static void work_fn_tx(struct work_struct *work)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
