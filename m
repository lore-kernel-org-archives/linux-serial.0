From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] dz.c: Add and reorder inclusions, remove unneeded ones
Date: Fri, 19 Oct 2007 21:28:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0710192125470.13279@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:42181 "EHLO
	cerber.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbXJSU2X (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Oct 2007 16:28:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

 Sort the header inclusions, add a few that are needed but pulled 
indirectly only and remove ones that are not really used.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with checkpatch.pl and at the run-time -- MIPS/Linux on a 
DECstation 5000/200.

 Please apply,

  Maciej

patch-mips-2.6.18-20060920-dz-include-4
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/serial/dz.c linux-mips-2.6.18-20060920/drivers/serial/dz.c
--- linux-mips-2.6.18-20060920.macro/drivers/serial/dz.c	2006-11-23 05:17:01.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/serial/dz.c	2007-01-15 02:09:38.000000000 +0000
@@ -6,7 +6,7 @@
  *
  * Email: olivier.lebaillif@ifrsys.com
  *
- * Copyright (C) 2004, 2006  Maciej W. Rozycki
+ * Copyright (C) 2004, 2006, 2007  Maciej W. Rozycki
  *
  * [31-AUG-98] triemer
  * Changed IRQ to use Harald's dec internals interrupts.h
@@ -32,26 +32,29 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
+#include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/console.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/module.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
 
 #include <asm/bootinfo.h>
+#include <asm/system.h>
+
 #include <asm/dec/interrupts.h>
 #include <asm/dec/kn01.h>
 #include <asm/dec/kn02.h>
 #include <asm/dec/machtype.h>
 #include <asm/dec/prom.h>
-#include <asm/irq.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
 
 #include "dz.h"
 
