Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D72CC48BE5
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 04:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D5F61208
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 04:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFUEtB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Jun 2021 00:49:01 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:51760 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFUEsQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Jun 2021 00:48:16 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210621044601epoutp01dbf8a924f935e9eaa7891b57a1b7897c~Kf3ZSApor3089530895epoutp01N
        for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2021 04:46:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210621044601epoutp01dbf8a924f935e9eaa7891b57a1b7897c~Kf3ZSApor3089530895epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624250761;
        bh=+kNfBEB63My+Q+bp5feHqqd5F7O/GDMyOOUqAtOyYmA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cXFbrDB5mJFqluvwKMKBc1q78pxamk3iVbzU7QCzRPUxUbqmbMRr34ifT4lX/gt3o
         CNKJct48sy+VWtxMp6fGXBNCpNupx9g/IdNAHTXkOUt0M4Pmyml1JSoixwdcbgj+NU
         ZEIabFNqKjm4rYiPs3/wNi4sm2ov40O+33fgawIE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210621044600epcas5p3275c77ea8c9f9726424a8a31ebdd0050~Kf3YE-Vnk1754917549epcas5p3p;
        Mon, 21 Jun 2021 04:46:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.49.09595.88910D06; Mon, 21 Jun 2021 13:46:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210621044517epcas5p187affa518a18a3d019deb0c189cd8396~Kf2wCcTt92864828648epcas5p1W;
        Mon, 21 Jun 2021 04:45:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210621044517epsmtrp24ac8ba1856d40e6b9554bf8ffdc86b3c~Kf2wBknJI1488314883epsmtrp2K;
        Mon, 21 Jun 2021 04:45:17 +0000 (GMT)
X-AuditID: b6c32a4a-ed5ff7000000257b-26-60d0198812fc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.EF.08289.D5910D06; Mon, 21 Jun 2021 13:45:17 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210621044515epsmtip2c6f05125a8963c6eb535b3b56b2fb6a9~Kf2uaZssK3133331333epsmtip2C;
        Mon, 21 Jun 2021 04:45:15 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH] serial: samsung: use dma_ops of DMA if attached
Date:   Mon, 21 Jun 2021 10:19:16 +0530
Message-Id: <20210621044916.41564-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7bCmhm6H5IUEg9sbJS0OvD/IYvFg3jY2
        i+bF69kspmz4wGTR//g1s8X58xvYLTY9vsZqcXnXHDaLGef3MVmcWdzLbnG3dTG7A7fHplWd
        bB77565h99i8pN6jb8sqRo/1W66yeHzeJBfAFsVlk5Kak1mWWqRvl8CVsXnJJJaCp1YV3Qd3
        szUwHjLsYuTgkBAwkXj+0KWLkYtDSGA3o8T2zpuMEM4nRonmrbdZuxg5gZzPjBI71heB2CAN
        a97OY4co2sUoMX3mGmYIp4VJYkvHFFaQsWwCmhLHz3ODNIgIhEi8O7sFbCqzwFNGieXHrrOA
        JIQFHCQWXl3IDGKzCKhKnJnwDszmFbCQ2NA3nxFim7zE6g0HwBZICJxjl9jTMJMdIuEi8X1R
        CwuELSzx6vgWqLiUxOd3e9kg7HyJ+fNWMUPYFRIrL7yBsu0lDlyZwwJyKDPQoet36UOEZSWm
        nlrHBGIzC/BJ9P5+wgQR55XYMQ/GVpT4v7sfapW4xLsVU1ghbA+J652XmSChFSuxc+4zpgmM
        srMQNixgZFzFKJlaUJybnlpsWmCUl1quV5yYW1yal66XnJ+7iRGcJrS8djA+fPBB7xAjEwfj
        IUYJDmYlEV7OzDMJQrwpiZVVqUX58UWlOanFhxilOViUxHmXsh9KEBJITyxJzU5NLUgtgsky
        cXBKNTClGIdXLZ2xNVP71gw5ef25cRpfV87+Xt7qu7VGv0Lku6JLXqYc6+WlJwqszv4o8C/8
        w1WscZzx+OflgZvkDE8aT7N0nPJoS9aUgDWhl8JY6uY+s+LMtjjUp30k+KBcfE6Ao/TiF881
        1q235FpXEyUe/O5tn3zkXKPfYT1sNcZ3nYNKCzmWcGrvnHFbYBGb7MTNjeczdn9saKkP503u
        yOK6UfdrY8KnGU17p73X/sUs8eOQT4R1SYr8hMxTaxR68yOceQv9+bYfCOFZyxy34iL73w7F
        u2oz1X+zyP5ReyvY8cnXImrOvvmLZ054/8tzbT33+zLpCNZTicod3a5CwdqzX1Tu634/3+bG
        3QdZs5VYijMSDbWYi4oTAcBKHcSCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvG6s5IUEg/PbxCwOvD/IYvFg3jY2
        i+bF69kspmz4wGTR//g1s8X58xvYLTY9vsZqcXnXHDaLGef3MVmcWdzLbnG3dTG7A7fHplWd
        bB77565h99i8pN6jb8sqRo/1W66yeHzeJBfAFsVlk5Kak1mWWqRvl8CVsXnJJJaCp1YV3Qd3
        szUwHjLsYuTkkBAwkVjzdh57FyMXh5DADkaJB03T2CAS4hLTfu1nhLCFJVb+ew5V1MQk0T1/
        HlARBwebgKbE8fPcIKaIQITEzI81ICXMAq8ZJbY8mADWKyzgILHw6kJmEJtFQFXizIR3YDav
        gIXEhr75UPPlJVZvOMA8gZFnASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4KDT
        0trBuGfVB71DjEwcjIcYJTiYlUR4OTPPJAjxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5I
        ID2xJDU7NbUgtQgmy8TBKdXA1G8hq1bs+zbh9CnGrTom3tcZSzf9FV9jbJuifct+VR9nvcK3
        JYuTf/6MvB/bcmHl9nferTX2czr9lnPPWbl79crZ5ycpXHIpeX/sx72Vlk6cadsYPF0uyai1
        /oyOSknNiy8t8+7nF0tkaQg3tFedGr30jSqHX0WhrsSC8/oM8UdO5M1h49OwPyPtoyqYxrny
        15eoP4+u32ic0/H0w77o7IPbb6x9ZtSU/NgyKY7x9gyDlx+0tr9NFMmcLZ7eHX76g5vq2k5D
        y6ZjO1/dTOpNWOK6UfM715GldtM2xpvtTAhPCPL8XsHDbuCRrzAtiT1NrUMsfEV6tFH4YeMN
        57+q9nmdn6iqvb1g9XOfiz+VWIozEg21mIuKEwGOJ6LpqQIAAA==
