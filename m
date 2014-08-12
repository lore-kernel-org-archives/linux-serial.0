From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v4 2/2] DTS: serial: Add bindings documention for the Mediatek UARTs
Date: Tue, 12 Aug 2014 16:12:17 +0200
Message-ID: <1407852737-17265-3-git-send-email-matthias.bgg@gmail.com>
References: <1407852737-17265-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1407852737-17265-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, matthias.bgg@gmail.com, alan@linux.intel.com, varkabhadram@gmail.com, tklauser@distanz.ch, heiko@sntech.de, yingjoe.chen@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch adds the devicetree documentation for the Mediatek UART.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../devicetree/bindings/serial/mtk-uart.txt        |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/mtk-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
new file mode 100644
index 0000000..6ca0e15
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -0,0 +1,20 @@
+* Mediatek Universal Asynchronous Receiver/Transmitter (UART)
+
+Required properties:
+- compatible: "mediatek,mt6577-uart"
+  Compatibility with mt6577, mt6589, mt6582
+
+- reg: The base address of the UART register bank.
+
+- interrupts: A single interrupt specifier.
+
+- clocks: Clock driving the hardware.
+
+Example:
+
+	uart0: serial@11006000 {
+		compatible = "mediatek,mt6577-uart";
+		reg = <0x11006000 0x400>;
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>;
+	};
-- 
1.7.9.5

