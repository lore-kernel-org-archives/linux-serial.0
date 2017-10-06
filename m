From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 14/16] arm64: dts: marvell: armada-37xx: add second UART port
Date: Fri,  6 Oct 2017 12:13:42 +0200
Message-ID: <20171006101344.15590-15-miquel.raynal@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171006101344.15590-1-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Add a node in Armada 37xx DTSI file for the second UART, with a
different compatible due to its extended IP which has some
differences with the first UART already in place.

Make use of this commit to also fully describe the first port and
use the same clear and named interrupt bindings for both ports.

The standard UART (UART0) uses level-interrupts while the extended
UART (UART1) uses edge-triggered interrupts.

Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index a36d667f770e..72b68f23c001 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -55,6 +55,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
 	cpus {
@@ -136,7 +137,22 @@
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x200>;
 				clocks = <&xtalclk>;
-				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts =
+				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "uart-sum", "uart-tx", "uart-rx";
+				status = "disabled";
+			};
+
+			uart1: serial@12200 {
+				compatible = "marvell,armada-3700-uart-ext";
+				reg = <0x12200 0x30>;
+				clocks = <&xtalclk>;
+				interrupts =
+				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "uart-tx", "uart-rx";
 				status = "disabled";
 			};
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