X-CMS-MailID: 20210621044517epcas5p187affa518a18a3d019deb0c189cd8396
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210621044517epcas5p187affa518a18a3d019deb0c189cd8396
References: <CGME20210621044517epcas5p187affa518a18a3d019deb0c189cd8396@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When DMA is used for TX and RX by serial driver, it should
pass the DMA device pointer to DMA API instead of UART device
pointer.

This patch is necessary to fix the SMMU page faults
which is observed when a DMA(with SMMU enabled) is attached
to UART for transfer.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 60 +++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index b923683e6a25..5bdc7dd2a5e2 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -284,8 +284,13 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_tx_state state;
+	struct device *dma_map_ops_dev = ourport->port.dev;
 	int count;
 
+	/* Pick dma_ops of DMA device if DMA device is attached */
+	if (dma && dma->tx_chan)
+		dma_map_ops_dev = dma->tx_chan->device->dev;
+
 	if (!ourport->tx_enabled)
 		return;
 
@@ -298,7 +303,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 		dmaengine_pause(dma->tx_chan);
 		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_sync_single_for_cpu(ourport->port.dev,
+		dma_sync_single_for_cpu(dma_map_ops_dev,
 			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
 		async_tx_ack(dma->tx_desc);
 		count = dma->tx_bytes_requested - state.residue;
@@ -324,15 +329,19 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 	struct circ_buf *xmit = &port->state->xmit;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 	struct dma_tx_state state;
+	struct device *dma_map_ops_dev = ourport->port.dev;
 	unsigned long flags;
 	int count;
 
+	/* Pick dma_ops of DMA device if DMA device is attached */
+	if (dma && dma->tx_chan)
+		dma_map_ops_dev = dma->tx_chan->device->dev;
 
 	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
 	count = dma->tx_bytes_requested - state.residue;
 	async_tx_ack(dma->tx_desc);
 
-	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
+	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
 				dma->tx_size, DMA_TO_DEVICE);
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -408,7 +417,11 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	struct uart_port *port = &ourport->port;
 	struct circ_buf *xmit = &port->state->xmit;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
+	struct device *dma_map_ops_dev = ourport->port.dev;
 
+	/* Pick dma_ops of DMA device if DMA device is attached */
+	if (dma && dma->tx_chan)
+		dma_map_ops_dev = dma->tx_chan->device->dev;
 
 	if (ourport->tx_mode != S3C24XX_TX_DMA)
 		enable_tx_dma(ourport);
@@ -416,7 +429,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
 	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
 
-	dma_sync_single_for_device(ourport->port.dev, dma->tx_transfer_addr,
+	dma_sync_single_for_device(dma_map_ops_dev, dma->tx_transfer_addr,
 				dma->tx_size, DMA_TO_DEVICE);
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
@@ -483,12 +496,17 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
 		struct tty_port *tty, int count)
 {
 	struct s3c24xx_uart_dma *dma = ourport->dma;
+	struct device *dma_map_ops_dev = ourport->port.dev;
 	int copied;
 
+	/* Pick dma_ops of DMA device if DMA device is attached */
+	if (dma && dma->rx_chan)
+		dma_map_ops_dev = dma->rx_chan->device->dev;
+
 	if (!count)
 		return;
 
-	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
+	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	ourport->port.icount.rx += count;
@@ -600,8 +618,13 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct s3c24xx_uart_dma *dma = ourport->dma;
+	struct device *dma_map_ops_dev = ourport->port.dev;
 
-	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
+	/* Pick dma_ops of DMA device if DMA device is attached */
+	if (dma && dma->rx_chan)
+		dma_map_ops_dev = dma->rx_chan->device->dev;
+
+	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
@@ -983,6 +1006,7 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	struct s3c24xx_uart_dma	*dma = p->dma;
 	struct dma_slave_caps dma_caps;
 	const char *reason = NULL;
+	struct device *dma_map_ops_dev = p->port.dev;
 	int ret;
 
 	/* Default slave configuration parameters */
@@ -1040,18 +1064,25 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 		goto err_release_tx;
 	}
 
-	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
+	/* Pick dma_ops of DMA device if DMA device is attached */
+	if (dma && dma->rx_chan)
+		dma_map_ops_dev = dma->rx_chan->device->dev;
+
+	dma->rx_addr = dma_map_single(dma_map_ops_dev, dma->rx_buf,
 				dma->rx_size, DMA_FROM_DEVICE);
-	if (dma_mapping_error(p->port.dev, dma->rx_addr)) {
+	if (dma_mapping_error(dma_map_ops_dev, dma->rx_addr)) {
 		reason = "DMA mapping error for RX buffer";
 		ret = -EIO;
 		goto err_free_rx;
 	}
 
+	/* Pick dma_ops of DMA device if DMA device is attached */
+	if (dma && dma->tx_chan)
+		dma_map_ops_dev = dma->tx_chan->device->dev;
 	/* TX buffer */
-	dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
+	dma->tx_addr = dma_map_single(dma_map_ops_dev, p->port.state->xmit.buf,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
-	if (dma_mapping_error(p->port.dev, dma->tx_addr)) {
+	if (dma_mapping_error(dma_map_ops_dev, dma->tx_addr)) {
 		reason = "DMA mapping error for TX buffer";
 		ret = -EIO;
 		goto err_unmap_rx;
@@ -1060,7 +1091,9 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	return 0;
 
 err_unmap_rx:
-	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
+	if (dma->rx_chan)
+		dma_map_ops_dev = dma->rx_chan->device->dev;
+	dma_unmap_single(dma_map_ops_dev, dma->rx_addr, dma->rx_size,
 			 DMA_FROM_DEVICE);
 err_free_rx:
 	kfree(dma->rx_buf);
@@ -1077,10 +1110,12 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 {
 	struct s3c24xx_uart_dma	*dma = p->dma;
+	struct device *dma_map_ops_dev = p->port.dev;
 
 	if (dma->rx_chan) {
+		dma_map_ops_dev = dma->rx_chan->device->dev;
 		dmaengine_terminate_all(dma->rx_chan);
-		dma_unmap_single(p->port.dev, dma->rx_addr,
+		dma_unmap_single(dma_map_ops_dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 		kfree(dma->rx_buf);
 		dma_release_channel(dma->rx_chan);
@@ -1088,8 +1123,9 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 	}
 
 	if (dma->tx_chan) {
+		dma_map_ops_dev = dma->tx_chan->device->dev;
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_unmap_single(p->port.dev, dma->tx_addr,
+		dma_unmap_single(dma_map_ops_dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 		dma_release_channel(dma->tx_chan);
 		dma->tx_chan = NULL;
-- 
2.17.1

