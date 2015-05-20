From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 8/8] serial: tegra: Correct error handling on DMA setup
Date: Wed, 20 May 2015 10:51:59 +0100
Message-ID: <555C593F.5040107@nvidia.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com> <1430835479-6613-9-git-send-email-jonathanh@nvidia.com> <CAAVeFuL=z-xbGT1e_L6+_GQ8aZ0BvNBfmoi65u_7qVHv=tpTbA@mail.gmail.com> <5551CD25.4030206@nvidia.com> <CAAVeFuLUVHJMPjy3y6bw9J7iQHb+is-SR_5H-=TCe4yoyEGRqQ@mail.gmail.com> <555309F4.1080306@nvidia.com> <CAAVeFuL8XoQUykpVbzgJiYNkoXA0e7c1k95nvB6Q+wZUHjOjSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAVeFuL8XoQUykpVbzgJiYNkoXA0e7c1k95nvB6Q+wZUHjOjSw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


On 20/05/15 04:57, Alexandre Courbot wrote:

[snip]

> There may still be a leak (that is not related to your patch) in the
> RX path though:
> 
>     dma_buf = dma_alloc_coherent(...);
>     ret = dmaengine_slave_config(...);
>     if (ret < 0) {
>         ...
>         goto scrub;
>     }
> 
>     tup->rx_dma_buf_virt = dma_buf;
>     tup->rx_dma_buf_phys = dma_phys;
> 
> scrub:
>     dma_release_channel(dma_chan);
>     return ret;
> 
> It seems that if dmaengine_slave_config() fails, then the result of
> dma_alloc_coherent() remains purely local to the function and is never
> freed. Or am I missing something again?

Yes, you are right here. Actually, this would be applicable to
both RX and TX paths because in the TX path the buffer would
not be unmapped. I will generated a separate patch for fix
this. How does the following look?

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 3b63f103f0c9..cf0133ae762d 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -999,6 +999,12 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
                        dma_release_channel(dma_chan);
                        return -ENOMEM;
                }
+               dma_sconfig.src_addr = tup->uport.mapbase;
+               dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+               dma_sconfig.src_maxburst = 4;
+               tup->rx_dma_chan = dma_chan;
+               tup->rx_dma_buf_virt = dma_buf;
+               tup->rx_dma_buf_phys = dma_phys;
        } else {
                dma_phys = dma_map_single(tup->uport.dev,
                        tup->uport.state->xmit.buf, UART_XMIT_SIZE,
@@ -1009,39 +1015,23 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
                        return -ENOMEM;
                }
                dma_buf = tup->uport.state->xmit.buf;
-       }
-
-       if (dma_to_memory) {
-               dma_sconfig.src_addr = tup->uport.mapbase;
-               dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-               dma_sconfig.src_maxburst = 4;
-       } else {
                dma_sconfig.dst_addr = tup->uport.mapbase;
                dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
                dma_sconfig.dst_maxburst = 16;
+               tup->tx_dma_chan = dma_chan;
+               tup->tx_dma_buf_virt = dma_buf;
+               tup->tx_dma_buf_phys = dma_phys;
        }
 
        ret = dmaengine_slave_config(dma_chan, &dma_sconfig);
        if (ret < 0) {
                dev_err(tup->uport.dev,
                        "Dma slave config failed, err = %d\n", ret);
-               goto scrub;
+               tegra_uart_dma_channel_free(tup, dma_to_memory);
+               return ret;
        }
 
-       if (dma_to_memory) {
-               tup->rx_dma_chan = dma_chan;
-               tup->rx_dma_buf_virt = dma_buf;
-               tup->rx_dma_buf_phys = dma_phys;
-       } else {
-               tup->tx_dma_chan = dma_chan;
-               tup->tx_dma_buf_virt = dma_buf;
-               tup->tx_dma_buf_phys = dma_phys;
-       }
        return 0;
-
-scrub:
-       tegra_uart_dma_channel_free(tup, dma_to_memory);
-       return ret;
 }
 
Cheers
Jon
