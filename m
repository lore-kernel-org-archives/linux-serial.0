Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E13BC43331
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 07:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091D620787
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585900292;
	bh=BghNhGulEQr0kLjskkUOg6b0TXTN0SIR/eshclZhPQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GQA2L0FtSKY3pdJr7fL4Dd1fzct8L6pg34eeALzCdsp5Sw1w5ntFQXx/4BRn5cxUu
	 wc9zBaiaUSvGeycaqIVQaGRtSGNgxTh6NBjZa2OHO/QFa8qXg0q0BuuSX0l50g2Szd
	 xFJHxTPhWP65lh1ZgOLGRogDeVB5Riy0JeBjZw4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgDCHv2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:51:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39187 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbgDCHv2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 03:51:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so8200260edf.6;
        Fri, 03 Apr 2020 00:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FrbcHFj0dm8KrckD2b/yiBc/1g6Pf5o+uljHj8BaPN8=;
        b=bobxQc2uK07V/4Tp7E/Oq0fO12aHOwIpIkdfCf0hGu9ra7UcjjtxT6BDdVgteJr0cX
         Af4d3Mjxt0MMwnIlwUrIt2m0RtYw6LuyzwBirohkpfrgcAR1zlANZA97QbmPb3oLjbQp
         Q4gBKI73EcaGMfQEb2nCOG4Mp0/uIwS9J+YnkO3GdjR+qE41OKKNxKoeN9MrGOz5Lhb+
         Fvf3BqeYb+TYXIaSM7sUv98kqKk1y7cD7AjitwGyNBspp/kDgBMIcvFssixTkpfyiws1
         xpPcxXXO0K0Ljg8Mo+A2uRUxTLLCt3mX3rTuA9KE+oEjITdyuDQh3C5holrjIgZismnh
         9laA==
X-Gm-Message-State: AGi0PuYkKgb8Xs0RVqcI5LHSyTSL3EzzhOAn1TCzeY3kjLLUEIBVBFno
        e/D9kmQMLlPPSMPqRFUGEBs=
X-Google-Smtp-Source: APiQypIrcHJYRv1WIrgNA9AiIhYtOM0atxCY3hVtPi2Fwodq0nL/GJ/YWXSy5trX555E50tOg/puaA==
X-Received: by 2002:a17:906:64b:: with SMTP id t11mr6896556ejb.224.1585900285735;
        Fri, 03 Apr 2020 00:51:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id l24sm1425106ejx.81.2020.04.03.00.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 00:51:24 -0700 (PDT)
Date:   Fri, 3 Apr 2020 09:51:22 +0200
From:   'Krzysztof Kozlowski' <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, 'Kukjin Kim' <kgene@kernel.org>,
        'Jiri Slaby' <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200403075122.GA9358@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200402110609epcas2p4a5ec1fb3a5eaa3b12c20cfc2060162f3@epcas2p4.samsung.com>
 <20200402110430.31156-1-hyunki00.koo@samsung.com>
 <20200402135903.GA14861@kozik-lap>
 <004c01d60989$c5923030$50b69090$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <004c01d60989$c5923030$50b69090$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 04:30:38PM +0900, Hyunki Koo wrote:
