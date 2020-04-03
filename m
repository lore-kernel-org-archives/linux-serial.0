Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21401C2BA12
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 13:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51262082F
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585920903;
	bh=v/H/nnFY599+LAGe575izJw+9qKf9KYV7HNLqCyq+BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TabFcjY1pb4DTB7wFI/uxD5KCbMSrZMHTm/ssBLXODwui31VsNTmO4nJgTxiOIwq4
	 QtosHsQO8GTo+uye9LYJYEp6gLNkkOl8vL9GsELYSNa7tvGHhNsSWxypKdsuap7hDc
	 yHGi6+Pt77ub9nKumjszfA8PdxUOPtjisJONSt6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgDCNfD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:35:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37999 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCNfD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 09:35:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id e5so9287801edq.5;
        Fri, 03 Apr 2020 06:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHL8e7nL4/qUh9vws2n4KsOcApV4CgwG1tpyifMdKgI=;
        b=OsZOCjSVPVn6kZZuNeIvq2Sn/7HIHnmCeRjDqtBYQHXFZZBIGU2cr+VEMqNIv3TJq2
         YeVPyThuvvUKHrZhuJpESdqW+/WTH1JLx0nORdOXFuUftpN0hZFfsc8KxvXYJytYHznl
         xGnqIHA8q+wliAodjwh4NZ4hVP49aSTXfMJAOJgb3fD3TUdRUTN9u5oFl/ISgSQ3xBPy
         GLIU6GdHz0OHDwG2o02uZnI4LwkeBrlkxgHIYxbVzntGBFkSCEFz1QF4uP8DOwtUtBIV
         A8ffeSmez6PlPahh+5peFy96i3sDQHymKO3UfhdGd+EWpAkO+UdV/IFvsaNWU72xLJeG
         cbsQ==
X-Gm-Message-State: AGi0Pub/KwkduFNRut+lHjR7Z0d01lcO25TUcWLJcypQn08UJPyMb7Pj
        WhclL6ztzjtLbF95EEP284w=
X-Google-Smtp-Source: APiQypKCOyi2XIrs/N1hDYUvQqvI+0UpEcP4/oumUA+xBaBS78CEyzsuqz1vPjIe44F7Nk4/dFXALg==
X-Received: by 2002:a05:6402:1caa:: with SMTP id cz10mr7824357edb.4.1585920900471;
        Fri, 03 Apr 2020 06:35:00 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id u13sm1402362edi.82.2020.04.03.06.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 06:34:59 -0700 (PDT)
Date:   Fri, 3 Apr 2020 15:34:57 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, Kukjin Kim <kgene@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200403133457.GA7561@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48@epcas2p4.samsung.com>
 <20200403111511.10598-1-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403111511.10598-1-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 08:15:10PM +0900, Hyunki Koo wrote:
> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> 
> This is required for some newer SoCs.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
> v2: 
> line 954 : change rd_regl to rd_reg in for backward compatibility.
> line 2031: Add init value for ourport->port.iotype  to UPIO_MEM 
> v3:
> line 2031: remove redundant init value  for ourport->port.iotype 
> v4:
> correct variable types and change misleading function name
> ---
>  drivers/tty/serial/samsung_tty.c | 76 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 64 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 73f951d65b93..bdf1d4d12cb1 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -154,12 +154,47 @@ struct s3c24xx_uart_port {
>  #define portaddrl(port, reg) \
>  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
>  
> -#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
> +static u32 rd_reg(struct uart_port *port, u32 reg)
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
> +static void wr_reg(struct uart_port *port, u32 reg, u32 val)
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
> +static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
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
> @@ -2000,10 +2035,27 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  			dev_get_platdata(&pdev->dev) :
>  			ourport->drv_data->def_cfg;
>  
> -	if (np)
> +	if (np) {
>  		of_property_read_u32(np,
>  			"samsung,uart-fifosize", &ourport->port.fifosize);
>  
> +		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {

I got more thoughts... where is the binding for it? It looked like
standard DT property but it is not described in device tree spec.

Also, where is the user (DTS) with it? I expect such changes go with the
user itself... otherwise, next cleanup it will go away.

Best regards,
Krzysztof
