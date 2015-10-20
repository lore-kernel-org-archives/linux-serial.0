From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: Fix length of scatterlist
Date: Tue, 20 Oct 2015 14:22:23 +0200
Message-ID: <CAMuHMdVNeSMnFqRxxqmP+v8PBVnzoh3sdyMyqt_3=USoL=09Vw@mail.gmail.com>
References: <1445343502-4436-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1445343502-4436-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Shimoda-san,

On Tue, Oct 20, 2015 at 2:18 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch fixes an issue that the "length" of scatterlist should be
> set using sh_dma_length(). Otherwise, a dmaengine driver cannot work

sg_dma_len()?

> correctly if CONFIG_NEED_SG_DMA_LENGTH=y.
>
> Fixes: 7b39d90184 (serial: sh-sci: Fix NULL pointer dereference if HIGHMEM is enabled)
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/tty/serial/sh-sci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 960e50a..284a872 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1437,7 +1437,7 @@ static void sci_request_dma(struct uart_port *port)
>                         sg_init_table(sg, 1);
>                         s->rx_buf[i] = buf;
>                         sg_dma_address(sg) = dma;
> -                       sg->length = s->buf_len_rx;
> +                       sg_dma_length(sg) = s->buf_len_rx;

There's no definition for "sg_dma_length" in my tree?? sg_dma_len()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
