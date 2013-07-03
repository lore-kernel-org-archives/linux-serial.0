From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/5] serial: imx: add DMA support for imx6
Date: Wed, 3 Jul 2013 11:38:39 +0800
Message-ID: <20130703033837.GE9145@S2101-09.ap.freescale.net>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-3-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:44999 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753143Ab3GCDiR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jul 2013 23:38:17 -0400
Content-Disposition: inline
In-Reply-To: <1372746628-20092-3-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de

On Tue, Jul 02, 2013 at 02:30:25PM +0800, Huang Shijie wrote:
> We only enable the DMA support when the following are meet:
> 
>   [1] The uart port supports the hardware flow control(CTS/RTS).
>       (Some uart port does not support the CTS/RTS.)
> 
>   [2] The application enables the CTS/RTS.
> 
>   [3] The Soc is imx6.
>       For the sdma's firmware limit, we do not support the DMA except
>       the imx6 platform.
> 
>   [4] The uart is not used as a console.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/tty/serial/imx.c |  413 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 408 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index d215fa9..2a4cf89 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -49,9 +49,11 @@
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/io.h>
> +#include <linux/dma-mapping.h>
>  
>  #include <asm/irq.h>
>  #include <linux/platform_data/serial-imx.h>
> +#include <linux/platform_data/dma-imx.h>
>  
>  /* Register definitions */
>  #define URXD0 0x0  /* Receiver Register */
> @@ -83,6 +85,7 @@
>  #define UCR1_ADBR	(1<<14) /* Auto detect baud rate */
>  #define UCR1_TRDYEN	(1<<13) /* Transmitter ready interrupt enable */
>  #define UCR1_IDEN	(1<<12) /* Idle condition interrupt */
> +#define UCR1_ICD_REG(x) (((x) & 3) << 10) /* idle condition detect */
>  #define UCR1_RRDYEN	(1<<9)	/* Recv ready interrupt enable */
>  #define UCR1_RDMAEN	(1<<8)	/* Recv ready DMA enable */
>  #define UCR1_IREN	(1<<7)	/* Infrared interface enable */
> @@ -91,6 +94,7 @@
>  #define UCR1_SNDBRK	(1<<4)	/* Send break */
>  #define UCR1_TDMAEN	(1<<3)	/* Transmitter ready DMA enable */
>  #define IMX1_UCR1_UARTCLKEN (1<<2) /* UART clock enabled, i.mx1 only */
> +#define UCR1_ATDMAEN    (1<<2)  /* Aging DMA Timer Enable */
>  #define UCR1_DOZE	(1<<1)	/* Doze */
>  #define UCR1_UARTEN	(1<<0)	/* UART enabled */
>  #define UCR2_ESCI	(1<<15)	/* Escape seq interrupt enable */
> @@ -126,6 +130,7 @@
>  #define UCR4_ENIRI	(1<<8)	/* Serial infrared interrupt enable */
>  #define UCR4_WKEN	(1<<7)	/* Wake interrupt enable */
>  #define UCR4_REF16	(1<<6)	/* Ref freq 16 MHz */
> +#define UCR4_IDDMAEN    (1<<6)  /* DMA IDLE Condition Detected */
>  #define UCR4_IRSC	(1<<5)	/* IR special case */
>  #define UCR4_TCEN	(1<<3)	/* Transmit complete interrupt enable */
>  #define UCR4_BKEN	(1<<2)	/* Break condition interrupt enable */
> @@ -210,6 +215,19 @@ struct imx_port {
>  	struct clk		*clk_ipg;
>  	struct clk		*clk_per;
>  	const struct imx_uart_data *devdata;
> +
> +	/* DMA fields */
> +	unsigned int		dma_is_inited:1;
> +	unsigned int		dma_is_enabled:1;
> +	unsigned int		dma_is_rxing:1;
> +	unsigned int		dma_is_txing:1;
> +	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
> +	struct scatterlist	rx_sgl, tx_sgl[2];
> +	void			*rx_buf;
> +	unsigned int		rx_bytes, tx_bytes;
> +	struct work_struct	tsk_dma_rx, tsk_dma_tx;
> +	unsigned int		dma_tx_nents;
> +	wait_queue_head_t	dma_wait;
>  };
>  
>  struct imx_port_ucrs {
> @@ -400,6 +418,13 @@ static void imx_stop_tx(struct uart_port *port)
>  		return;
>  	}
>  
> +	/*
> +	 * We are maybe in the SMP context, so if the DMA TX thread is running
> +	 * on other cpu, we have to wait for it to finish.
> +	 */
> +	if (sport->dma_is_enabled && sport->dma_is_txing)
> +		return;
> +
>  	temp = readl(sport->port.membase + UCR1);
>  	writel(temp & ~UCR1_TXMPTYEN, sport->port.membase + UCR1);
>  }
> @@ -412,6 +437,13 @@ static void imx_stop_rx(struct uart_port *port)
>  	struct imx_port *sport = (struct imx_port *)port;
>  	unsigned long temp;
>  
> +	/*
> +	 * We are maybe in the SMP context, so if the DMA TX thread is running
> +	 * on other cpu, we have to wait for it to finish.
> +	 */
> +	if (sport->dma_is_enabled && sport->dma_is_rxing)
> +		return;
> +
>  	temp = readl(sport->port.membase + UCR2);
>  	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
>  }
> @@ -447,6 +479,96 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
>  		imx_stop_tx(&sport->port);
>  }
>  
> +static void dma_tx_callback(void *data)
> +{
> +	struct imx_port *sport = data;
> +	struct scatterlist *sgl = &sport->tx_sgl[0];
> +	struct circ_buf *xmit = &sport->port.state->xmit;
> +	unsigned long flags;
> +
> +	dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
> +
> +	sport->dma_is_txing = 0;
> +
> +	/* update the stat */
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +	xmit->tail = (xmit->tail + sport->tx_bytes) & (UART_XMIT_SIZE - 1);
> +	sport->port.icount.tx += sport->tx_bytes;
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +
> +	dev_dbg(sport->port.dev, "we finish the TX DMA.\n");
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(&sport->port);
> +
> +	if (waitqueue_active(&sport->dma_wait)) {
> +		wake_up(&sport->dma_wait);
> +		dev_dbg(sport->port.dev, "exit in %s.\n", __func__);
> +		return;
> +	}
> +
> +	schedule_work(&sport->tsk_dma_tx);
> +}
> +
> +static void dma_tx_work(struct work_struct *w)
> +{
> +	struct imx_port *sport = container_of(w, struct imx_port, tsk_dma_tx);
> +	struct circ_buf *xmit = &sport->port.state->xmit;
> +	struct scatterlist *sgl = sport->tx_sgl;
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_chan	*chan = sport->dma_chan_tx;
> +	struct device *dev = sport->port.dev;
> +	enum dma_status status;
> +	unsigned long flags;
> +	int ret;
> +
> +	status = chan->device->device_tx_status(chan, (dma_cookie_t)0, NULL);
> +	if (DMA_IN_PROGRESS == status)
> +		return;
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +	sport->tx_bytes = uart_circ_chars_pending(xmit);
> +	if (sport->tx_bytes == 0) {
> +		spin_unlock_irqrestore(&sport->port.lock, flags);
> +		return;
> +	}
> +
> +	if (xmit->tail > xmit->head) {
> +		sport->dma_tx_nents = 2;
> +		sg_init_table(sgl, 2);
> +		sg_set_buf(sgl, xmit->buf + xmit->tail,
> +				UART_XMIT_SIZE - xmit->tail);
> +		sg_set_buf(sgl + 1, xmit->buf, xmit->head);
> +	} else {
> +		sport->dma_tx_nents = 1;
> +		sg_init_one(sgl, xmit->buf + xmit->tail, sport->tx_bytes);
> +	}
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +
> +	ret = dma_map_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
> +	if (ret == 0) {
> +		dev_err(dev, "DMA mapping error for TX.\n");
> +		return;
> +	}
> +	desc = dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
> +					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(dev, "We cannot prepare for the TX slave dma!\n");
> +		return;
> +	}
> +	desc->callback = dma_tx_callback;
> +	desc->callback_param = sport;
> +
> +	sport->dma_is_txing = 1;
> +
> +	dev_dbg(dev, "TX: prepare to send %lu bytes by DMA.\n",
> +			uart_circ_chars_pending(xmit));
> +	/* fire it */
> +	dmaengine_submit(desc);
> +	dma_async_issue_pending(chan);
> +	return;
> +}
> +
>  /*
>   * interrupts disabled on entry
>   */
> @@ -473,8 +595,10 @@ static void imx_start_tx(struct uart_port *port)
>  	temp |= UCR4_OREN;
>  	writel(temp, sport->port.membase + UCR4);
>  
> -	temp = readl(sport->port.membase + UCR1);
> -	writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
> +	if (!sport->dma_is_enabled) {
> +		temp = readl(sport->port.membase + UCR1);
> +		writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
> +	}
>  
>  	if (USE_IRDA(sport)) {
>  		temp = readl(sport->port.membase + UCR1);
> @@ -486,6 +610,15 @@ static void imx_start_tx(struct uart_port *port)
>  		writel(temp, sport->port.membase + UCR4);
>  	}
>  
> +	if (sport->dma_is_enabled) {
> +		/*
> +		 * We may in the interrupt context, so arise a work_struct to
> +		 * do the real job.
> +		 */
> +		schedule_work(&sport->tsk_dma_tx);
> +		return;
> +	}
> +
>  	if (readl(sport->port.membase + uts_reg(sport)) & UTS_TXEMPTY)
>  		imx_transmit_buffer(sport);
>  }
> @@ -601,6 +734,28 @@ out:
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * If the RXFIFO is filled with some data, and then we
> + * arise a DMA operation to receive them.
> + */
> +static void imx_dma_rxint(struct imx_port *sport)
> +{
> +	unsigned long temp;
> +
> +	temp = readl(sport->port.membase + USR2);
> +	if ((temp & USR2_RDR) && !sport->dma_is_rxing) {
> +		sport->dma_is_rxing = 1;
> +
> +		/* disable the `Recerver Ready Interrrupt` */
> +		temp = readl(sport->port.membase + UCR1);
> +		temp &= ~(UCR1_RRDYEN);
> +		writel(temp, sport->port.membase + UCR1);
> +
> +		/* tell the DMA to receive the data. */
> +		schedule_work(&sport->tsk_dma_rx);
> +	}
> +}
> +
>  static irqreturn_t imx_int(int irq, void *dev_id)
>  {
>  	struct imx_port *sport = dev_id;
> @@ -609,8 +764,12 @@ static irqreturn_t imx_int(int irq, void *dev_id)
>  
>  	sts = readl(sport->port.membase + USR1);
>  
> -	if (sts & USR1_RRDY)
> -		imx_rxint(irq, dev_id);
> +	if (sts & USR1_RRDY) {
> +		if (sport->dma_is_enabled)
> +			imx_dma_rxint(sport);
> +		else
> +			imx_rxint(irq, dev_id);
> +	}
>  
>  	if (sts & USR1_TRDY &&
>  			readl(sport->port.membase + UCR1) & UCR1_TXMPTYEN)
> @@ -667,7 +826,8 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	temp = readl(sport->port.membase + UCR2) & ~UCR2_CTS;
>  
>  	if (mctrl & TIOCM_RTS)
> -		temp |= UCR2_CTS;
> +		if (!sport->dma_is_enabled)
> +			temp |= UCR2_CTS;
>  
>  	writel(temp, sport->port.membase + UCR2);
>  }
> @@ -706,6 +866,226 @@ static int imx_setup_ufcr(struct imx_port *sport, unsigned int mode)
>  	return 0;
>  }
>  
> +#define RX_BUF_SIZE	(PAGE_SIZE)
> +static int start_rx_dma(struct imx_port *sport);
> +static void dma_rx_work(struct work_struct *w)
> +{
> +	struct imx_port *sport = container_of(w, struct imx_port, tsk_dma_rx);
> +	struct tty_port *port = &sport->port.state->port;
> +
> +	if (sport->rx_bytes) {
> +		tty_insert_flip_string(port, sport->rx_buf, sport->rx_bytes);
> +		tty_flip_buffer_push(port);
> +		sport->rx_bytes = 0;
> +	}
> +
> +	if (sport->dma_is_rxing)
> +		start_rx_dma(sport);
> +}
> +
> +static void imx_rx_dma_done(struct imx_port *sport)
> +{
> +	unsigned long temp;
> +
> +	/* Enable this interrupt when the RXFIFO is empty. */
> +	temp = readl(sport->port.membase + UCR1);
> +	temp |= UCR1_RRDYEN;
> +	writel(temp, sport->port.membase + UCR1);
> +
> +	sport->dma_is_rxing = 0;
> +
> +	/* Is the shutdown waiting for us? */
> +	if (waitqueue_active(&sport->dma_wait))
> +		wake_up(&sport->dma_wait);
> +}
> +
> +/*
> + * There are three kinds of RX DMA interrupts(such as in the MX6Q):
> + *   [1] the RX DMA buffer is full.
> + *   [2] the Aging timer expires(wait for 8 bytes long)
> + *   [3] the Idle Condition Detect(enabled the UCR4_IDDMAEN).
> + *
> + * The [2] is trigger when a character was been sitting in the FIFO
> + * meanwhile [3] can wait for 32 bytes long when the RX line is
> + * on IDLE state and RxFIFO is empty.
> + */
> +static void dma_rx_callback(void *data)
> +{
> +	struct imx_port *sport = data;
> +	struct dma_chan	*chan = sport->dma_chan_rx;
> +	unsigned int count;
> +	struct tty_struct *tty;
> +	struct scatterlist *sgl;
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	tty = sport->port.state->port.tty;
> +	sgl = &sport->rx_sgl;
> +
> +	/* unmap it first */
> +	dma_unmap_sg(sport->port.dev, sgl, 1, DMA_FROM_DEVICE);
> +
> +	status = chan->device->device_tx_status(chan, (dma_cookie_t)0, &state);
> +	count = RX_BUF_SIZE - state.residue;
> +	dev_dbg(sport->port.dev, "We get %d bytes.\n", count);
> +
> +	if (count) {
> +		sport->rx_bytes = count;
> +		schedule_work(&sport->tsk_dma_rx);
> +	} else
> +		imx_rx_dma_done(sport);
> +}
> +
> +static int start_rx_dma(struct imx_port *sport)
> +{
> +	struct scatterlist *sgl = &sport->rx_sgl;
> +	struct dma_chan	*chan = sport->dma_chan_rx;
> +	struct device *dev = sport->port.dev;
> +	struct dma_async_tx_descriptor *desc;
> +	int ret;
> +
> +	sg_init_one(sgl, sport->rx_buf, RX_BUF_SIZE);
> +	ret = dma_map_sg(dev, sgl, 1, DMA_FROM_DEVICE);
> +	if (ret == 0) {
> +		dev_err(dev, "DMA mapping error for RX.\n");
> +		return -EINVAL;
> +	}
> +	desc = dmaengine_prep_slave_sg(chan, sgl, 1, DMA_DEV_TO_MEM,
> +					DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(dev, "We cannot prepare for the RX slave dma!\n");
> +		return -EINVAL;
> +	}
> +	desc->callback = dma_rx_callback;
> +	desc->callback_param = sport;
> +
> +	dev_dbg(dev, "RX: prepare for the DMA.\n");
> +	dmaengine_submit(desc);
> +	dma_async_issue_pending(chan);
> +	return 0;
> +}
> +
> +static void imx_uart_dma_exit(struct imx_port *sport)
> +{
> +	if (sport->dma_chan_rx) {
> +		dma_release_channel(sport->dma_chan_rx);
> +		sport->dma_chan_rx = NULL;
> +
> +		kfree(sport->rx_buf);
> +		sport->rx_buf = NULL;
> +	}
> +
> +	if (sport->dma_chan_tx) {
> +		dma_release_channel(sport->dma_chan_tx);
> +		sport->dma_chan_tx = NULL;
> +	}
> +}
> +
> +static int imx_uart_dma_init(struct imx_port *sport)
> +{
> +	struct dma_slave_config slave_config;
> +	struct device *dev = sport->port.dev;
> +	int ret;
> +
> +	/* Prepare for RX : */
> +	sport->dma_chan_rx = dma_request_slave_channel(dev, "rx");
> +	if (!sport->dma_chan_rx) {
> +		dev_err(dev, "cannot get the DMA channel.\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	slave_config.direction = DMA_DEV_TO_MEM;
> +	slave_config.src_addr = sport->port.mapbase + URXD0;
> +	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	slave_config.src_maxburst = RXTL;
> +	ret = dmaengine_slave_config(sport->dma_chan_rx, &slave_config);
> +	if (ret) {
> +		dev_err(dev, "error in RX dma configuration.\n");
> +		goto err;
> +	}
> +
> +	sport->rx_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!sport->rx_buf) {
> +		dev_err(dev, "cannot alloc DMA buffer.\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	sport->rx_bytes = 0;
> +
> +	/* Prepare for TX : */
> +	sport->dma_chan_tx = dma_request_slave_channel(dev, "tx");
> +	if (!sport->dma_chan_tx) {
> +		dev_err(dev, "cannot get the TX DMA channel!\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	slave_config.direction = DMA_MEM_TO_DEV;
> +	slave_config.dst_addr = sport->port.mapbase + URTX0;
> +	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	slave_config.dst_maxburst = TXTL;
> +	ret = dmaengine_slave_config(sport->dma_chan_tx, &slave_config);
> +	if (ret) {
> +		dev_err(dev, "error in TX dma configuration.");
> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	imx_uart_dma_exit(sport);
> +	return ret;
> +}
> +
> +static void imx_enable_dma(struct imx_port *sport)
> +{
> +	unsigned long temp;
> +	struct tty_port *port = &sport->port.state->port;
> +
> +	port->low_latency = 1;
> +	INIT_WORK(&sport->tsk_dma_tx, dma_tx_work);
> +	INIT_WORK(&sport->tsk_dma_rx, dma_rx_work);
> +	init_waitqueue_head(&sport->dma_wait);

I had a hard time to understand why these work and wait queue are
necessarily needed here.

I haven't totally understand it.  But it looks like to me that the
implementation might be complexer than it needs to be.  Can you please
take a look at serial-tegra.c to see how the DMA is supported there?
It looks much neater than the changes we have here.

> +
> +	/* set UCR1 */
> +	temp = readl(sport->port.membase + UCR1);
> +	temp |= UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN |
> +		/* wait for 4 idle frames and enable AGING Timer */
> +		UCR1_ICD_REG(0);
> +	writel(temp, sport->port.membase + UCR1);
> +
> +	/* set UCR4 */
> +	temp = readl(sport->port.membase + UCR4);
> +	temp |= UCR4_IDDMAEN;
> +	writel(temp, sport->port.membase + UCR4);
> +}
> +
> +static void imx_disable_dma(struct imx_port *sport)
> +{
> +	unsigned long temp;
> +	struct tty_port *port = &sport->port.state->port;
> +
> +	/* clear UCR1 */
> +	temp = readl(sport->port.membase + UCR1);
> +	temp &= ~(UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN);
> +	writel(temp, sport->port.membase + UCR1);
> +
> +	/* clear UCR2 */
> +	temp = readl(sport->port.membase + UCR2);
> +	temp &= ~(UCR2_CTSC | UCR2_CTS);
> +	writel(temp, sport->port.membase + UCR2);
> +
> +	/* clear UCR4 */
> +	temp = readl(sport->port.membase + UCR4);
> +	temp &= ~UCR4_IDDMAEN;
> +	writel(temp, sport->port.membase + UCR4);
> +
> +	sport->dma_is_enabled = 0;
> +	sport->dma_is_inited = 0;

Shouldn't dma_is_inited be reset in imx_uart_dma_exit() for better?
(I haven't looked at the necessity of these flags.  But please save
the use of them if we can.)

> +
> +	port->low_latency = 0;
> +}
> +
>  /* half the RX buffer size */
>  #define CTSTL 16
>  
> @@ -870,6 +1250,14 @@ static void imx_shutdown(struct uart_port *port)
>  	unsigned long temp;
>  	unsigned long flags;
>  
> +	if (sport->dma_is_enabled) {
> +		/* We have to wait for the DMA to finish. */
> +		wait_event(sport->dma_wait,
> +			!sport->dma_is_rxing && !sport->dma_is_txing);
> +		imx_stop_rx(port);
> +		imx_uart_dma_exit(sport);
> +	}
> +
>  	spin_lock_irqsave(&sport->port.lock, flags);
>  	temp = readl(sport->port.membase + UCR2);
>  	temp &= ~(UCR2_TXEN);
> @@ -910,6 +1298,10 @@ static void imx_shutdown(struct uart_port *port)
>  		temp &= ~(UCR1_IREN);
>  
>  	writel(temp, sport->port.membase + UCR1);
> +
> +	if (sport->dma_is_enabled)
> +		imx_disable_dma(sport);
> +

Shouldn't imx_disable_dma() be called before imx_uart_dma_exit()
logically?

>  	spin_unlock_irqrestore(&sport->port.lock, flags);
>  
>  	clk_disable_unprepare(sport->clk_per);
> @@ -956,6 +1348,13 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
>  		if (sport->have_rtscts) {
>  			ucr2 &= ~UCR2_IRTS;
>  			ucr2 |= UCR2_CTSC;
> +
> +			/* Can we enable the DMA support? */
> +			if (is_imx6_uart(sport) && !uart_console(port)
> +				&& !sport->dma_is_inited) {
> +				if (!imx_uart_dma_init(sport))
> +					sport->dma_is_inited = 1;

I think the setting of the flag can just be handled inside
imx_uart_dma_init().


> +			}
>  		} else {
>  			termios->c_cflag &= ~CRTSCTS;
>  		}
> @@ -1069,6 +1468,10 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
>  	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
>  		imx_enable_ms(&sport->port);
>  
> +	if (sport->dma_is_inited && !sport->dma_is_enabled) {
> +		imx_enable_dma(sport);
> +		sport->dma_is_enabled = 1;

Ditto

> +	}

I see imx_disable_dma() and imx_uart_dma_exit() are called in
imx_shutdown().  Why can not imx_uart_dma_init() and imx_enable_dma()
be called in imx_startup()?

Shawn

>  	spin_unlock_irqrestore(&sport->port.lock, flags);
>  }
>  
> -- 
> 1.7.1
> 
> 

