From: Loys Ollivier <lollivier@baylibre.com>
Subject: [PATCH] tty: serial: meson: if no alias specified use an available id
Date: Mon, 14 Jan 2019 17:54:26 +0100
Message-ID: <1547484866-3600-1-git-send-email-lollivier@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Loys Ollivier <lollivier@baylibre.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

At probe, the uart driver tries to get an id from a device tree alias.
When no alias was specified, the driver would return an error and probing
would fail.

Providing an alias for registering a serial device should not be mandatory.
If the device tree does not specify an alias, provide an id from a reserved
range so that the probing can continue.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a842591b37c..fbc5bc022a39 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -72,7 +72,8 @@
 #define AML_UART_BAUD_USE		BIT(23)
 #define AML_UART_BAUD_XTAL		BIT(24)
 
-#define AML_UART_PORT_NUM		6
+#define AML_UART_PORT_NUM		12
+#define AML_UART_PORT_OFFSET		6
 #define AML_UART_DEV_NAME		"ttyAML"
 
 
@@ -654,10 +655,20 @@ static int meson_uart_probe(struct platform_device *pdev)
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
 	int ret = 0;
+	int id = -1;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
 
+	if (pdev->id < 0) {
+		for (id = AML_UART_PORT_OFFSET; id < AML_UART_PORT_NUM; id++) {
+			if (!meson_ports[id]) {
+				pdev->id = id;
+				break;
+			}
+		}
+	}
+
 	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
 		return -EINVAL;
 
-- 
2.7.4
