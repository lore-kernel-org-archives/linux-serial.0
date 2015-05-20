From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add R-Car SCIF DMA receive support
Date: Wed, 20 May 2015 11:40:43 +0200
Message-ID: <CAMuHMdVKWEK2y=y+wAF3r4Etxha4WhTe1O0u+RX3W8nH8AXq=g@mail.gmail.com>
References: <1430500294-23407-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430500294-23407-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Kaneko-san, Matsuoka-san, Mizuguchi-san,

On Fri, May 1, 2015 at 7:11 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thanks for your patch!

BTW, with which DMA engine was this tested? The old shdmac or the new
rcar-dmac?

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

> @@ -1348,13 +1363,26 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
>  {
>         struct dma_chan *chan = s->chan_rx;
>         struct uart_port *port = &s->port;
> +       size_t buf_len_rx;
> +       int t = 100000;
> +
> +       s->rx_release_flag = 1;
> +       while (t--) {
> +               if (!s->rx_flag)
> +                       break;
> +               usleep_range(10, 50);
> +       }

This is done to make sure rx DMA has completed before releasing the channel
(and setting s->chan_rx = NULL)?

Is there a better way to wait for this, without looping?

>         s->chan_rx = NULL;

> @@ -1419,11 +1457,19 @@ static void work_fn_rx(struct work_struct *work)
>         struct uart_port *port = &s->port;
>         struct dma_async_tx_descriptor *desc;
>         int new;
> +       int next;
> +
> +       if (s->chan_rx == NULL) {
> +               dev_dbg(port->dev, "%s: DMA channel is released.\n", __func__);
> +               return;
> +       }

I believe this is a workaround for the race condition where work_fn_rx()
is called after shutdown of the port, and s->chan_rx has already been set
to NULL in sci_rx_dma_release(), which leads to a NULL pointer dereference
in work_fn_rx()?

As this is a bug fix, it should be a separate patch.

Can this still happen in the presence of the loop until !rx_flag in
sci_rx_dma_release() above?

> @@ -1707,14 +1770,22 @@ static void sci_request_dma(struct uart_port *port)
>         chan = dma_request_channel(mask, filter, param);
>         dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
>         if (chan) {
> -               dma_addr_t dma[2];
> -               void *buf[2];
> +               dma_addr_t dma[3];
> +               void *buf[3];
> +               size_t sum_buf_len;
> +               int nr_sg = 2;
>                 int i;
>
>                 s->chan_rx = chan;
>
>                 s->buf_len_rx = 2 * max(16, (int)port->fifosize);
> -               buf[0] = dma_alloc_coherent(port->dev, s->buf_len_rx * 2,
> +               if (port->type == PORT_SCIF || port->type == PORT_HSCIF) {
> +                       nr_sg = 3;
> +                       sum_buf_len = 1 + s->buf_len_rx * 2;
> +               } else {
> +                       sum_buf_len = s->buf_len_rx * 2;
> +               }
> +               buf[0] = dma_alloc_coherent(port->dev, sum_buf_len,
>                                             &dma[0], GFP_KERNEL);

I think the code manipulating the buffers can be simplified a lot by
storing in sci_port:
  - The number of buffers in use (2 vs. 3),
  - The sizes of the individual buffers.

That way you can remove many checks for (H)SCIF, and avoid recalculating the
buffer sizes everywhere.

> @@ -1778,7 +1863,6 @@ static int sci_startup(struct uart_port *port)
>
>         spin_lock_irqsave(&port->lock, flags);
>         sci_start_tx(port);
> -       sci_start_rx(port);

Why is this needed?

> @@ -1796,6 +1880,8 @@ static void sci_shutdown(struct uart_port *port)
>         sci_stop_tx(port);
>         spin_unlock_irqrestore(&port->lock, flags);
>
> +       serial_port_out(port, SCSCR, 0x00);

Isn't this already handled by sci_stop_tx() above, and by sci_stop_rx() in
the line above that (not visible in the patch)?
Which additional bits do you need to clear?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
