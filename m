From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add R-Car SCIF DMA receive support
Date: Wed, 13 May 2015 11:18:59 +0200
Message-ID: <CAMuHMdWE03xpqXtEGzORQF3_L1v-UMux_2v76vkM0=hoOKFEOg@mail.gmail.com>
References: <1430500294-23407-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430500294-23407-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
List-Id: linux-serial@vger.kernel.org

Hi Kaneko-san,

On Fri, May 1, 2015 at 7:11 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thank you for your patch! I will give it a try...

It would be nice to have some more information in the patch description.
E.g. what it's doing, and why it's needed.

> ---
>
> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
> tree.
>
> This patch is the result of squashing two patches.
> One, of the same name, by Koji Matsuoka. And a second small fix by
> Kazuya Mizuguchi. Accordingly I have included both authors signed-off-by
> lines above.
>
>  drivers/tty/serial/sh-sci.c | 142 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 114 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index e7d6566..65cc72a 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1,4 +1,8 @@
>  /*
> + * drivers/tty/serial/sh-sci.c

It's preferred to not put full paths in source files, as the source file
may be moved later.

> + *
> + *  Copyright (C) 2014 Renesas Electronics Corporation
> + *
>   * SuperH on-chip serial module support.  (SCI with no FIFO / with FIFO)
>   *
>   *  Copyright (C) 2002 - 2011  Paul Mundt
> @@ -103,13 +107,13 @@ struct sci_port {
>
>  #ifdef CONFIG_SERIAL_SH_SCI_DMA
>         struct dma_async_tx_descriptor  *desc_tx;
> -       struct dma_async_tx_descriptor  *desc_rx[2];
> +       struct dma_async_tx_descriptor  *desc_rx[3];
>         dma_cookie_t                    cookie_tx;
> -       dma_cookie_t                    cookie_rx[2];
> +       dma_cookie_t                    cookie_rx[3];
>         dma_cookie_t                    active_rx;
>         struct scatterlist              sg_tx;
>         unsigned int                    sg_len_tx;
> -       struct scatterlist              sg_rx[2];
> +       struct scatterlist              sg_rx[3];

Why do you need 3 scatter lists?

>         size_t                          buf_len_rx;
>         struct sh_dmae_slave            param_tx;
>         struct sh_dmae_slave            param_rx;
> @@ -117,6 +121,8 @@ struct sci_port {

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

The above part looks a bit fishy to me... Isn't there a better way to wait?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
