From: claudio@evidence.eu.com
Subject: [PATCH 3/3] atmel_serial: add generic TTGR support
Date: Mon, 11 Feb 2013 16:54:26 +0100
Message-ID: <1360598067-3577-4-git-send-email-claudio@evidence.eu.com>
References: <CAJa4H3fQ_khDVNcSu+39C+oZyc268YUgq9ahzt2ugk1_6eqYfw@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mr002msb.fastweb.it ([85.18.95.86]:50731 "EHLO
	mr002msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757607Ab3BKQBq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Feb 2013 11:01:46 -0500
In-Reply-To: <CAJa4H3fQ_khDVNcSu+39C+oZyc268YUgq9ahzt2ugk1_6eqYfw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: nicolas.ferre@atmel.com, clagix@gmail.com, Claudio Scordino <claudio@evidence.eu.com>

From: Claudio Scordino <claudio@evidence.eu.com>

This patch adds an entry in sys/ to get/set the TTGR register for this specific
driver.

When set greater than zero the driver will insert gaps between the sent
characters. The length of the gaps will be specified in bit times. The feature
can be used either in RS232 and RS485 mode to slow down transmission if the
receiving device is not capable to process incoming characters at line speed.

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Guido Classen <clagix@gmail.com>
Tested-by: Guido Classen <clagix@gmail.com>
---
 drivers/tty/serial/atmel_serial.c |   53 +++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 52648ec..df3d871 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -59,6 +59,9 @@
 #define SUPPORT_SYSRQ
 #endif
 
+/* Maximum value of TTGR according to Atmel datasheet */
+#define MAX_TTGR_VALUE		255
+
 #include <linux/serial_core.h>
 
 static void atmel_start_rx(struct uart_port *port);
@@ -99,6 +102,7 @@ static void atmel_stop_rx(struct uart_port *port);
 #define UART_PUT_BRGR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_BRGR)
 #define UART_PUT_RTOR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_RTOR)
 #define UART_PUT_TTGR(port, v)	__raw_writel(v, (port)->membase + ATMEL_US_TTGR)
+#define UART_GET_TTGR(port)	__raw_readl((port)->membase + ATMEL_US_TTGR)
 
  /* PDC registers */
 #define UART_PUT_PTCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_PTCR)
@@ -181,6 +185,14 @@ to_atmel_uart_port(struct uart_port *uart)
 	return container_of(uart, struct atmel_uart_port, uart);
 }
 
+static inline bool is_uart_port_dbgu(struct uart_port *uart)
+{
+	struct atmel_uart_data *atmel_uart_data =
+	    to_platform_device((uart)->dev)->dev.platform_data;
+	return atmel_uart_data->use_dma_tx == 0
+	    && atmel_uart_data->use_dma_rx == 0;
+}
+
 #ifdef CONFIG_SERIAL_ATMEL_PDC
 static bool atmel_use_dma_rx(struct uart_port *port)
 {
@@ -1420,6 +1432,41 @@ static struct uart_ops atmel_pops = {
 #endif
 };
 
+/* Entry in sys/ to get/set TTGR register */
+
+static ssize_t set_ttgr(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t len)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct atmel_uart_data *pdata = pdev->dev.platform_data;
+	int id = pdata->num;
+	struct atmel_uart_port *atmel_port = &atmel_ports[id];
+	struct uart_port *port = &(atmel_port->uart);
+	unsigned int value;
+	if (kstrtouint(buf, 10, &value))
+		return 0;
+	if (value > MAX_TTGR_VALUE)
+		value = MAX_TTGR_VALUE;
+	UART_PUT_TTGR(port, value);
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t get_ttgr(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct atmel_uart_data *pdata = pdev->dev.platform_data;
+	int id = pdata->num;
+	struct atmel_uart_port *atmel_port = &atmel_ports[id];
+	struct uart_port *port = &(atmel_port->uart);
+	unsigned int value;
+	value = UART_GET_TTGR(port);
+	return snprintf(buf, PAGE_SIZE, "%u\n", value);
+}
+
+static DEVICE_ATTR(ttgr, 0644, get_ttgr, set_ttgr);
+
+
 static void atmel_of_init_port(struct atmel_uart_port *atmel_port,
 					 struct device_node *np)
 {
@@ -1824,6 +1871,9 @@ static int atmel_serial_probe(struct platform_device *pdev)
 		UART_PUT_CR(&port->uart, ATMEL_US_RTSEN);
 	}
 
+	if (!is_uart_port_dbgu(&port->uart))
+		device_create_file(&(pdev->dev), &dev_attr_ttgr);
+
 	return 0;
 
 err_add_port:
@@ -1858,6 +1908,9 @@ static int atmel_serial_remove(struct platform_device *pdev)
 
 	clk_put(atmel_port->clk);
 
+	if (!is_uart_port_dbgu(port))
+		device_remove_file(&(pdev->dev), &dev_attr_ttgr);
+
 	return ret;
 }
 
-- 
1.7.9.5

