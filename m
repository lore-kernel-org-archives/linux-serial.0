From: <shubhrajyoti.datta@gmail.com>
Subject: [LINUX PATCHv3 6/9] serial-uartlite: Change logic how console_port is setup
Date: Tue, 16 Oct 2018 15:48:05 +0530
Message-ID: <1539685088-13465-7-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, jacmet@sunsite.dk, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Change logic how console_port is setup by using CON_ENABLED flag
instead of index. There will be unique uart_console
structure that's why code can't use id for console_port
assignment.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 4a7989d..9c99a1d9 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -665,7 +665,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	 * If register_console() don't assign value, then console_port pointer
 	 * is cleanup.
 	 */
-	if (ulite_uart_driver.cons->index == -1)
+	if (!console_port)
 		console_port = port;
 #endif
 
@@ -680,7 +680,8 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
-	if (ulite_uart_driver.cons->index == -1)
+	if (console_port == port &&
+	    !(ulite_uart_driver->cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
@@ -859,6 +860,11 @@ static int ulite_remove(struct platform_device *pdev)
 
 	clk_unprepare(pdata->clk);
 	rc = ulite_release(&pdev->dev);
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+	if (console_port == port)
+		console_port = NULL;
+#endif
+
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.1.1
