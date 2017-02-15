From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 05/11] Documentation: devicetree: serial: Document Actions Semi Owl UARTs
Date: Wed, 15 Feb 2017 17:55:22 +0100
Message-ID: <20170215165528.10052-6-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: contact@linux-xapple.org, mp-cs@actions-semi.com, info@ucrobotics.com, support@lemaker.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 .../devicetree/bindings/serial/acts,owl-uart.txt         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/acts,owl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/acts,owl-uart.txt b/Documentation/devicetree/bindings/serial/acts,owl-uart.txt
new file mode 100644
index 0000000..a1aecd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/acts,owl-uart.txt
@@ -0,0 +1,16 @@
+Actions Semi Owl UART
+
+Required properties:
+- compatible :  "acts,s500-uart", "acts,owl-uart" for S500
+                "acts,s900-uart", "acts,owl-uart" for S900
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+
+
+Example:
+
+		uart3: serial@b0126000 {
+			compatible = "acts,s500-uart", "acts,owl-uart";
+			reg = <0xb0126000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
-- 
2.10.2
