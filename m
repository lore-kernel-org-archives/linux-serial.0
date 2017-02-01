From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] tty: serial: cpm_uart: make use of for_each_node_by_type()
Date: Wed, 1 Feb 2017 15:20:12 -0800
Message-ID: <20170201232012.GA35599@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Instead of open-coding loop with of_find_node_by_type(), let's use canned
macro.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index d3e3d42c0c12..f6bcc19c99d5 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1302,7 +1302,7 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 	struct uart_cpm_port *pinfo;
 	struct uart_port *port;
 
-	struct device_node *np = NULL;
+	struct device_node *np;
 	int i = 0;
 
 	if (co->index >= UART_NR) {
@@ -1311,17 +1311,19 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 		return -ENODEV;
 	}
 
-	do {
-		np = of_find_node_by_type(np, "serial");
-		if (!np)
-			return -ENODEV;
-
+	for_each_node_by_type(np, "serial") {
 		if (!of_device_is_compatible(np, "fsl,cpm1-smc-uart") &&
 		    !of_device_is_compatible(np, "fsl,cpm1-scc-uart") &&
 		    !of_device_is_compatible(np, "fsl,cpm2-smc-uart") &&
 		    !of_device_is_compatible(np, "fsl,cpm2-scc-uart"))
-			i--;
-	} while (i++ != co->index);
+			continue;
+
+		if (i++ == co->index)
+			break;
+	}
+
+	if (!np)
+		return -ENODEV;
 
 	pinfo = &cpm_uart_ports[co->index];
 
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
