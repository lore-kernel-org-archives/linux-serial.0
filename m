Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A878C48BE5
	for <linux-serial@archiver.kernel.org>; Wed, 23 Jun 2021 07:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9FB61185
	for <linux-serial@archiver.kernel.org>; Wed, 23 Jun 2021 07:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWIA2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Jun 2021 04:00:28 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43561 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFWIA1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Jun 2021 04:00:27 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210623075808epoutp011980c028a220ccba1bb31eef36827b89~LJxs-S0xv3038930389epoutp01I
        for <linux-serial@vger.kernel.org>; Wed, 23 Jun 2021 07:58:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210623075808epoutp011980c028a220ccba1bb31eef36827b89~LJxs-S0xv3038930389epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624435088;
        bh=STnqqpqrDAa4Awhx4ERYLxNyS6G1U43Y6rlW7ZZm8YY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=R6wvxtaPc2p9JWhbdx9GmhcVDHRjQSun52TRXSK11+ozz8dUaWPN+jAqbx4G6iQbf
         flo4BX6BQEQQT4LLyaMsonVyfQiRlrSlodYexn1+Pk2s616bGjxdXcSOvsaQuchWmV
         VrC063WGDUvU6hkAUVuqp1iyEVFmn9K8L9EVgORI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210623075807epcas5p1f467e34343b58cc245e668b11c749cdc~LJxsTVdcl2330323303epcas5p1b;
        Wed, 23 Jun 2021 07:58:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.19.09595.F89E2D06; Wed, 23 Jun 2021 16:58:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210623062924epcas5p343049bb2c31fe088bcd022ae59361bbf~LIkOozONU0886408864epcas5p3r;
        Wed, 23 Jun 2021 06:29:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210623062924epsmtrp13e0c34486b78d8cd8f7bd5fb4326018a~LIkOn4ImL1516015160epsmtrp1n;
        Wed, 23 Jun 2021 06:29:24 +0000 (GMT)
