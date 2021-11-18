Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7D2C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 21:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEDA61A81
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 21:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhKRVUz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 16:20:55 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:46736 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229944AbhKRVUy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 16:20:54 -0500
Received: from [176.199.209.39] (account willenberg@hs-mannheim.de HELO localhost.localdomain)
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55642082; Thu, 18 Nov 2021 22:17:52 +0100
From:   Ruediger Willenberg <r.willenberg@hs-mannheim.de>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, git@xilinx.com,
        shubhrajyoti.datta@xilinx.com, michal.simek@xilinx.com,
        Ruediger Willenberg <r.willenberg@hs-mannheim.de>
Subject: [PATCH v2] serial: uartlite: Move out-of-range port-numbers into ULITE_NR_UARTS range
Date:   Thu, 18 Nov 2021 22:17:45 +0100
Message-Id: <20211118211745.133778-1-r.willenberg@hs-mannheim.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
the device tree port-number property is outside that range. This
happens when there are other UART types in the system because the
Xilinx device tree generator numbers all UARTs consecutively;
as a result, not as many Uartlites as specified by the
SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.

Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
---
Changes in v2:
 - give KERN_NOTICE when changing the id,
   with reference to the requested port-number 

 drivers/tty/serial/uartlite.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index d3d9566e5dbd..27c513c7350e 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -631,15 +631,17 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 {
 	struct uart_port *port;
 	int rc;
+	int oor_id = -1;
 
-	/* if id = -1; then scan for a free id and use that */
-	if (id < 0) {
+	/* if id -1 or out of range; then scan for a free id and use that */
+	if (id < 0 || id >= ULITE_NR_UARTS) {
+		oor_id = id;
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
 
@@ -676,7 +678,11 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 		dev_set_drvdata(dev, NULL);
 		return rc;
 	}
-
+	if (oor_id >= 0)
+		dev_notice(dev,
+			"assigned uartlite with device tree port-number=<%i> to %s%i\n",
+			oor_id, ULITE_NAME, id);
+
 	return 0;
 }
 
-- 
2.25.1

