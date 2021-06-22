Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC616C2B9F4
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 11:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F1061374
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 11:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhFVMBC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 08:01:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14810 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhFVMBB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 08:01:01 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210622115843epoutp019d73e5502a0809cbb677c05b3aeade1f~K5aesqEkb3206732067epoutp01Z
        for <linux-serial@vger.kernel.org>; Tue, 22 Jun 2021 11:58:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210622115843epoutp019d73e5502a0809cbb677c05b3aeade1f~K5aesqEkb3206732067epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624363123;
        bh=C/rQ7pJ5MD+9lMady1pthrrgQAWoaxubuwR/aPfNjBc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kym8CNWbgndfteyywrg4fJUxU/9xC6lGz4f3YOzLgMNe5nCCAiBydXTSUqqMRR6fW
         YZgLHIEKooBODoyeHVcZiY6daq1N9dQgD9Ap5kHuC1ofxtw/89BEcpsCj9iInMA1R3
         1q+kgNwgLq5UpPWucvNvrQlj2g0dguS1yktB+ESI=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210622115843epcas5p43976d045c4146d4f94bd14fb24d7b678~K5aeNKUB_1399213992epcas5p4E;
        Tue, 22 Jun 2021 11:58:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.41.09476.370D1D06; Tue, 22 Jun 2021 20:58:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210622091321epcas5p42e0a80b034f22ae9b82a3377193bb972~K3KFndPAZ2443024430epcas5p4F;
        Tue, 22 Jun 2021 09:13:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210622091321epsmtrp16c2fae4566e234052390c2ba60c26b6e~K3KFmuc4S0424004240epsmtrp1Z;
        Tue, 22 Jun 2021 09:13:21 +0000 (GMT)
X-AuditID: b6c32a49-6b7ff70000002504-da-60d1d0731464
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.D0.08289.1B9A1D06; Tue, 22 Jun 2021 18:13:21 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210622091319epsmtip1b9beaa3e24b9c63993dfa14a29de73a5~K3KEIcHMg1947919479epsmtip12;
        Tue, 22 Jun 2021 09:13:19 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v3] serial: samsung: use dma_ops of DMA if attached