X-AuditID: b6c32a4a-ed5ff7000000257b-f0-60d2e98f9d2d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.16.08289.4C4D2D06; Wed, 23 Jun 2021 15:29:24 +0900 (KST)
Received: from mshams01 (unknown [107.122.12.94]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210623062922epsmtip2fef898dc0702b4947d69d2d457b3539b~LIkNCCBzt2071920719epsmtip27;
        Wed, 23 Jun 2021 06:29:22 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <ajaykumar.rs@samsung.com>
In-Reply-To: <e511bd16-fb50-bc63-d0c5-a8b4e5e78525@canonical.com>
Subject: RE: [PATCH v3] serial: samsung: use dma_ops of DMA if attached
Date:   Wed, 23 Jun 2021 11:59:21 +0530
Message-ID: <00e401d767f9$1bcac470$53604d50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQItU4fysVW8QImmVYiqDo0qYjPo+wIna99BATcTGFOqWlU/0A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUwTURDGfd3tdqmprqWGseLVhBgw1gvjKgoeJFSNR4wa40WrbNDQg7Sg
        0nhUIKKEimeUtixGigoq1Yq2ActRxbNGRUIEg3J5oBQVjFGJUdfWyH+/mffNfPMlj8TEpXwp
        uV2bxui1KrWMEOI3bkVOnJzf3aCc6uydRNd+rMPpNvYGQWcVOwi6tzCcvur/xqOdnU18+lml
        jaBPP67m0b5is2B+iMJiMhMKZ9khQlFTeEmguGbfpzhcUYYU/c6xK4n1wrlJjHr7DkY/JVYp
        3Fb8qwilsopdH1ru803IPScXkSRQ0VBSr8lFQlJMVSHoyX5OBIo+BNYaF8pFIX+KfgRdVwUc
        cwPPLn/FAqJKBH2Z74LFGwQOu4vPqQhqMhyrO4BxLKF2wuPT1r9rMcqHoLP4OI/zDqEWgKV5
        FYehVAKY2sI5xKkIePqV4CZF1GxwdrQEeQTcL+jCOcaoceDy27DAPePh++tzfG5UQi0ET6U8
        IAmD7vrbAs4UqBISelrsKKCPh6y8vCCHwvu7FcFcUujOPxBkHRSxZcH9u6D0SU+Q46C20YZz
        XhgVCY7KKYH2GDj5oJwX8B0G5oEuXqAvAjf7jyfAr6r84Pow6L1wgn8EySyDklkGJbMMimD5
        73YG4WVoFJNq0CQzhpmp07XMTrlBpTGka5PlW3UaJ/r7m6KWuFF72ye5F/FI5EVAYjKJqCO7
        QSkWJakyjIxel6hPVzMGLxpN4rIwUYnAqxRTyao0JoVhUhn9v1ceGSI18Y5nvcm7I7j5IM5j
        PdK0LLr6czOE7blNphyrGXo0p6B8RpOBNFeQ7zNXtZK3oq0DMTZt5pCfMemhzStzjHvNVeyX
        uS/Wja5Tuy7kT/S0+s5rJPNOZH0yWgvTzrn73TlWr9FinL3UMXJ3u7qDlZpi7hVG6ZJ+aArO
        kls3FdlOTvPYfQm+dT6/sAu7vmRFBO2R5mWrXst+RCSwI2IXN5TGbbgIq9e+Oijax+KS7vBZ
        8xrFc55vaUIORvUSdb5qJw5ufpsx3HUGpWiyl28+tUh+uOBozcOY/a2m1YmWxIi++IG4NWMi
        4+MfKe+WD2wc0rOA9S/9MK7efCVjk70R08X6Zbhhm2paFKY3qH4Dzmx2W7wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXvfIlUsJBicXSVkceH+QxeLBvG1s
        Fs2L17NZvJsrY7Hx7Q8mi02Pr7FaXN41h81ixvl9TBZnFveyO3B6zGroZfPYtKqTzWP/3DXs
        HpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxuL/8xkL5nlUvL51krWBcYdVFyMnh4SA
        icTltd+Yuxi5OIQEdjBK/Pr8nREiIS4x7dd+KFtYYuW/5+wQRU8YJZ5/n8oGkmAT0JWYdLAN
        qJuDQ0SgUmJJkx5IDbPABUaJ7qM3oBr2M0o8fnGRDaSIU8BRYtbNIBBTWMBdouGBDIjJIqAq
        cfEb2EReAUuJTY9uQdmCEidnPmEBsZkFtCV6H7YyQtjyEtvfzmGGOE1B4ufTZawQFzhJ7N2l
        B1EiLvHy6BH2CYzCs5BMmoVk0iwkk2YhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10v
        OT93EyM4xrS0djDuWfVB7xAjEwfjIUYJDmYlEd5HLZcShHhTEiurUovy44tKc1KLDzFKc7Ao
        ifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamC64PQsUea/eTnnaqOkbMfPkvF1a12mf1Ww31u4
        IThJeuKev0y2i4Kv7z1zXFE11W+VIhPjpamGXQkPA8U9BWXfNLjV6mkYnRC/emudzvQ769wC
        NTfoTXnLmvnzNU/YfSXXTCPT75pfMo1PxzC9ubjjwZLEurnn3Lfpb38oZe949vQ9gTM39S7J
        RDpsn1tgHaC85cDnSyefJ2s1v5/RFX5lh8CexFM7gmMF1q9686h5X7/gKt26+vRlsrJ7nPfW
        SX1u3Hb0TsnuV+/kM5ZXKr3/dXCu+nM3hgWvvujGpaXks2lrO6lqpXvuiRCyZMl8mMIQX6si
        rl7CzH6ybjnfpMDVLLVnVTUUZP0mptmzCymxFGckGmoxFxUnAgA70xIoIAMAAA==
X-CMS-MailID: 20210623062924epcas5p343049bb2c31fe088bcd022ae59361bbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210622091321epcas5p42e0a80b034f22ae9b82a3377193bb972
References: <CGME20210622091321epcas5p42e0a80b034f22ae9b82a3377193bb972@epcas5p4.samsung.com>
        <20210622091710.44032-1-m.shams@samsung.com>
        <e511bd16-fb50-bc63-d0c5-a8b4e5e78525@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > When DMA is used for TX and RX by serial driver, it should pass the
> > DMA device pointer to DMA API instead of UART device pointer. DMA
> > device should be used for DMA API because only the DMA device is aware
> > of how the device connects to the memory.
> > There might be an extra level of address translation due to a SMMU
> > attached to the DMA device. When serial device pointer device is used
> > for DMA API, the DMA API will have no clue of the SMMU attached to the
> > DMA device.
> >
> > This patch is necessary to fix the SMMU page faults which is observed
> > when a DMA(with SMMU enabled) is attached to UART for transfer.
> >
> > Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> > Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> > ---
> > Changes since v1:
> > 1. Rebased the patch on "tty-next" branch of TTY driver tree
> >
> > Changes since v2:
> > 1. Updated the commit message.
> > 2. Changed the comment description
> >
> >  drivers/tty/serial/samsung_tty.c | 62
> > +++++++++++++++++++++++++-------
> >  1 file changed, 50 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 9fbc61151c2e..7dd648cb7237 100644
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
> > +	/* Null pointer check for "dma" and "dma->tx_chan" */
> 
> The comment is not useful.
> 
I will remove these comments.
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
> > +	/* Null pointer check for "dma" and "dma->tx_chan" */
> > +	if (dma && dma->tx_chan)
> 
> 
> What is the "else" here? How is it even possible? Why having this "if"
> at all?
> 
As mentioned in my reply (https://lkml.org/lkml/2021/6/23/6)  to
Robin's comments for patch version 2, I will be removing these
"if" conditions, and directly assign DMA device pointers.

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
> > +	/* Null pointer check for "dma" and "dma->tx_chan" */
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
> > +	/* Null pointer check for "dma" and "dma->rx_chan" */
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
> > +	/* Null pointer check for "dma" and "dma->rx_chan" */
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
> > +	/* Null pointer check for "dma" and "dma->rx_chan" */
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
> > +	/* Null pointer check for "dma" and "dma->tx_chan" */
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
> >
> 
> 
> Best regards,
> Krzysztof

Thanks & Regards,
Tamseel Shams

