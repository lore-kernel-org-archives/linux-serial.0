From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 8/8] drivers: tty: serial: xilinx_uartps: use helpers
Date: Tue, 12 Mar 2019 15:57:40 +0100
Message-ID: <1552402660-31730-9-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

---
 drivers/tty/serial/xilinx_uartps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 74089f5..92aff38 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -953,15 +953,14 @@ static int cdns_uart_verify_port(struct uart_port *port,
  */
 static int cdns_uart_request_port(struct uart_port *port)
 {
-	if (!request_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE,
-					 CDNS_UART_NAME)) {
+	if (!uart_memres_request(port, CDNS_UART_NAME)) {
 		return -ENOMEM;
 	}
 
-	port->membase = ioremap(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	port->membase = uart_memres_ioremap(port);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+		uart_memres_release(port);
 		return -ENOMEM;
 	}
 	return 0;
@@ -976,7 +975,7 @@ static int cdns_uart_request_port(struct uart_port *port)
  */
 static void cdns_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	uart_memres_release(port);
 	iounmap(port->membase);
 	port->membase = NULL;
 }
@@ -1626,7 +1625,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * This function also registers this device with the tty layer
 	 * and triggers invocation of the config_port() entry point.
 	 */
-	port->mapbase = res->start;
+	uart_memres_set(*res);
 	port->irq = irq;
 	port->dev = &pdev->dev;
 	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
@@ -1707,7 +1706,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 			&cdns_uart_data->clk_rate_change_nb);
 #endif
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
-	port->mapbase = 0;
+	uart_memres_clear(port);
 	mutex_lock(&bitmap_lock);
 	if (cdns_uart_data->id < MAX_UART_INSTANCES)
 		clear_bit(cdns_uart_data->id, bitmap);
-- 
1.9.1
