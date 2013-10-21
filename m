From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 2/3] tty: xuartps: Fix build error due to missing forward declaration
Date: Mon, 21 Oct 2013 16:41:00 -0700
Message-ID: <1382398861-21542-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1382398861-21542-1-git-send-email-soren.brinkmann@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382398861-21542-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

If CONFIG_PM_SLEEP is enabled and CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
is not, a forward declaration of the uart_driver struct is not
included, leading to a build error due to an undeclared variable.
Fixing this by moving the definition of the struct uart_driver before
the definition of the suspend/resume callbacks.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 5ac6c480df43..ca4a2f1fbca9 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1198,6 +1198,20 @@ console_initcall(xuartps_console_init);
 
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
+/** Structure Definitions
+ */
+static struct uart_driver xuartps_uart_driver = {
+	.owner		= THIS_MODULE,		/* Owner */
+	.driver_name	= XUARTPS_NAME,		/* Driver name */
+	.dev_name	= XUARTPS_TTY_NAME,	/* Node name */
+	.major		= XUARTPS_MAJOR,	/* Major number */
+	.minor		= XUARTPS_MINOR,	/* Minor number */
+	.nr		= XUARTPS_NR_PORTS,	/* Number of UART ports */
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+	.cons		= &xuartps_console,	/* Console */
+#endif
+};
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * xuartps_suspend - suspend event
@@ -1311,20 +1325,6 @@ static int xuartps_resume(struct device *device)
 
 static SIMPLE_DEV_PM_OPS(xuartps_dev_pm_ops, xuartps_suspend, xuartps_resume);
 
-/** Structure Definitions
- */
-static struct uart_driver xuartps_uart_driver = {
-	.owner		= THIS_MODULE,		/* Owner */
-	.driver_name	= XUARTPS_NAME,		/* Driver name */
-	.dev_name	= XUARTPS_TTY_NAME,	/* Node name */
-	.major		= XUARTPS_MAJOR,	/* Major number */
-	.minor		= XUARTPS_MINOR,	/* Minor number */
-	.nr		= XUARTPS_NR_PORTS,	/* Number of UART ports */
-#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-	.cons		= &xuartps_console,	/* Console */
-#endif
-};
-
 /* ---------------------------------------------------------------------
  * Platform bus binding
  */
-- 
1.8.4.1
