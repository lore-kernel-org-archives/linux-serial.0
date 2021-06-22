Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3DBC48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F716128E
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 07:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFVHyZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:54:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53871 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVHyZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 03:54:25 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210622075208epoutp0421545ef8c7b6911022f2d52419489af2~K2DLDiZ-L1792417924epoutp04g
        for <linux-serial@vger.kernel.org>; Tue, 22 Jun 2021 07:52:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210622075208epoutp0421545ef8c7b6911022f2d52419489af2~K2DLDiZ-L1792417924epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624348328;
        bh=KTxHmuLD3DLPfT/gur5BtJPLNjOfTiAWIvDVIAUlhmo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=IgHotq4UMDxn643qhIpStPhWkfDYOU4xacGMOjpxeSsSMMnAxAASbeJbaEZIk3Brc
         M/CQt2/2yMQUE1RwK6wlk38yI3ceghQruvZOk3OxGxHSggFLMsd737dPQXf2dR8VWz
         Z3Uwgljd2dPGC5f3AzpFKPgNruGNcq+wjrrSB6xM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210622075203epcas5p1e4ba147834618a2312bf1fc1c578e5ca~K2DG6fnzT2190821908epcas5p1s;
        Tue, 22 Jun 2021 07:52:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.59.09452.3A691D06; Tue, 22 Jun 2021 16:52:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210622063715epcas5p4407d85eec70b971c7d6b991ea3a00256~K1ByotU4K2654126541epcas5p47;
        Tue, 22 Jun 2021 06:37:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210622063715epsmtrp24a29a449818b17987c6c9cef86b11be3~K1Byn_IgZ2392223922epsmtrp22;
        Tue, 22 Jun 2021 06:37:15 +0000 (GMT)
X-AuditID: b6c32a4b-429ff700000024ec-36-60d196a3d33c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.63.08394.B1581D06; Tue, 22 Jun 2021 15:37:15 +0900 (KST)
Received: from mshams01 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210622063713epsmtip1199711e54f0ce840c3237085f6bc6944~K1BxQd7f-1035910359epsmtip18;
        Tue, 22 Jun 2021 06:37:13 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <krzysztof.kozlowski@canonical.com>, <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <ajaykumar.rs@samsung.com>
