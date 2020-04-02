Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0B7C43331
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 13:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D802074D
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 13:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585835952;
	bh=zLtl1hegVDZ3JX8jSfCefGzoiajaEZQuyWHnbec+81Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w+eNI15Mc3eppehxAGU/Osiid59+pwsRQpsiF/hMOBfzKKScrkiXvBdbWiF5yQ367
	 98tnPUDPK5PCQNzKsndTIdC9ZQ4ri6lgkj6t9FNQbXO6UomUaytcI97tiMrBsxf1Ri
	 KL7vgxNH1ub5Ck1XmgvZtpDFgSuXagJtfMqT6bLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgDBN7I (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:59:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43246 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgDBN7I (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 09:59:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id bd14so4194573edb.10;
        Thu, 02 Apr 2020 06:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FG8YtufMkodYHyo0Cjo7XgVdXtJaBvxft8gScddvk0g=;
        b=ThlE/KS6IKCoIdco9q/pUBh+wOA83+dJLOQs7W96QFXkvvgaCV6MVVnu4E+0VIkDRU
         /gerC+nDONN2gzUAMaMfz6vt0h94oKwIzuw9Ltu56wx33WZtoIJ4tvMZTNFJXTOlqiiz
         5FLS5x4Hqd9O2FgPv1RA6s0GI/wQKBHxeD9blyN8xTWU2J7Iqs5tJA1l/RPqhSwA+Xdq
         hW0YZzzFPsMuwirBO4CMa0O1oBxzCq+oX06SeAfavVOvmhL98Kqvwq/Iy1y7jY+PerZU
         4U+dxBAdc+XCkZPb9LkL8HQ/SQ7TKW8R03GTsG1LJEHQXAvGfa3PXp2LYDhmXqz6Ko/q
         MRDA==
X-Gm-Message-State: AGi0PuZ0B3VPW4ghvVSqnd7Tjw/rwY1uLZg4lwwLZ7OLGTxygWvVwgyO
        sl26luubx9HqFEVCZPXKWVs=
X-Google-Smtp-Source: APiQypJZiYA4+kO7+JETns8DlnM+JC+pL4k5yzrzry0SWjVI/A+wLBOeGJc99+87ubrsog7lCOCCkw==
X-Received: by 2002:a50:af85:: with SMTP id h5mr3071705edd.300.1585835945843;
        Thu, 02 Apr 2020 06:59:05 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id n18sm950462edv.93.2020.04.02.06.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Apr 2020 06:59:05 -0700 (PDT)
Date:   Thu, 2 Apr 2020 15:59:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, Kukjin Kim <kgene@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200402135903.GA14861@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200402110609epcas2p4a5ec1fb3a5eaa3b12c20cfc2060162f3@epcas2p4.samsung.com>
 <20200402110430.31156-1-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200402110430.31156-1-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 02, 2020 at 08:04:29PM +0900, Hyunki Koo wrote:
> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> 
> This is required for some newer SoCs.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 78 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 73f951d65b93..826d8c5846a6 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -154,12 +154,47 @@ struct s3c24xx_uart_port {
>  #define portaddrl(port, reg) \
>  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
>  
> -#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
> +static unsigned int rd_reg(struct uart_port *port, int reg)
> +{
> +	switch (port->iotype) {
> +	case UPIO_MEM:
> +		return readb_relaxed(portaddr(port, reg));
> +	case UPIO_MEM32:
> +		return readl_relaxed(portaddr(port, reg));
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
>  #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
>  
> -#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
> +static void wr_reg(struct uart_port *port, int reg, int val)
> +{
> +	switch (port->iotype) {
> +	case UPIO_MEM:
> +		writeb_relaxed(val, portaddr(port, reg));
> +		break;
> +	case UPIO_MEM32:
> +		writel_relaxed(val, portaddr(port, reg));
> +		break;
> +	}
> +}
> +
>  #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
>  
> +static void write_buf(struct uart_port *port, int reg, int val)
> +{
> +	switch (port->iotype) {
> +	case UPIO_MEM:
> +		writeb(val, portaddr(port, reg));
> +		break;
> +	case UPIO_MEM32:
> +		writel(val, portaddr(port, reg));
> +		break;
> +	}
> +}
> +
>  /* Byte-order aware bit setting/clearing functions. */
>  
>  static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
> @@ -714,7 +749,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
>  		fifocnt--;
>  
>  		uerstat = rd_regl(port, S3C2410_UERSTAT);
> -		ch = rd_regb(port, S3C2410_URXH);
> +		ch = rd_reg(port, S3C2410_URXH);
>  
>  		if (port->flags & UPF_CONS_FLOW) {
>  			int txe = s3c24xx_serial_txempty_nofifo(port);
> @@ -826,7 +861,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>  	}
>  
>  	if (port->x_char) {
> -		wr_regb(port, S3C2410_UTXH, port->x_char);
> +		wr_reg(port, S3C2410_UTXH, port->x_char);
>  		port->icount.tx++;
>  		port->x_char = 0;
>  		goto out;
> @@ -852,7 +887,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>  		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info->tx_fifofull)
>  			break;
>  
> -		wr_regb(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
> +		wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
>  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>  		port->icount.tx++;
>  		count--;
> @@ -916,7 +951,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
>  /* no modem control lines */
>  static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
>  {
> -	unsigned int umstat = rd_regb(port, S3C2410_UMSTAT);
> +	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
>  
>  	if (umstat & S3C2410_UMSTAT_CTS)
>  		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
> @@ -1974,7 +2009,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct s3c24xx_uart_port *ourport;
>  	int index = probe_index;
> -	int ret;
> +	int ret, prop = 0;
>  
>  	if (np) {
>  		ret = of_alias_get_id(np, "serial");
> @@ -2000,10 +2035,29 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  			dev_get_platdata(&pdev->dev) :
>  			ourport->drv_data->def_cfg;
>  
> -	if (np)
> +	if (np) {
>  		of_property_read_u32(np,
>  			"samsung,uart-fifosize", &ourport->port.fifosize);
>  
> +		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> +			switch (prop) {
> +			case 1:
> +				ourport->port.iotype = UPIO_MEM;
> +				break;
> +			case 4:
> +				ourport->port.iotype = UPIO_MEM32;
> +				break;
> +			default:
> +				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> +						prop);
> +				ret = -EINVAL;
> +				break;
> +			}
> +		} else {
> +			ourport->port.iotype = UPIO_MEM;
> +		}
> +	}

I think this still breaks all non-DT platforms (e.g. s3c).

Best regards,
Krzysztof

