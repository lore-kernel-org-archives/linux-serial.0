Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A422C43460
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 17:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2CF61458
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhD3Rvi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Apr 2021 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhD3Rvh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Apr 2021 13:51:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BAFC06138B;
        Fri, 30 Apr 2021 10:50:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 21C1E1F43C65
Received: by jupiter.universe (Postfix, from userid 1000)
        id F35124800C3; Fri, 30 Apr 2021 19:50:44 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Ian Ray <ian.ray@ge.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, kernel@collabora.com
Subject: [PATCHv5 1/2] serial: imx: Add DMA buffer configuration via DT
Date:   Fri, 30 Apr 2021 19:50:37 +0200
Message-Id: <20210430175038.103226-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430175038.103226-1-sebastian.reichel@collabora.com>
References: <20210430175038.103226-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fabien Lahoudere <fabien.lahoudere@collabora.com>

In order to optimize serial communication (performance/throughput VS
latency), we may need to tweak DMA period number and size. This adds
DT properties to configure those values before initialising DMA.
The defaults will stay the same as before.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
[update documentation and commit message, rebase to current master,
switch back to DT instead of sysfs]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/serial/fsl-imx-uart.yaml         | 12 +++++++++
 drivers/tty/serial/imx.c                      | 25 +++++++++++++------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 2b06c6ce4a75..9d949296a142 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -71,6 +71,18 @@ properties:
       received, and that the peripheral should invert its input using the
       INVR registers.
 
+  fsl,dma-info:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    description: |
+      First cell contains the size of DMA buffer chunks, second cell contains
+      the amount of chunks used for the device. Multiplying both numbers is
+      the total size of memory used for receiving data.
+      When not being configured the system will use default settings, which
+      are sensible for most use cases. If you need low latency processing on
+      slow connections this needs to be configured appropriately.
+
   uart-has-rtscts: true
 
   rs485-rts-delay: true
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7d5a8dfa3e91..9e72e382a867 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -225,6 +225,8 @@ struct imx_port {
 	struct scatterlist	rx_sgl, tx_sgl[2];
 	void			*rx_buf;
 	struct circ_buf		rx_ring;
+	unsigned int		rx_buf_size;
+	unsigned int		rx_period_length;
 	unsigned int		rx_periods;
 	dma_cookie_t		rx_cookie;
 	unsigned int		tx_bytes;
@@ -1183,10 +1185,6 @@ static void imx_uart_dma_rx_callback(void *data)
 	}
 }
 
-/* RX DMA buffer periods */
-#define RX_DMA_PERIODS	16
-#define RX_BUF_SIZE	(RX_DMA_PERIODS * PAGE_SIZE / 4)
-
 static int imx_uart_start_rx_dma(struct imx_port *sport)
 {
 	struct scatterlist *sgl = &sport->rx_sgl;
@@ -1197,9 +1195,8 @@ static int imx_uart_start_rx_dma(struct imx_port *sport)
 
 	sport->rx_ring.head = 0;
 	sport->rx_ring.tail = 0;
-	sport->rx_periods = RX_DMA_PERIODS;
 
-	sg_init_one(sgl, sport->rx_buf, RX_BUF_SIZE);
+	sg_init_one(sgl, sport->rx_buf, sport->rx_buf_size);
 	ret = dma_map_sg(dev, sgl, 1, DMA_FROM_DEVICE);
 	if (ret == 0) {
 		dev_err(dev, "DMA mapping error for RX.\n");
@@ -1316,7 +1313,8 @@ static int imx_uart_dma_init(struct imx_port *sport)
 		goto err;
 	}
 
-	sport->rx_buf = kzalloc(RX_BUF_SIZE, GFP_KERNEL);
+	sport->rx_buf_size = sport->rx_period_length * sport->rx_periods;
+	sport->rx_buf = kzalloc(sport->rx_buf_size, GFP_KERNEL);
 	if (!sport->rx_buf) {
 		ret = -ENOMEM;
 		goto err;
@@ -2179,11 +2177,16 @@ static enum hrtimer_restart imx_trigger_stop_tx(struct hrtimer *t)
 	return HRTIMER_NORESTART;
 }
 
+/* Default RX DMA buffer configuration */
+#define RX_DMA_PERIODS		16
+#define RX_DMA_PERIOD_LEN	(PAGE_SIZE / 4)
+
 static int imx_uart_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct imx_port *sport;
 	void __iomem *base;
+	u32 dma_buf_conf[2];
 	int ret = 0;
 	u32 ucr1;
 	struct resource *res;
@@ -2218,6 +2221,14 @@ static int imx_uart_probe(struct platform_device *pdev)
 	if (of_get_property(np, "fsl,inverted-rx", NULL))
 		sport->inverted_rx = 1;
 
+	if (!of_property_read_u32_array(np, "fsl,dma-info", dma_buf_conf, 2)) {
+		sport->rx_period_length = dma_buf_conf[0];
+		sport->rx_periods = dma_buf_conf[1];
+	} else {
+		sport->rx_period_length = RX_DMA_PERIOD_LEN;
+		sport->rx_periods = RX_DMA_PERIODS;
+	}
+
 	if (sport->port.line >= ARRAY_SIZE(imx_uart_ports)) {
 		dev_err(&pdev->dev, "serial%d out of range\n",
 			sport->port.line);
-- 
2.30.2

