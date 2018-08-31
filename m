From: Radu Pirea <radu.pirea@microchip.com>
Subject: [RESEND PATCH v11 2/6] dt-bindings: add binding for atmel-usart in SPI mode
Date: Fri, 31 Aug 2018 16:41:37 +0300
Message-ID: <20180831134141.9335-3-radu.pirea@microchip.com>
References: <20180831134141.9335-1-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831134141.9335-1-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: richard.genoud@gmail.com, pirea.radu@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, jslaby@suse.com, broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>
List-Id: linux-serial@vger.kernel.org

This patch moves the bindings for serial from serial/atmel-usart.txt to
mfd/atmel-usart.txt and adds bindings for USART in SPI mode.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
 include/dt-bindings/mfd/at91-usart.h          | 17 +++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
similarity index 76%
rename from Documentation/devicetree/bindings/serial/atmel-usart.txt
rename to Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 7c0d6b2f53e4..0348fef0f497 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -1,6 +1,6 @@
 * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
 
-Required properties:
+Required properties for USART:
 - compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
   The compatible <chip> indicated will be the first SoC to support an
   additional mode or an USART new feature.
@@ -11,7 +11,13 @@ Required properties:
 	Required elements: "usart"
 - clocks: phandles to input clocks.
 
-Optional properties:
+Required properties for USART in SPI mode:
+- #size-cells      : Must be <0>
+- #address-cells   : Must be <1>
+- cs-gpios: chipselects (internal cs not supported)
+- atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
+
+Optional properties in serial mode:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD line respectively.
@@ -62,3 +68,18 @@ Example:
 		dma-names = "tx", "rx";
 		atmel,fifo-size = <32>;
 	};
+
+- SPI mode:
+	#include <dt-bindings/mfd/at91-usart.h>
+
+	spi0: spi@f001c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "atmel,at91rm9200-usart", "atmel,at91sam9260-usart";
+		atmel,usart-mode = <AT91_USART_MODE_SPI>;
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
+		cs-gpios = <&pioB 3 0>;
+	};
diff --git a/include/dt-bindings/mfd/at91-usart.h b/include/dt-bindings/mfd/at91-usart.h
new file mode 100644
index 000000000000..2de5bc312e1e
--- /dev/null
+++ b/include/dt-bindings/mfd/at91-usart.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides macros for AT91 USART DT bindings.
+ *
+ * Copyright (C) 2018 Microchip Technology
+ *
+ * Author: Radu Pirea <radu.pirea@microchip.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_AT91_USART_H__
+#define __DT_BINDINGS_AT91_USART_H__
+
+#define AT91_USART_MODE_SERIAL	0
+#define AT91_USART_MODE_SPI	1
+
+#endif /* __DT_BINDINGS_AT91_USART_H__ */
-- 
2.18.0
