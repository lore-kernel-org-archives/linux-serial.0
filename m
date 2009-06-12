From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH resend v3] UART regs: add OMAP wakeup-enable register
Date: Fri, 12 Jun 2009 10:41:26 -0700
Message-ID: <1244828486-13666-1-git-send-email-khilman@ti.deeprootsystems.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752271AbZFLRlk@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-serial@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Add the wakeup enable register to the list of OMAP-specific UART
registers.

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
