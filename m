Return-Path: <SRS0=Gen4=44=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA1C3F2D0
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EB220848
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 08:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNs8JD2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgCKIbr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:31:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35726 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgCKIbr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 04:31:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id u12so1338416ljo.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Mar 2020 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYl8lkFpCTdsyEU1fcSE3XpffBLroxs6O2eSQD2SgcY=;
        b=JNs8JD2TvyR3SwZVj7IUpof+sgLl1mZr2XHFE6A+RHO4Vl7+f9xd9Mp6B1P8tQboMm
         JeVbyvrA7SgesikCFIRVbf4xRuqF/SL/rWx3s2RANrSAm47w1gC4po/7SzpzPFlz1l9M
         UI9UWqUf1qifejvkdvQ1TJl97w0Z9rZX2dcla97737b01L/xcHGSOW1Ou2ERvlMvwA40
         WKOQw3p6NIw9RimXN7wdYZi5YdLAeXZ4wbEKkVdFyVTyPwdYnocaORQ4zeQCSrjcWlzC
         lPcIAfAWzFvZI1Ole7SJbjfS2WCgXYD7Vh8uDMqlGMBQo38+QRFH1+FC2XMTC7FBZrtA
         AS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYl8lkFpCTdsyEU1fcSE3XpffBLroxs6O2eSQD2SgcY=;
        b=a71UHLSZvJmYonG5eRKG1DyQuezAf9U+43sqd+9Oyqk794mgjCttqa3gkACFBOYP1u
         j1tQ0mAUkiKBH7arRQZhy+yLQfDEH/O620VLq2OqXVu2Zn4/8QZZQpKSnMFOk+bmLtd5
         0ZXY820Pi9fqbpMpYWfa3Sglwo2F0/7Sl+CYFzl4KMo+To7rghRu0ukDOrK0nR4DxgiA
         uwigaBlheGQWuiBtvZqZtetVBL5Ce+Jwx4UPqRwuKPOgPha7xEISDLP4XokWrLHWgrFf
         jsiWK/CNasUp0Y4vCiIFhEKjwZcRRAgKdt6H42Av7hqA/sJjw1ZWrXJB2wLso6LPEZ5u
         rs6w==
X-Gm-Message-State: ANhLgQ0FFv8lignoKhm4427RUpRCkwvtLHumyNhMetHAMzmOU6B6cAT4
        qXpY1piREMlrz/xIlUg39DehKG6o4g0G8w==
X-Google-Smtp-Source: ADFU+vszKJhOr75nuh1GNId+/OEF3m4NP6gwHL3mQCZcJOrBl8wsv9qtqWnofuBUQyl1AO8VW5zsQA==
X-Received: by 2002:a2e:b892:: with SMTP id r18mr1492961ljp.252.1583915501445;
        Wed, 11 Mar 2020 01:31:41 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z84sm6315339lfa.6.2020.03.11.01.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:31:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v2] tty: serial: ifx6x60: Use helper variable for dev
Date:   Wed, 11 Mar 2020 09:31:30 +0100
Message-Id: <20200311083131.693908-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The &spi->dev is used so many times that the code gets
visibly better by introducing a simple dev helper variable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Include this preparation patch. Sorry for missing it.
---
 drivers/tty/serial/ifx6x60.c | 45 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 31033d517e82..32a0ccef9339 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -992,22 +992,23 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	int srdy;
 	struct ifx_modem_platform_data *pl_data;
 	struct ifx_spi_device *ifx_dev;
+	struct device *dev = &spi->dev;
 
 	if (saved_ifx_dev) {
-		dev_dbg(&spi->dev, "ignoring subsequent detection");
+		dev_dbg(dev, "ignoring subsequent detection");
 		return -ENODEV;
 	}
 
-	pl_data = dev_get_platdata(&spi->dev);
+	pl_data = dev_get_platdata(dev);
 	if (!pl_data) {
-		dev_err(&spi->dev, "missing platform data!");
+		dev_err(dev, "missing platform data!");
 		return -ENODEV;
 	}
 
 	/* initialize structure to hold our device variables */
 	ifx_dev = kzalloc(sizeof(struct ifx_spi_device), GFP_KERNEL);
 	if (!ifx_dev) {
-		dev_err(&spi->dev, "spi device allocation failed");
+		dev_err(dev, "spi device allocation failed");
 		return -ENOMEM;
 	}
 	saved_ifx_dev = ifx_dev;
@@ -1026,7 +1027,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	spi->bits_per_word = spi_bpw;
 	ret = spi_setup(spi);
 	if (ret) {
-		dev_err(&spi->dev, "SPI setup wasn't successful %d", ret);
+		dev_err(dev, "SPI setup wasn't successful %d", ret);
 		kfree(ifx_dev);
 		return -ENODEV;
 	}
@@ -1049,7 +1050,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 				&ifx_dev->tx_bus,
 				GFP_KERNEL);
 	if (!ifx_dev->tx_buffer) {
-		dev_err(&spi->dev, "DMA-TX buffer allocation failed");
+		dev_err(dev, "DMA-TX buffer allocation failed");
 		ret = -ENOMEM;
 		goto error_ret;
 	}
@@ -1058,7 +1059,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 				&ifx_dev->rx_bus,
 				GFP_KERNEL);
 	if (!ifx_dev->rx_buffer) {
-		dev_err(&spi->dev, "DMA-RX buffer allocation failed");
+		dev_err(dev, "DMA-RX buffer allocation failed");
 		ret = -ENOMEM;
 		goto error_ret;
 	}
@@ -1075,7 +1076,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	/* create our tty port */
 	ret = ifx_spi_create_port(ifx_dev);
 	if (ret != 0) {
-		dev_err(&spi->dev, "create default tty port failed");
+		dev_err(dev, "create default tty port failed");
 		goto error_ret;
 	}
 
