From: Joe Perches <joe@perches.com>
Subject: [PATCH] serial: samsung: Neaten dbg uses
Date: Tue, 20 May 2014 14:05:50 -0700
Message-ID: <1400619950.26709.39.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Jingoo Han <jg1.han@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Add format and argument checking and fix misuses in the dbg macro.

Add __printf
Use %pR for resource
Add #include guard to samsung.h
Move static functions from .h to .c
Use vscnprintf instead of length unguarded vsprintf

Signed-off-by: Joe Perches <joe@perches.com>
---

compiled (no warnings)/untested.

 drivers/tty/serial/samsung.c | 35 +++++++++++++++++++++++++++++------
 drivers/tty/serial/samsung.h | 23 +++--------------------
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 1f5505e..3293377 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -53,6 +53,29 @@
 
 #include "samsung.h"
 
+#if	defined(CONFIG_SERIAL_SAMSUNG_DEBUG) &&	\
+	defined(CONFIG_DEBUG_LL) &&		\
+	!defined(MODULE)
+
+extern void printascii(const char *);
+
+__printf(1, 2)
+static void dbg(const char *fmt, ...)
+{
+	va_list va;
+	char buff[256];
+
+	va_start(va, fmt);
+	vscnprintf(buff, sizeof(buf), fmt, va);
+	va_end(va);
+
+	printascii(buff);
+}
+
+#else
+#define dbg(fmt, ...) do { if (0) no_printk(fmt, ##__VA_ARGS__); } while (0)
+#endif
+
 /* UART name and device definitions */
 
 #define S3C24XX_SERIAL_NAME	"ttySAC"
@@ -468,8 +491,8 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	int ret;
 
-	dbg("s3c24xx_serial_startup: port=%p (%08lx,%p)\n",
-	    port->mapbase, port->membase);
+	dbg("s3c24xx_serial_startup: port=%p (%08llx,%p)\n",
+	    port, (unsigned long long)port->mapbase, port->membase);
 
 	rx_enabled(port) = 1;
 
@@ -514,8 +537,8 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	int ret;
 
-	dbg("s3c64xx_serial_startup: port=%p (%08lx,%p)\n",
-	    port->mapbase, port->membase);
+	dbg("s3c64xx_serial_startup: port=%p (%08llx,%p)\n",
+	    port, (unsigned long long)port->mapbase, port->membase);
 
 	wr_regl(port, S3C64XX_UINTM, 0xf);
 
@@ -1160,7 +1183,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		return -EINVAL;
 	}
 
-	dbg("resource %p (%lx..%lx)\n", res, res->start, res->end);
+	dbg("resource %pR)\n", res);
 
 	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
 	if (!port->membase) {
@@ -1203,7 +1226,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		wr_regl(port, S3C64XX_UINTSP, 0xf);
 	}
 
-	dbg("port: map=%08x, mem=%08x, irq=%d (%d,%d), clock=%ld\n",
+	dbg("port: map=%08x, mem=%p, irq=%d (%d,%d), clock=%u\n",
 	    port->mapbase, port->membase, port->irq,
 	    ourport->rx_irq, ourport->tx_irq, port->uartclk);
 
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 8827e54..eb071dd 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -1,3 +1,6 @@
+#ifndef __SAMSUNG_H
+#define __SAMSUNG_H
+
 /*
  * Driver for Samsung SoC onboard UARTs.
  *
@@ -77,24 +80,4 @@ struct s3c24xx_uart_port {
 #define wr_regb(port, reg, val) __raw_writeb(val, portaddr(port, reg))
 #define wr_regl(port, reg, val) __raw_writel(val, portaddr(port, reg))
 
-#if defined(CONFIG_SERIAL_SAMSUNG_DEBUG) && \
-    defined(CONFIG_DEBUG_LL) && \
-    !defined(MODULE)
-
-extern void printascii(const char *);
-
-static void dbg(const char *fmt, ...)
-{
-	va_list va;
-	char buff[256];
-
-	va_start(va, fmt);
-	vsprintf(buff, fmt, va);
-	va_end(va);
-
-	printascii(buff);
-}
-
-#else
-#define dbg(x...) do { } while (0)
 #endif