> On Thu, Apr 02, 2020 at 10:59:29PM +0900, Krzysztof Kozlowski
> > On Thu, Apr 02, 2020 at 08:04:29PM +0900, Hyunki Koo wrote:
> > > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> > >
> > > This is required for some newer SoCs.
> > >
> > > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > > ---
> > >  drivers/tty/serial/samsung_tty.c | 78
> > > +++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 66 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/samsung_tty.c
> > > b/drivers/tty/serial/samsung_tty.c
> > > index 73f951d65b93..826d8c5846a6 100644
> > > --- a/drivers/tty/serial/samsung_tty.c
> > > +++ b/drivers/tty/serial/samsung_tty.c
> > > @@ -154,12 +154,47 @@ struct s3c24xx_uart_port {  #define
> > > portaddrl(port, reg) \
> > >  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
> > >
> > > -#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
> > > +static unsigned int rd_reg(struct uart_port *port, int reg) {
> > > +	switch (port->iotype) {
> > > +	case UPIO_MEM:
> > > +		return readb_relaxed(portaddr(port, reg));
> > > +	case UPIO_MEM32:
> > > +		return readl_relaxed(portaddr(port, reg));
> > > +	default:
> > > +		return 0;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > >  #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
> > >
> > > -#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port,
> > > reg))
> > > +static void wr_reg(struct uart_port *port, int reg, int val) {
> > > +	switch (port->iotype) {
> > > +	case UPIO_MEM:
> > > +		writeb_relaxed(val, portaddr(port, reg));
> > > +		break;
> > > +	case UPIO_MEM32:
> > > +		writel_relaxed(val, portaddr(port, reg));
> > > +		break;
> > > +	}
> > > +}
> > > +
> > >  #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port,
> > > reg))
> > >
> > > +static void write_buf(struct uart_port *port, int reg, int val) {
> > > +	switch (port->iotype) {
> > > +	case UPIO_MEM:
> > > +		writeb(val, portaddr(port, reg));
> > > +		break;
> > > +	case UPIO_MEM32:
> > > +		writel(val, portaddr(port, reg));
> > > +		break;
> > > +	}
> > > +}
> > > +
> > >  /* Byte-order aware bit setting/clearing functions. */
> > >
> > >  static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
> > > @@ -714,7 +749,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct
> > s3c24xx_uart_port *ourport)
> > >  		fifocnt--;
> > >
> > >  		uerstat = rd_regl(port, S3C2410_UERSTAT);
> > > -		ch = rd_regb(port, S3C2410_URXH);
> > > +		ch = rd_reg(port, S3C2410_URXH);
> > >
> > >  		if (port->flags & UPF_CONS_FLOW) {
> > >  			int txe = s3c24xx_serial_txempty_nofifo(port);
> > > @@ -826,7 +861,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int
> > irq, void *id)
> > >  	}
> > >
> > >  	if (port->x_char) {
> > > -		wr_regb(port, S3C2410_UTXH, port->x_char);
> > > +		wr_reg(port, S3C2410_UTXH, port->x_char);
> > >  		port->icount.tx++;
> > >  		port->x_char = 0;
> > >  		goto out;
> > > @@ -852,7 +887,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int
> > irq, void *id)
> > >  		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info-
> > >tx_fifofull)
> > >  			break;
> > >
> > > -		wr_regb(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
> > > +		wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
> > >  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> > >  		port->icount.tx++;
> > >  		count--;
> > > @@ -916,7 +951,7 @@ static unsigned int
> > s3c24xx_serial_tx_empty(struct
> > > uart_port *port)
> > >  /* no modem control lines */
> > >  static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
> > > {
> > > -	unsigned int umstat = rd_regb(port, S3C2410_UMSTAT);
> > > +	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
> > >
> > >  	if (umstat & S3C2410_UMSTAT_CTS)
> > >  		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS; @@ -
> > 1974,7 +2009,7 @@
> > > static int s3c24xx_serial_probe(struct platform_device *pdev)
> > >  	struct device_node *np = pdev->dev.of_node;
> > >  	struct s3c24xx_uart_port *ourport;
> > >  	int index = probe_index;
> > > -	int ret;
> > > +	int ret, prop = 0;
> > >
> > >  	if (np) {
> > >  		ret = of_alias_get_id(np, "serial"); @@ -2000,10
> > +2035,29 @@ static
> > > int s3c24xx_serial_probe(struct platform_device *pdev)
> > >  			dev_get_platdata(&pdev->dev) :
> > >  			ourport->drv_data->def_cfg;
> > >
> > > -	if (np)
> > > +	if (np) {
> > >  		of_property_read_u32(np,
> > >  			"samsung,uart-fifosize", &ourport->port.fifosize);
> > >
> > > +		if (of_property_read_u32(np, "reg-io-width", &prop) ==
> > 0) {
> > > +			switch (prop) {
> > > +			case 1:
> > > +				ourport->port.iotype = UPIO_MEM;
> > > +				break;
> > > +			case 4:
> > > +				ourport->port.iotype = UPIO_MEM32;
> > > +				break;
> > > +			default:
> > > +				dev_warn(&pdev->dev, "unsupported
> > reg-io-width (%d)\n",
> > > +						prop);
> > > +				ret = -EINVAL;
> > > +				break;
> > > +			}
> > > +		} else {
> > > +			ourport->port.iotype = UPIO_MEM;
> > > +		}
> > > +	}
> > 
> > I think this still breaks all non-DT platforms (e.g. s3c).
> > 
> > Best regards,
> > Krzysztof
> 
> Thank you for your comment.
> I  hope ourport->port.iotype  is initialized by below table for non-DT platforms

Indeed, you're right. In this case, this else() you added is not needed.
The default value for non-DT and existing DT platforms will be the same
(UPIO_MEM).

Best regards,
Krzysztof

