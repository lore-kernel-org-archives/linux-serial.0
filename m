From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 03/14] serial: earlycon: Emit earlycon name in the OF table
Date: Fri,  6 Mar 2015 14:25:19 -0500
Message-ID: <1425669930-22137-4-git-send-email-peter@hurleysoftware.com>
References: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The OF device name of the earlycon is never used because there is no
device; re-purpose the name field to store the earlycon name in
the OF earlycon table. Earlycon will use the table entry to
fixup the console name and index.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/serial_core.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8aeec49..c523785 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -29,6 +29,7 @@
 #include <linux/tty.h>
 #include <linux/mutex.h>
 #include <linux/sysrq.h>
+#include <linux/mod_devicetable.h>
 #include <uapi/linux/serial_core.h>
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
@@ -353,8 +354,18 @@ extern int of_setup_earlycon(unsigned long addr,
 		 = { .name  = __stringify(_name),			\
 		     .setup = func  }
 
-#define OF_EARLYCON_DECLARE(name, compat, fn)				\
-	_OF_DECLARE(earlycon, name, compat, fn, void *)
+#ifdef CONFIG_OF
+#define EARLYCON_OF_TABLE_ATTR __used __section(__earlycon_of_table)
+#else
+#define EARLYCON_OF_TABLE_ATTR __attribute__((unused))
+#endif
+
+#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
+	static const struct of_device_id __of_table_##_name		\
+		EARLYCON_OF_TABLE_ATTR					\
+		 = { .name = __stringify(_name),			\
+		     .compatible = compat,				\
+		     .data = (fn == (void *)NULL) ? fn : fn  }
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
-- 
2.3.1
