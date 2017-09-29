From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 2/2] serial: sh-sci: Support for HSCIF RX sampling point adjustment
Date: Fri, 29 Sep 2017 15:08:54 +0200
Message-ID: <1506690534-27302-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: wsa@the-dreams.de, linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

HSCIF has facilities that allow moving the RX sampling point by between
-8 and 7 sampling cycles (one sampling cycles equals 1/15 of a bit
by default) to improve the error margin in case of slightly mismatched
bit rates between sender and receiver.

This patch allows changing the default (0, meaning center) using the
sysfs attribute "rx_sampling_point".

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 62 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/tty/serial/sh-sci.h |  4 +++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 41bf910..924a393 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -153,6 +153,7 @@ struct sci_port {
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
 	u16				hscif_tot;
+	u16				hscif_srhp;
 
 	bool has_rtscts;
 	bool autorts;
@@ -992,6 +993,42 @@ static int sci_handle_breaks(struct uart_port *port)
 	return copied;
 }
 
+static ssize_t rx_sampling_point_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct sci_port *sci = to_sci_port(port);
+
+	return sprintf(buf, "%d\n", sci->hscif_srhp);
+}
+
+static ssize_t rx_sampling_point_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t count)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct sci_port *sci = to_sci_port(port);
+	int ret;
+	long r;
+
+	ret = kstrtol(buf, 0, &r);
+	if (ret)
+		return ret;
+
+	if (r < -8 || r > 7)
+		return -EINVAL;
+
+	sci->hscif_srhp = r;
+
+	return count;
+}
+
+static DEVICE_ATTR(rx_sampling_point, 0644,
+		   rx_sampling_point_show,
+		   rx_sampling_point_store);
+
 static int scif_set_rtrg(struct uart_port *port, int rx_trig)
 {
 	unsigned int bits;
@@ -2378,8 +2415,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
 		serial_port_out(port, SCSMR, smr_val);
 		serial_port_out(port, SCBRR, brr);
-		if (sci_getreg(port, HSSRR)->size)
-			serial_port_out(port, HSSRR, srr | HSCIF_SRE);
 
 		/* Wait one bit interval */
 		udelay((1000000 + (baud - 1)) / baud);
@@ -2393,6 +2428,18 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_port_out(port, SCSMR, smr_val);
 	}
 
+	if (sci_getreg(port, HSSRR)->size) {
+		u16 hssrr = srr | HSCIF_SRE;
+
+		if (s->hscif_srhp) {
+			u16 srhp = (s->hscif_srhp << HSCIF_SRHP_SHIFT) &
+				   HSCIF_SRHP_MASK;
+
+			hssrr |= HSCIF_SRDE | srhp;
+		}
+		serial_port_out(port, HSSRR, hssrr);
+	}
+
 	sci_init_pins(port, termios->c_cflag);
 
 	port->status &= ~UPSTAT_AUTOCTS;
@@ -2793,6 +2840,7 @@ static int sci_init_single(struct platform_device *dev,
 
 	sci_port->rx_fifo_timeout = 0;
 	sci_port->hscif_tot = 0;
+	sci_port->hscif_shrp = 0;
 
 	/* SCIFA on sh7723 and sh7724 need a custom sampling rate that doesn't
 	 * match the SoC datasheet, this should be investigated. Let platform
@@ -3013,6 +3061,10 @@ static int sci_remove(struct platform_device *dev)
 		sysfs_remove_file(&dev->dev.kobj,
 				  &dev_attr_rx_fifo_timeout.attr);
 	}
+	if (port->port.type == PORT_HSCIF) {
+		sysfs_remove_file(&dev->dev.kobj,
+				  &dev_attr_rx_sampling_point.attr);
+	}
 
 	return 0;
 }
@@ -3206,6 +3258,12 @@ static int sci_probe(struct platform_device *dev)
 			return ret;
 		}
 	}
+	if (sp->port.type == PORT_HSCIF) {
+		ret = sysfs_create_file(&dev->dev.kobj,
+				&dev_attr_rx_sampling_point.attr);
+		if (ret)
+			return ret;
+	}
 
 #ifdef CONFIG_SH_STANDARD_BIOS
 	sh_bios_gdb_detach();
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 2b708cc..80958b2 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -129,6 +129,10 @@ enum {
 
 /* HSSRR HSCIF */
 #define HSCIF_SRE	BIT(15)	/* Sampling Rate Register Enable */
+#define HSCIF_SRDE	BIT(14)	/* Sampling Point Register Enable */
+
+#define HSCIF_SRHP_SHIFT	8
+#define HSCIF_SRHP_MASK		0x0f00
 
 /* SCPCR (Serial Port Control Register), SCIFA/SCIFB only */
 #define SCPCR_RTSC	BIT(4)	/* Serial Port RTS# Pin / Output Pin */
-- 
2.7.4
