From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] serial: 8250_ingenic: Add support for the JZ4725B SoC
Date: Fri, 13 Jul 2018 16:38:40 +0200
Message-ID: <20180713143840.9721-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-serial@vger.kernel.org

The UART in the jz4725b works just like in the other JZ SoCs, so this
commit simply adds a new compatible string.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.txt | 1 +
 drivers/tty/serial/8250/8250_ingenic.c                    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
index c3c6406d5cfe..a0b34fd3b602 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible : One of:
   - "ingenic,jz4740-uart",
+  - "ingenic,jz4725b-uart",
   - "ingenic,jz4760-uart",
   - "ingenic,jz4770-uart",
   - "ingenic,jz4775-uart",
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 15a8c8dfa92b..760266559a5a 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -133,6 +133,10 @@ EARLYCON_DECLARE(jz4740_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
 		    ingenic_early_console_setup);
 
+EARLYCON_DECLARE(jz4725b_uart, ingenic_early_console_setup);
+OF_EARLYCON_DECLARE(jz4725b_uart, "ingenic,jz4725b-uart",
+		    ingenic_early_console_setup);
+
 EARLYCON_DECLARE(jz4770_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
 		    ingenic_early_console_setup);
@@ -330,6 +334,7 @@ static const struct ingenic_uart_config jz4780_uart_config = {
 
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
+	{ .compatible = "ingenic,jz4725b-uart", .data = &jz4740_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
-- 
2.11.0
