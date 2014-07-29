From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 2/3] tty: omap-serial: use threaded interrupt handler
Date: Tue, 29 Jul 2014 16:52:56 +0200
Message-ID: <1406645577-18620-3-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:33642 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbaG2PFY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jul 2014 11:05:24 -0400
Received: from XSMCASSVR01.xsens-tech.local (rev-215.116.249.87.virtu.nl [87.249.116.215]) by filter1.ibarracuda.nl with ESMTP id GyqqfjEBGEwIOSOj (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <linux-serial@vger.kernel.org>; Tue, 29 Jul 2014 16:53:31 +0200 (CEST)
In-Reply-To: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Frans Klaver <frans.klaver@xsens.com>

At 3.6Mbaud, with slightly over 2Mbit/s data coming in, we see 1600 uart
rx buffer overflows within 30 seconds. Threading the interrupt handling reduces
this to about 170 overflows in 10 minutes.

In practice this therefore reduces the need for hardware flow control,
meaning the sending side doesn't have to buffer as much either.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/tty/serial/omap-serial.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index e454b7c..ff2d931 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -569,6 +569,21 @@ static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
 }
 
 /**
+ * serial_omap_fast_irq() - schedule interrupt handling
+ */
+static irqreturn_t serial_omap_fast_irq(int irq, void *dev_id)
+{
+	struct uart_omap_port *up = dev_id;
+	unsigned int iir = serial_in(up, UART_IIR);
+	if (iir & UART_IIR_NO_INT) {
+		return IRQ_NONE;
+	}
+
+	disable_irq_nosync(up->port.irq);
+	return IRQ_WAKE_THREAD;
+}
+
+/**
  * serial_omap_irq() - This handles the interrupt from one port
  * @irq: uart port irq number
  * @dev_id: uart port info
@@ -578,18 +593,12 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	struct uart_omap_port *up = dev_id;
 	unsigned int iir, lsr;
 	unsigned int type;
-	irqreturn_t ret = IRQ_NONE;
 	int max_count = 256;
 
 	spin_lock(&up->port.lock);
 	pm_runtime_get_sync(up->dev);
 
 	do {
-		iir = serial_in(up, UART_IIR);
-		if (iir & UART_IIR_NO_INT)
-			break;
-
-		ret = IRQ_HANDLED;
 		lsr = serial_in(up, UART_LSR);
 
 		/* extract IRQ type from IIR register */
@@ -618,17 +627,21 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 		default:
 			break;
 		}
+
+		iir = serial_in(up, UART_IIR);
 	} while (!(iir & UART_IIR_NO_INT) && max_count--);
 
 	spin_unlock(&up->port.lock);
 
 	tty_flip_buffer_push(&up->port.state->port);
 
+	enable_irq(up->port.irq);
+
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 	up->port_activity = jiffies;
 
-	return ret;
+	return IRQ_HANDLED;
 }
 
 static unsigned int serial_omap_tx_empty(struct uart_port *port)
@@ -725,15 +738,17 @@ static int serial_omap_startup(struct uart_port *port)
 	/*
 	 * Allocate the IRQ
 	 */
-	retval = request_irq(up->port.irq, serial_omap_irq, up->port.irqflags,
-				up->name, up);
+	retval = request_threaded_irq(up->port.irq, serial_omap_fast_irq,
+					serial_omap_irq, up->port.irqflags,
+					up->name, up);
 	if (retval)
 		return retval;
 
 	/* Optional wake-up IRQ */
 	if (up->wakeirq) {
-		retval = request_irq(up->wakeirq, serial_omap_irq,
-				     up->port.irqflags, up->name, up);
+		retval = request_threaded_irq(up->wakeirq, serial_omap_fast_irq,
+					serial_omap_irq, up->port.irqflags,
+					up->name, up);
 		if (retval) {
 			free_irq(up->port.irq, up);
 			return retval;
-- 
1.9.3

