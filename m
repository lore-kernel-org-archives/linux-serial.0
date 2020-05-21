Return-Path: <SRS0=lGjV=7D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF9FC433E3
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 09:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7DC20759
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 09:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgEUJMD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 May 2020 05:12:03 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:59154 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbgEUJMD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 May 2020 05:12:03 -0400
Received: from zenbar.fritz.box (pd95ef28a.dip0.t-ipconnect.de [217.94.242.138])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 349F740BCC4;
        Thu, 21 May 2020 09:09:02 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 2/6] sc16is7xx: Add flag to activate IrDA mode
Date:   Thu, 21 May 2020 11:11:48 +0200
Message-Id: <20200521091152.404404-3-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091152.404404-1-daniel@zonque.org>
References: <20200521091152.404404-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pascal Huerst <pascal.huerst@gmail.com>

This series of uart controllers is able to work in IrDA mode.
Add per-port flag to the device-tree to enable that feature if needed.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/tty/serial/sc16is7xx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7d3ae31cc720..cf9cf59bb04e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -315,6 +315,7 @@ struct sc16is7xx_one {
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
 	struct sc16is7xx_one_config	config;
+	bool				irda_mode;
 };
 
 struct sc16is7xx_port {
@@ -994,6 +995,7 @@ static int sc16is7xx_config_rs485(struct uart_port *port,
 
 static int sc16is7xx_startup(struct uart_port *port)
 {
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	unsigned int val;
 
@@ -1032,6 +1034,13 @@ static int sc16is7xx_startup(struct uart_port *port)
 	/* Now, initialize the UART */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
 
+	/* Enable IrDA mode if requested in DT */
+	/* This bit must be written with LCR[7] = 0 */
+	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
+			      SC16IS7XX_MCR_IRDA_BIT,
+			      one->irda_mode ?
+				SC16IS7XX_MCR_IRDA_BIT : 0);
+
 	/* Enable the Rx and Tx FIFO */
 	sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG,
 			      SC16IS7XX_EFCR_RXDISABLE_BIT |
@@ -1302,6 +1311,17 @@ static int sc16is7xx_probe(struct device *dev,
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
 
+	if (dev->of_node) {
+		struct property *prop;
+		const __be32 *p;
+		u32 u;
+
+		of_property_for_each_u32(dev->of_node, "linux,irda-mode-ports",
+					 prop, p, u)
+			if (u < devtype->nr_uart)
+				s->p[u].irda_mode = true;
+	}
+
 	/* Setup interrupt */
 	ret = devm_request_irq(dev, irq, sc16is7xx_irq,
 			       flags, dev_name(dev), s);
-- 
2.26.2

