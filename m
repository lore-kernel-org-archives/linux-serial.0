Return-Path: <SRS0=RakX=7L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD601C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB014207D4
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 05:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgE2FvI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 May 2020 01:51:08 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:56532 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2FvH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 May 2020 01:51:07 -0400
Received: from zenbar.fritz.box (p57bc97c6.dip0.t-ipconnect.de [87.188.151.198])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 2E3DA4230C5;
        Fri, 29 May 2020 05:51:06 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 2/2] sc16is7xx: Add flag to activate IrDA mode
Date:   Fri, 29 May 2020 07:50:58 +0200
Message-Id: <20200529055058.1606910-3-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529055058.1606910-1-daniel@zonque.org>
References: <20200529055058.1606910-1-daniel@zonque.org>
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
index 56508e63f9a0..deb55e2ad169 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -315,6 +315,7 @@ struct sc16is7xx_one {
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
 	struct sc16is7xx_one_config	config;
+	bool				irda_mode;
 };
 
 struct sc16is7xx_port {
@@ -986,6 +987,7 @@ static int sc16is7xx_config_rs485(struct uart_port *port,
 
 static int sc16is7xx_startup(struct uart_port *port)
 {
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	unsigned int val;
 
@@ -1024,6 +1026,13 @@ static int sc16is7xx_startup(struct uart_port *port)
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
@@ -1304,6 +1313,17 @@ static int sc16is7xx_probe(struct device *dev,
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
 
+	if (dev->of_node) {
+		struct property *prop;
+		const __be32 *p;
+		u32 u;
+
+		of_property_for_each_u32(dev->of_node, "irda-mode-ports",
+					 prop, p, u)
+			if (u < devtype->nr_uart)
+				s->p[u].irda_mode = true;
+	}
+
 	/*
 	 * Setup interrupt. We first try to acquire the IRQ line as level IRQ.
 	 * If that succeeds, we can allow sharing the interrupt as well.
-- 
2.26.2

