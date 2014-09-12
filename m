From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [RFC 3/3] serial: sh-sci: make RX FIFO trigger tunable via sysfs
Date: Fri, 12 Sep 2014 10:51:48 +0200
Message-ID: <1410511908-9282-4-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1410511908-9282-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1410511908-9282-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org
Cc: horms@verge.net.au, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Allows tuning of the RX FIFO interrupt threshold in case there are
problems with buffer overruns or latency.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 78aeec1..a72ba5c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1913,6 +1913,30 @@ static void scif_set_rtrg(struct uart_port *port)
 	serial_port_out(port, SCFCR, serial_port_in(port, SCFCR) | bits);
 }
 
+static ssize_t rx_trigger_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct sci_port *sci = to_sci_port(port);
+	return sprintf(buf, "%d\n", sci->rx_trigger);
+}
+
+static ssize_t rx_trigger_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t count)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct sci_port *sci = to_sci_port(port);
+	int r = simple_strtol(buf, NULL, 0);
+	sci->rx_trigger = r;
+	scif_set_rtrg(port);
+	return count;
+}
+
+static DEVICE_ATTR(rx_trigger_level, 0644, rx_trigger_show, rx_trigger_store);
+
 static void sci_reset(struct uart_port *port)
 {
 	struct plat_sci_reg *reg;
@@ -2516,6 +2540,11 @@ static int sci_remove(struct platform_device *dev)
 
 	sci_cleanup_single(port);
 
+	if (port->port.fifosize > 1) {
+		sysfs_remove_file(&dev->dev.kobj,
+		                &dev_attr_rx_trigger_level.attr);
+	}
+
 	return 0;
 }
 
@@ -2660,6 +2689,13 @@ static int sci_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
+	if (sp->port.fifosize > 1) {
+		ret = sysfs_create_file(&dev->dev.kobj,
+				&dev_attr_rx_trigger_level.attr);
+		if (ret)
+			return ret;
+	}
+
 	sp->freq_transition.notifier_call = sci_notifier;
 
 	ret = cpufreq_register_notifier(&sp->freq_transition,
-- 
1.8.4.5

