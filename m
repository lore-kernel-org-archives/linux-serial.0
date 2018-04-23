From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 4/4] serial: uartps: Remove static port array
Date: Mon, 23 Apr 2018 11:51:03 +0200
Message-ID: <f8baf0f2dae274bb1ee7662373fca43803651eb1.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, geert+renesas@glider.be
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Allocate uart port structure dynamically.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/xilinx_uartps.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f7d527a1c532..0fc9de20843c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1097,8 +1097,6 @@ static const struct uart_ops cdns_uart_ops = {
 #endif
 };
 
-static struct uart_port cdns_uart_port[CDNS_UART_NR_PORTS];
-
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
  * cdns_uart_console_wait_tx - Wait for the TX to be full
@@ -1438,6 +1436,9 @@ static int cdns_uart_probe(struct platform_device *pdev)
 			GFP_KERNEL);
 	if (!cdns_uart_data)
 		return -ENOMEM;
+	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
@@ -1503,16 +1504,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (id < 0)
 		id = 0;
 
-	/* Try the given port id if failed use default method */
-	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
-		/* Find the next unused port */
-		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
-			if (cdns_uart_port[id].mapbase == 0)
-				break;
-	}
-
-	port = &cdns_uart_port[id];
-	if (!port || id >= CDNS_UART_NR_PORTS) {
+	if (id >= CDNS_UART_NR_PORTS) {
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
 		rc = -ENODEV;
 		goto err_out_notif_unreg;
-- 
2.17.0
