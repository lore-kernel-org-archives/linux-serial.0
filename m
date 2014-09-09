From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v5 2/2] DTS: serial: Add bindings documention for the Mediatek UARTs
Date: Tue,  9 Sep 2014 17:31:43 +0200
Message-ID: <1410276703-5274-3-git-send-email-matthias.bgg@gmail.com>
References: <1410276703-5274-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410276703-5274-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, matthias.bgg@gmail.com, alan@linux.intel.com, varkabhadram@gmail.com, tklauser@distanz.ch, heiko@sntech.de, yingjoe.chen@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch adds the devicetree documentation for the Mediatek UART.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../devicetree/bindings/serial/mtk-uart.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/mtk-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
new file mode 100644
index 0000000..48358a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -0,0 +1,22 @@
+* Mediatek Universal Asynchronous Receiver/Transmitter (UART)
+
+Required properties:
+- compatible should contain:
+  * "mediatek,mt6589-uart" for MT6589 compatible UARTS
+  * "mediatek,mt6582-uart" for MT6582 compatible UARTS
+  * "mediatek,mt6577-uart" for all compatible UARTS (MT6589, MT6582, MT6577)
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
+		compatible = "mediatek,mt6589-uart", "mediatek,mt6577-uart";
+		reg = <0x11006000 0x400>;
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>;
+	};
-- 
1.9.1
