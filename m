Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138BC49EAB
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 07:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FA16192F
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 07:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFZHnA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Jun 2021 03:43:00 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13947 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFZHnA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Jun 2021 03:43:00 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210626074036epoutp025387d70f7702153694645ae799fe3907~MEePzXBxq0620506205epoutp021
        for <linux-serial@vger.kernel.org>; Sat, 26 Jun 2021 07:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210626074036epoutp025387d70f7702153694645ae799fe3907~MEePzXBxq0620506205epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624693236;
        bh=jIg6eJtvJlgSAM+goRQ+BvC94W/eYVLTOQvzAAe3+qE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oCfW4VG9z9Orw6+rMOasGPBAjwXgX9MnQ+Jiy/Ki1MWtPCEIq8aOu08K0FHJZvoYw
         1jYp3k0BxdIiO8PXKI9bXXKb/s5zZUq5yrwK2nilzHI898VI2Bfqd56t0zQki6sfGy
         G/cUA7WdQBsrKfTfNOrLnoycK5Byrq2t6lbT18kU=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210626074035epcas5p3d8e7a876b0e330c71ffc7c825bad166a~MEeO4FPtQ1928719287epcas5p3e;
        Sat, 26 Jun 2021 07:40:35 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.64.09595.3F9D6D06; Sat, 26 Jun 2021 16:40:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210625074751epcas5p125067e47c4ff1ad24a1e595d85f82540~Lw7TR68LK2260722607epcas5p1L;
        Fri, 25 Jun 2021 07:47:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210625074751epsmtrp1b157cf5a1bb68353956c90017770b653~Lw7TRLkP80139401394epsmtrp1U;
        Fri, 25 Jun 2021 07:47:51 +0000 (GMT)
X-AuditID: b6c32a4a-eebff7000000257b-33-60d6d9f3691f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.A7.08289.72A85D06; Fri, 25 Jun 2021 16:47:51 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210625074750epsmtip17448187f2900bbe9d1f5be274f951074~Lw7Rl7QYm1896718967epsmtip15;
        Fri, 25 Jun 2021 07:47:50 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, robin.murphy@arm.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v4] serial: samsung: use dma_ops of DMA if attached
Date:   Fri, 25 Jun 2021 13:21:14 +0530
Message-Id: <20210625075114.71155-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7bCmlu7nm9cSDFau5bc48P4gi8WDedvY
        LJoXr2ezeDdXxmLj2x9MFpseX2O1uLxrDpvFjPP7mCzOLO5lt7jbupjd4uCHJ6wO3B5r5q1h
        9JjV0MvmsWlVJ5vH/rlr2D02L6n36NuyitHj8ya5APYoLpuU1JzMstQifbsErowHb2+yFXzU
        rji+soWxgXGVahcjJ4eEgInE6q4eti5GLg4hgd2MEm8bNrBCOJ8YJa7v/QmV+cwocWJaAyNM
        y6/ZbcwQiV2MEn9v/2WHcFqYJNbM/wqU4eBgE9CUOH6eG6RBRCBS4sOeTWANzAK/gXa0nmUB
        SQgLOEvsvj4LzGYRUJW4+GMjmM0rYCHx9MpxqG3yEqs3HABrlhC4xi6xaP00qISLxL3tX1kh
        bGGJV8e3sEPYUhIv+9ug7HyJ+fNWMUPYFRIrL7yBsu0lDlyZwwJyKDPQoet36UOEZSWmnlrH
        BGIzC/BJ9P5+wgQR55XYMQ/GVpT4v7sfary4xLsVU6BO8JBYfW0a2P1CArESK3evZ5zAKDsL
        YcMCRsZVjJKpBcW56anFpgVGeanlesWJucWleel6yfm5mxjBKUPLawfjwwcf9A4xMnEwHmKU
        4GBWEuEVq7qWIMSbklhZlVqUH19UmpNafIhRmoNFSZx3KfuhBCGB9MSS1OzU1ILUIpgsEwen
        VANT+vYTrltmrL4/+8bzyYlPTYVNL0+ZXdPi0S58XPtzmu9Jtm3ct7r2LpXg/KSqdUL3hua+
        qgWfnQ3PhX04VbEg8cMZrSY1nosy/cduBRz9pFY2Ta923loVnU9iodIXEtnDeuTVjj7V6xcz
        8FcJU/u9j3HuYeWpxfXOjibX1+8OXKo5X899Ks+kCYFfBW8WqtaoNL5ZsOTczw8qAmcOBfQb
        ON7WCq0XXOzbVV4gN8ssgE1tq9At9rNHbba2+jbN6D6+r6COueba7Y9T6rcbe6wVvJqmX9C/
        zYltXrR64Cd3zSr7dueIhqvzmBvy89jYbT+kRy+Mn6vHcm755gxW3fRtL//cDFRt3Fsdd//u
        pBQlluKMREMt5qLiRAAmoiH1iAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSnK5619UEg8PXTS0OvD/IYvFg3jY2
        i+bF69ks3s2Vsdj49geTxabH11gtLu+aw2Yx4/w+Joszi3vZLe62Lma3OPjhCasDt8eaeWsY
        PWY19LJ5bFrVyeaxf+4ado/NS+o9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+PB25tsBR+1
        K46vbGFsYFyl2sXIySEhYCLxa3YbcxcjF4eQwA5GiXkts5ggEuIS037tZ4SwhSVW/nvODlHU
        xCTx6vpCoA4ODjYBTYnj57lBakQEoiUWbz7ECFLDLNDMJDHrbDdYs7CAs8Tu67NYQGwWAVWJ
        iz82gtm8AhYST68ch1ogL7F6wwHmCYw8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
        525iBIefltYOxj2rPugdYmTiYDzEKMHBrCTC+6jlUoIQb0piZVVqUX58UWlOavEhRmkOFiVx
        3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTAnfZk/+vT+hPqdqs4Wll7VMSquDsvwGy7OBVTsy
        2fVPRNRIL7hXGarN2M07/9c8Y/nnfy6e3/+9pu70+zjDedfkw6rtMsPn6hTvEPzp9bF+RnTt
        oSb90sUP31yP/2VmuTDxeKD3beHLHe1Plq7QsZNOlhKeOuMNF4NCkDVXsanvU4eEY3dNhVbm
        s71rvnv/85zcU2VaB5luavQExzVIxRXZvN5jsTS6cXnovZCl1+ROalhpPrH6sfROvoaOyzqD
        p2EcV91NRUqsM68fUuPW8nY0ExAp4vxUuOnF1Y6kxsT+T2wvvgT/VZpw7Or/pwt+v0mZr31X
        JeneiwXiH4oV/zLesdu09NCbAkGZ4veiSizFGYmGWsxFxYkAeBPnj64CAAA=
