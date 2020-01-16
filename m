Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D00C33CB1
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BDD20748
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgAPMYB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:24:01 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:40469 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgAPMYA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 07:24:00 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id E75C41008C54C;
        Thu, 16 Jan 2020 13:23:57 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id A92C960AE1B8;
        Thu, 16 Jan 2020 13:23:57 +0100 (CET)
X-Mailbox-Line: From 421d3aed4c34cc8447ac9c26c320961f1b787f11 Mon Sep 17 00:00:00 2001
Message-Id: <421d3aed4c34cc8447ac9c26c320961f1b787f11.1579175223.git.lukas@wunner.de>
In-Reply-To: <cover.1579175223.git.lukas@wunner.de>
References: <cover.1579175223.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 16 Jan 2020 13:14:04 +0100
Subject: [PATCH 4/6] serial: 8250_bcm2835aux: Allocate uart_8250_port on stack
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Martin Sperl <kernel@martin.sperl.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The bcm2835aux UART driver stores a struct uart_8250_port in its private
data even though it's only passed once to serial8250_register_8250_port()
(which copies all relevant data) and becomes obsolete afterwards.
Allocate the struct on the stack instead for simplicity and to conserve
memory.

The driver also initializes a spinlock in the struct which is never used.
Drop that as well.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 33 +++++++++++------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index fb850d0ad643..f03d38e7c3a7 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -17,13 +17,13 @@
 #include "8250.h"
 
 struct bcm2835aux_data {
-	struct uart_8250_port uart;
 	struct clk *clk;
 	int line;
 };
 
 static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
+	struct uart_8250_port up = { };
 	struct bcm2835aux_data *data;
 	struct resource *res;
 	int ret;
@@ -34,17 +34,14 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* initialize data */
-	spin_lock_init(&data->uart.port.lock);
-	data->uart.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
-	data->uart.port.dev = &pdev->dev;
-	data->uart.port.regshift = 2;
-	data->uart.port.type = PORT_16550;
-	data->uart.port.iotype = UPIO_MEM;
-	data->uart.port.fifosize = 8;
-	data->uart.port.flags = UPF_SHARE_IRQ |
-				UPF_FIXED_PORT |
-				UPF_FIXED_TYPE |
-				UPF_SKIP_TEST;
+	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
+	up.port.dev = &pdev->dev;
+	up.port.regshift = 2;
+	up.port.type = PORT_16550;
+	up.port.iotype = UPIO_MEM;
+	up.port.fifosize = 8;
+	up.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE |
+			UPF_SKIP_TEST;
 
 	/* get the clock - this also enables the HW */
 	data->clk = devm_clk_get(&pdev->dev, NULL);
@@ -59,7 +56,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		return ret;
-	data->uart.port.irq = ret;
+	up.port.irq = ret;
 
 	/* map the main registers */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -67,15 +64,15 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "memory resource not found");
 		return -EINVAL;
 	}
-	data->uart.port.membase = devm_ioremap_resource(&pdev->dev, res);
-	ret = PTR_ERR_OR_ZERO(data->uart.port.membase);
+	up.port.membase = devm_ioremap_resource(&pdev->dev, res);
+	ret = PTR_ERR_OR_ZERO(up.port.membase);
 	if (ret)
 		return ret;
 
 	/* Check for a fixed line number */
 	ret = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (ret >= 0)
-		data->uart.port.line = ret;
+		up.port.line = ret;
 
 	/* enable the clock as a last step */
 	ret = clk_prepare_enable(data->clk);
@@ -90,10 +87,10 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	 * so we have to multiply the actual clock by 2
 	 * to get identical baudrates.
 	 */
-	data->uart.port.uartclk = clk_get_rate(data->clk) * 2;
+	up.port.uartclk = clk_get_rate(data->clk) * 2;
 
 	/* register the port */
-	ret = serial8250_register_8250_port(&data->uart);
+	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev,
-- 
2.24.0

