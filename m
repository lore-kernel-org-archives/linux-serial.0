From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] 8250: add OMAP wakeup-enable register
Date: Thu, 14 May 2009 16:50:31 -0700
Message-ID: <1242345031-26775-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:51554 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbZENXuc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 May 2009 19:50:32 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 include/linux/serial_reg.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 96c0d93..850db2e 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -323,6 +323,7 @@
 #define UART_OMAP_MVER		0x14	/* Module version register */
 #define UART_OMAP_SYSC		0x15	/* System configuration register */
 #define UART_OMAP_SYSS		0x16	/* System status register */
+#define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
1.6.2.2

