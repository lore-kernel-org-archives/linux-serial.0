Return-Path: <SRS0=rV5n=57=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A290C3815B
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F2A20771
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 19:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jb91CZSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411774AbgDOTIN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416843AbgDOSlb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Apr 2020 14:41:31 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D4CC061A0C
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2020 11:41:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l14so4858268ljj.5
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2020 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pNAU5PY6HCG3Fv/JQ8QECrB/SgONRgKCqGtg0tj0Ew=;
        b=Jb91CZSlqCPv2SiZAmXw/fPLHVIyIj7M3t8yhJ9bJ+PRLMrakZeqraNKlaYBqk52IG
         xZh5XadLVDtBvMLN2xTCm/NlSdBIGvb8glw1Di5BYad+PEt6vX+uvfGt4iSmZfpiJN02
         Vv6FI0QON4z2u3NeoFNRoztffUPWHr4iAMUQazoKgj5V7VrePl7m4rWF1efAdKli6lMB
         IqGTougoe+LXdoJD+uwH06NPSZzmfdaV24Dh07d497jQ78d8BmmUZsp7B5DnhPVEUaFE
         xt+7+J/cZNYybzS/GzmIJOnMrtRfbw5dt+Kg8u8ELBr/9j81W1uPi458vL9WLCnAsbCy
         ptDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pNAU5PY6HCG3Fv/JQ8QECrB/SgONRgKCqGtg0tj0Ew=;
        b=jH0FrLdtbipcva5CJX3RUSTwn+GKRLBIOIdOcoGpWw88n5fGzyroohuGVZdNqCI/ao
         mQYj5Sl2rzITUdD4icB9rJPIwBBRp2gTYm0GU1KLpb/6Z3bE1UuJWElTsNtit0KtSR4W
         9EeKfGuGaQhp2v+bg374zeG0RQb/MlwZ8cnT5mGgv/xf0pqb/rpsVoYCpTYxt/x5LE5u
         5iKQBmFUEeds4GebTiFwB+iggBamg9X/FM7TqpDp45XGQZ4tb3U53JSNeGfp6UnTvhGZ
         zRTk/XfDADGPWWUP0p1ka7zmgs59E8+oh/gEoKyrQHbFsAxQW6e0w42ERPpwtZGUjAq2
         6Eyw==
X-Gm-Message-State: AGi0Pua+egpJ22quBiNjdgTCz75khr9cOVMxW+Dx0d2Vbz3Y4eIZTpQZ
        QDTzc7KVd03L15biyBQAnVZKOR3R10o=
X-Google-Smtp-Source: APiQypJnU9sp3mH+3BuYAlvH/ogAPj1NISHAsGt3qX1nC7zKhl0u5fvJ9Pgv1CuNGSGo04GfZtMigw==
X-Received: by 2002:a2e:b1c4:: with SMTP id e4mr4056581lja.29.1586976089575;
        Wed, 15 Apr 2020 11:41:29 -0700 (PDT)
Received: from localhost.localdomain (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id o6sm12164144lji.15.2020.04.15.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:41:28 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Shubhrajyoti D <shubhrajyoti@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH] serial: omap: Convert to use GPIO descriptors
Date:   Wed, 15 Apr 2020 20:39:27 +0200
Message-Id: <20200415183927.269445-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This converts the OMAP serial driver to use a GPIO descriptor
for the optional RTS signal.

Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/omap-serial.c | 48 +++++++++++++++++---------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f7d6b3c9ea45..c71c1a2266dc 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -33,8 +33,7 @@
 #include <linux/pm_wakeirq.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_data/serial-omap.h>
 
 #define OMAP_MAX_HSUART_PORTS	10
