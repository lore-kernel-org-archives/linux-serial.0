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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E63C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 04:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0914B61164
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 04:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFVEbj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 00:31:39 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:33529 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhFVEbj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 00:31:39 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210622042921epoutp04e9240464564ae801a16d20552eccaf22~KzSIH8VZv1284612846epoutp04B
        for <linux-serial@vger.kernel.org>; Tue, 22 Jun 2021 04:29:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210622042921epoutp04e9240464564ae801a16d20552eccaf22~KzSIH8VZv1284612846epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624336161;
        bh=lWP1/+eZrzHstaQ/AT2T62KyWbs10mew8C3n6w1XkKQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pOImwlXK01mcmol+Jp7P4At19edoAp9b+iQl0TPjcJEWYuPozaPxjv+DeI7Hv4O/q
         rvy6uoJLU/zYtFi8EOskoMQag1woE8WmIoGbcoW+hxLHlVvSPmWlJQLfGZ6O6WKqpF
         YEsI5NmJXot9XmnCn5eCdMIDRHshSbPBpGoiJx0U=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210622042920epcas5p3549a22d1113cb11c056d932bccfd6c81~KzSG-W-u52459124591epcas5p3V;
        Tue, 22 Jun 2021 04:29:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.27.09476.02761D06; Tue, 22 Jun 2021 13:29:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb~KyuSRssVG0855908559epcas5p3V;
        Tue, 22 Jun 2021 03:48:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210622034818epsmtrp2784f980b414b4af3c46eaa8a010aa249~KyuSQtrLo0947109471epsmtrp2c;
        Tue, 22 Jun 2021 03:48:18 +0000 (GMT)
X-AuditID: b6c32a49-6a1ff70000002504-9c-60d16720e8a1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.00.08394.28D51D06; Tue, 22 Jun 2021 12:48:18 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210622034817epsmtip29945746b26433cfe79d09a63aa96e61f~KyuQwr_V30534405344epsmtip2Z;
        Tue, 22 Jun 2021 03:48:16 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v2] serial: samsung: use dma_ops of DMA if attached
Date:   Tue, 22 Jun 2021 09:22:02 +0530
Message-Id: <20210622035202.5260-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCmlq5C+sUEg8N3xCwOvD/IYvFg3jY2
        i+bF69ks3s2Vsdj49geTxabH11gtLu+aw2Yx4/w+Joszi3vZLe62LmZ34PKY1dDL5rFpVSeb
        x/65a9g9Ni+p9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MdXM+MRY8s6r4N+U0cwPjUcMu
        Rk4OCQETifkTG1m7GLk4hAR2M0pc/3uRBcL5xCjx+PNtRgjnG6PE52k3mWFabh05BNWyl1Fi
        +uYjUE4Lk8S79gNALRwcbAKaEsfPc4M0iAhESnzYs4kZpIZZ4CmjxPJj11lAEsICzhLzP61n
        BqlnEVCVWPDLHyTMK2AuMWFVPxvEMnmJ1RsOgPVKCJxil2i68BzqCheJOxuvQhUJS7w6voUd
        wpaS+PxuL1Q8X2L+vFVQ9RUSKy+8gbLtJQ5cmcMCspcZ6M71u/QhwrISU0+tYwKxmQX4JHp/
        P2GCiPNK7JgHYytK/N/dD7VKXOLdiimsELaHxIYX19lBRgoJxEocORc5gVF2FsKCBYyMqxgl
        UwuKc9NTi00LDPNSy/WKE3OLS/PS9ZLzczcxglODlucOxrsPPugdYmTiYDzEKMHBrCTCezPl
        QoIQb0piZVVqUX58UWlOavEhRmkOFiVx3qXshxKEBNITS1KzU1MLUotgskwcnFINTOFWCk6T
        FavLw6Wdr2rtypzJ4SjN5V/lfjT0hOSx/5POb+KbHu/v6tMSkZg5e+lKq4OC9+4ILzefe5eJ
        x+XyjjUyBy53RmpturaxerfmngSPtZML7r/n6SuuXzthtzKzKsOcZ9fvFO8Wu240c8FX0wYf
        pmTvCYtXJmv1KflbnmEOfjxh4UsrzudnF/Bsu5QWs5R9k2K62pPv2VxnLyxQL7BYeSc7TDK8
        /4Ach1GOxL7G1e4TH0U/5Vm444GvXrqbrrDUBumgH6JziuT5RdcsF7UKT2ky0SiwaeW7tOfY
        9sSzRsosHOc7xQ8bpSaaz27zffFGQefivflbYt1Uzgg0vTxWYv9ZuKRKOe/jRd6TSizFGYmG
        WsxFxYkAE0U0HnwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSvG5T7MUEg6m75S0OvD/IYvFg3jY2
        i+bF69ks3s2Vsdj49geTxabH11gtLu+aw2Yx4/w+Joszi3vZLe62LmZ34PKY1dDL5rFpVSeb
        x/65a9g9Ni+p9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MdXM+MRY8s6r4N+U0cwPjUcMu
        Rk4OCQETiVtHDrF2MXJxCAnsZpR4M38LE0RCXGLar/2MELawxMp/z9khipqYJC71HAIq4uBg
        E9CUOH6eG6RGRCBaYvHmQ4wgNcwCrxkltjyYANYsLOAsMf/TemaQehYBVYkFv/xBwrwC5hIT
        VvWzQcyXl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxggNNS3MH
        4/ZVH/QOMTJxMB5ilOBgVhLhvZlyIUGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJ
        JanZqakFqUUwWSYOTqkGpriyxh9vra/K3W5ZzXlWvf2IoxDrnhmPD1mo7LeZ+eLzyXB5X3/b
        TyEVDnuEvpk8Wnwi4vPWOftO3dwf9HW2Pqvq3u3OG/L4p3M835M9y8txfvy1f9mJJ/Lqwler
        JKUfrTO2r3r9TDuqdc4Mz+u7Fyw0f6Ln4W/O/dhnrh9bNmeczWsrFraFwYf0TW5n/vvr8W7d
        xYyJTnsEGbrsv96oa00v9l3XfZ7f/ZRXW1hNwVbfN+I/o5LafjczpebnR+VrZd1uvLH654o8
        0cQu+bOCwhJLzKx0fA8zXbXfNu3hY5WM/QphrsYLpG9Fra/P3KYVV8Sw7JHaS6/P2jk5ZqXV
        Aa+Ejs/9fS5JQzxhQZqvEktxRqKhFnNRcSIAkh6F7KMCAAA=
X-CMS-MailID: 20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb
References: <CGME20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb@epcas5p3.samsung.com>
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
 drivers/tty/serial/samsung_tty.c | 62 +++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9fbc61151c2e..0c924bb6108e 100644
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
 
+	/* Pick dma_ops of DMA device if DMA device is attached */
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
+	/* Pick dma_ops of DMA device if DMA device is attached */
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
@@ -635,8 +655,13 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct s3c24xx_uart_dma *dma = ourport->dma;
+	struct device *dma_map_ops_dev = ourport->port.dev;
+
+	/* Pick dma_ops of DMA device if DMA device is attached */
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

