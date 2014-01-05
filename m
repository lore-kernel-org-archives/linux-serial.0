From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] the eDMA support for the LPUART send driver
Date: Sun, 5 Jan 2014 15:44:49 +0100
Message-ID: <201401051544.50036.arnd@arndb.de>
References: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50556 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbaAEOpS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Jan 2014 09:45:18 -0500
In-Reply-To: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Yuan Yao <yao.yuan@freescale.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

On Friday 27 December 2013, Yuan Yao wrote:
> This patch add eDMA support for LPUART send function.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi    |  12 +++
>  drivers/tty/serial/fsl_lpuart.c | 187 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 163 insertions(+), 36 deletions(-)

Not sure if this got applied already, but you are missing the respective
change to Documentation/devicetree/bindings/serial/fsl-lpuart.txt.

Please document the dma-names you use here. While you are at it, please
also add the "ipg" clock-name.

	Arnd

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

This is wrong: Since the dma is performed by the dma engine rather
than the uart, the first argument here needs to be the dma device
pointer. In fact, dma_map_single is normally supposed to fail on
the uart device as the dma_mask value should be zero. Not sure
why this worked.

> +	if (!dma_phys) {
> +		dev_err(sport->port.dev, "Dma_phys single failed\n");
> +		return -ENOMEM;
> +	}

Please also change all references to "phys" -- it's not a phys
address but a bus address. These are often the same, but that's
not for the driver to know.

	Arnd
