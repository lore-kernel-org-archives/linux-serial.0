Return-Path: <SRS0=bk4J=CD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6FAC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 22:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AB3206EB
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598393839;
	bh=/FOUSdujCr7K101FlkjEFQT7V3qH99OHxy//G/AmMxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fb1laYdbRrv+zdF67rCVl1Y+B/VfFcE4LCv02uuDE9f68f6LHmWpq/gDRFYq0OY/w
	 ZplRmnL2ofQvig08tAVPqUXrHvihPMmAmlR5jnYup9P+r5blqmmyGzSW3LSMsXMIly
	 cby//kaKHS3bKghqBwPxlkKvXk8zrajNQWPdwNdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHYWRT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:17:19 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42030 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgHYWRR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Aug 2020 18:17:17 -0400
Received: by mail-il1-f193.google.com with SMTP id t13so105314ile.9;
        Tue, 25 Aug 2020 15:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+gWDI2HSuxEN9PHmssWSsCWOPQwrrYQlqUj19kTiZO8=;
        b=OQY9F/zTNsU93s9FdY4UeJ85tbK0FjyG4fuyxl+sfQpEvD9vpCoRE3QnNs/E4KR5Fu
         0pACK004BPJNwDolGL+SN0A4w53c3jXm2l3rJ/CV5xI8O1lEKopV7/ExJpQ2YORLFZLx
         CYuCBD64UiR9bFhh/bg+vSIsnrAXSd1WTO8vdrzdvoiY3RPNdoNsndHhpWeaNTVFOELS
         fnOpMHk1Wd1idkSIFIGYHo0oaB1cumFiwK9mtR3GzByxqu76qhoOd+AWVys/zRqJA5xM
         8D/T61YUCXXNPlXVoJHFspOoV0dkq7K2gH/svi5vi8+y/4KYrNnTgsBad4CQAs6h/Ldr
         QzCQ==
X-Gm-Message-State: AOAM531ZeMRhslBL9iWfVocCgYz1QjLcMnf6PWHuV1Y6GsaxA+ytjHH7
        wakJ+hqYhCOHQDgATwSyDQ==
X-Google-Smtp-Source: ABdhPJwm1iL8A8bcUtnGf91+AkOK/GRMiWrC+scYAmpNQ1NeVEa2Pr792/aFF2e2Mb9IojjUUBXTNQ==
X-Received: by 2002:a92:de42:: with SMTP id e2mr10686539ilr.148.1598393835748;
        Tue, 25 Aug 2020 15:17:15 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a16sm218775ilc.7.2020.08.25.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:17:15 -0700 (PDT)
Received: (nullmailer pid 1441951 invoked by uid 1000);
        Tue, 25 Aug 2020 22:17:13 -0000
Date:   Tue, 25 Aug 2020 16:17:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        jslaby@suse.com, git-dev@xilinx.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] tty: pl011: Add support for xilinx uart
Message-ID: <20200825221713.GB1429623@bogus>
References: <1597855439-746-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1597855439-746-2-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597855439-746-2-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 19, 2020 at 10:13:59PM +0530, Shubhrajyoti Datta wrote:
> Xilinx uart is similar to sbsa but it has configurable
> parity and hardware flow. Add a compatible for the same.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 77 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 8efd7c2..41dbcee 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2073,6 +2073,55 @@ sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> +static void
> +xlnx_sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
> +			   struct ktermios *old)
> +{
> +	struct uart_amba_port *uap =
> +	    container_of(port, struct uart_amba_port, port);
> +	unsigned long flags;
> +	unsigned int lcr_h, old_cr;
> +
> +	tty_termios_encode_baud_rate(termios, uap->fixed_baud, uap->fixed_baud);
> +	/* The SBSA UART only supports 8n1 without hardware flow control. */
> +	termios->c_cflag &= ~(CMSPAR | CRTSCTS);
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS5:
> +		lcr_h = UART01x_LCRH_WLEN_5;
> +		break;
> +	case CS6:
> +		lcr_h = UART01x_LCRH_WLEN_6;
> +		break;
> +	case CS7:
> +		lcr_h = UART01x_LCRH_WLEN_7;
> +		break;
> +	default:
> +		lcr_h = UART01x_LCRH_WLEN_8;
> +		break;
> +	}
> +	if (termios->c_cflag & CSTOPB)
> +		lcr_h |= UART01x_LCRH_STP2;
> +	if (termios->c_cflag & PARENB) {
> +		lcr_h |= UART01x_LCRH_PEN;
> +		if (!(termios->c_cflag & PARODD))
> +			lcr_h |= UART01x_LCRH_EPS;
> +		if (termios->c_cflag & CMSPAR)
> +			lcr_h |= UART011_LCRH_SPS;
> +	}
> +	if (uap->fifosize > 1)
> +		lcr_h |= UART01x_LCRH_FEN;

