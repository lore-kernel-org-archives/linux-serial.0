Return-Path: <SRS0=S7Zs=76=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC2CC433E2
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B56520CC7
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592407749;
	bh=SD+fejC18TjS7/DoA5KE5YrnoAqS1yLaxfx11ISwTbM=;
	h=From:To:Subject:Date:List-ID:From;
	b=I6rSE/rlTGFQ1vcVqvnYLgCGG0vVYkN1DoSkCQvH1/f1warxHI1Yju3EXWDKScTP3
	 nSlEw4FgJl9oDGQjdK80hxoICQmAnPTH40ZHipoMndLvM0Wvi0NBDxvisUvNVzfTuD
	 YovAsw16GY51oT+Qo6e8wfuhpE7CE1tc8yzjmWXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgFQP3F (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgFQP3D (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Jun 2020 11:29:03 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7AE20897;
        Wed, 17 Jun 2020 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592407742;
        bh=SD+fejC18TjS7/DoA5KE5YrnoAqS1yLaxfx11ISwTbM=;
        h=From:To:Subject:Date:From;
        b=nF/JSFGNj+SedrGskz4bgXFzZUfgizp2OmgNo4HUP37JHEcCY9Ov9Wqps/KNaLklv
         KfoizibFHs7fTzlwFxrmfoL6igIyNTVeH5qaWhJCnQ6UcGaSLcnGGzEkrCkEOZukVy
         nSHRUgttSJF7pXr7+g8rKFIDbICS7nwgJ0RvAuFA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: samsung: Minor whitespace cleanups
Date:   Wed, 17 Jun 2020 17:28:56 +0200
Message-Id: <20200617152856.18086-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Make the code slightly more readable by removing unneeded line breaks,
adding missing line breaks and white spaces.  This also fixes few strict
checkpatch suggestions:

	CHECK: spaces preferred around that '-' (ctx:VxV)
	CHECK: Unbalanced braces around else statement
	CHECK: Lines should not end with a '('

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d913d9b2762a..7be9579216b8 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -327,7 +327,6 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 	unsigned long flags;
 	int count;
 
-
 	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
 	count = dma->tx_bytes_requested - state.residue;
 	async_tx_ack(dma->tx_desc);
@@ -409,7 +408,6 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 	struct circ_buf *xmit = &port->state->xmit;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 
-
 	if (ourport->tx_mode != S3C24XX_TX_DMA)
 		enable_tx_dma(ourport);
 
@@ -816,7 +814,6 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 	return IRQ_HANDLED;
 }
 
-
 static irqreturn_t s3c24xx_serial_rx_chars(int irq, void *dev_id)
 {
 	struct s3c24xx_uart_port *ourport = dev_id;
@@ -842,8 +839,8 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	    count >= ourport->min_dma_size) {
 		int align = dma_get_cache_alignment() -
 			(xmit->tail & (dma_get_cache_alignment() - 1));
-		if (count-align >= ourport->min_dma_size) {
-			dma_count = count-align;
+		if (count - align >= ourport->min_dma_size) {
+			dma_count = count - align;
 			count = align;
 		}
 	}
@@ -1589,7 +1586,6 @@ s3c24xx_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return 0;
 }
 
-
 #ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
 
 static struct console s3c24xx_serial_console;
@@ -1672,7 +1668,6 @@ s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
 		}
 	},
 #if CONFIG_SERIAL_SAMSUNG_UARTS > 2
-
 	[2] = {
 		.port = {
 			.lock		= __PORT_LOCK_UNLOCKED(2),
@@ -1728,7 +1723,6 @@ static void s3c24xx_serial_resetport(struct uart_port *port,
 	udelay(1);
 }
 
-
 #ifdef CONFIG_ARM_S3C24XX_CPUFREQ
 
 static int s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
@@ -1903,9 +1897,9 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	port->mapbase = res->start;
 	ret = platform_get_irq(platdev, 0);
-	if (ret < 0)
+	if (ret < 0) {
 		port->irq = 0;
-	else {
+	} else {
 		port->irq = ret;
 		ourport->rx_irq = ret;
 		ourport->tx_irq = ret + 1;
@@ -1977,8 +1971,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[];
 
 static int probe_index;
 
-static inline struct s3c24xx_serial_drv_data *s3c24xx_get_driver_data(
-			struct platform_device *pdev)
+static inline struct s3c24xx_serial_drv_data *
+s3c24xx_get_driver_data(struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
 	if (pdev->dev.of_node) {
@@ -2329,7 +2323,6 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 		*baud = rate / (16 * (ubrdiv + 1));
 		dev_dbg(port->dev, "calculated baud %d\n", *baud);
 	}
-
 }
 
 static int __init
@@ -2696,6 +2689,7 @@ static int __init s3c2410_early_console_setup(struct earlycon_device *device,
 	device->port.private_data = &s3c2410_early_console_data;
 	return samsung_early_console_setup(device, opt);
 }
+
 OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
 			s3c2410_early_console_setup);
 
@@ -2710,6 +2704,7 @@ static int __init s3c2440_early_console_setup(struct earlycon_device *device,
 	device->port.private_data = &s3c2440_early_console_data;
 	return samsung_early_console_setup(device, opt);
 }
+
 OF_EARLYCON_DECLARE(s3c2412, "samsung,s3c2412-uart",
 			s3c2440_early_console_setup);
 OF_EARLYCON_DECLARE(s3c2440, "samsung,s3c2440-uart",
@@ -2728,6 +2723,7 @@ static int __init s5pv210_early_console_setup(struct earlycon_device *device,
 	device->port.private_data = &s5pv210_early_console_data;
 	return samsung_early_console_setup(device, opt);
 }
+
 OF_EARLYCON_DECLARE(s5pv210, "samsung,s5pv210-uart",
 			s5pv210_early_console_setup);
 OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
-- 
2.17.1