Date:   Tue, 22 Jun 2021 14:47:10 +0530
Message-Id: <20210622091710.44032-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCmum7xhYsJBkufC1oceH+QxeLBvG1s
        Fs2L17NZvJsrY7Hx7Q8mi02Pr7FaXN41h81ixvl9TBZnFveyW9xtXczuwOUxq6GXzWPTqk42
        j/1z17B7bF5S79G3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZK1buYy84aldxoH8+ewPjOZMu
        Rk4OCQETiQdr/7J3MXJxCAnsZpR4cvM2I4TziVFi84LFzCBVQgKfGSU+PJXrYuQA65j42xSi
        ZhejxM5V15ghnBYmiZedyxhBitgENCWOn+cG6RURiJT4sGcTWA2zwFNGieXHrrOAJIQFnCUm
        rToHtoBFQFVixX4Im1fAQuLmj0Y2iPPkJVZvOADWLCFwih3o1oOsEAkXiX+9N1ggbGGJV8e3
        sEPYUhIv+9ug7HyJ+fNWMUPYFRIrL7yBsu0lDlyZwwJyKDPQoet36UOEZSWmnlrHBGIzC/BJ
        9P5+wgQR55XYMQ/GVpT4v7sfary4xLsVU6DO8ZCYtfQcCySwYiXmvfrIOoFRdhbChgWMjKsY
        JVMLinPTU4tNCwzzUsv1ihNzi0vz0vWS83M3MYJTg5bnDsa7Dz7oHWJk4mA8xCjBwawkwvsi
        +2KCEG9KYmVValF+fFFpTmrxIUZpDhYlcd6l7IcShATSE0tSs1NTC1KLYLJMHJxSDUw7KiOn
        cfLMiVk2P//HFyY/h/1bEhjO/TyqefRqzUSVXMvZ4v/u9SxpPaywmXleg7EEi+CtdXyz4n3W
        yTxa7Xjw//5qF5E3rSnrjy28HsuvvvW+umVr43QH+6tSVs/k7S/1XjpZ5mHWvmnGhEvzL5t5
        2rTm/1p00Xdu/g227iX/JzUbsuTXaazKrGJ3aD3Yb1+l9TcsO6nzE5cAg+TuNRXPtSI4HxzI
        YNW6+vDvcrekaMGWP1NU3j1/uermx9VeNcwMIW0pistPn361REbo86vqUzISwc81Pojk7TW+
        7byw5eQ6x7gESykG5to8OfmQY6lJWSsqNE+XqllnrXk5c/051lfJfyr6xE/mfFjGzaHEUpyR
        aKjFXFScCACz17VxfAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSnO7GlRcTDPbME7Y48P4gi8WDedvY
        LJoXr2ezeDdXxmLj2x9MFpseX2O1uLxrDpvFjPP7mCzOLO5lt7jbupjdgctjVkMvm8emVZ1s
        HvvnrmH32Lyk3qNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyVqzcx15w1K7iQP989gbGcyZd
        jBwcEgImEhN/m3YxcnEICexglDj3tIexi5ETKC4uMe3XfihbWGLlv+fsEEVNTBIPF3UzgTSz
        CWhKHD/PDVIjIhAtsXjzIUaQGmaB14wSWx5MAGsWFnCWmLTqHDOIzSKgKrFiP4TNK2AhcfNH
        IxvEAnmJ1RsOME9g5FnAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM40LS0djDu
        WfVB7xAjEwfjIUYJDmYlEd4X2RcThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliS
        mp2aWpBaBJNl4uCUamDa2p958GtimpiExWtvTd1QxsytPbP9XYSu2S5Q71h5ZXdJRNMVzjmr
        yoJcY4IyJlx/p/ksmXe7day0+lGbPa9/8l5uTBTh3TlJ1zvt3/YtjvuuBs2u23VIQm+j26Qi
        xTdKn69vqakyXczztOiKsuimOSwv3DetfvMupnvPN97adjanU/svrPv83aPyyon03E0P57It
        Wzt/ySURm6OJtgtU6uNnZjX6hk2UY9xR8HDOy1b3+2VODtx72I3mZFcKHs6X2d6qyud3Sc2n
        VdYjIGGK7lEDm2fzZOOYWd7kbL6neEjQNtp6xx8VFuXTEYEvch1CVgle9pkQwnQ257JtgBTf
        7agV3Sxckv9OKkgcZFViKc5INNRiLipOBADSPcm/owIAAA==
X-CMS-MailID: 20210622091321epcas5p42e0a80b034f22ae9b82a3377193bb972
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210622091321epcas5p42e0a80b034f22ae9b82a3377193bb972
References: <CGME20210622091321epcas5p42e0a80b034f22ae9b82a3377193bb972@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When DMA is used for TX and RX by serial driver, it should
pass the DMA device pointer to DMA API instead of UART device
pointer. DMA device should be used for DMA API because only
the DMA device is aware of how the device connects to the memory.
There might be an extra level of address translation due to a
SMMU attached to the DMA device. When serial device pointer device
is used for DMA API, the DMA API will have no clue of the SMMU
attached to the DMA device.

This patch is necessary to fix the SMMU page faults
which is observed when a DMA(with SMMU enabled) is attached
to UART for transfer.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
Changes since v1:
1. Rebased the patch on "tty-next" branch of TTY driver tree

Changes since v2:
1. Updated the commit message.
2. Changed the comment description

 drivers/tty/serial/samsung_tty.c | 62 +++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9fbc61151c2e..7dd648cb7237 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -284,8 +284,13 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_tx_state state;
+	struct device *dma_map_ops_dev = ourport->port.dev;
 	int count;
 
