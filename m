From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/76] OMAP: Enable Magic SysRq on serial console ttyOx
Date: Wed, 16 Mar 2011 14:11:34 -0700
Message-ID: <1300309966-5745-4-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32813 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754607Ab1CPVMw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:12:52 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Greg Kroah-Hartman <gregkh@suse.de>

From: Thomas Weber <weber@corscience.de>

Magic SysRq key is not working for OMAP on new serial
console ttyOx because SUPPORT_SYSRQ is not defined
for omap-serial.

This patch defines SUPPORT_SYSRQ in omap-serial and
enables handling of Magic SysRq character.

Further there is an issue of losing first break character.
Removing the reset of the lsr_break_flag fixes this issue.

Signed-off-by: Thomas Weber <weber@corscience.de>
Acked-by: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Manjunath G Kondaiah <manjugk@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/omap-serial.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7f2f010..699b344 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -20,6 +20,10 @@
  * this driver as required for the omap-platform.
  */
 
+#if defined(CONFIG_SERIAL_OMAP_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -190,7 +194,6 @@ static inline void receive_chars(struct uart_omap_port *up, int *status)
 			if (up->port.line == up->port.cons->index) {
 				/* Recover the break flag from console xmit */
 				lsr |= up->lsr_break_flag;
-				up->lsr_break_flag = 0;
 			}
 #endif
 			if (lsr & UART_LSR_BI)
-- 
1.7.4.1

