Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AAFC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 13:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2BA2074D
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 13:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgFONNS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:13:18 -0400
Received: from foss.arm.com ([217.140.110.172]:47528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730213AbgFONNS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 09:13:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 844A731B;
        Mon, 15 Jun 2020 06:13:17 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E73B93F6CF;
        Mon, 15 Jun 2020 06:13:15 -0700 (PDT)
Subject: Re: [RFC PATCH] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
To:     Tamseel Shams <m.shams@samsung.com>, kgene@kernel.org,
        krzk@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        linux-arm-kernel@lists.infradead.org
References: <CGME20200615124355epcas5p446ae2f1b63331ef87334cd7d696c3c43@epcas5p4.samsung.com>
 <20200615122609.71884-1-m.shams@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <027c0955-3246-8c1e-4d0d-053a2a177dc6@arm.com>
Date:   Mon, 15 Jun 2020 14:13:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615122609.71884-1-m.shams@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-06-15 13:26, Tamseel Shams wrote:
> In few older Samsung SoCs like s3c2410, s3c2412
> and s3c2440, UART IP is having 2 interrupt lines.
> However, in other SoCs like s3c6400, s5pv210,
> exynos5433, and exynos4210 UART is having only 1
> interrupt line. Due to this, "platform_get_irq(platdev, 1)"
> call in the driver gives the following warning:
> "IRQ index 1 not found" on recent platforms.
> 
> This patch re-factors the IRQ resources handling for
> each platform and hence fixing the above warnings seen
> on some platforms.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
>   drivers/tty/serial/samsung_tty.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 6ef614d8648c..078dcb3e316f 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -60,6 +60,7 @@ struct s3c24xx_uart_info {
>   	char			*name;
>   	unsigned int		type;
>   	unsigned int		fifosize;
> +	unsigned int		irq_cnt;
>   	unsigned long		rx_fifomask;
>   	unsigned long		rx_fifoshift;
>   	unsigned long		rx_fifofull;
> @@ -1908,12 +1909,17 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>   	else {
>   		port->irq = ret;
>   		ourport->rx_irq = ret;
> -		ourport->tx_irq = ret + 1;
> +		if (ourport->info->irq_cnt == 1)
> +			ourport->tx_irq = ret;
> +		else
> +			ourport->tx_irq = ret + 1;
>   	}
>   
> -	ret = platform_get_irq(platdev, 1);
> -	if (ret > 0)
> -		ourport->tx_irq = ret;
> +	if (ourport->info->irq_cnt != 1) {
> +		ret = platform_get_irq(platdev, 1);
> +		if (ret > 0)
> +			ourport->tx_irq = ret;

FWIW, if you're not going to do anything in the error case then you may 
as well just call platform_get_irq_optional() unconditionally.

Robin.

> +	}
>   	/*
>   	 * DMA is currently supported only on DT platforms, if DMA properties
>   	 * are specified.
> @@ -2387,6 +2393,7 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
>   		.name		= "Samsung S3C2410 UART",
>   		.type		= PORT_S3C2410,
>   		.fifosize	= 16,
> +		.irq_cnt	= 2,
>   		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
>   		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
>   		.rx_fifofull	= S3C2410_UFSTAT_RXFULL,
> @@ -2414,6 +2421,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
>   		.name		= "Samsung S3C2412 UART",
>   		.type		= PORT_S3C2412,
>   		.fifosize	= 64,
> +		.irq_cnt	= 2,
>   		.has_divslot	= 1,
>   		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
>   		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
> @@ -2443,6 +2451,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
>   		.name		= "Samsung S3C2440 UART",
>   		.type		= PORT_S3C2440,
>   		.fifosize	= 64,
> +		.irq_cnt	= 2,
>   		.has_divslot	= 1,
>   		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
>   		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
> @@ -2471,6 +2480,7 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
>   		.name		= "Samsung S3C6400 UART",
>   		.type		= PORT_S3C6400,
>   		.fifosize	= 64,
> +		.irq_cnt	= 1,
>   		.has_divslot	= 1,
>   		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
>   		.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
> @@ -2498,6 +2508,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>   	.info = &(struct s3c24xx_uart_info) {
>   		.name		= "Samsung S5PV210 UART",
>   		.type		= PORT_S3C6400,
> +		.irq_cnt	= 1,
>   		.has_divslot	= 1,
>   		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
>   		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
> @@ -2526,6 +2537,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>   	.info = &(struct s3c24xx_uart_info) {			\
>   		.name		= "Samsung Exynos UART",	\
>   		.type		= PORT_S3C6400,			\
> +		.irq_cnt	= 1,				\
>   		.has_divslot	= 1,				\
>   		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
>   		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
> 
