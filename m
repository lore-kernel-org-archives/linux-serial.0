From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sirf: fix line over 80 characters style issue
Date: Mon, 8 Sep 2014 16:15:27 -0700
Message-ID: <20140908231527.GA23907@kroah.com>
References: <1408354372-18601-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36371 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbaIHXP2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Sep 2014 19:15:28 -0400
Content-Disposition: inline
In-Reply-To: <1408354372-18601-1-git-send-email-Barry.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: linux-serial@vger.kernel.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

On Mon, Aug 18, 2014 at 05:32:52PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> According to key customer's requirement, fix "line over 80
> characters".

Someone is forcing you to fix all upstream kernel.org code for 80
columns?  Who?

> Signed-off-by: Qipan Li <Qipan.Li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/tty/serial/sirfsoc_uart.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
> index 4102192..89f1e59 100644
> --- a/drivers/tty/serial/sirfsoc_uart.c
> +++ b/drivers/tty/serial/sirfsoc_uart.c
> @@ -525,7 +525,8 @@ static void sirfsoc_rx_tmo_process_tl(unsigned long param)
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
> -		sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
> +		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
> +		&tx_state)) {

Isn't that now harder to read?

>  		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
>  					SIRFSOC_RX_DMA_BUF_SIZE);
>  		sirfport->rx_completed++;
> @@ -707,7 +708,8 @@ static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
>  	struct dma_tx_state tx_state;
>  	spin_lock_irqsave(&port->lock, flags);
>  	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
> -			sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
> +		sirfport->rx_dma_items[sirfport->rx_completed].cookie,
> +		&tx_state)) {

Same here.

>  		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
>  					SIRFSOC_RX_DMA_BUF_SIZE);
>  		if (rd_regl(port, ureg->sirfsoc_int_en_reg) &
> @@ -1303,7 +1305,8 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
>  		"sirf,uart-has-rtscts");
>  	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-uart"))
>  		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
> -	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart")) {
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +		"sirf,prima2-usp-uart")) {

Same.

>  		sirfport->uart_reg->uart_type =	SIRF_USP_UART;
>  		if (!sirfport->hw_flow_ctrl)
>  			goto usp_no_flow_control;
> @@ -1360,11 +1363,12 @@ usp_no_flow_control:
>  		goto err;
>  	}
>  	tasklet_init(&sirfport->rx_dma_complete_tasklet,
> -			sirfsoc_uart_rx_dma_complete_tl, (unsigned long)sirfport);
> +		sirfsoc_uart_rx_dma_complete_tl, (unsigned long)sirfport);

Same.

You can break this line at the last variable instead.

>  	tasklet_init(&sirfport->rx_tmo_process_tasklet,
>  			sirfsoc_rx_tmo_process_tl, (unsigned long)sirfport);
>  	port->mapbase = res->start;
> -	port->membase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	port->membase = devm_ioremap(&pdev->dev,
> +			res->start, resource_size(res));

same here, it could be made to look better.

Sorry, not going to take this, if your customer blames you, point them
at me.

seriously.

greg k-h
