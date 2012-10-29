From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/3] uart: add other serial core layer get attributes
Date: Mon, 29 Oct 2012 15:20:40 +0000
Message-ID: <20121029152035.9451.29163.stgit@localhost.localdomain>
References: <20121029151901.9451.41783.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58109 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759053Ab2J2PTW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Oct 2012 11:19:22 -0400
In-Reply-To: <20121029151901.9451.41783.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 Documentation/ABI/testing/sysfs-tty |  112 +++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c    |  145 +++++++++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index 0c43015..c0e2471 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -26,3 +26,115 @@ Description:
 		 UART port in serial_core, that is bound to TTY like ttyS0.
 		 uartclk = 16 * baud_base
 
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/type
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Shows the current tty type for this port.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/line
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Shows the current tty line number for this port.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/port
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Shows the current tty port I/O address for this port.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/irq
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Shows the current primary interrupt for this port.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/flags
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Show the tty port status flags for this port.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/xmit_fifo_size
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Show the transmit FIFO size for this port.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/close_delay
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Show the closing delay time for this port in ms.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/closing_wait
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Show the close wait time for this port in ms.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/custom_divisor
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description: 
+		 Show the custom divisor if any that is set on this port.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/io_type
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Show the I/O type that is to be used with the iomem base
+		 address.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/iomem_base
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 The I/O memory base for this port.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyS0/iomem_reg_shift
+Date:		October 2012
+Contact:	Alan Cox <alan@linux.intel.com>
+Description:
+		 Show the register shift indicating the spacing to be used
+		 for accesses on this iomem address.
+
+		 These sysfs values expose the TIOCGSERIAL interface via
+		 sysfs rather than via ioctls.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0c4304e..d3dd4ad 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2340,10 +2340,155 @@ static ssize_t uart_get_attr_uartclk(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.baud_base * 16);
 }
 
+static ssize_t uart_get_attr_type(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.type);
+}
+static ssize_t uart_get_attr_line(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.line);
+}
+
+static ssize_t uart_get_attr_port(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "0x%lX\n", (unsigned long)(tmp.port | (tmp.port_high << HIGH_BITS_OFFSET)));
+}
+
+static ssize_t uart_get_attr_irq(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.irq);
+}
+
+static ssize_t uart_get_attr_flags(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "0x%X\n", tmp.flags);
+}
+
+static ssize_t uart_get_attr_xmit_fifo_size(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.xmit_fifo_size);
+}
+
+
+static ssize_t uart_get_attr_close_delay(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.close_delay);
+}
+
+
+static ssize_t uart_get_attr_closing_wait(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.closing_wait);
+}
+
+static ssize_t uart_get_attr_custom_divisor(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.custom_divisor);
+}
+
+static ssize_t uart_get_attr_io_type(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.io_type);
+}
+
+static ssize_t uart_get_attr_iomem_base(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "0x%lX\n", (unsigned long)tmp.iomem_base);
+}
+
+static ssize_t uart_get_attr_iomem_reg_shift(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct serial_struct tmp;
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	uart_get_info(port, &tmp);
+	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.iomem_reg_shift);
+}
+
+static DEVICE_ATTR(type, S_IRUSR | S_IRGRP, uart_get_attr_type, NULL);
+static DEVICE_ATTR(line, S_IRUSR | S_IRGRP, uart_get_attr_line, NULL);
+static DEVICE_ATTR(port, S_IRUSR | S_IRGRP, uart_get_attr_port, NULL);
+static DEVICE_ATTR(irq, S_IRUSR | S_IRGRP, uart_get_attr_irq, NULL);
+static DEVICE_ATTR(flags, S_IRUSR | S_IRGRP, uart_get_attr_flags, NULL);
+static DEVICE_ATTR(xmit_fifo_size, S_IRUSR | S_IRGRP, uart_get_attr_xmit_fifo_size, NULL);
 static DEVICE_ATTR(uartclk, S_IRUSR | S_IRGRP, uart_get_attr_uartclk, NULL);
+static DEVICE_ATTR(close_delay, S_IRUSR | S_IRGRP, uart_get_attr_close_delay, NULL);
+static DEVICE_ATTR(closing_wait, S_IRUSR | S_IRGRP, uart_get_attr_closing_wait, NULL);
+static DEVICE_ATTR(custom_divisor, S_IRUSR | S_IRGRP, uart_get_attr_custom_divisor, NULL);
+static DEVICE_ATTR(io_type, S_IRUSR | S_IRGRP, uart_get_attr_io_type, NULL);
+static DEVICE_ATTR(iomem_base, S_IRUSR | S_IRGRP, uart_get_attr_iomem_base, NULL);
+static DEVICE_ATTR(iomem_reg_shift, S_IRUSR | S_IRGRP, uart_get_attr_iomem_reg_shift, NULL);
 
 static struct attribute *tty_dev_attrs[] = {
+	&dev_attr_type.attr,
+	&dev_attr_line.attr,
+	&dev_attr_port.attr,
+	&dev_attr_irq.attr,
+	&dev_attr_flags.attr,
+	&dev_attr_xmit_fifo_size.attr,
 	&dev_attr_uartclk.attr,
+	&dev_attr_close_delay.attr,
+	&dev_attr_closing_wait.attr,
+	&dev_attr_custom_divisor.attr,
+	&dev_attr_io_type.attr,
+	&dev_attr_iomem_base.attr,
+	&dev_attr_iomem_reg_shift.attr,
 	NULL,
 	};
 

