Return-Path: <SRS0=Pw1G=6W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42B8C54E4B
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953F2206D5
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 14:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgEHOnj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 May 2020 10:43:39 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:53208 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgEHOni (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 May 2020 10:43:38 -0400
Received: from zenbar.fritz.box (pD95EF03D.dip0.t-ipconnect.de [217.94.240.61])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 49E3D406490;
        Fri,  8 May 2020 14:35:22 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        pascal.huerst@gmail.com
Subject: [PATCH 2/4] sc16is7xx: Add flag to activate IrDA mode
Date:   Fri,  8 May 2020 16:37:55 +0200
Message-Id: <20200508143757.2609740-3-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508143757.2609740-1-daniel@zonque.org>
References: <20200508143757.2609740-1-daniel@zonque.org>
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
---
 drivers/tty/serial/sc16is7xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7d3ae31cc720..e4025b8566a4 100644
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
@@ -1254,6 +1263,8 @@ static int sc16is7xx_probe(struct device *dev,
 			SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
+		char name[32];
+
 		s->p[i].line		= i;
 		/* Initialize port data */
 		s->p[i].port.dev	= dev;
@@ -1271,6 +1282,9 @@ static int sc16is7xx_probe(struct device *dev,
 			goto out_ports;
 		}
 
+		snprintf(name, sizeof(name), "linux,irda-mode-port-%d", i);
+		s->p[i].irda_mode = device_property_read_bool(dev, name);
+
 		/* Disable all interrupts */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_IER_REG, 0);
 		/* Disable TX/RX */
-- 
2.26.2

