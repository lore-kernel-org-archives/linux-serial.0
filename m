From: <shubhrajyoti.datta@gmail.com>
Subject: [LINUX PATCHv3 2/9] serial-uartlite: Add get serial id if not provided
Date: Tue, 16 Oct 2018 15:48:01 +0530
Message-ID: <1539685088-13465-3-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, jacmet@sunsite.dk, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add get serial id if not provided

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 77bc9d0..441a216 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -763,6 +763,13 @@ static int ulite_probe(struct platform_device *pdev)
 	if (prop)
 		id = be32_to_cpup(prop);
 #endif
+	if (id < 0) {
+		/* Look for a serialN alias */
+		id = of_alias_get_id(pdev->dev.of_node, "serial");
+		if (id < 0)
+			id = 0;
+	}
+
 	if (!ulite_uart_driver.state) {
 		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
 		ret = uart_register_driver(&ulite_uart_driver);
-- 
2.1.1
