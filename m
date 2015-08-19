From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/5] drivers/tty: make serial/mpsc.c driver explicitly non-modular
Date: Wed, 19 Aug 2015 17:48:08 -0400
Message-ID: <1440020889-12120-5-git-send-email-paul.gortmaker@windriver.com>
References: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig for this driver is currently:

config SERIAL_MPSC
        bool "Marvell MPSC serial port support"

...meaning that it currently is not being built as a module by anyone.
Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We leave some tags like MODULE_AUTHOR for documentation purposes.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/mpsc.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index 82bb6d1fe23b..edb32e3f1e84 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -55,8 +55,6 @@
 #define SUPPORT_SYSRQ
 #endif
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/ioport.h>
@@ -2108,24 +2106,8 @@ static int mpsc_drv_probe(struct platform_device *dev)
 	return rc;
 }
 
-static int mpsc_drv_remove(struct platform_device *dev)
-{
-	pr_debug("mpsc_drv_exit: Removing MPSC %d\n", dev->id);
-
-	if (dev->id < MPSC_NUM_CTLRS) {
-		uart_remove_one_port(&mpsc_reg, &mpsc_ports[dev->id].port);
-		mpsc_release_port((struct uart_port *)
-				&mpsc_ports[dev->id].port);
-		mpsc_drv_unmap_regs(&mpsc_ports[dev->id]);
-		return 0;
-	} else {
-		return -ENODEV;
-	}
-}
-
 static struct platform_driver mpsc_driver = {
 	.probe	= mpsc_drv_probe,
-	.remove	= mpsc_drv_remove,
 	.driver	= {
 		.name	= MPSC_CTLR_NAME,
 	},
@@ -2156,22 +2138,10 @@ static int __init mpsc_drv_init(void)
 
 	return rc;
 }
+device_initcall(mpsc_drv_init);
 
-static void __exit mpsc_drv_exit(void)
-{
-	platform_driver_unregister(&mpsc_driver);
-	platform_driver_unregister(&mpsc_shared_driver);
-	uart_unregister_driver(&mpsc_reg);
-	memset(mpsc_ports, 0, sizeof(mpsc_ports));
-	memset(&mpsc_shared_regs, 0, sizeof(mpsc_shared_regs));
-}
-
-module_init(mpsc_drv_init);
-module_exit(mpsc_drv_exit);
-
+/*
 MODULE_AUTHOR("Mark A. Greer <mgreer@mvista.com>");
 MODULE_DESCRIPTION("Generic Marvell MPSC serial/UART driver");
-MODULE_VERSION(MPSC_VERSION);
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CHARDEV_MAJOR(MPSC_MAJOR);
-MODULE_ALIAS("platform:" MPSC_CTLR_NAME);
+*/
-- 
2.5.0