+	/* Null pointer check for "dma" and "dma->tx_chan" */
+	if (dma && dma->tx_chan)
+		dma_map_ops_dev = dma->tx_chan->device->dev;
+
 	if (!ourport->tx_enabled)
 		return;
 
@@ -305,7 +310,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 		dmaengine_pause(dma->tx_chan);
 		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_sync_single_for_cpu(ourport->port.dev,
+		dma_sync_single_for_cpu(dma_map_ops_dev,
 			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
 		async_tx_ack(dma->tx_desc);
 		count = dma->tx_bytes_requested - state.residue;
@@ -331,14 +336,19 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 	struct circ_buf *xmit = &port->state->xmit;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 	struct dma_tx_state state;
+	struct device *dma_map_ops_dev = ourport->port.dev;
 	unsigned long flags;
 	int count;
 
+	/* Null pointer check for "dma" and "dma->tx_chan" */
+	if (dma && dma->tx_chan)
+		dma_map_ops_dev = dma->tx_chan->device->dev;
+
 	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
 	count = dma->tx_bytes_requested - state.residue;
 	async_tx_ack(dma->tx_desc);
 
-	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
+	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
 				dma->tx_size, DMA_TO_DEVICE);
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -436,6 +446,11 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	struct uart_port *port = &ourport->port;
 	struct circ_buf *xmit = &port->state->xmit;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
+	struct device *dma_map_ops_dev = ourport->port.dev;
+
+	/* Null pointer check for "dma" and "dma->tx_chan" */
+	if (dma && dma->tx_chan)
+		dma_map_ops_dev = dma->tx_chan->device->dev;
 
 	if (ourport->tx_mode != S3C24XX_TX_DMA)
 		enable_tx_dma(ourport);
@@ -443,7 +458,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
 	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
 
-	dma_sync_single_for_device(ourport->port.dev, dma->tx_transfer_addr,
+	dma_sync_single_for_device(dma_map_ops_dev, dma->tx_transfer_addr,
 				dma->tx_size, DMA_TO_DEVICE);
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
@@ -510,12 +525,17 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
 		struct tty_port *tty, int count)
 {
 	struct s3c24xx_uart_dma *dma = ourport->dma;
+	struct device *dma_map_ops_dev = ourport->port.dev;
 	int copied;
 
+	/* Null pointer check for "dma" and "dma->rx_chan" */
+	if (dma && dma->rx_chan)
+		dma_map_ops_dev = dma->rx_chan->device->dev;
+
 	if (!count)
 		return;
 
-	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
+	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	ourport->port.icount.rx += count;
@@ -635,8 +655,13 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct s3c24xx_uart_dma *dma = ourport->dma;
+	struct device *dma_map_ops_dev = ourport->port.dev;
+
+	/* Null pointer check for "dma" and "dma->rx_chan" */
+	if (dma && dma->rx_chan)
+		dma_map_ops_dev = dma->rx_chan->device->dev;
 
-	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
+	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
@@ -1045,6 +1070,7 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	struct s3c24xx_uart_dma	*dma = p->dma;
 	struct dma_slave_caps dma_caps;
 	const char *reason = NULL;
+	struct device *dma_map_ops_dev = p->port.dev;
 	int ret;
 
 	/* Default slave configuration parameters */
@@ -1102,18 +1128,25 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 		goto err_release_tx;
 	}
 
-	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
+	/* Null pointer check for "dma" and "dma->rx_chan" */
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
 
+	/* Null pointer check for "dma" and "dma->tx_chan" */
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
@@ -1122,7 +1155,9 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	return 0;
 
 err_unmap_rx:
-	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
+	if (dma->rx_chan)
+		dma_map_ops_dev = dma->rx_chan->device->dev;
+	dma_unmap_single(dma_map_ops_dev, dma->rx_addr, dma->rx_size,
 			 DMA_FROM_DEVICE);
 err_free_rx:
 	kfree(dma->rx_buf);
@@ -1139,10 +1174,12 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
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
@@ -1150,8 +1187,9 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
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

