From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 53/68] TTY: simserial, fix includes
Date: Mon,  5 Mar 2012 14:52:40 +0100
Message-ID: <1330955575-26641-54-git-send-email-jslaby@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: linux-serial@vger.kernel.org

Use headers from linux/* instead of asm/. Remove declaration of
console_drivers, it's in linux/console.h already.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/ia64/hp/sim/simserial.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index d8237c3..24d6ca0 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -24,14 +24,13 @@
 #include <linux/capability.h>
 #include <linux/circ_buf.h>
 #include <linux/console.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/serial.h>
 #include <linux/sysrq.h>
+#include <linux/uaccess.h>
 
-#include <asm/irq.h>
 #include <asm/hpsim.h>
-#include <asm/hw_irq.h>
-#include <asm/uaccess.h>
 
 #include "hpsim_ssc.h"
 
@@ -57,8 +56,6 @@ struct tty_driver *hp_simserial_driver;
 
 static struct console *console;
 
-extern struct console *console_drivers; /* from kernel/printk.c */
-
 static void receive_chars(struct tty_struct *tty)
 {
 	unsigned char ch;
-- 
1.7.9.2
