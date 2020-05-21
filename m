Return-Path: <SRS0=lGjV=7D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B398BC433E5
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 09:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8070220759
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 09:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgEUJME (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 May 2020 05:12:04 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:59168 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgEUJME (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 May 2020 05:12:04 -0400
Received: from zenbar.fritz.box (pd95ef28a.dip0.t-ipconnect.de [217.94.242.138])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 8F4AE40BCC8;
        Thu, 21 May 2020 09:09:03 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 3/6] sc16is7xx: Always use falling edge IRQ
Date:   Thu, 21 May 2020 11:11:49 +0200
Message-Id: <20200521091152.404404-4-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091152.404404-1-daniel@zonque.org>
References: <20200521091152.404404-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver currently only uses IRQF_TRIGGER_FALLING if the probing
happened without a device-tree setup. The device however will always
generate falling edges on its IRQ line, so let's use that flag in
all cases.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/tty/serial/sc16is7xx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index cf9cf59bb04e..fcb2551a5df2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1185,7 +1185,7 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 
 static int sc16is7xx_probe(struct device *dev,
 			   const struct sc16is7xx_devtype *devtype,
-			   struct regmap *regmap, int irq, unsigned long flags)
+			   struct regmap *regmap, int irq)
 {
 	struct sched_param sched_param = { .sched_priority = MAX_RT_PRIO / 2 };
 	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
@@ -1324,7 +1324,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 	/* Setup interrupt */
 	ret = devm_request_irq(dev, irq, sc16is7xx_irq,
-			       flags, dev_name(dev), s);
+			       IRQF_TRIGGER_FALLING, dev_name(dev), s);
 	if (!ret)
 		return 0;
 
@@ -1398,7 +1398,6 @@ static struct regmap_config regcfg = {
 static int sc16is7xx_spi_probe(struct spi_device *spi)
 {
 	const struct sc16is7xx_devtype *devtype;
-	unsigned long flags = 0;
 	struct regmap *regmap;
 	int ret;
 
@@ -1419,14 +1418,13 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 		const struct spi_device_id *id_entry = spi_get_device_id(spi);
 
 		devtype = (struct sc16is7xx_devtype *)id_entry->driver_data;
-		flags = IRQF_TRIGGER_FALLING;
 	}
 
 	regcfg.max_register = (0xf << SC16IS7XX_REG_SHIFT) |
 			      (devtype->nr_uart - 1);
 	regmap = devm_regmap_init_spi(spi, &regcfg);
 
-	return sc16is7xx_probe(&spi->dev, devtype, regmap, spi->irq, flags);
+	return sc16is7xx_probe(&spi->dev, devtype, regmap, spi->irq);
 }
 
 static int sc16is7xx_spi_remove(struct spi_device *spi)
@@ -1465,7 +1463,6 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c,
 			       const struct i2c_device_id *id)
 {
 	const struct sc16is7xx_devtype *devtype;
-	unsigned long flags = 0;
 	struct regmap *regmap;
 
 	if (i2c->dev.of_node) {
@@ -1474,14 +1471,13 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c,
 			return -ENODEV;
 	} else {
 		devtype = (struct sc16is7xx_devtype *)id->driver_data;
-		flags = IRQF_TRIGGER_FALLING;
 	}
 
 	regcfg.max_register = (0xf << SC16IS7XX_REG_SHIFT) |
 			      (devtype->nr_uart - 1);
 	regmap = devm_regmap_init_i2c(i2c, &regcfg);
 
-	return sc16is7xx_probe(&i2c->dev, devtype, regmap, i2c->irq, flags);
+	return sc16is7xx_probe(&i2c->dev, devtype, regmap, i2c->irq);
 }
 
 static int sc16is7xx_i2c_remove(struct i2c_client *client)
-- 
2.26.2