X-CMS-MailID: 20210625074751epcas5p125067e47c4ff1ad24a1e595d85f82540
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210625074751epcas5p125067e47c4ff1ad24a1e595d85f82540
References: <CGME20210625074751epcas5p125067e47c4ff1ad24a1e595d85f82540@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When DMA is used for TX and RX by serial driver, it should
pass the DMA device pointer to DMA API instead of UART device
pointer. DMA device should be used for DMA API because only
the DMA device is aware of how the device connects to the memory.
There might be an extra level of address translation due to a
SMMU attached to the DMA device. When serial device is used for
DMA API, the DMA API will have no clue of the SMMU attached to
the DMA device.

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

Changes since v3:
1. Removed the null pointer check for "dma", "dma->tx_chan" and
"dma->rx_chan" and instead sending DMA device pointer while calling
DMA API.

 drivers/tty/serial/samsung_tty.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9fbc61151c2e..fa30aa20a13f 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -305,7 +305,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 		dmaengine_pause(dma->tx_chan);
 		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_sync_single_for_cpu(ourport->port.dev,
+		dma_sync_single_for_cpu(dma->tx_chan->device->dev,
 			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
 		async_tx_ack(dma->tx_desc);
 		count = dma->tx_bytes_requested - state.residue;
@@ -338,8 +338,8 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 	count = dma->tx_bytes_requested - state.residue;
 	async_tx_ack(dma->tx_desc);
 
-	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
-				dma->tx_size, DMA_TO_DEVICE);
+	dma_sync_single_for_cpu(dma->tx_chan->device->dev,
+			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -443,8 +443,8 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
 	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
 
-	dma_sync_single_for_device(ourport->port.dev, dma->tx_transfer_addr,
-				dma->tx_size, DMA_TO_DEVICE);
+	dma_sync_single_for_device(dma->tx_chan->device->dev,
+			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
 				dma->tx_transfer_addr, dma->tx_size,
@@ -515,7 +515,7 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
 	if (!count)
 		return;
 
-	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
+	dma_sync_single_for_cpu(dma->rx_chan->device->dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	ourport->port.icount.rx += count;
@@ -636,7 +636,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 
-	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
+	dma_sync_single_for_device(dma->rx_chan->device->dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
@@ -1102,18 +1102,18 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 		goto err_release_tx;
 	}
 
-	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
+	dma->rx_addr = dma_map_single(dma->rx_chan->device->dev, dma->rx_buf,
 				dma->rx_size, DMA_FROM_DEVICE);
-	if (dma_mapping_error(p->port.dev, dma->rx_addr)) {
+	if (dma_mapping_error(dma->rx_chan->device->dev, dma->rx_addr)) {
 		reason = "DMA mapping error for RX buffer";
 		ret = -EIO;
 		goto err_free_rx;
 	}
 
 	/* TX buffer */
-	dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
-				UART_XMIT_SIZE, DMA_TO_DEVICE);
-	if (dma_mapping_error(p->port.dev, dma->tx_addr)) {
+	dma->tx_addr = dma_map_single(dma->tx_chan->device->dev,
+			p->port.state->xmit.buf, UART_XMIT_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma->tx_chan->device->dev, dma->tx_addr)) {
 		reason = "DMA mapping error for TX buffer";
 		ret = -EIO;
 		goto err_unmap_rx;
@@ -1122,8 +1122,8 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	return 0;
 
 err_unmap_rx:
-	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
-			 DMA_FROM_DEVICE);
+	dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
+			dma->rx_size, DMA_FROM_DEVICE);
 err_free_rx:
 	kfree(dma->rx_buf);
 err_release_tx:
@@ -1142,7 +1142,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->rx_chan) {
 		dmaengine_terminate_all(dma->rx_chan);
-		dma_unmap_single(p->port.dev, dma->rx_addr,
+		dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 		kfree(dma->rx_buf);
 		dma_release_channel(dma->rx_chan);
@@ -1151,7 +1151,7 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->tx_chan) {
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_unmap_single(p->port.dev, dma->tx_addr,
+		dma_unmap_single(dma->tx_chan->device->dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 		dma_release_channel(dma->tx_chan);
 		dma->tx_chan = NULL;
-- 
2.17.1

