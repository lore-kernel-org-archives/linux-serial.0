From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] serial: 8250_ingenic: Add support for the JZ4770 SoC
Date: Thu, 28 Dec 2017 14:07:08 +0100
Message-ID: <20171228130709.12457-3-paul@crapouillou.net>
References: <20171228130709.12457-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228130709.12457-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-serial@vger.kernel.org

The JZ4770 SoC's UART is no different from the other JZ SoCs, so this
commit simply adds the ingenic,jz4770-uart compatible string.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.txt | 8 ++++++--
 drivers/tty/serial/8250/8250_ingenic.c                    | 5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

 v1: Initial version

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
index 02cb7fe59cb7..c3c6406d5cfe 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
@@ -1,8 +1,12 @@
 * Ingenic SoC UART
 
 Required properties:
-- compatible : "ingenic,jz4740-uart", "ingenic,jz4760-uart",
-	"ingenic,jz4775-uart" or "ingenic,jz4780-uart"
+- compatible : One of:
+  - "ingenic,jz4740-uart",
+  - "ingenic,jz4760-uart",
+  - "ingenic,jz4770-uart",
+  - "ingenic,jz4775-uart",
+  - "ingenic,jz4780-uart".
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
 - clocks : phandles to the module & baud clocks.
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 6af84900870e..165b4bb3de93 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -125,6 +125,10 @@ EARLYCON_DECLARE(jz4740_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
 		    ingenic_early_console_setup);
 
+EARLYCON_DECLARE(jz4770_uart, ingenic_early_console_setup);
+OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
+		    ingenic_early_console_setup);
+
 EARLYCON_DECLARE(jz4775_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4775_uart, "ingenic,jz4775-uart",
 		    ingenic_early_console_setup);
@@ -319,6 +323,7 @@ static const struct ingenic_uart_config jz4780_uart_config = {
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
+	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4780-uart", .data = &jz4780_uart_config },
 	{ /* sentinel */ }
-- 
2.15.1
