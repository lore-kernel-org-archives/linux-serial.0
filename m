From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/3] serial: vt8500_serial: make it explicitly non-modular
Date: Mon, 20 Jun 2016 18:55:04 -0400
Message-ID: <20160620225505.7320-3-paul.gortmaker@windriver.com>
References: <20160620225505.7320-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160620225505.7320-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Tony Prisk <linux@prisktech.co.nz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alexey Charkov <alchark@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/tty/serial/Kconfig:config SERIAL_VT8500
drivers/tty/serial/Kconfig:     bool "VIA VT8500 on-chip serial port support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/vt8500_serial.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index b384060e3b1f..23cfc5e16b45 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -21,7 +21,6 @@
 
 #include <linux/hrtimer.h>
 #include <linux/delay.h>
-#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
@@ -730,22 +729,12 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int vt8500_serial_remove(struct platform_device *pdev)
-{
-	struct vt8500_port *vt8500_port = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(vt8500_port->clk);
-	uart_remove_one_port(&vt8500_uart_driver, &vt8500_port->uart);
-
-	return 0;
-}
-
 static struct platform_driver vt8500_platform_driver = {
 	.probe  = vt8500_serial_probe,
-	.remove = vt8500_serial_remove,
 	.driver = {
 		.name = "vt8500_serial",
 		.of_match_table = wmt_dt_ids,
+		.suppress_bind_attrs = true,
 	},
 };
 
@@ -764,19 +753,4 @@ static int __init vt8500_serial_init(void)
 
 	return ret;
 }
-
-static void __exit vt8500_serial_exit(void)
-{
-#ifdef CONFIG_SERIAL_VT8500_CONSOLE
-	unregister_console(&vt8500_console);
-#endif
-	platform_driver_unregister(&vt8500_platform_driver);
-	uart_unregister_driver(&vt8500_uart_driver);
-}
-
-module_init(vt8500_serial_init);
-module_exit(vt8500_serial_exit);
-
-MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
-MODULE_DESCRIPTION("Driver for vt8500 serial device");
-MODULE_LICENSE("GPL v2");
+device_initcall(vt8500_serial_init);
-- 
2.8.4
