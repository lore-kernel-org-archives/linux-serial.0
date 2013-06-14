From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH] serial: mfd: Add sysrq support
Date: Fri, 14 Jun 2013 18:11:17 +0800
Message-ID: <1371204677-5475-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17574 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab3FNKPb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 06:15:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, alan@linux.intel.com
Cc: Feng Tang <feng.tang@intel.com>

When using MFD HSU based console, sometime we need the sysrq function
to help debugging kernel. The sysrq code is basically there, this
patch just simply enable it.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/tty/serial/mfd.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 5f4765a..e266eca 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -21,6 +21,10 @@
  *    be triggered
  */
 
+#if defined(CONFIG_SERIAL_MFD_HSU_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
-- 
1.7.9.5