@@ -1085,21 +1086,21 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	ifx_dev->gpio.srdy = pl_data->srdy;
 	ifx_dev->gpio.reset_out = pl_data->rst_out;
 
-	dev_info(&spi->dev, "gpios %d, %d, %d, %d, %d",
+	dev_info(dev, "gpios %d, %d, %d, %d, %d",
 		 ifx_dev->gpio.reset, ifx_dev->gpio.po, ifx_dev->gpio.mrdy,
 		 ifx_dev->gpio.srdy, ifx_dev->gpio.reset_out);
 
 	/* Configure gpios */
 	ret = gpio_request(ifx_dev->gpio.reset, "ifxModem");
 	if (ret < 0) {
-		dev_err(&spi->dev, "Unable to allocate GPIO%d (RESET)",
+		dev_err(dev, "Unable to allocate GPIO%d (RESET)",
 			ifx_dev->gpio.reset);
 		goto error_ret;
 	}
 	ret += gpio_direction_output(ifx_dev->gpio.reset, 0);
 	ret += gpio_export(ifx_dev->gpio.reset, 1);
 	if (ret) {
-		dev_err(&spi->dev, "Unable to configure GPIO%d (RESET)",
+		dev_err(dev, "Unable to configure GPIO%d (RESET)",
 			ifx_dev->gpio.reset);
 		ret = -EBUSY;
 		goto error_ret2;
@@ -1109,7 +1110,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	ret += gpio_direction_output(ifx_dev->gpio.po, 0);
 	ret += gpio_export(ifx_dev->gpio.po, 1);
 	if (ret) {
-		dev_err(&spi->dev, "Unable to configure GPIO%d (ON)",
+		dev_err(dev, "Unable to configure GPIO%d (ON)",
 			ifx_dev->gpio.po);
 		ret = -EBUSY;
 		goto error_ret3;
@@ -1117,14 +1118,14 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 
 	ret = gpio_request(ifx_dev->gpio.mrdy, "ifxModem");
 	if (ret < 0) {
-		dev_err(&spi->dev, "Unable to allocate GPIO%d (MRDY)",
+		dev_err(dev, "Unable to allocate GPIO%d (MRDY)",
 			ifx_dev->gpio.mrdy);
 		goto error_ret3;
 	}
 	ret += gpio_export(ifx_dev->gpio.mrdy, 1);
 	ret += gpio_direction_output(ifx_dev->gpio.mrdy, 0);
 	if (ret) {
-		dev_err(&spi->dev, "Unable to configure GPIO%d (MRDY)",
+		dev_err(dev, "Unable to configure GPIO%d (MRDY)",
 			ifx_dev->gpio.mrdy);
 		ret = -EBUSY;
 		goto error_ret4;
@@ -1132,7 +1133,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 
 	ret = gpio_request(ifx_dev->gpio.srdy, "ifxModem");
 	if (ret < 0) {
-		dev_err(&spi->dev, "Unable to allocate GPIO%d (SRDY)",
+		dev_err(dev, "Unable to allocate GPIO%d (SRDY)",
 			ifx_dev->gpio.srdy);
 		ret = -EBUSY;
 		goto error_ret4;
@@ -1140,7 +1141,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	ret += gpio_export(ifx_dev->gpio.srdy, 1);
 	ret += gpio_direction_input(ifx_dev->gpio.srdy);
 	if (ret) {
-		dev_err(&spi->dev, "Unable to configure GPIO%d (SRDY)",
+		dev_err(dev, "Unable to configure GPIO%d (SRDY)",
 			ifx_dev->gpio.srdy);
 		ret = -EBUSY;
 		goto error_ret5;
@@ -1148,14 +1149,14 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 
 	ret = gpio_request(ifx_dev->gpio.reset_out, "ifxModem");
 	if (ret < 0) {
-		dev_err(&spi->dev, "Unable to allocate GPIO%d (RESET_OUT)",
+		dev_err(dev, "Unable to allocate GPIO%d (RESET_OUT)",
 			ifx_dev->gpio.reset_out);
 		goto error_ret5;
 	}
 	ret += gpio_export(ifx_dev->gpio.reset_out, 1);
 	ret += gpio_direction_input(ifx_dev->gpio.reset_out);
 	if (ret) {
-		dev_err(&spi->dev, "Unable to configure GPIO%d (RESET_OUT)",
+		dev_err(dev, "Unable to configure GPIO%d (RESET_OUT)",
 			ifx_dev->gpio.reset_out);
 		ret = -EBUSY;
 		goto error_ret6;
@@ -1166,7 +1167,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 			  IRQF_TRIGGER_RISING|IRQF_TRIGGER_FALLING, DRVNAME,
 			  ifx_dev);
 	if (ret) {
-		dev_err(&spi->dev, "Unable to get irq %x\n",
+		dev_err(dev, "Unable to get irq %x\n",
 			gpio_to_irq(ifx_dev->gpio.reset_out));
 		goto error_ret6;
 	}
@@ -1177,14 +1178,14 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 			  ifx_spi_srdy_interrupt, IRQF_TRIGGER_RISING, DRVNAME,
 			  ifx_dev);
 	if (ret) {
-		dev_err(&spi->dev, "Unable to get irq %x",
+		dev_err(dev, "Unable to get irq %x",
 			gpio_to_irq(ifx_dev->gpio.srdy));
 		goto error_ret7;
 	}
 
 	/* set pm runtime power state and register with power system */
-	pm_runtime_set_active(&spi->dev);
-	pm_runtime_enable(&spi->dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
 	/* handle case that modem is already signaling SRDY */
 	/* no outgoing tty open at this point, this just satisfies the
-- 
2.24.1

