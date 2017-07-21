From: Michal Simek <michal.simek@xilinx.com>
Subject: [RFC PATCH 4/4] serial: uartps: Remove static port array
Date: Fri, 21 Jul 2017 11:32:27 +0200
Message-ID: <1764822fbab7d1072270436e3b6160353c06c553.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Allocate uart port structure dynamically.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4fb74baeae35..1c9ec8c4c2b6 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1102,8 +1102,6 @@ static void cdns_uart_pm(struct uart_port *port, unsigned int state,
 #endif
 };
 
-static struct uart_port cdns_uart_port[CDNS_UART_NR_PORTS];
-
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
  * cdns_uart_console_wait_tx - Wait for the TX to be full
@@ -1443,6 +1441,9 @@ static int cdns_uart_probe(struct platform_device *pdev)
 			GFP_KERNEL);
 	if (!cdns_uart_data)
 		return -ENOMEM;
+	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
@@ -1508,16 +1509,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (id < 0)
 		id = 0;
 
-	/* Try the given port id if failed use default method */
-	if (cdns_uart_port[id].mapbase != 0) {
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
1.9.1
