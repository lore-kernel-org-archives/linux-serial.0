Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CA0C38A2D
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 07:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiJYHkB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Oct 2022 03:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiJYHkA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Oct 2022 03:40:00 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEECBC780
        for <linux-serial@vger.kernel.org>; Tue, 25 Oct 2022 00:39:56 -0700 (PDT)
Received: from xps.skovby (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id 2383E57B5C;
        Tue, 25 Oct 2022 07:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1666683593; bh=zC6yY9Z9y7cMK5ushCy4fMvTSkslAwzYcdjLc7jTcSQ=;
        h=From:To:Cc:Subject:Date;
        b=a14FKHHwcTjWYWnzehgbsdiYGHNzwjP00zbsL9eGdhHuTmH8jCym6eJVT/XbZOiqh
         ymyE6X61X3egQH+ZSNgJaMY+2iC3pGnHJN6NyrnsY3PgX3HGkV+Bx/eDdbmjGLdnuO
         28wnxAq8PAdbtmv8yfCqFGWCF6UsQ7X6tuzY12CYcbzl4sFO+pZsai1s9vfdjKUBGy
         HGvKCw6hsvW6NnGHOdw9LwcKdjX1U536G9q8hIuH4sa3cPzIsPzIzaRxg33zA0+v5c
         3jrLHjB15ONiAdamB+SH7BO6We2SgAu6N6TXpSwnBPMF/vzAmckRMpNnf5wemnq8Dv
         5vdP4MxawnEcA==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 1/4] serial: 8250: allow use of non-runtime configured uart ports
Date:   Tue, 25 Oct 2022 09:39:41 +0200
Message-Id: <20221025073944.102437-1-martin@geanix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The logic to find unused ports when registering new 8250 uart ports
searches only up to CONFIG_SERIAL_8250_RUNTIME_UARTS, which forces users
of external 8250 ports to increase the number of runtime ports
artificially.

Fix this by initializing each allocated port structure with basic
settings like line number and uart operation callbacks, and by searching
the entire array of allocated ports to find an unused one.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/tty/serial/8250/8250_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94fbf0add2ce..a166cc66e7d1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -500,7 +500,7 @@ static void __init serial8250_isa_init_ports(void)
 	if (nr_uarts > UART_NR)
 		nr_uarts = UART_NR;
 
-	for (i = 0; i < nr_uarts; i++) {
+	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 		struct uart_port *port = &up->port;
 
@@ -926,15 +926,16 @@ static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_
 
 	/* try line number first if still available */
 	i = port->line;
-	if (i < nr_uarts && serial8250_ports[i].port.type == PORT_UNKNOWN &&
+	if (i < UART_NR && serial8250_ports[i].port.type == PORT_UNKNOWN &&
 			serial8250_ports[i].port.iobase == 0)
 		return &serial8250_ports[i];
+
 	/*
 	 * We didn't find a matching entry, so look for the first
 	 * free entry.  We look for one which hasn't been previously
 	 * used (indicated by zero iobase).
 	 */
-	for (i = 0; i < nr_uarts; i++)
+	for (i = 0; i < UART_NR; i++)
 		if (serial8250_ports[i].port.type == PORT_UNKNOWN &&
 		    serial8250_ports[i].port.iobase == 0)
 			return &serial8250_ports[i];
@@ -943,7 +944,7 @@ static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_
 	 * That also failed.  Last resort is to find any entry which
 	 * doesn't have a real port associated with it.
 	 */
-	for (i = 0; i < nr_uarts; i++)
+	for (i = 0; i < UART_NR; i++)
 		if (serial8250_ports[i].port.type == PORT_UNKNOWN)
 			return &serial8250_ports[i];
 
-- 
2.38.1