I'm guessing at least some of the above code is just copy-n-paste from 
the pl011 version? Can't you reuse the existing version?

> +	spin_lock_irqsave(&port->lock, flags);
> +	uart_update_timeout(port, CS8, uap->fixed_baud);
> +	pl011_setup_status_masks(port, termios);
> +	/* first, disable everything */
> +	old_cr = pl011_read(uap, REG_CR);
> +	pl011_write(0, uap, REG_CR);
> +	pl011_write_lcr_h(uap, lcr_h);
> +	pl011_write(old_cr, uap, REG_CR);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
>  static const char *pl011_type(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
> @@ -2179,6 +2228,28 @@ static const struct uart_ops sbsa_uart_pops = {
>  #endif
>  };
>  
> +static const struct uart_ops xlnx_sbsa_uart_pops = {
> +	.tx_empty	= pl011_tx_empty,
> +	.set_mctrl	= sbsa_uart_set_mctrl,
> +	.get_mctrl	= sbsa_uart_get_mctrl,
> +	.stop_tx	= pl011_stop_tx,
> +	.start_tx	= pl011_start_tx,
> +	.stop_rx	= pl011_stop_rx,
> +	.startup	= sbsa_uart_startup,
> +	.shutdown	= sbsa_uart_shutdown,
> +	.set_termios	= xlnx_sbsa_uart_set_termios,
> +	.type		= pl011_type,
> +	.release_port	= pl011_release_port,
> +	.request_port	= pl011_request_port,
> +	.config_port	= pl011_config_port,
> +	.verify_port	= pl011_verify_port,
> +#ifdef CONFIG_CONSOLE_POLL
> +	.poll_init     = pl011_hwinit,
> +	.poll_get_char = pl011_get_poll_char,
> +	.poll_put_char = pl011_put_poll_char,
> +#endif
> +};
> +
>  static struct uart_amba_port *amba_ports[UART_NR];
>  
>  #ifdef CONFIG_SERIAL_AMBA_PL011_CONSOLE
> @@ -2754,7 +2825,10 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>  	uap->reg_offset	= uap->vendor->reg_offset;
>  	uap->fifosize	= 32;
>  	uap->port.iotype = uap->vendor->access_32b ? UPIO_MEM32 : UPIO_MEM;
> -	uap->port.ops	= &sbsa_uart_pops;
> +	if (of_device_is_compatible(pdev->dev.of_node, "arm,xlnx-sbsa-uart"))
> +		uap->port.ops	= &xlnx_sbsa_uart_pops;
> +	else
> +		uap->port.ops	= &sbsa_uart_pops;
>  	uap->fixed_baud = baudrate;
>  
>  	snprintf(uap->type, sizeof(uap->type), "SBSA");
> @@ -2781,6 +2855,7 @@ static int sbsa_uart_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id sbsa_uart_of_match[] = {
>  	{ .compatible = "arm,sbsa-uart", },
> +	{ .compatible = "arm,xlnx-sbsa-uart", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
> -- 
> 2.7.4
> 