In-Reply-To: <YNF5T3dLjGZ7z0Gw@kroah.com>
Subject: RE: [PATCH v2] serial: samsung: use dma_ops of DMA if attached
Date:   Tue, 22 Jun 2021 12:07:12 +0530
Message-ID: <007401d76731$09fd69a0$1df83ce0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFcRGEZG7b0woiOY60hUFl/qJOGXQI/LuL6AWIkNXyr+MsecA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7bCmhu7iaRcTDM7NV7I48P4gi8WDedvY
        LJoXr2ezeDdXxmLj2x9MFpseX2O1uLxrDpvFjPP7mCzOLO5ld+D0mNXQy+axaVUnm8f+uWvY
        PTYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujOkbLrAVXPOueD9tNmsDY69tFyMnh4SA
        icTGl4sYuxi5OIQEdjNK3Ng3lR3C+cQocf7xRajMN0aJ/S/uscC07J/5D6pqL6PEwvf7GEES
        QgLPGCV2rZEBsdkEdCUmHWxjBrFFBHQkOs6cYAFpYBboZJLYO+cYWIJTQFPi06pFYM3CAu4S
        S550M3UxcnCwCKhKrN3NARLmFbCUOLBjIjOELShxcuYTsCOYBeQltr+dwwxxkILEz6fLWEFa
        RQScJDYv94EoEZd4efQI2J0SAms5JH7c3M0GUe8iceDQKlYIW1ji1fEt7BC2lMTnd3uhavIl
        5s9bBTW/QmLlhTdQtr3EgStzWEB2MQOdv36XPkRYVmLqqXVMEHv5JHp/P2GCiPNK7JgHYytK
        /N/dD7VKXOLdiimsExiVZiH5bBaSz2YheWEWwrYFjCyrGCVTC4pz01OLTQuM81LL9YoTc4tL
        89L1kvNzNzGCE5SW9w7GRw8+6B1iZOJgPMQowcGsJML7IvtighBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHepeyHEoQE0hNLUrNTUwtSi2CyTBycUg1MNXxXvCMuX3950GHx4e1vzqj946qP8zgT
        fSP19leJiOXPrZYpCeQbBO00eT8tY7utufO0e2o79+v/8u5tVnOL7W4O8Lg92fFRV+XcL/Mv
        3ZjIsTL8VHoW/7M+2Wz+fW+WvtA3tdCyvvbmc1HRu+0HxZ5Y3PNyju53XrzuqaQdn0zlgxzT
        bU/F8rgvnZ53fN0vgx/HO06+ivvxxfLZJeXTFxpyvhrsjzS6Uc26eMLieN68WXyhrBmJO590
        M6tJPRPadeFsg51sctKMb0zfuZeJq2p+ZF8ULH/aO36Fe9DOe9OTxLN4f63h2919Xr9w2VXB
        dfM2e+3imVf+7tbma3stOVeWXf8y588GxbMvf9Wl6SixFGckGmoxFxUnAgDPODY8vwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTle69WKCwbI+NosD7w+yWDyYt43N
        onnxejaLd3NlLDa+/cFksenxNVaLy7vmsFnMOL+PyeLM4l52B06PWQ29bB6bVnWyeeyfu4bd
        Y/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKmL7hAlvBNe+K99NmszYw9tp2MXJySAiY
        SOyf+Y+9i5GLQ0hgN6PEkeYONoiEuMS0X/sZIWxhiZX/nkMVPWGUOLlmE1gRm4CuxKSDbcwg
        toiAjkTHmRMsIEXMAhOZJKa0PITqWMYoMXFLHxNIFaeApsSnVYvAxgoLuEssedINFOfgYBFQ
        lVi7mwMkzCtgKXFgx0RmCFtQ4uTMJywgJcwCehJtG8E6mQXkJba/ncMMcZyCxM+ny1hBSkQE
        nCQ2L/eBKBGXeHn0CPsERuFZSAbNQhg0C8mgWUg6FjCyrGKUTC0ozk3PLTYsMMxLLdcrTswt
        Ls1L10vOz93ECI4yLc0djNtXfdA7xMjEwXiIUYKDWUmE90X2xQQh3pTEyqrUovz4otKc1OJD
        jNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamCY7Ca9TCVtsPMH0XYsC09KvR+Wvud2e
        XavrYvartkFSn++VvYP57OONFgYTE/N/M188oGT9eIPIZdZC4dO/StVZD4tM3K51tJ3hs4o1
        R/uKH1e3OL75fGLhQQa1Y5JaGzYJ7DJTPRyp+S/S+KgJ6/FPqrpr8u49YpN8ybvQ3NFovvWR
        fXHhNiKXhcyPnl8VGDalastKAV1bT6Vjt/8tvfBj4z+eG4w/GDdf5e5mX5GY1CJyer3/wXuH
        A068ippWsSJhQeHqnnnM7jYPF+1+E2e/7Kb3oVUBIfbsYsx7z6q7RXlXbInPebjmjk2h00TF
        +7cZ195aYHvv4Gov99am6q8GuXWuB06Yrb5gIqIRukGJpTgj0VCLuag4EQDIs5qVIQMAAA==
X-CMS-MailID: 20210622063715epcas5p4407d85eec70b971c7d6b991ea3a00256
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb
References: <CGME20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb@epcas5p3.samsung.com>
        <20210622035202.5260-1-m.shams@samsung.com> <YNF5T3dLjGZ7z0Gw@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


