From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 6/7] serial: sh-sci: make RX FIFO parameters tunable via sysfs
Date: Mon, 23 Jan 2017 17:04:17 +0100
Message-ID: <1485187458-8195-7-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Allows tuning of the RX FIFO fill threshold and timeout. (The latter is
only applicable to SCIFA and SCIFB).

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 034041e..46b3e84 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1183,6 +1183,66 @@ static void rx_fifo_timer_fn(unsigned long arg)
 	scif_set_rtrg(port, 1);
 }
 
+static ssize_t rx_trigger_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct sci_port *sci = to_sci_port(port);
+
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
+	long r;
+
+	if (kstrtol(buf, 0, &r) == -EINVAL)
+		return -EINVAL;
+	sci->rx_trigger = scif_set_rtrg(port, r);
+	scif_set_rtrg(port, 1);
+	return count;
+}
+
+static DEVICE_ATTR(rx_fifo_trigger, 0644, rx_trigger_show, rx_trigger_store);
+
+static ssize_t rx_fifo_timeout_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct sci_port *sci = to_sci_port(port);
+
+	return sprintf(buf, "%d\n", sci->rx_fifo_timeout);
+}
+
+static ssize_t rx_fifo_timeout_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t count)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct sci_port *sci = to_sci_port(port);
+	long r;
+
+	if (kstrtol(buf, 0, &r) == -EINVAL)
+		return -EINVAL;
+	sci->rx_fifo_timeout = r;
+	scif_set_rtrg(port, 1);
+	if (r > 0)
+		setup_timer(&sci->rx_fifo_timer, rx_fifo_timer_fn,
+			    (unsigned long)sci);
+	return count;
+}
+
+static DEVICE_ATTR(rx_fifo_timeout, 0644, rx_fifo_timeout_show, rx_fifo_timeout_store);
+
+
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 static void sci_dma_tx_complete(void *arg)
 {
@@ -3030,6 +3090,15 @@ static int sci_remove(struct platform_device *dev)
 
 	sci_cleanup_single(port);
 
+	if (port->port.fifosize > 1) {
+		sysfs_remove_file(&dev->dev.kobj,
+				  &dev_attr_rx_fifo_trigger.attr);
+	}
+	if (port->port.type == PORT_SCIFA || port->port.type == PORT_SCIFB) {
+		sysfs_remove_file(&dev->dev.kobj,
+				  &dev_attr_rx_fifo_timeout.attr);
+	}
+
 	return 0;
 }
 
@@ -3195,6 +3264,24 @@ static int sci_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
+	if (sp->port.fifosize > 1) {
+		ret = sysfs_create_file(&dev->dev.kobj,
+				&dev_attr_rx_fifo_trigger.attr);
+		if (ret)
+			return ret;
+	}
+	if (sp->port.type == PORT_SCIFA || sp->port.type ==  PORT_SCIFB) {
+		ret = sysfs_create_file(&dev->dev.kobj,
+				&dev_attr_rx_fifo_timeout.attr);
+		if (ret) {
+			if (sp->port.fifosize > 1) {
+				sysfs_remove_file(&dev->dev.kobj,
+					&dev_attr_rx_fifo_trigger.attr);
+			}
+			return ret;
+		}
+	}
+
 #ifdef CONFIG_SH_STANDARD_BIOS
 	sh_bios_gdb_detach();
 #endif
-- 
2.7.4
