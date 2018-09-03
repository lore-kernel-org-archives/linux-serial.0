From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v3 03/10] serial: uartps: Fix suspend functionality
Date: Mon,  3 Sep 2018 15:10:51 +0200
Message-ID: <26804ea4d2196674a30ddd7dccc068269816b882.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org
Cc: Nava kishore Manne <nava.manne@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

The driver's suspend/resume functions were buggy.
If UART node contains any child node in the DT and
the child is established a communication path with
the parent UART. The relevant /dev/ttyPS* node will
be not available for other operations.
If the driver is trying to do any operations like
suspend/resume without checking the tty->dev status
it leads to the kernel crash/hang.

This patch fix this issue by call the device_may_wake()
with the generic parameter of type struct device.
in the uart suspend and resume paths.

It also fixes a race condition in the uart suspend
path(i.e uart_suspend_port() should be called at the
end of cdns_uart_suspend API this path updates the same)

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- New patch - can be sent separately but there is dependency that's why
  sent in this series

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 41 +++++++++++---------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9a08542cec47..fc0ecaf3615d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1272,24 +1272,11 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 static int cdns_uart_suspend(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
-	struct tty_struct *tty;
-	struct device *tty_dev;
-	int may_wake = 0;
-
-	/* Get the tty which could be NULL so don't assume it's valid */
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		tty_dev = tty->dev;
-		may_wake = device_may_wakeup(tty_dev);
-		tty_kref_put(tty);
-	}
+	int may_wake;
 
-	/*
-	 * Call the API provided in serial_core.c file which handles
-	 * the suspend.
-	 */
-	uart_suspend_port(&cdns_uart_uart_driver, port);
-	if (!(console_suspend_enabled && !may_wake)) {
+	may_wake = device_may_wakeup(device);
+
+	if (console_suspend_enabled && may_wake) {
 		unsigned long flags = 0;
 
 		spin_lock_irqsave(&port->lock, flags);
@@ -1304,7 +1291,11 @@ static int cdns_uart_suspend(struct device *device)
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
-	return 0;
+	/*
+	 * Call the API provided in serial_core.c file which handles
+	 * the suspend.
+	 */
+	return uart_suspend_port(&cdns_uart_uart_driver, port);
 }
 
 /**
@@ -1318,17 +1309,9 @@ static int cdns_uart_resume(struct device *device)
 	struct uart_port *port = dev_get_drvdata(device);
 	unsigned long flags = 0;
 	u32 ctrl_reg;
-	struct tty_struct *tty;
-	struct device *tty_dev;
-	int may_wake = 0;
-
-	/* Get the tty which could be NULL so don't assume it's valid */
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		tty_dev = tty->dev;
-		may_wake = device_may_wakeup(tty_dev);
-		tty_kref_put(tty);
-	}
+	int may_wake;
+
+	may_wake = device_may_wakeup(device);
 
 	if (console_suspend_enabled && !may_wake) {
 		struct cdns_uart *cdns_uart = port->private_data;
-- 
1.9.1
