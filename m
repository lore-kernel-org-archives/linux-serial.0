Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F5C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 18 Oct 2022 13:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiJRNem (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJRNek (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Oct 2022 09:34:40 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA976567
        for <linux-serial@vger.kernel.org>; Tue, 18 Oct 2022 06:34:32 -0700 (PDT)
Received: from xps.skovby (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id 889B0579A4;
        Tue, 18 Oct 2022 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1666100068; bh=IV/De8+ALYMctYGGtVoa1YOHt96F1KUg8Fig3NwI23U=;
        h=From:To:Cc:Subject:Date;
        b=A5l09l0jk6bDhPYL2C+WEPnWYOrLuT0T413l3858GzErLg/0Z9VgHfNdpRthuIokj
         YIExEgSDeo8sOhRfZ49ofIZm33ACsvWDY3T/qGe3LTTFTfTjH9CGeEpy4ArKiWx8XN
         pVcwky0v1Wk4rBPTQj7M5CsHQUtEnStn3CTTyH393SWoyyAO8LxV1Du4xJLRFNVQWm
         lF3xmaE2gXUR+BRSQCxw20XQ3KVpvt3rBzSvOgIt2PUopovz9q1l63Ho1kWz6K43v+
         3wJybGtMMYWjA7SO9q9wBqwRYSYFAqpCFC9kHuzOMqW0HAA2b4+mpree2gEl3a4WU2
         i9gO5eBK2+x7Q==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/3] serial: 8250: allow use of non-runtime configured uart ports
Date:   Tue, 18 Oct 2022 15:34:17 +0200
Message-Id: <20221018133419.134110-1-martin@geanix.com>
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

