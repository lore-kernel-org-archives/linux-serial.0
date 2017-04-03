From: Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH v3 1/3] serial: samsung: Use right device for DMA-mapping calls
Date: Mon, 3 Apr 2017 07:42:54 -0600
Message-ID: <CAKocOONgzKoFrW1wfP3tsudd5ZiP-ovANORc67O=uCc99eVZnA@mail.gmail.com>
References: <CGME20170403062115eucas1p25b1504b3441f1195129bbedad261494c@eucas1p2.samsung.com>
 <1491200468-28463-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1491200468-28463-1-git-send-email-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>, stable <stable@vger.kernel.org>, shuahkh@osg.samsung.com
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 3, 2017 at 12:20 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Driver should provide its own struct device for all DMA-mapping calls instead
> of extracting device pointer from DMA engine channel. Although this is harmless
> from the driver operation perspective on ARM architecture, it is always good
> to use the DMA mapping API in a proper way. This patch fixes following DMA API
> debug warning:
>
> WARNING: CPU: 0 PID: 0 at lib/dma-debug.c:1241 check_sync+0x520/0x9f4
> samsung-uart 12c20000.serial: DMA-API: device driver tries to sync DMA memory it has not allocated [device address=0x000000006df0f580] [size=64 bytes]
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.11.0-rc1-00137-g07ca963 #51
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c011aaa4>] (unwind_backtrace) from [<c01127c0>] (show_stack+0x20/0x24)
> [<c01127c0>] (show_stack) from [<c06ba5d8>] (dump_stack+0x84/0xa0)
> [<c06ba5d8>] (dump_stack) from [<c0139528>] (__warn+0x14c/0x180)
> [<c0139528>] (__warn) from [<c01395a4>] (warn_slowpath_fmt+0x48/0x50)
> [<c01395a4>] (warn_slowpath_fmt) from [<c0729058>] (check_sync+0x520/0x9f4)
> [<c0729058>] (check_sync) from [<c072967c>] (debug_dma_sync_single_for_device+0x88/0xc8)
> [<c072967c>] (debug_dma_sync_single_for_device) from [<c0803c10>] (s3c24xx_serial_start_tx_dma+0x100/0x2f8)
> [<c0803c10>] (s3c24xx_serial_start_tx_dma) from [<c0804338>] (s3c24xx_serial_tx_chars+0x198/0x33c)
>
> Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Fixes: 62c37eedb74c8 ("serial: samsung: add dma reqest/release functions")
> CC: stable@vger.kernel.org # v4.0+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

The change looks good.

Reviewed-by: Shuah Khan <shuahkh@osg.samsung.com>

-- Shuah

> ---
> v3:
> - extended commit message
>
> v2:
> - fixed commit id in 'fixes' tag, added 'reviewed-by' tag
> ---
>  drivers/tty/serial/samsung.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 7a17aedbf902..9f3759bdb44f 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -901,14 +901,13 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>                 return -ENOMEM;
>         }
>
> -       dma->rx_addr = dma_map_single(dma->rx_chan->device->dev, dma->rx_buf,
> +       dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
>                                 dma->rx_size, DMA_FROM_DEVICE);
>
>         spin_lock_irqsave(&p->port.lock, flags);
>
>         /* TX buffer */
> -       dma->tx_addr = dma_map_single(dma->tx_chan->device->dev,
> -                               p->port.state->xmit.buf,
> +       dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
>                                 UART_XMIT_SIZE, DMA_TO_DEVICE);
>
>         spin_unlock_irqrestore(&p->port.lock, flags);
> @@ -922,7 +921,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>
>         if (dma->rx_chan) {
>                 dmaengine_terminate_all(dma->rx_chan);
> -               dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
> +               dma_unmap_single(p->port.dev, dma->rx_addr,
>                                 dma->rx_size, DMA_FROM_DEVICE);
>                 kfree(dma->rx_buf);
>                 dma_release_channel(dma->rx_chan);
> @@ -931,7 +930,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>
>         if (dma->tx_chan) {
>                 dmaengine_terminate_all(dma->tx_chan);
> -               dma_unmap_single(dma->tx_chan->device->dev, dma->tx_addr,
> +               dma_unmap_single(p->port.dev, dma->tx_addr,
>                                 UART_XMIT_SIZE, DMA_TO_DEVICE);
>                 dma_release_channel(dma->tx_chan);
>                 dma->tx_chan = NULL;
> --
> 1.9.1
>
