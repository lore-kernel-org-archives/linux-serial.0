From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 1/5] serial: sh-sci: Sort headers alphabetically
Date: Tue, 29 Oct 2013 11:29:55 +0100
Message-ID: <1383042599-25151-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:34719 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab3J2K3i (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Oct 2013 06:29:38 -0400
In-Reply-To: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

This helps locating duplicates.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5377502..280753f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -23,35 +23,35 @@
 
 #undef DEBUG
 
-#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/ctype.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/sh_dma.h>
-#include <linux/timer.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/serial.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/sysrq.h>
 #include <linux/ioport.h>
+#include <linux/major.h>
+#include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/console.h>
-#include <linux/platform_device.h>
-#include <linux/serial_sci.h>
 #include <linux/notifier.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/cpufreq.h>
-#include <linux/clk.h>
-#include <linux/ctype.h>
-#include <linux/err.h>
-#include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
+#include <linux/serial.h>
+#include <linux/serial_sci.h>
+#include <linux/sh_dma.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
+#include <linux/string.h>
+#include <linux/sysrq.h>
+#include <linux/timer.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 
 #ifdef CONFIG_SUPERH
 #include <asm/sh_bios.h>
-- 
1.8.1.5

