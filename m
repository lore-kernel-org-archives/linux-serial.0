From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 2/4] serial: uartps: Check if the device is a console
Date: Tue, 18 Dec 2018 13:18:40 +0100
Message-ID: <863488c6f6d7f3d8c53d46f442f25ec2f46ee651.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
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

Changes in v2: None

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
