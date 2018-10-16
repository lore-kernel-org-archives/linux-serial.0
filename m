From: <shubhrajyoti.datta@gmail.com>
Subject: [LINUX PATCHv3 7/9] serial-uartlite: Use allocated structure instead of static ones
Date: Tue, 16 Oct 2018 15:48:06 +0530
Message-ID: <1539685088-13465-8-git-send-email-shubhrajyoti.datta@gmail.com>
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

Remove the use of the static uartlite structure.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 9c99a1d9..20fe11f 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -670,7 +670,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 #endif
 
 	/* Register the port */
-	rc = uart_add_one_port(&ulite_uart_driver, port);
+	rc = uart_add_one_port(pdata->ulite_uart_driver, port);
 	if (rc) {
 		dev_err(dev, "uart_add_one_port() failed; err=%i\n", rc);
 		port->mapbase = 0;
@@ -681,7 +681,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
 	if (console_port == port &&
-	    !(ulite_uart_driver->cons->flags & CON_ENABLED))
+	    !(pdata->ulite_uart_driver->cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
-- 
2.1.1
