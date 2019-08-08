From: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 3/3] serial: lantiq: Add support for Lightning Mountain SoC
Date: Thu,  8 Aug 2019 18:02:08 +0800
Message-ID: <0df20f6e4bbf9de09c85a5c92c92e642f62f441f.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, jslaby@suse.com, andriy.shevchenko@intel.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

This patch adds IRQ & ISR support in the driver for Lightning Mountain SoC.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/tty/serial/lantiq.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index b129531dfb9a..fcbea43dc334 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -57,6 +57,7 @@
 #define ASC_IRNCR_TIR		0x1
 #define ASC_IRNCR_RIR		0x2
 #define ASC_IRNCR_EIR		0x4
+#define ASC_IRNCR_MASK		GENMASK(2, 0)
 
 #define ASCOPT_CSIZE		0x3
 #define TXFIFO_FL		1
@@ -115,6 +116,7 @@ struct ltq_uart_port {
 	unsigned int		tx_irq;
 	unsigned int		rx_irq;
 	unsigned int		err_irq;
+	unsigned int		common_irq;
 	spinlock_t		lock; /* exclusive access for multi core */
 
 	const struct ltq_soc_data	*soc;
@@ -293,6 +295,31 @@ lqasc_rx_int(int irq, void *_port)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t lqasc_irq(int irq, void *p)
+{
+	unsigned long flags;
+	u32 stat;
+	struct uart_port *port = p;
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+
+	spin_lock_irqsave(&ltq_port->lock, flags);
+	stat = readl(port->membase + LTQ_ASC_IRNCR);
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
+	if (!(stat & ASC_IRNCR_MASK))
+		return IRQ_NONE;
+
+	if (stat & ASC_IRNCR_TIR)
+		lqasc_tx_int(irq, p);
+
+	if (stat & ASC_IRNCR_RIR)
+		lqasc_rx_int(irq, p);
+
+	if (stat & ASC_IRNCR_EIR)
+		lqasc_err_int(irq, p);
+
+	return IRQ_HANDLED;
+}
+
 static unsigned int
 lqasc_tx_empty(struct uart_port *port)
 {
@@ -677,6 +704,7 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 OF_EARLYCON_DECLARE(lantiq, "lantiq,asc", lqasc_serial_early_console_setup);
+OF_EARLYCON_DECLARE(lantiq, "intel,lgm-asc", lqasc_serial_early_console_setup);
 
 static struct uart_driver lqasc_reg = {
 	.owner =	THIS_MODULE,
@@ -751,6 +779,42 @@ static void free_irq_lantiq(struct uart_port *port)
 	free_irq(ltq_port->err_irq, port);
 }
 
+static int fetch_irq_intel(struct device *dev, struct ltq_uart_port *ltq_port)
+{
+	struct uart_port *port = &ltq_port->port;
+	int ret;
+
+	ret = of_irq_get(dev->of_node, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to fetch IRQ for serial port\n");
+		return ret;
+	}
+	ltq_port->common_irq = ret;
+	port->irq = ret;
+
+	return 0;
+}
+
+static int request_irq_intel(struct uart_port *port)
+{
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+	int retval;
+
+	retval = request_irq(ltq_port->common_irq, lqasc_irq, 0,
+			     "asc_irq", port);
+	if (retval)
+		dev_err(port->dev, "failed to request asc_irq\n");
+
+	return retval;
+}
+
+static void free_irq_intel(struct uart_port *port)
+{
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+
+	free_irq(ltq_port->common_irq, port);
+}
+
 static int __init
 lqasc_probe(struct platform_device *pdev)
 {
@@ -842,8 +906,15 @@ static const struct ltq_soc_data soc_data_lantiq = {
 	.free_irq = free_irq_lantiq,
 };
 
+static const struct ltq_soc_data soc_data_intel = {
+	.fetch_irq = fetch_irq_intel,
+	.request_irq = request_irq_intel,
+	.free_irq = free_irq_intel,
+};
+
 static const struct of_device_id ltq_asc_match[] = {
 	{ .compatible = "lantiq,asc", .data = &soc_data_lantiq },
+	{ .compatible = "intel,lgm-asc", .data = &soc_data_intel },
 	{},
 };
 
-- 
2.11.0
