From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 1/2] tty: bfin-sport-uart: Rx interrupt is not called always with irq disabled.
Date: Tue, 6 Dec 2011 15:16:33 +0800
Message-ID: <1323155794-14696-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:6114
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932414Ab1LFHYZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Dec 2011 02:24:25 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Replace local_irq_disable by local_irq_save.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_sport_uart.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bfin_sport_uart.h b/drivers/tty/serial/bfin_sport_uart.h
index 6d06ce1..e4510ea 100644
--- a/drivers/tty/serial/bfin_sport_uart.h
+++ b/drivers/tty/serial/bfin_sport_uart.h
@@ -45,11 +45,12 @@
 #define SPORT_GET_RX32(sport) \
 ({ \
 	unsigned int __ret; \
+	unsigned long flags; \
 	if (ANOMALY_05000473) \
-		local_irq_disable(); \
+		local_irq_save(flags); \
 	__ret = bfin_read32((sport)->port.membase + OFFSET_RX); \
 	if (ANOMALY_05000473) \
-		local_irq_enable(); \
+		local_irq_restore(flags); \
 	__ret; \
 })
 #define SPORT_GET_RCR1(sport)		bfin_read16(((sport)->port.membase + OFFSET_RCR1))
-- 
1.7.0.4


