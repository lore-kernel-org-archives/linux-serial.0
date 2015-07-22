From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/4] drivers/tty: make serial/sn_console.c driver explicitly non-modular
Date: Tue, 21 Jul 2015 22:02:15 -0400
Message-ID: <1437530538-5078-2-git-send-email-paul.gortmaker@windriver.com>
References: <1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig for this option is currently:

config SERIAL_SGI_L1_CONSOLE
    bool "SGI Altix L1 serial console support"

...meaning that it currently is not being built as a module by anyone.
Lets remove the orphaned module code, so that when reading the
driver there is no doubt it is builtin-only.  We could consider
making it tristate, but the above bool has been there since before
the start of git history, which isn't all that surprising, since
consoles are typically critical to have at early boot.  So adding
tristate is really of no value here.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/sn_console.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index 33e94e56dcdb..d4692d888e9d 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -42,7 +42,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
 #include <linux/console.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/circ_buf.h>
 #include <linux/serial_reg.h>
@@ -659,7 +659,7 @@ static void sn_sal_timer_poll(unsigned long data)
  * @port: Our sn_cons_port (which contains the uart port)
  *
  * So this is used by sn_sal_serial_console_init (early on, before we're
- * registered with serial core).  It's also used by sn_sal_module_init
+ * registered with serial core).  It's also used by sn_sal_init
  * right after we've registered with serial core.  The later only happens
  * if we didn't already come through here via sn_sal_serial_console_init.
  *
@@ -709,7 +709,7 @@ static void __init sn_sal_switch_to_asynch(struct sn_cons_port *port)
  * sn_sal_switch_to_interrupts - Switch to interrupt driven mode
  * @port: Our sn_cons_port (which contains the uart port)
  *
- * In sn_sal_module_init, after we're registered with serial core and
+ * In sn_sal_init, after we're registered with serial core and
  * the port is added, this function is called to switch us to interrupt
  * mode.  We were previously in asynch/polling mode (using init_timer).
  *
@@ -773,7 +773,7 @@ static struct uart_driver sal_console_uart = {
 };
 
 /**
- * sn_sal_module_init - When the kernel loads us, get us rolling w/ serial core
+ * sn_sal_init - When the kernel loads us, get us rolling w/ serial core
  *
  * Before this is called, we've been printing kernel messages in a special
  * early mode not making use of the serial core infrastructure.  When our
@@ -781,7 +781,7 @@ static struct uart_driver sal_console_uart = {
  * core and try to enable interrupt driven mode.
  *
  */
-static int __init sn_sal_module_init(void)
+static int __init sn_sal_init(void)
 {
 	int retval;
 
@@ -811,7 +811,7 @@ static int __init sn_sal_module_init(void)
 
 	if (uart_register_driver(&sal_console_uart) < 0) {
 		printk
-		    ("ERROR sn_sal_module_init failed uart_register_driver, line %d\n",
+		    ("ERROR sn_sal_init failed uart_register_driver, line %d\n",
 		     __LINE__);
 		return -ENODEV;
 	}
@@ -832,33 +832,19 @@ static int __init sn_sal_module_init(void)
 
 	/* when this driver is compiled in, the console initialization
 	 * will have already switched us into asynchronous operation
-	 * before we get here through the module initcalls */
+	 * before we get here through the initcalls */
 	if (!sal_console_port.sc_is_asynch) {
 		sn_sal_switch_to_asynch(&sal_console_port);
 	}
 
-	/* at this point (module_init) we can try to turn on interrupts */
+	/* at this point (device_init) we can try to turn on interrupts */
 	if (!IS_RUNNING_ON_SIMULATOR()) {
 		sn_sal_switch_to_interrupts(&sal_console_port);
 	}
 	sn_process_input = 1;
 	return 0;
 }
-
-/**
- * sn_sal_module_exit - When we're unloaded, remove the driver/port
- *
- */
-static void __exit sn_sal_module_exit(void)
-{
-	del_timer_sync(&sal_console_port.sc_timer);
-	uart_remove_one_port(&sal_console_uart, &sal_console_port.sc_port);
-	uart_unregister_driver(&sal_console_uart);
-	misc_deregister(&misc);
-}
-
-module_init(sn_sal_module_init);
-module_exit(sn_sal_module_exit);
+device_initcall(sn_sal_init);
 
 /**
  * puts_raw_fixed - sn_sal_console_write helper for adding \r's as required
-- 
2.2.1
