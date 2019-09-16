From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 3/4] serial: imx: adapt rx buffer and dma periods
Date: Mon, 16 Sep 2019 16:24:17 +0200
Message-ID: <b5c905fadc332ae2ddb30f3f890ff8deff81de71.camel@pengutronix.de>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
         <20190911144943.21554-4-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190911144943.21554-4-philipp.puschmann@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Puschmann <philipp.puschmann@emlix.com>, linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, gregkh@linuxfoundation.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mi, 2019-09-11 at 16:49 +0200, Philipp Puschmann wrote:
> Using only 4 DMA periods for UART RX is very few if we have a high
> frequency of small transfers - like in our case using Bluetooth with many
> small packets via UART - causing many dma transfers but in each only
> filling a fraction of a single buffer. Such a case may lead to the
> situation that DMA RX transfer is triggered but no buffer is available.
> While we have addressed the dma handling already we still want to avoid
> UART RX FIFO overrun. So we decrease the size of the buffers and increase
> their number and the total buffer size.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>

Reasoning seems sound:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/tty/serial/imx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 57d6e6ba556e..cdc51569237c 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1028,8 +1028,6 @@ static void imx_uart_timeout(struct timer_list *t)
>  	}
>  }
>  
> -#define RX_BUF_SIZE	(PAGE_SIZE)
> -
>  /*
>   * There are two kinds of RX DMA interrupts(such as in the MX6Q):
>   *   [1] the RX DMA buffer is full.
> @@ -1112,7 +1110,8 @@ static void imx_uart_dma_rx_callback(void *data)
>  }
>  
>  /* RX DMA buffer periods */
> -#define RX_DMA_PERIODS 4
> +#define RX_DMA_PERIODS	16
> +#define RX_BUF_SIZE	(PAGE_SIZE / 4)
>  
>  static int imx_uart_start_rx_dma(struct imx_port *sport)
>  {
