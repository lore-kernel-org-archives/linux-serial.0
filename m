From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] serial: mfd: Add nmi_touch_watchdog() into the console write function
Date: Thu, 15 Nov 2012 16:03:16 +0800
Message-ID: <1352966596-4420-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12718 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992679Ab2KOID4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 03:03:56 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
Cc: Feng Tang <feng.tang@intel.com>

This is following what 8250 driver is doing in console write function,
to avoid the hardware lockup case.

v2: incldudes the <linux/nmi.h>

Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/mfd.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index c4b50af..79fe59b 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -36,6 +36,7 @@
 #include <linux/serial_mfd.h>
 #include <linux/dma-mapping.h>
 #include <linux/pci.h>
+#include <linux/nmi.h>
 #include <linux/io.h>
 #include <linux/debugfs.h>
 #include <linux/pm_runtime.h>
@@ -1113,6 +1114,8 @@ serial_hsu_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned int ier;
 	int locked = 1;
 
+	touch_nmi_watchdog();
+
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
-- 
1.7.9.5

