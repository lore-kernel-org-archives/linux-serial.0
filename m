From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH] serial: mfd: Add nmi_touch_watchdog() into the console write function
Date: Thu,  8 Nov 2012 14:10:53 +0800
Message-ID: <1352355053-30040-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13068 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab2KHGLd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Nov 2012 01:11:33 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
Cc: Feng Tang <feng.tang@intel.com>

This is following what 8250 driver is doing in console write function,
to avoid the hardware lockup case.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/tty/serial/mfd.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index c4b50af..bde9fce 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -1113,6 +1113,8 @@ serial_hsu_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned int ier;
 	int locked = 1;
 
+	touch_nmi_watchdog();
+
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
-- 
1.7.9.5

