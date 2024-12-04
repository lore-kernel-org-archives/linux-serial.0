Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D47442F;
	Wed,  4 Dec 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309690; cv=none; b=VXufdM+PqlxRkkYFzjqQjlL+8lIMp8/y2CZG1w5K89De+owacfpO/8K/V+NNBFsFE1YqWeXizeLj1/azfj7s1/8fVhGjnj3kBZ0ISMfhGZ9pm/NXMO960sYodhqql2BGPuDjY3F0CikdRxyfmMUCFddrU4e368Q+Vq9IXwg43ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309690; c=relaxed/simple;
	bh=9qOOMVRLj24dF0G+B7UhakX9K+6dsnNX3VJMCg1sBQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECfo+zLbNrvSkzYPm6ZdhxjDu+yoRluJPlXKU1oHDfilSEDk4DtaRXJ5Jkbl5yMVWESmdwUMLkkjDwmk1PFqs18pj6aDfNMF5sPfL6qQPqAf7t4uhWkeRL1n+1IcFwDNhwD/bJh4R/oMKSc56smvqrHFMbSE37McJSjZ55FDXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8C2C4CED1;
	Wed,  4 Dec 2024 10:54:48 +0000 (UTC)
Message-ID: <52517849-48ed-4fe8-8638-ec2a4dc2bcbd@linux-m68k.org>
Date: Wed, 4 Dec 2024 20:54:45 +1000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: coldfire: Support resources for UART
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20241202-m5441x_uart_resource-v1-1-6b28cb295fb5@yoseli.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20241202-m5441x_uart_resource-v1-1-6b28cb295fb5@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi JM,

