From: Adrian Bunk <bunk@fs.tum.de>
Subject: [patch] serialP.h: remove a kernel 2.2 #ifdef
Date: Sun, 8 Feb 2004 02:28:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040208012822.GL7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: tytso@mit.edu, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The patch below removes a kernel 2.2 #ifdef from include/linux/serialP.h .

Please apply
Adrian


--- linux-2.6.2-mm1/include/linux/serialP.h.old	2004-02-08 02:25:01.000000000 +0100
+++ linux-2.6.2-mm1/include/linux/serialP.h	2004-02-08 02:25:22.000000000 +0100
@@ -26,11 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
 #include <linux/wait.h>
-#if (LINUX_VERSION_CODE < 0x020300)
-/* Unfortunate, but Linux 2.2 needs async_icount defined here and
- * it got moved in 2.3 */
-#include <linux/serial.h>
-#endif
 
 struct serial_state {
 	int	magic;