@@ -153,7 +152,7 @@ struct uart_omap_port {
 	u32			errata;
 	u32			features;
 
-	int			rts_gpio;
+	struct gpio_desc	*rts_gpiod;
 
 	struct pm_qos_request	pm_qos_request;
 	u32			latency;
@@ -303,11 +302,11 @@ static void serial_omap_stop_tx(struct uart_port *port)
 			serial_out(up, UART_OMAP_SCR, up->scr);
 			res = (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) ?
 				1 : 0;
-			if (gpio_get_value(up->rts_gpio) != res) {
+			if (gpiod_get_value(up->rts_gpiod) != res) {
 				if (port->rs485.delay_rts_after_send > 0)
 					mdelay(
 					port->rs485.delay_rts_after_send);
-				gpio_set_value(up->rts_gpio, res);
+				gpiod_set_value(up->rts_gpiod, res);
 			}
 		} else {
 			/* We're asked to stop, but there's still stuff in the
@@ -412,8 +411,8 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 		/* if rts not already enabled */
 		res = (port->rs485.flags & SER_RS485_RTS_ON_SEND) ? 1 : 0;
-		if (gpio_get_value(up->rts_gpio) != res) {
-			gpio_set_value(up->rts_gpio, res);
+		if (gpiod_get_value(up->rts_gpiod) != res) {
+			gpiod_set_value(up->rts_gpiod, res);
 			if (port->rs485.delay_rts_before_send > 0)
 				mdelay(port->rs485.delay_rts_before_send);
 		}
@@ -1414,12 +1413,12 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 	 * Just as a precaution, only allow rs485
 	 * to be enabled if the gpio pin is valid
 	 */
-	if (gpio_is_valid(up->rts_gpio)) {
+	if (up->rts_gpiod) {
 		/* enable / disable rts */
 		val = (port->rs485.flags & SER_RS485_ENABLED) ?
 			SER_RS485_RTS_AFTER_SEND : SER_RS485_RTS_ON_SEND;
 		val = (port->rs485.flags & val) ? 1 : 0;
-		gpio_set_value(up->rts_gpio, val);
+		gpiod_set_value(up->rts_gpiod, val);
 	} else
 		port->rs485.flags &= ~SER_RS485_ENABLED;
 
@@ -1596,13 +1595,15 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 }
 
 static int serial_omap_probe_rs485(struct uart_omap_port *up,
-				   struct device_node *np)
+				   struct device *dev)
 {
 	struct serial_rs485 *rs485conf = &up->port.rs485;
+	struct device_node *np = dev->of_node;
+	enum gpiod_flags gflags;
 	int ret;
 
 	rs485conf->flags = 0;
-	up->rts_gpio = -EINVAL;
+	up->rts_gpiod = NULL;
 
 	if (!np)
 		return 0;
@@ -1618,19 +1619,20 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 	}
 
 	/* check for tx enable gpio */
-	up->rts_gpio = of_get_named_gpio(np, "rts-gpio", 0);
-	if (gpio_is_valid(up->rts_gpio)) {
-		ret = devm_gpio_request(up->dev, up->rts_gpio, "omap-serial");
-		if (ret < 0)
+	gflags = rs485conf->flags & SER_RS485_RTS_AFTER_SEND ?
+		GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	up->rts_gpiod = devm_gpiod_get_optional(dev, "rts", gflags);
+	if (IS_ERR(up->rts_gpiod)) {
+		ret = PTR_ERR(up->rts_gpiod);
+	        if (ret == -EPROBE_DEFER)
 			return ret;
-		ret = rs485conf->flags & SER_RS485_RTS_AFTER_SEND ? 1 : 0;
-		ret = gpio_direction_output(up->rts_gpio, ret);
-		if (ret < 0)
-			return ret;
-	} else if (up->rts_gpio == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
+		/*
+		 * FIXME: the code historically ignored any other error than
+		 * -EPROBE_DEFER and just went on without GPIO.
+		 */
+		up->rts_gpiod = NULL;
 	} else {
-		up->rts_gpio = -EINVAL;
+		gpiod_set_consumer_name(up->rts_gpiod, "omap-serial");
 	}
 
 	return 0;
@@ -1703,7 +1705,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 		dev_info(up->port.dev, "no wakeirq for uart%d\n",
 			 up->port.line);
 
-	ret = serial_omap_probe_rs485(up, pdev->dev.of_node);
+	ret = serial_omap_probe_rs485(up, &pdev->dev);
 	if (ret < 0)
 		goto err_rs485;
 
-- 
2.25.2

