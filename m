From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/79] serial: samsung: Add unified interrupt handler for s3c64xx and later SoC's
Date: Wed, 26 Oct 2011 14:12:18 +0200
Message-ID: <1319631204-23262-13-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60944 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932832Ab1JZMNf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:35 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Thomas Abraham <thomas.abraham@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Thomas Abraham <thomas.abraham@linaro.org>

s3c64xx and later SoC's include the interrupt mask and pending registers
in the uart controller, unlike the s3c24xx SoC's which have these registers
in the interrupt controller. When the mask and pending registers are part
of the uart controller, a unified interrupt handler can handle the tx/rx
interrupt. With this, the static reservation of interrupt numbers for the
uart tx/rx/err interrupts in the linux irq space is not required and
simplifies adding device tree support.

Suggested-by: Grant Likely <grant.likely@secretlab.ca>
CC: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/samsung.c |  107 +++++++++++++++++++++++++++++++++++++-----
 drivers/tty/serial/samsung.h |    1 +
 2 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index afc6294..9b84654 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -83,6 +83,16 @@ static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
 	return (rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE);
 }
 
+/*
+ * s3c64xx and later SoC's include the interrupt mask and status registers in
+ * the controller itself, unlike the s3c24xx SoC's which have these registers
+ * in the interrupt controller. Check if the port type is s3c64xx or higher.
+ */
+static int s3c24xx_serial_has_interrupt_mask(struct uart_port *port)
+{
+	return to_ourport(port)->info->type == PORT_S3C6400;
+}
+
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	unsigned long flags;
@@ -126,7 +136,11 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	if (tx_enabled(port)) {
-		disable_irq_nosync(ourport->tx_irq);
+		if (s3c24xx_serial_has_interrupt_mask(port))
+			__set_bit(S3C64XX_UINTM_TXD,
+				portaddrl(port, S3C64XX_UINTM));
+		else
+			disable_irq_nosync(ourport->tx_irq);
 		tx_enabled(port) = 0;
 		if (port->flags & UPF_CONS_FLOW)
 			s3c24xx_serial_rx_enable(port);
@@ -141,19 +155,26 @@ static void s3c24xx_serial_start_tx(struct uart_port *port)
 		if (port->flags & UPF_CONS_FLOW)
 			s3c24xx_serial_rx_disable(port);
 
-		enable_irq(ourport->tx_irq);
+		if (s3c24xx_serial_has_interrupt_mask(port))
+			__clear_bit(S3C64XX_UINTM_TXD,
+				portaddrl(port, S3C64XX_UINTM));
+		else
+			enable_irq(ourport->tx_irq);
 		tx_enabled(port) = 1;
 	}
 }
 
-
 static void s3c24xx_serial_stop_rx(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	if (rx_enabled(port)) {
 		dbg("s3c24xx_serial_stop_rx: port=%p\n", port);
-		disable_irq_nosync(ourport->rx_irq);
+		if (s3c24xx_serial_has_interrupt_mask(port))
+			__set_bit(S3C64XX_UINTM_RXD,
+				portaddrl(port, S3C64XX_UINTM));
+		else
+			disable_irq_nosync(ourport->rx_irq);
 		rx_enabled(port) = 0;
 	}
 }
@@ -320,6 +341,28 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	return IRQ_HANDLED;
 }
 
+/* interrupt handler for s3c64xx and later SoC's.*/
+static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
+{
+	struct s3c24xx_uart_port *ourport = id;
+	struct uart_port *port = &ourport->port;
+	unsigned int pend = rd_regl(port, S3C64XX_UINTP);
+	unsigned long flags;
+	irqreturn_t ret = IRQ_HANDLED;
+
+	spin_lock_irqsave(&port->lock, flags);
+	if (pend & S3C64XX_UINTM_RXD_MSK) {
+		ret = s3c24xx_serial_rx_chars(irq, id);
+		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
+	}
+	if (pend & S3C64XX_UINTM_TXD_MSK) {
+		ret = s3c24xx_serial_tx_chars(irq, id);
+		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+	return ret;
+}
+
 static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
@@ -377,18 +420,25 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	if (ourport->tx_claimed) {
-		free_irq(ourport->tx_irq, ourport);
+		if (!s3c24xx_serial_has_interrupt_mask(port))
+			free_irq(ourport->tx_irq, ourport);
 		tx_enabled(port) = 0;
 		ourport->tx_claimed = 0;
 	}
 
 	if (ourport->rx_claimed) {
-		free_irq(ourport->rx_irq, ourport);
+		if (!s3c24xx_serial_has_interrupt_mask(port))
+			free_irq(ourport->rx_irq, ourport);
 		ourport->rx_claimed = 0;
 		rx_enabled(port) = 0;
 	}
-}
 
