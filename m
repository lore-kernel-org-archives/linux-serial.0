Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25286C11F66
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jul 2021 02:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2CE613F7
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jul 2021 02:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhGJC0c (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Jul 2021 22:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233349AbhGJCZu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Jul 2021 22:25:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0A7361407;
        Sat, 10 Jul 2021 02:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625883785;
        bh=l7HpfyGaASe1EXqssYiTB8W6w7CPgRkUmS+BAL1qRFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFRQfQNNMfdm2VAPsR/PBKVzIK0vWY9k+YPi6OWxFACqY5fAGIQjTU4aGLApKTBPu
         gzfQRs3cjlX5H1m42c2ouKHBwa8htcI+tm/tQjJ14Txfo473a1OZUHVtQzzkZp88Y5
         ArkeNuTl/UqlgmQ6jdI/Zz3RmmzR7fqtDYPZiKs8adj3Sg/hXKdJxWFzVnVoT7bQ5e
         pXesN+r38e5jLZhJRBTLdA8CzKTGoNWV7Um1O+AJL5VfhQ4T4RLv5fUZb3c6UaU5zn
         JOmObTzLp/HCq4TO+lOcOufUicxknilC+qV426qV5XG76qFL+VR1i2xysMDd79ZkM+
         A+WzQhuN84c0w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 052/104] serial: tty: uartlite: fix console setup
Date:   Fri,  9 Jul 2021 22:21:04 -0400
Message-Id: <20210710022156.3168825-52-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022156.3168825-1-sashal@kernel.org>
References: <20210710022156.3168825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Mack <daniel@zonque.org>

[ Upstream commit d157fca711ad42e75efef3444c83d2e1a17be27a ]

Remove the hack to assign the global console_port variable at probe time.
This assumption that cons->index is -1 is wrong for systems that specify
'console=' in the cmdline (or 'stdout-path' in dts). Hence, on such system
the actual console assignment is ignored, and the first UART that happens
to be probed is used as console instead.

Move the logic to console_setup() and map the console to the correct port
through the array of available ports instead.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Link: https://lore.kernel.org/r/20210528133321.1859346-1-daniel@zonque.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/uartlite.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f42ccc40ffa6..a5f15f22d9ef 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -505,21 +505,23 @@ static void ulite_console_write(struct console *co, const char *s,
 
 static int ulite_console_setup(struct console *co, char *options)
 {
-	struct uart_port *port;
+	struct uart_port *port = NULL;
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
 
-
-	port = console_port;
+	if (co->index >= 0 && co->index < ULITE_NR_UARTS)
+		port = ulite_ports + co->index;
 
 	/* Has the device been initialized yet? */
-	if (!port->mapbase) {
+	if (!port || !port->mapbase) {
 		pr_debug("console on ttyUL%i not present\n", co->index);
 		return -ENODEV;
 	}
 
+	console_port = port;
+
 	/* not initialized yet? */
 	if (!port->membase) {
 		if (ulite_request_port(port))
@@ -655,17 +657,6 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 
 	dev_set_drvdata(dev, port);
 
-#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
-	/*
-	 * If console hasn't been found yet try to assign this port
-	 * because it is required to be assigned for console setup function.
-	 * If register_console() don't assign value, then console_port pointer
-	 * is cleanup.
-	 */
-	if (ulite_uart_driver.cons->index == -1)
-		console_port = port;
-#endif
-
 	/* Register the port */
 	rc = uart_add_one_port(&ulite_uart_driver, port);
 	if (rc) {
@@ -675,12 +666,6 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 		return rc;
 	}
 
-#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
-	/* This is not port which is used for console that's why clean it up */
-	if (ulite_uart_driver.cons->index == -1)
-		console_port = NULL;
-#endif
-
 	return 0;
 }
 
-- 
2.30.2

