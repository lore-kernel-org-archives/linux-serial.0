From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 1/2] serial: sh-sci: Fix probe error paths
Date: Wed, 13 Jun 2012 00:28:23 +0200
Message-ID: <1339540104-25003-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:48096 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab2FLW2U (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Jun 2012 18:28:20 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org

When probing fails, the driver must not try to cleanup resources that
have not been initialized. Fix this.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c |   36 +++++++++++++++++++++++-------------
 1 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3158e17..a779663 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2140,6 +2140,16 @@ static int __devinit sci_init_single(struct platform_device *dev,
 	return 0;
 }
 
+static void sci_cleanup_single(struct sci_port *port)
+{
+	sci_free_gpios(port);
+
+	clk_put(port->iclk);
+	clk_put(port->fclk);
+
+	pm_runtime_disable(port->port.dev);
+}
+
 #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
 static void serial_console_putchar(struct uart_port *port, int ch)
 {
@@ -2321,14 +2331,10 @@ static int sci_remove(struct platform_device *dev)
 	cpufreq_unregister_notifier(&port->freq_transition,
 				    CPUFREQ_TRANSITION_NOTIFIER);
 
-	sci_free_gpios(port);
-
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	clk_put(port->iclk);
-	clk_put(port->fclk);
+	sci_cleanup_single(port);
 
-	pm_runtime_disable(&dev->dev);
 	return 0;
 }
 
@@ -2353,7 +2359,13 @@ static int __devinit sci_probe_single(struct platform_device *dev,
 	if (ret)
 		return ret;
 
-	return uart_add_one_port(&sci_uart_driver, &sciport->port);
+	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
+	if (ret) {
+		sci_cleanup_single(sciport);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int __devinit sci_probe(struct platform_device *dev)
@@ -2374,24 +2386,22 @@ static int __devinit sci_probe(struct platform_device *dev)
 
 	ret = sci_probe_single(dev, dev->id, p, sp);
 	if (ret)
-		goto err_unreg;
+		return ret;
 
 	sp->freq_transition.notifier_call = sci_notifier;
 
 	ret = cpufreq_register_notifier(&sp->freq_transition,
 					CPUFREQ_TRANSITION_NOTIFIER);
-	if (unlikely(ret < 0))
-		goto err_unreg;
+	if (unlikely(ret < 0)) {
+		sci_cleanup_single(sp);
+		return ret;
+	}
 
 #ifdef CONFIG_SH_STANDARD_BIOS
 	sh_bios_gdb_detach();
 #endif
 
 	return 0;
-
-err_unreg:
-	sci_remove(dev);
-	return ret;
 }
 
 static int sci_suspend(struct device *dev)
-- 
1.7.3.4