+	/* Clear pending interrupts and mask all interrupts */
+	if (s3c24xx_serial_has_interrupt_mask(port)) {
+		wr_regl(port, S3C64XX_UINTP, 0xf);
+		wr_regl(port, S3C64XX_UINTM, 0xf);
+	}
+}
 
 static int s3c24xx_serial_startup(struct uart_port *port)
 {
@@ -436,6 +486,33 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 	return ret;
 }
 
+static int s3c64xx_serial_startup(struct uart_port *port)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	int ret;
+
+	dbg("s3c64xx_serial_startup: port=%p (%08lx,%p)\n",
+	    port->mapbase, port->membase);
+
+	ret = request_irq(port->irq, s3c64xx_serial_handle_irq, IRQF_SHARED,
+			  s3c24xx_serial_portname(port), ourport);
+	if (ret) {
+		printk(KERN_ERR "cannot get irq %d\n", port->irq);
+		return ret;
+	}
+
+	/* For compatibility with s3c24xx Soc's */
+	rx_enabled(port) = 1;
+	ourport->rx_claimed = 1;
+	tx_enabled(port) = 0;
+	ourport->tx_claimed = 1;
+
+	/* Enable Rx Interrupt */
+	__clear_bit(S3C64XX_UINTM_RXD, portaddrl(port, S3C64XX_UINTM));
+	dbg("s3c64xx_serial_startup ok\n");
+	return ret;
+}
+
 /* power power management control */
 
 static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
@@ -879,7 +956,6 @@ static struct uart_ops s3c24xx_serial_ops = {
 	.verify_port	= s3c24xx_serial_verify_port,
 };
 
-
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "s3c2410_serial",
@@ -895,7 +971,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 		.port = {
 			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[0].port.lock),
 			.iotype		= UPIO_MEM,
-			.irq		= IRQ_S3CUART_RX0,
 			.uartclk	= 0,
 			.fifosize	= 16,
 			.ops		= &s3c24xx_serial_ops,
@@ -907,7 +982,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 		.port = {
 			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[1].port.lock),
 			.iotype		= UPIO_MEM,
-			.irq		= IRQ_S3CUART_RX1,
 			.uartclk	= 0,
 			.fifosize	= 16,
 			.ops		= &s3c24xx_serial_ops,
@@ -921,7 +995,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 		.port = {
 			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[2].port.lock),
 			.iotype		= UPIO_MEM,
-			.irq		= IRQ_S3CUART_RX2,
 			.uartclk	= 0,
 			.fifosize	= 16,
 			.ops		= &s3c24xx_serial_ops,
@@ -935,7 +1008,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 		.port = {
 			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[3].port.lock),
 			.iotype		= UPIO_MEM,
-			.irq		= IRQ_S3CUART_RX3,
 			.uartclk	= 0,
 			.fifosize	= 16,
 			.ops		= &s3c24xx_serial_ops,
@@ -1077,6 +1149,10 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	port->dev	= &platdev->dev;
 	ourport->info	= info;
 
+	/* Startup sequence is different for s3c64xx and higher SoC's */
+	if (s3c24xx_serial_has_interrupt_mask(port))
+		s3c24xx_serial_ops.startup = s3c64xx_serial_startup;
+
 	/* copy the info in from provided structure */
 	ourport->port.fifosize = info->fifosize;
 
@@ -1116,6 +1192,13 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	ourport->clk	= clk_get(&platdev->dev, "uart");
 
+	/* Keep all interrupts masked and cleared */
+	if (s3c24xx_serial_has_interrupt_mask(port)) {
+		wr_regl(port, S3C64XX_UINTM, 0xf);
+		wr_regl(port, S3C64XX_UINTP, 0xf);
+		wr_regl(port, S3C64XX_UINTSP, 0xf);
+	}
+
 	dbg("port: map=%08x, mem=%08x, irq=%d (%d,%d), clock=%ld\n",
 	    port->mapbase, port->membase, port->irq,
 	    ourport->rx_irq, ourport->tx_irq, port->uartclk);
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index a69d9a5..8e87b78 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -61,6 +61,7 @@ struct s3c24xx_uart_port {
 /* register access controls */
 
 #define portaddr(port, reg) ((port)->membase + (reg))
+#define portaddrl(port, reg) ((unsigned long *)((port)->membase + (reg)))
 
 #define rd_regb(port, reg) (__raw_readb(portaddr(port, reg)))
 #define rd_regl(port, reg) (__raw_readl(portaddr(port, reg)))
-- 
1.7.7

