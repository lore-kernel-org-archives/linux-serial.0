From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] the eDMA support for the LPUART send driver
Date: Mon, 6 Jan 2014 13:37:34 +0800
Message-ID: <20140106053730.GA27227@S2101-09.ap.freescale.net>
References: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:53830
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750857AbaAFFgz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Jan 2014 00:36:55 -0500
Content-Disposition: inline
In-Reply-To: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 27, 2013 at 07:24:09PM +0800, Yuan Yao wrote:
> This patch add eDMA support for LPUART send function.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi    |  12 +++
>  drivers/tty/serial/fsl_lpuart.c | 187 ++++++++++++++++++++++++++++++++--------

Please split it into two patches.  The vf610.dtsi part should go via
arm-soc tree.

Shawn

>  2 files changed, 163 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index 365e0fa..35d7a79 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -118,6 +118,9 @@
>  				interrupts = <0 61 0x00>;
>  				clocks = <&clks VF610_CLK_UART0>;
>  				clock-names = "ipg";
> +				dma-names = "lpuart-rx","lpuart-tx";
> +				dmas = <&edma0 0 VF610_EDMA_MUXID0_UART0_RX>,
> +				       <&edma0 0 VF610_EDMA_MUXID0_UART0_TX>;
>  				status = "disabled";
>  			};
>  
> @@ -127,6 +130,9 @@
>  				interrupts = <0 62 0x04>;
>  				clocks = <&clks VF610_CLK_UART1>;
>  				clock-names = "ipg";
> +				dma-names = "lpuart-rx","lpuart-tx";
> +				dmas = <&edma0 0 VF610_EDMA_MUXID0_UART1_RX>,
> +				       <&edma0 0 VF610_EDMA_MUXID0_UART1_TX>;
>  				status = "disabled";
>  			};
>  
> @@ -136,6 +142,9 @@
>  				interrupts = <0 63 0x04>;
>  				clocks = <&clks VF610_CLK_UART2>;
>  				clock-names = "ipg";
> +				dma-names = "lpuart-rx","lpuart-tx";
> +				dmas = <&edma0 0 VF610_EDMA_MUXID0_UART2_RX>,
> +				       <&edma0 0 VF610_EDMA_MUXID0_UART2_TX>;
>  				status = "disabled";
>  			};
>  
> @@ -145,6 +154,9 @@
>  				interrupts = <0 64 0x04>;
>  				clocks = <&clks VF610_CLK_UART3>;
>  				clock-names = "ipg";
> +				dma-names = "lpuart-rx","lpuart-tx";
> +				dmas = <&edma0 0 VF610_EDMA_MUXID0_UART3_RX>,
> +				       <&edma0 0 VF610_EDMA_MUXID0_UART3_TX>;
>  				status = "disabled";
>  			};
>  
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 8978dc9..8375141 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -13,14 +13,19 @@
>  #define SUPPORT_SYSRQ
>  #endif
>  
> -#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/console.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dmapool.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> -#include <linux/clk.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/console.h>
> +#include <linux/of_dma.h>
>  #include <linux/serial_core.h>
> +#include <linux/slab.h>
>  #include <linux/tty_flip.h>
>  
>  /* All registers are 8-bit width */
> @@ -112,6 +117,9 @@
>  #define UARTSFIFO_TXOF		0x02
>  #define UARTSFIFO_RXUF		0x01
>  
> +#define DMA_MAXBURST		16
> +#define DMA_MAXBURST_MASK	(DMA_MAXBURST - 1)
> +
>  #define DRIVER_NAME	"fsl-lpuart"
>  #define DEV_NAME	"ttyLP"
>  #define UART_NR		6
> @@ -121,6 +129,13 @@ struct lpuart_port {
>  	struct clk		*clk;
>  	unsigned int		txfifo_size;
>  	unsigned int		rxfifo_size;
> +	struct dma_chan		*tx_dma_lpuart;
> +	struct dma_async_tx_descriptor  *tx_dma_desc;
> +	dma_addr_t		tx_dma_buf_phys;
> +	dma_cookie_t		tx_cookie;
> +	unsigned char		*tx_dma_buf_virt;
> +	unsigned int		tx_bytes;
> +	int			tx_in_progress;
>  };
>  
>  static struct of_device_id lpuart_dt_ids[] = {
> @@ -131,6 +146,9 @@ static struct of_device_id lpuart_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
>  
> +static int lpuart_dma_tx(struct lpuart_port *sport, unsigned long count);
> +static void lpuart_prepare_tx(struct lpuart_port *sport);
> +
>  static void lpuart_stop_tx(struct uart_port *port)
>  {
>  	unsigned char temp;
> @@ -152,12 +170,36 @@ static void lpuart_enable_ms(struct uart_port *port)
>  {
>  }
>  
> -static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
> +static void lpuart_dma_tx_complete(void *arg)
> +{
> +	struct lpuart_port *sport = arg;
> +	struct circ_buf *xmit = &sport->port.state->xmit;
> +	unsigned long flags;
> +
> +	async_tx_ack(sport->tx_dma_desc);
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +
> +	xmit->tail = (xmit->tail + sport->tx_bytes) & (UART_XMIT_SIZE - 1);
> +	sport->tx_in_progress = 0;
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(&sport->port);
> +
> +	lpuart_prepare_tx(sport);
> +
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +}
> +
> +static void lpuart_pio_tx(struct lpuart_port *sport)
>  {
>  	struct circ_buf *xmit = &sport->port.state->xmit;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
>  
>  	while (!uart_circ_empty(xmit) &&
> -		(readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size)) {
> +		readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size) {
>  		writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
>  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>  		sport->port.icount.tx++;
> @@ -167,46 +211,69 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
>  		uart_write_wakeup(&sport->port);
>  
>  	if (uart_circ_empty(xmit))
> -		lpuart_stop_tx(&sport->port);
> -}
> +		writeb(readb(sport->port.membase + UARTCR5) | UARTCR5_TDMAS,
> +			sport->port.membase + UARTCR5);
>  
> -static void lpuart_start_tx(struct uart_port *port)
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +}
> +
> +static int lpuart_dma_tx(struct lpuart_port *sport, unsigned long count)
>  {
> -	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
> -	unsigned char temp;
> +	struct circ_buf *xmit = &sport->port.state->xmit;
> +	dma_addr_t tx_phys_addr;
> +
> +	dma_sync_single_for_device(sport->port.dev, sport->tx_dma_buf_phys,
> +				UART_XMIT_SIZE, DMA_TO_DEVICE);
> +	sport->tx_bytes = count & ~(DMA_MAXBURST_MASK);
> +	tx_phys_addr = sport->tx_dma_buf_phys + xmit->tail;
> +	sport->tx_dma_desc = dmaengine_prep_slave_single(sport->tx_dma_lpuart,
> +					tx_phys_addr, sport->tx_bytes,
> +					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
> +
> +	if (!sport->tx_dma_desc) {
> +		dev_err(sport->port.dev, "Not able to get desc for Tx\n");
> +		return -EIO;
> +	}
>  
> -	temp = readb(port->membase + UARTCR2);
> -	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
> +	sport->tx_dma_desc->callback = lpuart_dma_tx_complete;
> +	sport->tx_dma_desc->callback_param = sport;
> +	sport->tx_in_progress = 1;
> +	sport->tx_cookie = dmaengine_submit(sport->tx_dma_desc);
> +	dma_async_issue_pending(sport->tx_dma_lpuart);
>  
> -	if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
> -		lpuart_transmit_buffer(sport);
> +	return 0;
>  }
>  
> -static irqreturn_t lpuart_txint(int irq, void *dev_id)
> +static void lpuart_prepare_tx(struct lpuart_port *sport)
>  {
> -	struct lpuart_port *sport = dev_id;
>  	struct circ_buf *xmit = &sport->port.state->xmit;
> -	unsigned long flags;
> +	unsigned long count =  CIRC_CNT_TO_END(xmit->head,
> +					xmit->tail, UART_XMIT_SIZE);
>  
> -	spin_lock_irqsave(&sport->port.lock, flags);
> -	if (sport->port.x_char) {
> -		writeb(sport->port.x_char, sport->port.membase + UARTDR);
> -		goto out;
> -	}
> -
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
> -		lpuart_stop_tx(&sport->port);
> -		goto out;
> -	}
> +	if (!count)
> +		return;
>  
> -	lpuart_transmit_buffer(sport);
> +	if (count < DMA_MAXBURST)
> +		writeb(readb(sport->port.membase + UARTCR5) & ~UARTCR5_TDMAS,
> +				sport->port.membase + UARTCR5);
> +	else
> +		lpuart_dma_tx(sport, count);
> +}
> +
> +static void lpuart_start_tx(struct uart_port *port)
> +{
> +	struct lpuart_port *sport = container_of(port,
> +			struct lpuart_port, port);
> +	struct circ_buf *xmit = &sport->port.state->xmit;
> +	unsigned char temp;
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> -		uart_write_wakeup(&sport->port);
> +	temp = readb(port->membase + UARTCR2);
> +	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
> +	temp = readb(port->membase + UARTCR5);
> +	writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
>  
> -out:
> -	spin_unlock_irqrestore(&sport->port.lock, flags);
> -	return IRQ_HANDLED;
> +	if (!uart_circ_empty(xmit) && !sport->tx_in_progress)
> +		lpuart_prepare_tx(sport);
>  }
>  
>  static irqreturn_t lpuart_rxint(int irq, void *dev_id)
> @@ -283,8 +346,9 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
>  		lpuart_rxint(irq, dev_id);
>  
>  	if (sts & UARTSR1_TDRE &&
> -		!(readb(sport->port.membase + UARTCR5) & UARTCR5_TDMAS))
> -		lpuart_txint(irq, dev_id);
> +		!(readb(sport->port.membase + UARTCR5) & UARTCR5_TDMAS)) {
> +		lpuart_pio_tx(sport);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -366,13 +430,60 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
>  	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
>  			sport->port.membase + UARTCFIFO);
>  
> -	writeb(2, sport->port.membase + UARTTWFIFO);
> +	writeb(0, sport->port.membase + UARTTWFIFO);
>  	writeb(1, sport->port.membase + UARTRWFIFO);
>  
>  	/* Restore cr2 */
>  	writeb(cr2_saved, sport->port.membase + UARTCR2);
>  }
>  
> +static int fsl_request_dma(struct uart_port *port)
> +{
> +	struct lpuart_port *sport = container_of(port,
> +					struct lpuart_port, port);
> +	struct dma_chan *tx_chan;
> +	struct dma_slave_config dma_tx_sconfig;
> +	dma_addr_t dma_phys;
> +	unsigned char *dma_buf;
> +	int ret;
> +
> +	tx_chan  = dma_request_slave_channel(sport->port.dev, "lpuart-tx");
> +
> +	if (!tx_chan) {
> +		dev_err(sport->port.dev, "Dma TX channel request failed!\n");
> +		return -ENODEV;
> +	}
> +
> +	dma_phys = dma_map_single(sport->port.dev,
> +				sport->port.state->xmit.buf,
> +				UART_XMIT_SIZE, DMA_TO_DEVICE);
> +
> +	if (!dma_phys) {
> +		dev_err(sport->port.dev, "Dma_phys single failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	dma_buf = sport->port.state->xmit.buf;
> +	dma_tx_sconfig.dst_addr = sport->port.mapbase + UARTDR;
> +	dma_tx_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_tx_sconfig.dst_maxburst = DMA_MAXBURST;
> +	dma_tx_sconfig.direction = DMA_MEM_TO_DEV;
> +	ret = dmaengine_slave_config(tx_chan, &dma_tx_sconfig);
> +
> +	if (ret < 0) {
> +		dev_err(sport->port.dev,
> +				"Dma slave config failed, err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	sport->tx_dma_lpuart = tx_chan;
> +	sport->tx_dma_buf_virt = dma_buf;
> +	sport->tx_dma_buf_phys = dma_phys;
> +	sport->tx_in_progress = 0;
> +
> +	return 0;
> +}
> +
>  static int lpuart_startup(struct uart_port *port)
>  {
>  	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
> @@ -380,6 +491,7 @@ static int lpuart_startup(struct uart_port *port)
>  	unsigned long flags;
>  	unsigned char temp;
>  
> +	fsl_request_dma(port);
>  	ret = devm_request_irq(port->dev, port->irq, lpuart_int, 0,
>  				DRIVER_NAME, sport);
>  	if (ret)
> @@ -393,6 +505,9 @@ static int lpuart_startup(struct uart_port *port)
>  	temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
>  	writeb(temp, sport->port.membase + UARTCR2);
>  
> +	temp = readb(port->membase + UARTCR5);
> +	writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
> +
>  	spin_unlock_irqrestore(&sport->port.lock, flags);
>  	return 0;
>  }
> -- 
> 1.8.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

