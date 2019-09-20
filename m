From: Andy Duan <fugang.duan@nxp.com>
Subject: RE: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
Date: Fri, 20 Sep 2019 03:42:57 +0000
Message-ID: <VI1PR0402MB3600CA068AEBAC63D3CE6A4CFF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190919145114.13006-1-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190919145114.13006-1-philipp.puschmann@emlix.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philipp Puschmann <philipp.puschmann@emlix.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "festevam@gmail.com" <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "jslaby@suse.com" <jslaby@suse.com>, Robin Gong <yibin.gong@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

From: Philipp Puschmann <philipp.puschmann@emlix.com> Sent: Thursday, September 19, 2019 10:51 PM
> Using only 4 DMA periods for UART RX is very few if we have a high frequency
> of small transfers - like in our case using Bluetooth with many small packets
> via UART - causing many dma transfers but in each only filling a fraction of a
> single buffer. Such a case may lead to the situation that DMA RX transfer is
> triggered but no free buffer is available. When this happens dma channel ist
> stopped - with the patch
> "dmaengine: imx-sdma: fix dma freezes" temporarily only - with the possible
> consequences that:
> with disabled hw flow control:
>   If enough data is incoming on UART port the RX FIFO runs over and
>   characters will be lost. What then happens depends on upper layer.
> 
> with enabled hw flow control:
>   If enough data is incoming on UART port the RX FIFO reaches a level
>   where CTS is deasserted and remote device sending the data stops.
>   If it fails to stop timely the i.MX' RX FIFO may run over and data
>   get lost. Otherwise it's internal TX buffer may getting filled to
>   a point where it runs over and data is again lost. It depends on
>   the remote device how this case is handled and if it is recoverable.
> 
> Obviously we want to avoid having no free buffers available. So we decrease
> the size of the buffers and increase their number and the total buffer size.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> 
> Changelog v3:
>  - enhance description
> 
> Changelog v2:
>  - split this patch from series "Fix UART DMA freezes for iMX6"
>  - add Reviewed-by tag
> 
>  drivers/tty/serial/imx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> 87c58f9f6390..51dc19833eab 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1034,8 +1034,6 @@ static void imx_uart_timeout(struct timer_list *t)
>         }
>  }
> 
> -#define RX_BUF_SIZE    (PAGE_SIZE)
> -
>  /*
>   * There are two kinds of RX DMA interrupts(such as in the MX6Q):
>   *   [1] the RX DMA buffer is full.
> @@ -1118,7 +1116,8 @@ static void imx_uart_dma_rx_callback(void
> *data)  }
> 
>  /* RX DMA buffer periods */
> -#define RX_DMA_PERIODS 4
> +#define RX_DMA_PERIODS 16
> +#define RX_BUF_SIZE    (PAGE_SIZE / 4)
> 
Why to decrease the DMA RX buffer size here ?

The current DMA implementation support DMA cyclic mode, one SDMA BD receive one Bluetooth frame can
bring better performance.
As you know, for L2CAP, a maximum transmission unit (MTU) associated with the largest Baseband payload
is 341 bytes for DH5 packets.

So I suggest to increase RX_BUF_SIZE along with RX_DMA_PERIODS to feasible value.

Andy

>  static int imx_uart_start_rx_dma(struct imx_port *sport)  {
> --
> 2.23.0