On 2/12/24 20:34, Jean-Michel Hautbois wrote:
> In order to use the eDMA channels for UART, the mcf_platform_uart needs
> to be changed. Instead of adding another custom member for the
> structure, use a resource tree in a platform_device per UART. It then
> makes it possible to have a device named like "mcfuart.N" with N the
> UART number.
> 
> Later, adding the dma channel in the mcf tty driver will also be more
> straightfoward.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>   arch/m68k/coldfire/device.c | 96 ++++++++++++++-------------------------------
>   drivers/tty/serial/mcf.c    | 69 +++++++++++++++++++-------------
>   2 files changed, 70 insertions(+), 95 deletions(-)
> 
> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
> index b6958ec2a220cf91a78a14fc7fa18749451412f7..fd7d0b0ce7eb2970cb8ffe33589fe8d7e88c268d 100644
> --- a/arch/m68k/coldfire/device.c
> +++ b/arch/m68k/coldfire/device.c
> @@ -24,73 +24,35 @@
>   #include <linux/platform_data/dma-mcf-edma.h>
>   #include <linux/platform_data/mmc-esdhc-mcf.h>
>   
> -/*
> - *	All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
> - */
> -static struct mcf_platform_uart mcf_uart_platform_data[] = {
> -	{
> -		.mapbase	= MCFUART_BASE0,
> -		.irq		= MCF_IRQ_UART0,
> -	},
> -	{
> -		.mapbase	= MCFUART_BASE1,
> -		.irq		= MCF_IRQ_UART1,
> -	},
> -#ifdef MCFUART_BASE2
> -	{
> -		.mapbase	= MCFUART_BASE2,
> -		.irq		= MCF_IRQ_UART2,
> -	},
> -#endif
> -#ifdef MCFUART_BASE3
> -	{
> -		.mapbase	= MCFUART_BASE3,
> -		.irq		= MCF_IRQ_UART3,
> -	},
> -#endif
> -#ifdef MCFUART_BASE4
> -	{
> -		.mapbase	= MCFUART_BASE4,
> -		.irq		= MCF_IRQ_UART4,
> -	},
> -#endif
> -#ifdef MCFUART_BASE5
> -	{
> -		.mapbase	= MCFUART_BASE5,
> -		.irq		= MCF_IRQ_UART5,
> -	},
> -#endif
> -#ifdef MCFUART_BASE6
> -	{
> -		.mapbase	= MCFUART_BASE6,
> -		.irq		= MCF_IRQ_UART6,
> -	},
> -#endif
> -#ifdef MCFUART_BASE7
> -	{
> -		.mapbase	= MCFUART_BASE7,
> -		.irq		= MCF_IRQ_UART7,
> +static u64 mcf_uart_mask = DMA_BIT_MASK(32);
> +
> +static struct resource mcf_uart0_resource[] = {
> +	[0] = {
> +		.start = MCFUART_BASE0,
> +		.end   = MCFUART_BASE0 + 0x3fff,
> +		.flags = IORESOURCE_MEM,
>   	},
> -#endif
> -#ifdef MCFUART_BASE8
> -	{
> -		.mapbase	= MCFUART_BASE8,
> -		.irq		= MCF_IRQ_UART8,
> +	[1] = {
> +		.start = 2,
> +		.end   = 3,
> +		.flags = IORESOURCE_DMA,
>   	},
> -#endif
> -#ifdef MCFUART_BASE9
> -	{
> -		.mapbase	= MCFUART_BASE9,
> -		.irq		= MCF_IRQ_UART9,
> +	[2] = {
> +		.start = MCF_IRQ_UART0,
> +		.end   = MCF_IRQ_UART0,
> +		.flags = IORESOURCE_IRQ,
>   	},
> -#endif
> -	{ },
>   };
>   
> -static struct platform_device mcf_uart = {
> +static struct platform_device mcf_uart0 = {
>   	.name			= "mcfuart",
>   	.id			= 0,
> -	.dev.platform_data	= mcf_uart_platform_data,
> +	.num_resources = ARRAY_SIZE(mcf_uart0_resource),
> +	.resource = mcf_uart0_resource,
> +	.dev = {
> +		.dma_mask = &mcf_uart_mask,
> +		.coherent_dma_mask = DMA_BIT_MASK(32),
> +	},
>   };
>   
>   #ifdef MCFFEC_BASE0
> @@ -485,12 +447,12 @@ static struct platform_device mcf_i2c5 = {
>   static const struct dma_slave_map mcf_edma_map[] = {
>   	{ "dreq0", "rx-tx", MCF_EDMA_FILTER_PARAM(0) },
>   	{ "dreq1", "rx-tx", MCF_EDMA_FILTER_PARAM(1) },
> -	{ "uart.0", "rx", MCF_EDMA_FILTER_PARAM(2) },
> -	{ "uart.0", "tx", MCF_EDMA_FILTER_PARAM(3) },
> -	{ "uart.1", "rx", MCF_EDMA_FILTER_PARAM(4) },
> -	{ "uart.1", "tx", MCF_EDMA_FILTER_PARAM(5) },
> -	{ "uart.2", "rx", MCF_EDMA_FILTER_PARAM(6) },
> -	{ "uart.2", "tx", MCF_EDMA_FILTER_PARAM(7) },
> +	{ "mcfuart.0", "rx", MCF_EDMA_FILTER_PARAM(2) },
> +	{ "mcfuart.0", "tx", MCF_EDMA_FILTER_PARAM(3) },
> +	{ "mcfuart.1", "rx", MCF_EDMA_FILTER_PARAM(4) },
> +	{ "mcfuart.1", "tx", MCF_EDMA_FILTER_PARAM(5) },
> +	{ "mcfuart.2", "rx", MCF_EDMA_FILTER_PARAM(6) },
> +	{ "mcfuart.2", "tx", MCF_EDMA_FILTER_PARAM(7) },
>   	{ "timer0", "rx-tx", MCF_EDMA_FILTER_PARAM(8) },
>   	{ "timer1", "rx-tx", MCF_EDMA_FILTER_PARAM(9) },
>   	{ "timer2", "rx-tx", MCF_EDMA_FILTER_PARAM(10) },
> @@ -623,7 +585,7 @@ static struct platform_device mcf_flexcan0 = {
>   #endif /* MCFFLEXCAN_SIZE */
>   
>   static struct platform_device *mcf_devices[] __initdata = {
> -	&mcf_uart,
> +	&mcf_uart0,
>   #ifdef MCFFEC_BASE0
>   	&mcf_fec0,
>   #endif
> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
> index 93e7dda4d39acd23daf8c0d4c29ac8d666f263c5..07b8decfdb6005f0265dd130765e45c3fd1715eb 100644
> --- a/drivers/tty/serial/mcf.c
> +++ b/drivers/tty/serial/mcf.c
> @@ -570,31 +570,46 @@ static struct uart_driver mcf_driver = {
>   
>   static int mcf_probe(struct platform_device *pdev)
>   {
> -	struct mcf_platform_uart *platp = dev_get_platdata(&pdev->dev);
>   	struct uart_port *port;
> -	int i;
> -
> -	for (i = 0; ((i < MCF_MAXPORTS) && (platp[i].mapbase)); i++) {
> -		port = &mcf_ports[i].port;
> -
> -		port->line = i;
> -		port->type = PORT_MCF;
> -		port->mapbase = platp[i].mapbase;
> -		port->membase = (platp[i].membase) ? platp[i].membase :
> -			(unsigned char __iomem *) platp[i].mapbase;
> -		port->dev = &pdev->dev;
> -		port->iotype = SERIAL_IO_MEM;
> -		port->irq = platp[i].irq;
> -		port->uartclk = MCF_BUSCLK;
> -		port->ops = &mcf_uart_ops;
> -		port->flags = UPF_BOOT_AUTOCONF;
> -		port->rs485_config = mcf_config_rs485;
> -		port->rs485_supported = mcf_rs485_supported;
> -		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
> -
> -		uart_add_one_port(&mcf_driver, port);
> +	struct mcf_uart *pp;
> +	struct resource *res;
> +	void __iomem *base;
> +	int id = pdev->id;
> +
> +	if (id == -1 || id >= MCF_MAXPORTS) {
> +		dev_err(&pdev->dev, "uart%d out of range\n",
> +			id);
> +		return -EINVAL;
>   	}
>   
> +	port = &mcf_ports[id].port;
> +	port->line = id;
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	port->mapbase = res->start;
> +	port->membase = base;
> +
> +	port->irq = platform_get_irq(pdev, 0);
> +	if (port->irq < 0)
> +		return port->irq;
> +
> +	port->type = PORT_MCF;
> +	port->dev = &pdev->dev;
> +	port->iotype = SERIAL_IO_MEM;
> +	port->uartclk = MCF_BUSCLK;
> +	port->ops = &mcf_uart_ops;
> +	port->flags = UPF_BOOT_AUTOCONF;
> +	port->rs485_config = mcf_config_rs485;
> +	port->rs485_supported = mcf_rs485_supported;
> +	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
> +
> +	pp = container_of(port, struct mcf_uart, port);
> +
> +	uart_add_one_port(&mcf_driver, port);
> +

This breaks platforms with more than one UART - which is quite a few of
the ColdFire platforms. Numerous boards bring and use more than one UART.

Regards
Greg



>   	return 0;
>   }
>   
> @@ -603,13 +618,11 @@ static int mcf_probe(struct platform_device *pdev)
>   static void mcf_remove(struct platform_device *pdev)
>   {
>   	struct uart_port *port;
> -	int i;
> +	int id = pdev->id;
>   
> -	for (i = 0; (i < MCF_MAXPORTS); i++) {
> -		port = &mcf_ports[i].port;
> -		if (port)
> -			uart_remove_one_port(&mcf_driver, port);
> -	}
> +	port = &mcf_ports[id].port;
> +	if (port)
> +		uart_remove_one_port(&mcf_driver, port);
>   }
>   
>   /****************************************************************************/
> 
> ---
> base-commit: e457f18d7f25288d143c1fe024a620d0b15caec1
> change-id: 20241202-m5441x_uart_resource-729b30c15363
> 
> Best regards,
