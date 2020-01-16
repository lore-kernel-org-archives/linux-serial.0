Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFBCC33CB1
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0181120748
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgAPMZW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:25:22 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:40041 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgAPMZW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 07:25:22 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id C19131008C8CE;
        Thu, 16 Jan 2020 13:25:20 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 81DBE60AE1B8;
        Thu, 16 Jan 2020 13:25:20 +0100 (CET)
X-Mailbox-Line: From 7d1a9bdb05090d8e465fd15cd26d6e81538d07f9 Mon Sep 17 00:00:00 2001
Message-Id: <7d1a9bdb05090d8e465fd15cd26d6e81538d07f9.1579175223.git.lukas@wunner.de>
In-Reply-To: <cover.1579175223.git.lukas@wunner.de>
References: <cover.1579175223.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 16 Jan 2020 13:14:05 +0100
Subject: [PATCH 5/6] serial: 8250_bcm2835aux: Use generic remapping code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Martin Sperl <kernel@martin.sperl.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On probe the bcm2835aux UART driver misreports the register base address
as 0x0:

ttyS0 at MMIO 0x0 (irq = 53, base_baud = 50000000) is a 16550

That's because the driver remaps the registers itself.  Take advantage
of the generic remapping code in serial8250_request_std_resource() to
get a message with the correct address and to simplify the driver.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index f03d38e7c3a7..d21460c9ef4b 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -41,7 +41,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	up.port.iotype = UPIO_MEM;
 	up.port.fifosize = 8;
 	up.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE |
-			UPF_SKIP_TEST;
+			UPF_SKIP_TEST | UPF_IOREMAP;
 
 	/* get the clock - this also enables the HW */
 	data->clk = devm_clk_get(&pdev->dev, NULL);
@@ -64,10 +64,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "memory resource not found");
 		return -EINVAL;
 	}
-	up.port.membase = devm_ioremap_resource(&pdev->dev, res);
-	ret = PTR_ERR_OR_ZERO(up.port.membase);
-	if (ret)
-		return ret;
+	up.port.mapbase = res->start;
+	up.port.mapsize = resource_size(res);
 
 	/* Check for a fixed line number */
 	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-- 
2.24.0

