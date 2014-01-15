From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
Date: Wed, 15 Jan 2014 10:25:34 +0100
Message-ID: <201401151025.34628.arnd@arndb.de>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com> <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60344 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbaAOJZo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jan 2014 04:25:44 -0500
In-Reply-To: <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Wednesday 15 January 2014, Yuan Yao wrote:
> Add dma support for lpuart. This function depend on DMA driver. 
> You can turn on it by SERIAL_FSL_LPUART_DMA=y. And It works if dts node has dma properties.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>

Most of the changes you did look good, but I have to say I'm not a fan of
the #ifdef you added. I don't think you actually need to have the compile-time
selection, and it would be best to just drop that part.

If you have a good reason to keep it, please change the code to
more readable "if (IS_ENABLED(CONFIG_FSL_LPUART_DMA))" constructs.
If you decide to do this, you will find that you need far fewer
such conditionals because a lot of the code will automatically
get dropped by the compiler.
  
>  uart0: serial@40027000 {
> -	       compatible = "fsl,vf610-lpuart";
> -	       reg = <0x40027000 0x1000>;
> -	       interrupts = <0 61 0x00>;
> -       };
> +		compatible = "fsl,vf610-lpuart";
> +		reg = <0x40027000 0x1000>;
> +		interrupts = <0 61 0x00>;
> +		clocks = <&clks VF610_CLK_UART0>;
> +		clock-names = "ipg";
> +		dma-names = "lpuart-tx","lpuart-rx";
> +		dmas = <&edma0 0 VF610_EDMA_MUXID0_UART0_TX>,
> +			<&edma0 0 VF610_EDMA_MUXID0_UART0_RX>;
> +	};

You still haven't addressed my comment about removing the VF610_EDMA_MUXID0_UART0_TX
macros.

>  
> +#ifdef CONFIG_SERIAL_FSL_LPUART_DMA
> +#define DMA_MAXBURST		16
> +#define DMA_MAXBURST_MASK	(DMA_MAXBURST - 1)
> +#define FSL_UART_RX_DMA_BUFFER_SIZE	64
> +#endif

For this part there was no need for the #ifdef to start with.

>  #define DRIVER_NAME	"fsl-lpuart"
>  #define DEV_NAME	"ttyLP"
>  #define UART_NR		6
> @@ -121,6 +132,26 @@ struct lpuart_port {
>  	struct clk		*clk;
>  	unsigned int		txfifo_size;
>  	unsigned int		rxfifo_size;
> +
> +#ifdef CONFIG_SERIAL_FSL_LPUART_DMA
> +	bool			lpuart_dma_use;
> +	struct dma_chan		*dma_tx_chan;
> +	struct dma_chan		*dma_rx_chan;
> +	struct dma_async_tx_descriptor  *dma_tx_desc;
> +	struct dma_async_tx_descriptor  *dma_rx_desc;
> +	dma_addr_t		dma_tx_buf_bus;
> +	dma_addr_t		dma_rx_buf_bus;
> +	dma_cookie_t		dma_tx_cookie;
> +	dma_cookie_t		dma_rx_cookie;
> +	unsigned char		*dma_tx_buf_virt;
> +	unsigned char		*dma_rx_buf_virt;
> +	unsigned int		dma_tx_bytes;
> +	unsigned int		dma_rx_bytes;
> +	int			dma_tx_in_progress;
> +	int			dma_rx_in_progress;
> +	unsigned int		dma_rx_timeout;
> +	struct timer_list	lpuart_timer;
> +#endif
>  };

This part will result in a slight increase in data size even if
dma support is turned off at compile time.

>  
>  	temp = readb(port->membase + UARTCR2);
>  	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
>  
> +#ifdef CONFIG_SERIAL_FSL_LPUART_DMA
> +	if (sport->lpuart_dma_use) {
> +		if (!uart_circ_empty(xmit) && !sport->dma_tx_in_progress)
> +			lpuart_prepare_tx(sport);
> +	} else {
> +		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
> +			lpuart_transmit_buffer(sport);
> +	}
> +#else
>  	if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
>  		lpuart_transmit_buffer(sport);
> +#endif
>  }

So this can simply become

+	if (IS_ENABLED(CONFIG_SERIAL_FSL_LPUART_DMA) && sport->lpuart_dma_use) {
+		if (!uart_circ_empty(xmit) && !sport->dma_tx_in_progress)
+			lpuart_prepare_tx(sport);
+	} else {
+		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
+			lpuart_trans	mit_buffer(sport);
+	}

and the compiler will silently drop the lpuart_prepare_tx() function and everything
it calls that isn't used elsewhere.


> +
> +#ifdef CONFIG_SERIAL_FSL_LPUART_DMA
> +	struct platform_device *pdev = to_platform_device(port->dev);
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	if (of_get_property(np, "dmas", NULL)) {
> +		sport->lpuart_dma_use = true;
> +		lpuart_dma_tx_request(port);
> +		lpuart_dma_rx_request(port);
> +		temp = readb(port->membase + UARTCR5);
> +		writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
> +	} else
> +		sport->lpuart_dma_use = false;	
> +#endif

Same here.

> @@ -854,6 +1291,10 @@ static int __init lpuart_serial_init(void)
>  
>  	pr_info("serial: Freescale lpuart driver\n");
>  
> +#ifdef CONFIG_SERIAL_FSL_LPUART_DMA
> +	pr_info("serial: Freescale lpuart dma support\n");
> +#endif
> +

This message is not helpful in the long run, I'd rather see you drop the
other one as well. Note that this function is called on *all* platforms
when the driver is enabled, not just on those that actually have the uart.

	Arnd
