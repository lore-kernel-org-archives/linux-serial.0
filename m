From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 08/11] dt-bindings: serial: Document RDA Micro UART
Date: Tue, 18 Dec 2018 20:32:35 +0530
Message-ID: <20181218150238.23010-9-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-unisoc@lists.infradead.org, afaerber@suse.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-serial@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add an initial binding for the UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
new file mode 100644
index 000000000000..a08df97a69e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
@@ -0,0 +1,17 @@
+RDA Micro UART
+
+Required properties:
+- compatible :  "rda,8810pl-uart" for RDA8810PL SoCs.
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+- clocks     :  Phandle to the input clock.
+
+
+Example:
+
+		uart2: serial@20a90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x20a90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>;
+		};
-- 
2.17.1
