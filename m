Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4BFC4332F
	for <linux-serial@archiver.kernel.org>; Thu, 13 Oct 2022 08:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJMIZq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJMIZp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Oct 2022 04:25:45 -0400
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Oct 2022 01:25:41 PDT
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1F9BE0C
        for <linux-serial@vger.kernel.org>; Thu, 13 Oct 2022 01:25:40 -0700 (PDT)
Received: from xps.lan (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id 5487214014D;
        Thu, 13 Oct 2022 08:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1665649073; bh=IV/De8+ALYMctYGGtVoa1YOHt96F1KUg8Fig3NwI23U=;
        h=From:To:Cc:Subject:Date;
        b=Qxa9+AHIAqA1QDnZJ0IhW+hyz+dHqa3H/K7/ZPekmx2saXnqwnp196Ts7GqHioHkF
         EONH8Mx2AAdxEromZEOL7xxr3CFSG1f0o7epVrahbZ0uycLWg4LPqdksb+9W9jHNzE
         im34xilEexGqEDDXX6PvMeuNlDmSbYrX5Mv+0FNg+wfVjh6ZbgZGykJWbrDQvY+SQy
         QDz5F8ZsVzbr4fpTn9lsSR3IYqMLaN39H8+DJbLo2qisgQhO0fGN2l5Dht7cY/IWwp
         LBpBOz9oy4PLZ9MPn9Tla55Z6gw1vL/1ba5o2VTyiAl/0Le7IQAovLQZblKtI4W2vq
         rJyJMkKcGYz9g==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] serial: 8250: allow use of non-runtime configured uart ports
Date:   Thu, 13 Oct 2022 10:17:46 +0200
Message-Id: <20221013081748.25699-1-martin@geanix.com>
X-Mailer: git-send-email 2.38.0
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
2.38.0

