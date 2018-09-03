From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v3 10/10] serial: uartps: Move Port ID to device data structure
Date: Mon,  3 Sep 2018 15:10:58 +0200
Message-ID: <9cda66fc3c143cc2055241802300dc12f5571669.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Record port ID in device data structure to be have it connected to
certain instance.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- New patch in series

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index d838612eda6f..71c032744dae 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -181,6 +181,7 @@
  * @pclk:		APB clock
  * @cdns_uart_driver:	Pointer to UART driver
  * @baud:		Current baud rate
+ * @id:			Port ID
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  */
@@ -190,6 +191,7 @@ struct cdns_uart {
 	struct clk		*pclk;
 	struct uart_driver	*cdns_uart_driver;
 	unsigned int		baud;
+	int			id;
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 };
@@ -1376,7 +1378,7 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
  */
 static int cdns_uart_probe(struct platform_device *pdev)
 {
-	int rc, id, irq;
+	int rc, irq;
 	struct uart_port *port;
 	struct resource *res;
 	struct cdns_uart *cdns_uart_data;
@@ -1402,18 +1404,18 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Look for a serialN alias */
-	id = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (id < 0)
-		id = 0;
+	cdns_uart_data->id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (cdns_uart_data->id < 0)
+		cdns_uart_data->id = 0;
 
-	if (id >= CDNS_UART_NR_PORTS) {
+	if (cdns_uart_data->id >= CDNS_UART_NR_PORTS) {
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
 		return -ENODEV;
 	}
 
 	/* There is a need to use unique driver name */
 	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
-				     CDNS_UART_NAME, id);
+				     CDNS_UART_NAME, cdns_uart_data->id);
 	if (!driver_name)
 		return -ENOMEM;
 
@@ -1421,7 +1423,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	cdns_uart_uart_driver->driver_name = driver_name;
 	cdns_uart_uart_driver->dev_name	= CDNS_UART_TTY_NAME;
 	cdns_uart_uart_driver->major = CDNS_UART_MAJOR;
-	cdns_uart_uart_driver->minor = id;
+	cdns_uart_uart_driver->minor = cdns_uart_data->id;
 	cdns_uart_uart_driver->nr = 1;
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
@@ -1432,7 +1434,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
 		sizeof(cdns_uart_console->name));
-	cdns_uart_console->index = id;
+	cdns_uart_console->index = cdns_uart_data->id;
 	cdns_uart_console->write = cdns_uart_console_write;
 	cdns_uart_console->device = uart_console_device;
 	cdns_uart_console->setup = cdns_uart_console_setup;
@@ -1454,7 +1456,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * registration because tty_driver structure is not filled.
 	 * name_base is 0 by default.
 	 */
-	cdns_uart_uart_driver->tty_driver->name_base = id;
+	cdns_uart_uart_driver->tty_driver->name_base = cdns_uart_data->id;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
-- 
1.9.1
