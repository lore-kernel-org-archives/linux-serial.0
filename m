From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 03/12] Serial: sc26xx - use interrupt trigger flags from
	resources.
Date: Sat, 13 Feb 2010 17:10:00 +0100
Message-ID: <20100213161000.22311.80097.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45000 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab0BMQKC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:10:02 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2648139ewy.28
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:10:02 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de

Allows platform resources to specify interrupt flags.

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index dc09682..ca74bf6 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -631,7 +631,7 @@ static void __devinit sc26xx_init_masks(struct uart_sc26xx_port *up,
 
 static int __devinit sc26xx_probe(struct platform_device *dev)
 {
-	struct resource *res;
+	struct resource *res, *irq_res;
 	struct uart_sc26xx_port *up;
 	unsigned int *sc26xx_data = dev->dev.platform_data;
 	int err;
@@ -640,6 +640,10 @@ static int __devinit sc26xx_probe(struct platform_device *dev)
 	if (!res)
 		return -ENODEV;
 
+	irq_res = platform_get_resource(dev, IORESOURCE_IRQ, 0);
+	if (!irq_res)
+		return -ENXIO;
+
 	up = kzalloc(sizeof *up, GFP_KERNEL);
 	if (unlikely(!up))
 		return -ENOMEM;
@@ -652,7 +656,7 @@ static int __devinit sc26xx_probe(struct platform_device *dev)
 	up->port[0].mapbase = res->start;
 	up->port[0].membase = ioremap_nocache(up->port[0].mapbase, 0x40);
 	up->port[0].iotype = UPIO_MEM;
-	up->port[0].irq = platform_get_irq(dev, 0);
+	up->port[0].irq = irq_res->start;
 
 	up->port[0].dev = &dev->dev;
 
@@ -688,7 +692,8 @@ static int __devinit sc26xx_probe(struct platform_device *dev)
 	if (err)
 		goto out_remove_port0;
 
-	err = request_irq(up->port[0].irq, sc26xx_interrupt, 0, "sc26xx", up);
+	err = request_irq(up->port[0].irq, sc26xx_interrupt,
+		irq_res->flags & IRQF_TRIGGER_MASK, "sc26xx", up);
 	if (err)
 		goto out_remove_ports;
 

