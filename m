From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH v2 2/2] serial: mps2-uart: support combined irq
Date: Wed, 30 Jan 2019 09:55:15 +0000
Message-ID: <1548842115-14782-3-git-send-email-vladimir.murzin@arm.com>
References: <1548842115-14782-1-git-send-email-vladimir.murzin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1548842115-14782-1-git-send-email-vladimir.murzin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: greg@kroah.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
List-Id: linux-serial@vger.kernel.org

It turns out that some designs went for implementing only combined
interrupt for rx, tx and overrun, which is currently not supported
by the driver.  Support of combined irq is built on top of existent
irq handlers and activated automatically if only single irq was
specified in device tree.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
Changelog
	v1 -> v2
	   - overrun interrupt also combined with rx and tx
	   - count number of irqs provided via dt to detect
	     use of combined irq.

 drivers/tty/serial/mps2-uart.c | 91 ++++++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 6da0633..4404eb7 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -66,11 +66,14 @@
 
 #define MPS2_MAX_PORTS		3
 
+#define UART_PORT_COMBINED_IRQ	BIT(0)
+
 struct mps2_uart_port {
 	struct uart_port port;
 	struct clk *clk;
 	unsigned int tx_irq;
 	unsigned int rx_irq;
+	unsigned int flags;
 };
 
 static inline struct mps2_uart_port *to_mps2_port(struct uart_port *port)
@@ -265,6 +268,20 @@ static irqreturn_t mps2_uart_oerrirq(int irq, void *data)
 	return handled;
 }
 
+static irqreturn_t mps2_uart_combinedirq(int irq, void *data)
+{
+	if (mps2_uart_rxirq(irq, data) == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	if (mps2_uart_txirq(irq, data) == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	if (mps2_uart_oerrirq(irq, data) == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
+}
+
 static int mps2_uart_startup(struct uart_port *port)
 {
 	struct mps2_uart_port *mps_port = to_mps2_port(port);
@@ -275,26 +292,37 @@ static int mps2_uart_startup(struct uart_port *port)
 
 	mps2_uart_write8(port, control, UARTn_CTRL);
 
-	ret = request_irq(mps_port->rx_irq, mps2_uart_rxirq, 0,
-			  MAKE_NAME(-rx), mps_port);
-	if (ret) {
-		dev_err(port->dev, "failed to register rxirq (%d)\n", ret);
-		return ret;
-	}
+	if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
+		ret = request_irq(port->irq, mps2_uart_combinedirq, 0,
+				  MAKE_NAME(-combined), mps_port);
 
-	ret = request_irq(mps_port->tx_irq, mps2_uart_txirq, 0,
-			  MAKE_NAME(-tx), mps_port);
-	if (ret) {
-		dev_err(port->dev, "failed to register txirq (%d)\n", ret);
-		goto err_free_rxirq;
-	}
+		if (ret) {
+			dev_err(port->dev, "failed to register combinedirq (%d)\n", ret);
+			return ret;
+		}
+	} else {
+		ret = request_irq(port->irq, mps2_uart_oerrirq, IRQF_SHARED,
+				  MAKE_NAME(-overrun), mps_port);
+
+		if (ret) {
+			dev_err(port->dev, "failed to register oerrirq (%d)\n", ret);
+			return ret;
+		}
 
-	ret = request_irq(port->irq, mps2_uart_oerrirq, IRQF_SHARED,
-			  MAKE_NAME(-overrun), mps_port);
+		ret = request_irq(mps_port->rx_irq, mps2_uart_rxirq, 0,
+				  MAKE_NAME(-rx), mps_port);
+		if (ret) {
+			dev_err(port->dev, "failed to register rxirq (%d)\n", ret);
+			goto err_free_oerrirq;
+		}
+
+		ret = request_irq(mps_port->tx_irq, mps2_uart_txirq, 0,
+				  MAKE_NAME(-tx), mps_port);
+		if (ret) {
+			dev_err(port->dev, "failed to register txirq (%d)\n", ret);
+			goto err_free_rxirq;
+		}
 
-	if (ret) {
-		dev_err(port->dev, "failed to register oerrirq (%d)\n", ret);
-		goto err_free_txirq;
 	}
 
 	control |= UARTn_CTRL_RX_GRP | UARTn_CTRL_TX_GRP;
@@ -303,10 +331,10 @@ static int mps2_uart_startup(struct uart_port *port)
 
 	return 0;
 
-err_free_txirq:
-	free_irq(mps_port->tx_irq, mps_port);
 err_free_rxirq:
 	free_irq(mps_port->rx_irq, mps_port);
+err_free_oerrirq:
+	free_irq(port->irq, mps_port);
 
 	return ret;
 }
@@ -320,8 +348,11 @@ static void mps2_uart_shutdown(struct uart_port *port)
 
 	mps2_uart_write8(port, control, UARTn_CTRL);
 
-	free_irq(mps_port->rx_irq, mps_port);
-	free_irq(mps_port->tx_irq, mps_port);
+	if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
+		free_irq(mps_port->rx_irq, mps_port);
+		free_irq(mps_port->tx_irq, mps_port);
+	}
+
 	free_irq(port->irq, mps_port);
 }
 
@@ -511,6 +542,10 @@ static int mps2_of_get_port(struct platform_device *pdev,
 	if (id < 0)
 		return id;
 
+	/* Only combined irq is presesnt */
+	if (platform_irq_count(pdev) == 1)
+		mps_port->flags |= UART_PORT_COMBINED_IRQ;
+
 	mps_port->port.line = id;
 
 	return 0;
@@ -529,11 +564,6 @@ static int mps2_init_port(struct platform_device *pdev,
 
 	mps_port->port.mapbase = res->start;
 	mps_port->port.mapsize = resource_size(res);
-
-	mps_port->rx_irq = platform_get_irq(pdev, 0);
-	mps_port->tx_irq = platform_get_irq(pdev, 1);
-	mps_port->port.irq = platform_get_irq(pdev, 2);
-
 	mps_port->port.iotype = UPIO_MEM;
 	mps_port->port.flags = UPF_BOOT_AUTOCONF;
 	mps_port->port.fifosize = 1;
@@ -552,6 +582,15 @@ static int mps2_init_port(struct platform_device *pdev,
 
 	clk_disable_unprepare(mps_port->clk);
 
+
+	if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
+		mps_port->port.irq = platform_get_irq(pdev, 0);
+	} else {
+		mps_port->rx_irq = platform_get_irq(pdev, 0);
+		mps_port->tx_irq = platform_get_irq(pdev, 1);
+		mps_port->port.irq = platform_get_irq(pdev, 2);
+	}
+
 	return ret;
 }
 
-- 
2.7.4