> > When DMA is used for TX and RX by serial driver, it should pass the
> > DMA device pointer to DMA API instead of UART device pointer.
> >
> > This patch is necessary to fix the SMMU page faults which is observed
> > when a DMA(with SMMU enabled) is attached to UART for transfer.
> >
> > Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> > Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 62
> > +++++++++++++++++++++++++-------
> >  1 file changed, 50 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 9fbc61151c2e..0c924bb6108e 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -284,8 +284,13 @@ static void s3c24xx_serial_stop_tx(struct uart_port
> *port)
> >  	struct s3c24xx_uart_dma *dma = ourport->dma;
> >  	struct circ_buf *xmit = &port->state->xmit;
> >  	struct dma_tx_state state;
> > +	struct device *dma_map_ops_dev = ourport->port.dev;
> >  	int count;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev = dma->tx_chan->device->dev;
> > +
> >  	if (!ourport->tx_enabled)
> >  		return;
> >
> > @@ -305,7 +310,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port
> *port)
> >  		dmaengine_pause(dma->tx_chan);
> >  		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> >  		dmaengine_terminate_all(dma->tx_chan);
> > -		dma_sync_single_for_cpu(ourport->port.dev,
> > +		dma_sync_single_for_cpu(dma_map_ops_dev,
> >  			dma->tx_transfer_addr, dma->tx_size,
> DMA_TO_DEVICE);
> >  		async_tx_ack(dma->tx_desc);
> >  		count = dma->tx_bytes_requested - state.residue; @@ -331,14
> +336,19
> > @@ static void s3c24xx_serial_tx_dma_complete(void *args)
> >  	struct circ_buf *xmit = &port->state->xmit;
> >  	struct s3c24xx_uart_dma *dma = ourport->dma;
> >  	struct dma_tx_state state;
> > +	struct device *dma_map_ops_dev = ourport->port.dev;
> >  	unsigned long flags;
> >  	int count;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev = dma->tx_chan->device->dev;
> > +
> >  	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> >  	count = dma->tx_bytes_requested - state.residue;
> >  	async_tx_ack(dma->tx_desc);
> >
> > -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> > +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
> >  				dma->tx_size, DMA_TO_DEVICE);
> >
> >  	spin_lock_irqsave(&port->lock, flags); @@ -436,6 +446,11 @@ static
> > int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
> >  	struct uart_port *port = &ourport->port;
> >  	struct circ_buf *xmit = &port->state->xmit;
> >  	struct s3c24xx_uart_dma *dma = ourport->dma;
> > +	struct device *dma_map_ops_dev = ourport->port.dev;
> > +
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev = dma->tx_chan->device->dev;
> >
> >  	if (ourport->tx_mode != S3C24XX_TX_DMA)
> >  		enable_tx_dma(ourport);
> > @@ -443,7 +458,7 @@ static int s3c24xx_serial_start_tx_dma(struct
> s3c24xx_uart_port *ourport,
> >  	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
> >  	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
> >
> > -	dma_sync_single_for_device(ourport->port.dev, dma-
> >tx_transfer_addr,
> > +	dma_sync_single_for_device(dma_map_ops_dev, dma-
> >tx_transfer_addr,
> >  				dma->tx_size, DMA_TO_DEVICE);
> >
> >  	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
> > @@ -510,12 +525,17 @@ static void s3c24xx_uart_copy_rx_to_tty(struct
> s3c24xx_uart_port *ourport,
> >  		struct tty_port *tty, int count)
> >  {
> >  	struct s3c24xx_uart_dma *dma = ourport->dma;
> > +	struct device *dma_map_ops_dev = ourport->port.dev;
> >  	int copied;
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->rx_chan)
> > +		dma_map_ops_dev = dma->rx_chan->device->dev;
> > +
> >  	if (!count)
> >  		return;
> >
> > -	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
> > +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
> >  				dma->rx_size, DMA_FROM_DEVICE);
> >
> >  	ourport->port.icount.rx += count;
> > @@ -635,8 +655,13 @@ static void s3c24xx_serial_rx_dma_complete(void
> > *args)  static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port
> > *ourport)  {
> >  	struct s3c24xx_uart_dma *dma = ourport->dma;
> > +	struct device *dma_map_ops_dev = ourport->port.dev;
> > +
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->rx_chan)
> > +		dma_map_ops_dev = dma->rx_chan->device->dev;
> >
> > -	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
> > +	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
> >  				dma->rx_size, DMA_FROM_DEVICE);
> >
> >  	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
> > @@ -1045,6 +1070,7 @@ static int s3c24xx_serial_request_dma(struct
> s3c24xx_uart_port *p)
> >  	struct s3c24xx_uart_dma	*dma = p->dma;
> >  	struct dma_slave_caps dma_caps;
> >  	const char *reason = NULL;
> > +	struct device *dma_map_ops_dev = p->port.dev;
> >  	int ret;
> >
> >  	/* Default slave configuration parameters */ @@ -1102,18 +1128,25
> @@
> > static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
> >  		goto err_release_tx;
> >  	}
> >
> > -	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->rx_chan)
> > +		dma_map_ops_dev = dma->rx_chan->device->dev;
> > +
> > +	dma->rx_addr = dma_map_single(dma_map_ops_dev, dma->rx_buf,
> >  				dma->rx_size, DMA_FROM_DEVICE);
> > -	if (dma_mapping_error(p->port.dev, dma->rx_addr)) {
> > +	if (dma_mapping_error(dma_map_ops_dev, dma->rx_addr)) {
> >  		reason = "DMA mapping error for RX buffer";
> >  		ret = -EIO;
> >  		goto err_free_rx;
> >  	}
> >
> > +	/* Pick dma_ops of DMA device if DMA device is attached */
> > +	if (dma && dma->tx_chan)
> > +		dma_map_ops_dev = dma->tx_chan->device->dev;
> >  	/* TX buffer */
> > -	dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
> > +	dma->tx_addr = dma_map_single(dma_map_ops_dev,
> > +p->port.state->xmit.buf,
> >  				UART_XMIT_SIZE, DMA_TO_DEVICE);
> > -	if (dma_mapping_error(p->port.dev, dma->tx_addr)) {
> > +	if (dma_mapping_error(dma_map_ops_dev, dma->tx_addr)) {
> >  		reason = "DMA mapping error for TX buffer";
> >  		ret = -EIO;
> >  		goto err_unmap_rx;
> > @@ -1122,7 +1155,9 @@ static int s3c24xx_serial_request_dma(struct
> s3c24xx_uart_port *p)
> >  	return 0;
> >
> >  err_unmap_rx:
> > -	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
> > +	if (dma->rx_chan)
> > +		dma_map_ops_dev = dma->rx_chan->device->dev;
> > +	dma_unmap_single(dma_map_ops_dev, dma->rx_addr, dma->rx_size,
> >  			 DMA_FROM_DEVICE);
> >  err_free_rx:
> >  	kfree(dma->rx_buf);
> > @@ -1139,10 +1174,12 @@ static int s3c24xx_serial_request_dma(struct
> > s3c24xx_uart_port *p)  static void s3c24xx_serial_release_dma(struct
> > s3c24xx_uart_port *p)  {
> >  	struct s3c24xx_uart_dma	*dma = p->dma;
> > +	struct device *dma_map_ops_dev = p->port.dev;
> >
> >  	if (dma->rx_chan) {
> > +		dma_map_ops_dev = dma->rx_chan->device->dev;
> >  		dmaengine_terminate_all(dma->rx_chan);
> > -		dma_unmap_single(p->port.dev, dma->rx_addr,
> > +		dma_unmap_single(dma_map_ops_dev, dma->rx_addr,
> >  				dma->rx_size, DMA_FROM_DEVICE);
> >  		kfree(dma->rx_buf);
> >  		dma_release_channel(dma->rx_chan);
> > @@ -1150,8 +1187,9 @@ static void s3c24xx_serial_release_dma(struct
> s3c24xx_uart_port *p)
> >  	}
> >
> >  	if (dma->tx_chan) {
> > +		dma_map_ops_dev = dma->tx_chan->device->dev;
> >  		dmaengine_terminate_all(dma->tx_chan);
> > -		dma_unmap_single(p->port.dev, dma->tx_addr,
> > +		dma_unmap_single(dma_map_ops_dev, dma->tx_addr,
> >  				UART_XMIT_SIZE, DMA_TO_DEVICE);
> >  		dma_release_channel(dma->tx_chan);
> >  		dma->tx_chan = NULL;
> > --
> > 2.17.1
> >
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot

Hi Greg,
Sorry for not mentioning the change from previous version.
I will update the patch and post the new version.

Thanks & Regards,
Tamseel Shams

