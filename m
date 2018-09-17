From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 5/5] serial: sprd: Fix the indentation issue
Date: Mon, 17 Sep 2018 11:33:44 -0700
Message-ID: <159889c1b417abcd9dc6eeffbecd0068b5b4ab2a.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, broonie@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Make the macros' definition and code have the same correct indentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
Changes from v1:
 - Add acked tag from Chunyan.
---
 drivers/tty/serial/sprd_serial.c | 46 +++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 8d5c9cd..4287ca3 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -68,24 +68,24 @@
 #define SPRD_LCR_DATA_LEN6	0x4
 #define SPRD_LCR_DATA_LEN7	0x8
 #define SPRD_LCR_DATA_LEN8	0xc
-#define SPRD_LCR_PARITY	(BIT(0) | BIT(1))
+#define SPRD_LCR_PARITY		(BIT(0) | BIT(1))
 #define SPRD_LCR_PARITY_EN	0x2
 #define SPRD_LCR_EVEN_PAR	0x0
 #define SPRD_LCR_ODD_PAR	0x1
 
 /* control register 1 */
-#define SPRD_CTL1			0x001C
+#define SPRD_CTL1		0x001C
 #define RX_HW_FLOW_CTL_THLD	BIT(6)
 #define RX_HW_FLOW_CTL_EN	BIT(7)
 #define TX_HW_FLOW_CTL_EN	BIT(8)
 #define RX_TOUT_THLD_DEF	0x3E00
-#define RX_HFC_THLD_DEF	0x40
+#define RX_HFC_THLD_DEF		0x40
 
 /* fifo threshold register */
 #define SPRD_CTL2		0x0020
-#define THLD_TX_EMPTY	0x40
+#define THLD_TX_EMPTY		0x40
 #define THLD_TX_EMPTY_SHIFT	8
-#define THLD_RX_FULL	0x40
+#define THLD_RX_FULL		0x40
 
 /* config baud rate register */
 #define SPRD_CLKD0		0x0024
@@ -95,11 +95,11 @@
 #define SPRD_CLKD1_SHIFT	16
 
 /* interrupt mask status register */
-#define SPRD_IMSR			0x002C
-#define SPRD_IMSR_RX_FIFO_FULL		BIT(0)
+#define SPRD_IMSR		0x002C
+#define SPRD_IMSR_RX_FIFO_FULL	BIT(0)
 #define SPRD_IMSR_TX_FIFO_EMPTY	BIT(1)
-#define SPRD_IMSR_BREAK_DETECT		BIT(7)
-#define SPRD_IMSR_TIMEOUT		BIT(13)
+#define SPRD_IMSR_BREAK_DETECT	BIT(7)
+#define SPRD_IMSR_TIMEOUT	BIT(13)
 
 struct sprd_uart_port {
 	struct uart_port port;
@@ -229,7 +229,7 @@ static inline void sprd_rx(struct uart_port *port)
 		port->icount.rx++;
 
 		if (lsr & (SPRD_LSR_BI | SPRD_LSR_PE |
-			SPRD_LSR_FE | SPRD_LSR_OE))
+			   SPRD_LSR_FE | SPRD_LSR_OE))
 			if (handle_lsr_errors(port, &lsr, &flag))
 				continue;
 		if (uart_handle_sysrq_char(port, ch))
@@ -292,8 +292,8 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 	if (ims & SPRD_IMSR_TIMEOUT)
 		serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
 
-	if (ims & (SPRD_IMSR_RX_FIFO_FULL |
-		SPRD_IMSR_BREAK_DETECT | SPRD_IMSR_TIMEOUT))
+	if (ims & (SPRD_IMSR_RX_FIFO_FULL | SPRD_IMSR_BREAK_DETECT |
+		   SPRD_IMSR_TIMEOUT))
 		sprd_rx(port);
 
 	if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
@@ -333,7 +333,7 @@ static int sprd_startup(struct uart_port *port)
 	sp = container_of(port, struct sprd_uart_port, port);
 	snprintf(sp->name, sizeof(sp->name), "sprd_serial%d", port->line);
 	ret = devm_request_irq(port->dev, port->irq, sprd_handle_irq,
-				IRQF_SHARED, sp->name, port);
+			       IRQF_SHARED, sp->name, port);
 	if (ret) {
 		dev_err(port->dev, "fail to request serial irq %d, ret=%d\n",
 			port->irq, ret);
@@ -361,8 +361,8 @@ static void sprd_shutdown(struct uart_port *port)
 }
 
 static void sprd_set_termios(struct uart_port *port,
-				    struct ktermios *termios,
-				    struct ktermios *old)
+			     struct ktermios *termios,
+			     struct ktermios *old)
 {
 	unsigned int baud, quot;
 	unsigned int lcr = 0, fc;
@@ -480,8 +480,7 @@ static void sprd_config_port(struct uart_port *port, int flags)
 		port->type = PORT_SPRD;
 }
 
-static int sprd_verify_port(struct uart_port *port,
-				   struct serial_struct *ser)
+static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	if (ser->type != PORT_SPRD)
 		return -EINVAL;
@@ -531,7 +530,7 @@ static void sprd_console_putchar(struct uart_port *port, int ch)
 }
 
 static void sprd_console_write(struct console *co, const char *s,
-				      unsigned int count)
+			       unsigned int count)
 {
 	struct uart_port *port = &sprd_port[co->index]->port;
 	int locked = 1;
@@ -594,7 +593,7 @@ static void sprd_putc(struct uart_port *port, int c)
 	unsigned int timeout = SPRD_TIMEOUT;
 
 	while (timeout-- &&
-		   !(readl(port->membase + SPRD_LSR) & SPRD_LSR_TX_OVER))
+	       !(readl(port->membase + SPRD_LSR) & SPRD_LSR_TX_OVER))
 		cpu_relax();
 
 	writeb(c, port->membase + SPRD_TXD);
@@ -607,9 +606,8 @@ static void sprd_early_write(struct console *con, const char *s, unsigned int n)
 	uart_console_write(&dev->port, s, n, sprd_putc);
 }
 
-static int __init sprd_early_console_setup(
-				struct earlycon_device *device,
-				const char *opt)
+static int __init sprd_early_console_setup(struct earlycon_device *device,
+					   const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
@@ -691,8 +689,8 @@ static int sprd_probe(struct platform_device *pdev)
 
 	index = sprd_probe_dt_alias(index, &pdev->dev);
 
-	sprd_port[index] = devm_kzalloc(&pdev->dev,
-		sizeof(*sprd_port[index]), GFP_KERNEL);
+	sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
+					GFP_KERNEL);
 	if (!sprd_port[index])
 		return -ENOMEM;
 
-- 
1.9.1
