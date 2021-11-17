Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F418AC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 22:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA09461B6F
	for <linux-serial@archiver.kernel.org>; Wed, 17 Nov 2021 22:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbhKQWTY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:19:24 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:48586 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241102AbhKQWTV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Nov 2021 17:19:21 -0500
Received: from [176.199.209.39] (account willenberg@hs-mannheim.de HELO localhost.localdomain)
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55622721; Wed, 17 Nov 2021 23:16:20 +0100
From:   Ruediger Willenberg <r.willenberg@hs-mannheim.de>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jacmet@sunsite.dk, git@xilinx.com,
        shubhrajyoti.datta@xilinx.com, michal.simek@xilinx.com,
        Ruediger Willenberg <r.willenberg@hs-mannheim.de>
Subject: [PATCH] serial: uartlite: Move out-of-range port-numbers into ULITE_NR_UARTS range
Date:   Wed, 17 Nov 2021 23:15:10 +0100
Message-Id: <20211117221510.11959-1-r.willenberg@hs-mannheim.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
the device tree port-number property is outside that range. This
can happen because the Xilinx device tree generator does not start
enumerating Uartlites at 0 when there are PS-UARTs or AXI 16550A
UARTs in the system; it then enumerates all UARTs consecutively
despite them having separate drivers with separate structures.
This has become more problematic since the Kconfig property
SERIAL_UARTLITE_NR_UARTS enables precise allocation of uart_port
structs, which can't be used if the port-number doesn't start at 0

Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
---
 drivers/tty/serial/uartlite.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index d3d9566e5dbd..546eecdb6033 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -632,14 +632,14 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	struct uart_port *port;
 	int rc;
 
-	/* if id = -1; then scan for a free id and use that */
-	if (id < 0) {
+	/* if id -1 or out of range; then scan for a free id and use that */
+	if (id < 0 || id >= ULITE_NR_UARTS) {
 		for (id = 0; id < ULITE_NR_UARTS; id++)
 			if (ulite_ports[id].mapbase == 0)
 				break;
 	}
-	if (id < 0 || id >= ULITE_NR_UARTS) {
-		dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
+	if (id == ULITE_NR_UARTS) {
+		dev_err(dev, "maximum number of %s assigned\n", ULITE_NAME);
 		return -EINVAL;
 	}
 
-- 
2.25.1

