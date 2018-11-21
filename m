From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Date: Wed, 21 Nov 2018 09:06:46 +0530
Message-ID: <20181121033652.12247-10-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, overseas.sales@unisoc.com, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-serial@vger.kernel.org

Document RDA Micro RDA8810PL SoC timer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/timer/rda,8810pl-timer.txt       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
new file mode 100644
index 000000000000..06cc2b00be12
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
@@ -0,0 +1,21 @@
+RDA Micro RDA8810PL Timer
+
+Required properties:
+- compatible      :  "rda,8810pl-timer"
+- reg             :  Offset and length of the register set for the device.
+- interrupts      :  Should contain the interrupts.
+- interrupt-names :  Valid names are: "hwtimer", "ostimer".
+                     See ../resource-names.txt
+
+Example:
+
+		apb@20900000 {
+			compatible = "simple-bus";
+			...
+			timer@10000 {
+				compatible = "rda,8810pl-timer";
+				reg = <0x10000 0x1000>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+					     <17 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "hwtimer", "ostimer";
+			};
-- 
2.17.1
