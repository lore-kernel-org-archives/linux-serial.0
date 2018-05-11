From: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v3 4/6] dt-bindings: add binding for at91-usart in spi mode
Date: Fri, 11 May 2018 13:38:20 +0300
Message-ID: <20180511103822.31698-5-radu.pirea@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511103822.31698-1-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc: mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, richard.genoud@gmail.com, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, broonie@kernel.org, Radu Pirea <radu.pirea@microchip.com>
List-Id: linux-serial@vger.kernel.org

These are bindings for at91-usart IP in spi spi mode. There is no support for
internal chip select. Only kind of chip selects available are gpio chip
selects.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 .../bindings/spi/microchip,at91-usart-spi.txt | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
new file mode 100644
index 000000000000..b68a3bec4121
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
@@ -0,0 +1,28 @@
+* Universal Synchronous Asynchronous Receiver/Transmitter (USART) in SPI mode
+
+Required properties:
+- #size-cells      : Must be <0>
+- #address-cells   : Must be <1>
+- compatible: Should be "atmel,at91rm9200-usart" or "atmel,at91sam9260-usart"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+- clocks: phandles to input clocks.
+- clock-names: tuple listing input clock names.
+	Required elements: "usart"
+- cs-gpios: chipselects (internal cs not supported)
+- at91,usart-mode: AT91_USART_MODE_SPI (found in dt-bindings/mfd/at91-usart.h)
+
+Example:
+	#include <dt-bindings/mfd/at91-usart.h>
+
+	spi0: spi@f001c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "atmel,at91rm9200-usart", "atmel,at91sam9260-usart";
+		at91,usart-mode = <AT91_USART_MODE_SPI>;
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
+		cs-gpios = <&pioB 3 0>;
+	};
-- 
2.17.0
