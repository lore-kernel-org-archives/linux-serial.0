Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D3C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  3 May 2022 06:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiECGfE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 May 2022 02:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiECGe7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 May 2022 02:34:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57159381AF;
        Mon,  2 May 2022 23:31:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EFB92210EE;
        Tue,  3 May 2022 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ytM5kTlhfOQM6IG3OcCbjJmaCYay4pn3Lo26jfdHWE=;
        b=nRidPY8mC0MDHLS4HCFIYDsJYXv8fCSaTj0BWC5AVOU43vPcu6L2R1xy1aOuyPfKaVT/fA
        rXZcS4v0pm4pM5VADGVQmPigdpdvVQHqHpbcMKPxmN7SJGAQmVyGpjl5xVZacJQOEWR+ZM
        olCykiczgjscDYXB4AgaYxwRIS2r7gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ytM5kTlhfOQM6IG3OcCbjJmaCYay4pn3Lo26jfdHWE=;
        b=3cA9kMxo9F4eQVSxgHQm3qqmzr5En3M/kY/cxRfcDNfBJQgsT68W879fHDDtYUrSvFFrK3
        c68PZlbS/JS+ynCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C56172C143;
        Tue,  3 May 2022 06:31:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/11] serial: pic32: remove constants from struct pic32_sport
Date:   Tue,  3 May 2022 08:31:14 +0200
Message-Id: <20220503063122.20957-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503063122.20957-1-jslaby@suse.cz>
References: <20220503063122.20957-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

All the irqflags_* in struct pic32_sport are set to IRQF_NO_THREAD and
never updated. So remove pic32_sport::irqflags_* and use the flag
directly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index a1b8c05f3d46..1e8ff6004e8e 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -45,13 +45,10 @@
  * @port: uart port descriptor
  * @idx: port index
  * @irq_fault: virtual fault interrupt number
- * @irqflags_fault: flags related to fault irq
  * @irq_fault_name: irq fault name
  * @irq_rx: virtual rx interrupt number
- * @irqflags_rx: flags related to rx irq
  * @irq_rx_name: irq rx name
  * @irq_tx: virtual tx interrupt number
- * @irqflags_tx: : flags related to tx irq
  * @irq_tx_name: irq tx name
  * @cts_gpio: clear to send gpio
  * @dev: device descriptor
@@ -61,13 +58,10 @@ struct pic32_sport {
 	int idx;
 
 	int irq_fault;
-	int irqflags_fault;
 	const char *irq_fault_name;
 	int irq_rx;
-	int irqflags_rx;
 	const char *irq_rx_name;
 	int irq_tx;
-	int irqflags_tx;
 	const char *irq_tx_name;
 	u8 enable_tx_irq;
 
@@ -533,7 +527,7 @@ static int pic32_uart_startup(struct uart_port *port)
 	}
 	irq_set_status_flags(sport->irq_fault, IRQ_NOAUTOEN);
 	ret = request_irq(sport->irq_fault, pic32_uart_fault_interrupt,
-			  sport->irqflags_fault, sport->irq_fault_name, port);
+			  IRQF_NO_THREAD, sport->irq_fault_name, port);
 	if (ret) {
 		dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
 			__func__, sport->irq_fault, ret,
@@ -551,7 +545,7 @@ static int pic32_uart_startup(struct uart_port *port)
 	}
 	irq_set_status_flags(sport->irq_rx, IRQ_NOAUTOEN);
 	ret = request_irq(sport->irq_rx, pic32_uart_rx_interrupt,
-			  sport->irqflags_rx, sport->irq_rx_name, port);
+			  IRQF_NO_THREAD, sport->irq_rx_name, port);
 	if (ret) {
 		dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
 			__func__, sport->irq_rx, ret,
@@ -569,7 +563,7 @@ static int pic32_uart_startup(struct uart_port *port)
 	}
 	irq_set_status_flags(sport->irq_tx, IRQ_NOAUTOEN);
 	ret = request_irq(sport->irq_tx, pic32_uart_tx_interrupt,
-			  sport->irqflags_tx, sport->irq_tx_name, port);
+			  IRQF_NO_THREAD, sport->irq_tx_name, port);
 	if (ret) {
 		dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
 			__func__, sport->irq_tx, ret,
@@ -918,11 +912,8 @@ static int pic32_uart_probe(struct platform_device *pdev)
 
 	sport->idx		= uart_idx;
 	sport->irq_fault	= irq_of_parse_and_map(np, 0);
-	sport->irqflags_fault	= IRQF_NO_THREAD;
 	sport->irq_rx		= irq_of_parse_and_map(np, 1);
-	sport->irqflags_rx	= IRQF_NO_THREAD;
 	sport->irq_tx		= irq_of_parse_and_map(np, 2);
-	sport->irqflags_tx	= IRQF_NO_THREAD;
 	sport->clk		= devm_clk_get(&pdev->dev, NULL);
 	sport->cts_gpio		= -EINVAL;
 	sport->dev		= &pdev->dev;
-- 
2.36.0

