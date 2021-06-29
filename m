Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2EEC11F68
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 04:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6DA61DB4
	for <linux-serial@archiver.kernel.org>; Tue, 29 Jun 2021 04:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhF2FCG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Jun 2021 01:02:06 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34416 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhF2FCG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Jun 2021 01:02:06 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210629045937epoutp013449c326551d5634cc41e96b3e172096~M9NjVlKH01588915889epoutp01Y
        for <linux-serial@vger.kernel.org>; Tue, 29 Jun 2021 04:59:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210629045937epoutp013449c326551d5634cc41e96b3e172096~M9NjVlKH01588915889epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624942777;
        bh=UX43tcH2z+3n+dP0BpvC3+c3dnAFQKA3bu75v05l9u0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=enTTBJxllFAswiUOZYAoImfnpcpEJb8mTsO8Ew+0cUBF/mZe0n7QzR79RscwfiqQo
         i31yn4qXa1mr3fvBpSCIgQiV95pxe12D9LBAQl0aTDc9TKlbF3iRlEAD4D7ebb2QhV
         ypiaGfytHgIHadvgYmtqetyq/RLzY7wGYkjLeErA=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210629045936epcas5p37b188f16e8888b772ff59585619a1de4~M9Ninuli91692516925epcas5p3E;
        Tue, 29 Jun 2021 04:59:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.BE.09476.8B8AAD06; Tue, 29 Jun 2021 13:59:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210629045610epcas5p4fa9d2a217b351a950899073d6b7d3dfd~M9Kh59m5f2705527055epcas5p4W;
        Tue, 29 Jun 2021 04:56:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210629045609epsmtrp2e52909c09997cbec79137debd5ba2b80~M9Kh5HWrq2463924639epsmtrp26;
        Tue, 29 Jun 2021 04:56:09 +0000 (GMT)
X-AuditID: b6c32a49-6b7ff70000002504-9d-60daa8b8ac13
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.6D.08289.9E7AAD06; Tue, 29 Jun 2021 13:56:09 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210629045608epsmtip29684896a250cbe31b5205e20741962d2~M9KgK5JYs0530005300epsmtip2D;
        Tue, 29 Jun 2021 04:56:08 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, robin.murphy@arm.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v5] serial: samsung: use dma_ops of DMA if attached
Date:   Tue, 29 Jun 2021 10:29:02 +0530
Message-Id: <20210629045902.48912-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7bCmpu6OFbcSDN4vM7U48P4gi8WDedvY
        LJoXr2ezeDdXxmLj2x9MFpseX2O1uLxrDpvFjPP7mCzOLO5lt7jbupjd4uCHJ6wO3B5r5q1h
        9JjV0MvmsWlVJ5vH/rlr2D02L6n36NuyitHj8ya5APYoLpuU1JzMstQifbsEroyWbR9YC07q
        V3S2bGJqYPyn3sXIySEhYCKxc/oBti5GLg4hgd2MEg+v9TNCOJ8YJW42bYNyPjNKLNv5hBGm
        5eu2XSwQiV1AiTOTmCGcFiaJ9a8eMXUxcnCwCWhKHD/PDdIgIhAp8WHPJrAaZoHfjBJvW8+y
        gCSEBZwlnn47yQZiswioSjxb/IcJxOYVsJC4ffsyK8Q2eYnVGw6ANUsI3GKXaNt3iBFkgYSA
        i8Sz2TUQNcISr45vYYewpSQ+v9vLBmHnS8yft4oZwq6QWHnhDZRtL3HgyhwWkDHMQHeu36UP
        EZaVmHpqHdgJzAJ8Er2/nzBBxHkldsyDsRUl/u/uh1olLvFuxRSoMz0kHvS/AosLCcRKzN10
        k20Co+wshA0LGBlXMUqmFhTnpqcWmxYY5qWW6xUn5haX5qXrJefnbmIEJwwtzx2Mdx980DvE
        yMTBeIhRgoNZSYT3bd6tBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8S9kPJQgJpCeWpGanphak
        FsFkmTg4pRqYtD5wZ71bcOKrY8N5y4Juf/Yl37seCDdO6e3acYuPfwGj5Fa2WgOdRSdDAjY4
        /9Xuj/66Qu29/4HgWeUrL8z8ych5zKpqTudHjlcPDJ9Xyiy0KuHzzF9osrGOnXHFx8bQOzIt
        ueeS3ksfnJU3S+W2dd3GVzOq5D+suXnvLJObbsrcTzOlYti+zsvnWlN635xtdeDPPXKHT+5P
        31xtrNS7avFqS3uNdk/OaM3K7VoBdzQOCG34uCOnY0611be/ZcYiiQUfFtaUKEkWCOatcxa8
        8Xb13ruzytzv2dzLZ9p2JDYi5OiH91yMgumyFU3Lj/57vWT7J85XHNuzkqZuTFQ0mVK3Qm+y
        V+qhtUtWKu1MVmIpzkg01GIuKk4EAIxuJWqHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSvO7L5bcSDH5/NLM48P4gi8WDedvY
        LJoXr2ezeDdXxmLj2x9MFpseX2O1uLxrDpvFjPP7mCzOLO5lt7jbupjd4uCHJ6wO3B5r5q1h
        9JjV0MvmsWlVJ5vH/rlr2D02L6n36NuyitHj8ya5APYoLpuU1JzMstQifbsEroyWbR9YC07q
        V3S2bGJqYPyn3sXIySEhYCLxddsuli5GLg4hgR2MEucufWSDSIhLTPu1nxHCFpZY+e85O0RR
        E5PE35Y1TF2MHBxsApoSx89zg9SICERLLN58iBGkhlmgmUli1tlusGZhAWeJp99Ogg1lEVCV
        eLb4DxOIzStgIXH79mVWiAXyEqs3HGCewMizgJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66
        XnJ+7iZGcPhpae1g3LPqg94hRiYOxkOMEhzMSiK8b/NuJQjxpiRWVqUW5ccXleakFh9ilOZg
        URLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXApDbFyyBKuXaZ7cPKbzZrTzySqzyflMDtdepE
        bNqHjEwTSeF1fieCViyfen5B7P1T9qyySe8uzrQrfdcR6yPL9klh7tGP339qrVz8nDMvPGPp
        pIq/XXYSmttZWwL/bnzz0Fux6cDcV2WbYncus5gTz7Bc6NyvFQ9rZm9syFq8okGmbeYlvdAL
        S9v4eeMMer9/0rh50SPvtHjssom5C720vG73BrldvHrl3/qjvRe2mUyTevDgYnI/11/bS2l7
        edqYK9P29y/RaZg5UXw/C+u8pkjzx9bGl/Zzh16ZdqVOoViounrGg5d3FzaUTl+gvHn/ST2X
        Vvb8itjyY5nPBA1e/GBPfdT2YnNwfsCjxQdds5VYijMSDbWYi4oTAWWgBCGuAgAA
