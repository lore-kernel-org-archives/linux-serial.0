From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: uartps: Check if the device is a console
Date: Wed,  5 Dec 2018 14:20:38 +0100
Message-ID: <ad7c37027afef738fcda5d978a73cc4c595ef412.1544016036.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

While checking for console_suspend_enabled also check if the
device is a console.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0140644391df..9cdc36be5b13 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1255,7 +1255,7 @@ static int cdns_uart_suspend(struct device *device)
 
 	may_wake = device_may_wakeup(device);
 
-	if (console_suspend_enabled && may_wake) {
+	if (console_suspend_enabled && uart_console(port) && may_wake) {
 		unsigned long flags = 0;
 
 		spin_lock_irqsave(&port->lock, flags);
@@ -1293,7 +1293,7 @@ static int cdns_uart_resume(struct device *device)
 
 	may_wake = device_may_wakeup(device);
 
-	if (console_suspend_enabled && !may_wake) {
+	if (console_suspend_enabled && uart_console(port) && !may_wake) {
 		clk_enable(cdns_uart->pclk);
 		clk_enable(cdns_uart->uartclk);
 
-- 
1.9.1
