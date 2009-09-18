From: sonic zhang <sonic.adi@gmail.com>
Subject: [PATCH][bfin-sport-uart] Walk around RX underflow hardware issue
	in 32-bit SPORT RX reading
Date: Fri, 18 Sep 2009 17:05:47 +0800
Message-ID: <1253264747.22138.2.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:20309 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZIRJEs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Sep 2009 05:04:48 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>

Disable local interrupts in 32-bit reading from SPORT RX MMR to walk
around the RX underflow hardware issue when this reading is interrupted
by the other IRQ.


Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/serial/bfin_sport_uart.h |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/bfin_sport_uart.h b/drivers/serial/bfin_sport_uart.h
index 671d41c..46e793e 100644
--- a/drivers/serial/bfin_sport_uart.h
+++ b/drivers/serial/bfin_sport_uart.h
@@ -43,7 +43,20 @@
 #define SPORT_GET_TFSDIV(sport)		bfin_read16(((sport)->port.membase + OFFSET_TFSDIV))
 #define SPORT_GET_TX(sport)		bfin_read16(((sport)->port.membase + OFFSET_TX))
 #define SPORT_GET_RX(sport)		bfin_read16(((sport)->port.membase + OFFSET_RX))
-#define SPORT_GET_RX32(sport)		bfin_read32(((sport)->port.membase + OFFSET_RX))
+/*
+ * Disable local interrupt to walk around the fake RX underflow error
+ * when do 32-bit reading from RX fifois interrupted by other interrupt.
+ * This is a possible hardware anomaly. After it is logged officially,
+ * the official anomaly id should be listed bellow.
+ */
+#define SPORT_GET_RX32(sport)  \
+({                             \
+	unsigned int __ret;             \
+	local_irq_disable();    \
+	__ret = bfin_read32(((sport)->port.membase + OFFSET_RX));       \
+	local_irq_enable();     \
+	__ret;                  \
+})
 #define SPORT_GET_RCR1(sport)		bfin_read16(((sport)->port.membase + OFFSET_RCR1))
 #define SPORT_GET_RCR2(sport)		bfin_read16(((sport)->port.membase + OFFSET_RCR2))
 #define SPORT_GET_RCLKDIV(sport)	bfin_read16(((sport)->port.membase + OFFSET_RCLKDIV))
-- 
1.6.0