X-CMS-MailID: 20210629045610epcas5p4fa9d2a217b351a950899073d6b7d3dfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210629045610epcas5p4fa9d2a217b351a950899073d6b7d3dfd
References: <CGME20210629045610epcas5p4fa9d2a217b351a950899073d6b7d3dfd@epcas5p4.samsung.com>
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

Changes since v4:
1. Fixed the alignments of arguments.

 drivers/tty/serial/samsung_tty.c | 46 +++++++++++++++++---------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9fbc61151c2e..0cf4dfe77c32 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -305,8 +305,9 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 		dmaengine_pause(dma->tx_chan);
 		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_sync_single_for_cpu(ourport->port.dev,
-			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
+		dma_sync_single_for_cpu(dma->tx_chan->device->dev,
+					dma->tx_transfer_addr, dma->tx_size,
+					DMA_TO_DEVICE);
 		async_tx_ack(dma->tx_desc);
 		count = dma->tx_bytes_requested - state.residue;
 		xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
@@ -338,8 +339,9 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 	count = dma->tx_bytes_requested - state.residue;
 	async_tx_ack(dma->tx_desc);
 
-	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
-				dma->tx_size, DMA_TO_DEVICE);
+	dma_sync_single_for_cpu(dma->tx_chan->device->dev,
+				dma->tx_transfer_addr, dma->tx_size,
+				DMA_TO_DEVICE);
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -443,8 +445,9 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
 	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
 
-	dma_sync_single_for_device(ourport->port.dev, dma->tx_transfer_addr,
-				dma->tx_size, DMA_TO_DEVICE);
+	dma_sync_single_for_device(dma->tx_chan->device->dev,
+				   dma->tx_transfer_addr, dma->tx_size,
+				   DMA_TO_DEVICE);
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
 				dma->tx_transfer_addr, dma->tx_size,
@@ -515,7 +518,7 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
 	if (!count)
 		return;
 
-	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
+	dma_sync_single_for_cpu(dma->rx_chan->device->dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
 	ourport->port.icount.rx += count;
@@ -636,8 +639,8 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 
-	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
-				dma->rx_size, DMA_FROM_DEVICE);
+	dma_sync_single_for_device(dma->rx_chan->device->dev, dma->rx_addr,
+				   dma->rx_size, DMA_FROM_DEVICE);
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
 				dma->rx_addr, dma->rx_size, DMA_DEV_TO_MEM,
@@ -1102,18 +1105,19 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 		goto err_release_tx;
 	}
 
-	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
-				dma->rx_size, DMA_FROM_DEVICE);
-	if (dma_mapping_error(p->port.dev, dma->rx_addr)) {
+	dma->rx_addr = dma_map_single(dma->rx_chan->device->dev, dma->rx_buf,
+				      dma->rx_size, DMA_FROM_DEVICE);
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
+				      p->port.state->xmit.buf, UART_XMIT_SIZE,
+				      DMA_TO_DEVICE);
+	if (dma_mapping_error(dma->tx_chan->device->dev, dma->tx_addr)) {
 		reason = "DMA mapping error for TX buffer";
 		ret = -EIO;
 		goto err_unmap_rx;
@@ -1122,8 +1126,8 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 	return 0;
 
 err_unmap_rx:
-	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
-			 DMA_FROM_DEVICE);
+	dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
+			 dma->rx_size, DMA_FROM_DEVICE);
 err_free_rx:
 	kfree(dma->rx_buf);
 err_release_tx:
@@ -1142,8 +1146,8 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->rx_chan) {
 		dmaengine_terminate_all(dma->rx_chan);
-		dma_unmap_single(p->port.dev, dma->rx_addr,
-				dma->rx_size, DMA_FROM_DEVICE);
+		dma_unmap_single(dma->rx_chan->device->dev, dma->rx_addr,
+				 dma->rx_size, DMA_FROM_DEVICE);
 		kfree(dma->rx_buf);
 		dma_release_channel(dma->rx_chan);
 		dma->rx_chan = NULL;
@@ -1151,8 +1155,8 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 
 	if (dma->tx_chan) {
 		dmaengine_terminate_all(dma->tx_chan);
-		dma_unmap_single(p->port.dev, dma->tx_addr,
-				UART_XMIT_SIZE, DMA_TO_DEVICE);
+		dma_unmap_single(dma->tx_chan->device->dev, dma->tx_addr,
+				 UART_XMIT_SIZE, DMA_TO_DEVICE);
 		dma_release_channel(dma->tx_chan);
 		dma->tx_chan = NULL;
 	}
-- 
2.17.1

