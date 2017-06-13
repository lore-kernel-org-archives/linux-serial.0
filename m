From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 2/2] tty/serial: atmel: make the driver DT only
Date: Tue, 13 Jun 2017 22:24:39 +0200
Message-ID: <20170613202439.26369-2-alexandre.belloni@free-electrons.com>
References: <20170613202439.26369-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613202439.26369-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

Now that AVR32 is gone, platform_data are not used to initialize the driver
anymore, remove that path from the driver. Also remove the now unused
struct atmel_uart_data.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c   | 96 +++++++++++++------------------------
 include/linux/platform_data/atmel.h | 10 ----
 2 files changed, 33 insertions(+), 73 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 906e2b91bf57..937d67f22fba 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1655,72 +1655,56 @@ static void atmel_init_property(struct atmel_uart_port *atmel_port,
 				struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
-
-	if (np) {
-		/* DMA/PDC usage specification */
-		if (of_property_read_bool(np, "atmel,use-dma-rx")) {
-			if (of_property_read_bool(np, "dmas")) {
-				atmel_port->use_dma_rx  = true;
-				atmel_port->use_pdc_rx  = false;
-			} else {
-				atmel_port->use_dma_rx  = false;
-				atmel_port->use_pdc_rx  = true;
-			}
+
+	/* DMA/PDC usage specification */
+	if (of_property_read_bool(np, "atmel,use-dma-rx")) {
+		if (of_property_read_bool(np, "dmas")) {
+			atmel_port->use_dma_rx  = true;
+			atmel_port->use_pdc_rx  = false;
 		} else {
 			atmel_port->use_dma_rx  = false;
-			atmel_port->use_pdc_rx  = false;
+			atmel_port->use_pdc_rx  = true;
 		}
+	} else {
+		atmel_port->use_dma_rx  = false;
+		atmel_port->use_pdc_rx  = false;
+	}
 
-		if (of_property_read_bool(np, "atmel,use-dma-tx")) {
-			if (of_property_read_bool(np, "dmas")) {
-				atmel_port->use_dma_tx  = true;
-				atmel_port->use_pdc_tx  = false;
-			} else {
-				atmel_port->use_dma_tx  = false;
-				atmel_port->use_pdc_tx  = true;
-			}
+	if (of_property_read_bool(np, "atmel,use-dma-tx")) {
+		if (of_property_read_bool(np, "dmas")) {
+			atmel_port->use_dma_tx  = true;
+			atmel_port->use_pdc_tx  = false;
 		} else {
 			atmel_port->use_dma_tx  = false;
-			atmel_port->use_pdc_tx  = false;
+			atmel_port->use_pdc_tx  = true;
 		}
-
 	} else {
-		atmel_port->use_pdc_rx  = pdata->use_dma_rx;
-		atmel_port->use_pdc_tx  = pdata->use_dma_tx;
-		atmel_port->use_dma_rx  = false;
 		atmel_port->use_dma_tx  = false;
+		atmel_port->use_pdc_tx  = false;
 	}
-
 }
 
 static void atmel_init_rs485(struct uart_port *port,
 				struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
-
-	if (np) {
-		struct serial_rs485 *rs485conf = &port->rs485;
-		u32 rs485_delay[2];
-		/* rs485 properties */
-		if (of_property_read_u32_array(np, "rs485-rts-delay",
-					rs485_delay, 2) == 0) {
-			rs485conf->delay_rts_before_send = rs485_delay[0];
-			rs485conf->delay_rts_after_send = rs485_delay[1];
-			rs485conf->flags = 0;
-		}
 
-		if (of_get_property(np, "rs485-rx-during-tx", NULL))
-			rs485conf->flags |= SER_RS485_RX_DURING_TX;
+	struct serial_rs485 *rs485conf = &port->rs485;
+	u32 rs485_delay[2];
 
-		if (of_get_property(np, "linux,rs485-enabled-at-boot-time",
-								NULL))
-			rs485conf->flags |= SER_RS485_ENABLED;
-	} else {
-		port->rs485       = pdata->rs485;
+	/* rs485 properties */
+	if (of_property_read_u32_array(np, "rs485-rts-delay",
+				       rs485_delay, 2) == 0) {
+		rs485conf->delay_rts_before_send = rs485_delay[0];
+		rs485conf->delay_rts_after_send = rs485_delay[1];
+		rs485conf->flags = 0;
 	}
 
+	if (of_get_property(np, "rs485-rx-during-tx", NULL))
+		rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
+	if (of_get_property(np, "linux,rs485-enabled-at-boot-time", NULL))
+		rs485conf->flags |= SER_RS485_ENABLED;
 }
 
 static void atmel_set_ops(struct uart_port *port)
@@ -2402,7 +2386,6 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 {
 	int ret;
 	struct uart_port *port = &atmel_port->uart;
-	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 
 	atmel_init_property(atmel_port, pdev);
 	atmel_set_ops(port);
@@ -2410,24 +2393,17 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	atmel_init_rs485(port, pdev);
 
 	port->iotype		= UPIO_MEM;
-	port->flags		= UPF_BOOT_AUTOCONF;
+	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
 	port->ops		= &atmel_pops;
 	port->fifosize		= 1;
 	port->dev		= &pdev->dev;
 	port->mapbase	= pdev->resource[0].start;
 	port->irq	= pdev->resource[1].start;
 	port->rs485_config	= atmel_config_rs485;
+	port->membase	= NULL;
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
-	if (pdata && pdata->regs) {
-		/* Already mapped by setup code */
-		port->membase = pdata->regs;
-	} else {
-		port->flags	|= UPF_IOREMAP;
-		port->membase	= NULL;
-	}
-
 	/* for console, the clock could already be configured */
 	if (!atmel_port->clk) {
 		atmel_port->clk = clk_get(&pdev->dev, "usart");
@@ -2761,19 +2737,13 @@ static int atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *atmel_port;
 	struct device_node *np = pdev->dev.of_node;
-	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 	void *data;
 	int ret = -ENODEV;
 	bool rs485_enabled;
 
 	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
 
-	if (np)
-		ret = of_alias_get_id(np, "serial");
-	else
-		if (pdata)
-			ret = pdata->num;
-
+	ret = of_alias_get_id(np, "serial");
 	if (ret < 0)
 		/* port id not found in platform data nor device-tree aliases:
 		 * auto-enumerate it */
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 3c8825b67298..d36bc8d17e97 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -9,7 +9,6 @@
 
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/serial.h>
 
  /* Compact Flash */
 struct at91_cf_data {
@@ -42,15 +41,6 @@ struct atmel_nand_data {
 	bool		need_reset_workaround;
 };
 
- /* Serial */
-struct atmel_uart_data {
-	int			num;		/* port num */
-	short			use_dma_tx;	/* use transmit DMA? */
-	short			use_dma_rx;	/* use receive DMA? */
-	void __iomem		*regs;		/* virt. base address, if any */
-	struct serial_rs485	rs485;		/* rs485 settings */
-};
-
 /* FIXME: this needs a better location, but gets stuff building again */
 extern int at91_suspend_entering_slow_clock(void);
 
-- 
2.11.0
