From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 3/7] ARM: sunxi: Rename uart nodes to serial
Date: Tue, 19 Mar 2013 11:35:12 +0100
Message-ID: <1363689316-7847-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kevin@allwinnertech.com, sunny@allwinnertech.com, shuge@allwinnertech.com, linux-serial@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The other architecture use serial@address for their uart nodes, so
rename our uart dt nodes to be consistent

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |    4 ++--
 arch/arm/boot/dts/sun4i-a10-hackberry.dts  |    2 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |    2 +-
 arch/arm/boot/dts/sunxi.dtsi               |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 88e2dc1..cd06a3c 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -36,11 +36,11 @@
 			};
 		};
 
-		uart0: uart@01c28000 {
+		uart0: serial@01c28000 {
 			status = "okay";
 		};
 
-		uart1: uart@01c28400 {
+		uart1: serial@01c28400 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index f84549a..9ab6875 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -23,7 +23,7 @@
 	};
 
 	soc {
-		uart0: uart@01c28000 {
+		uart0: serial@01c28000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 33d1c7e..f1579a8 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -32,7 +32,7 @@
 			};
 		};
 
-		uart1: uart@01c28400 {
+		uart1: serial@01c28400 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pins_b>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 791c02a..1e0f4b5 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -59,7 +59,7 @@
 			#interrupt-cells = <1>;
 		};
 
-		uart0: uart@01c28000 {
+		uart0: serial@01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <1>;
@@ -69,7 +69,7 @@
 			status = "disabled";
 		};
 
-		uart1: uart@01c28400 {
+		uart1: serial@01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
 			interrupts = <2>;
-- 
1.7.10.4
