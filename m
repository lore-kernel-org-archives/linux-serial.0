From: David Lechner <david@lechnology.com>
Subject: [PATCH v3 4/4] ARM: dts: keystone: Add "ti,da830-uart" compatible string
Date: Thu,  5 Jan 2017 12:54:20 -0600
Message-ID: <1483642460-6891-5-git-send-email-david@lechnology.com>
References: <1483642460-6891-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483642460-6891-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: David Lechner <david@lechnology.com>, Franklin S Cooper Jr <fcooper@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>, Axel Haslam <ahaslam@baylibre.com>, Alexandre Bailon <abailon@baylibre.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The TI Keystone SoCs have extra UART registers beyond the standard 8250
registers, so we need a new compatible string to indicate this. Also, at
least one of these registers uses the full 32 bits, so we need to specify
reg-io-width in addition to reg-shift.

"ns16550a" is left in the compatible specification since it does work as
long as the bootloader configures the SoC UART power management registers.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes:
* None

v2 changes:
* This is a new patch in v2

 arch/arm/boot/dts/keystone-k2g.dtsi | 2 +-
 arch/arm/boot/dts/keystone-k2l.dtsi | 4 ++--
 arch/arm/boot/dts/keystone.dtsi     | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 63c7cf0c..7d7b9a8 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -90,7 +90,7 @@
 		};
 
 		uart0: serial@02530c00 {
-			compatible = "ns16550a";
+			compatible = "ti,da830-uart", "ns16550a";
 			current-speed = <115200>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index 0c5e74e..e91633f 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -35,7 +35,7 @@
 		/include/ "keystone-k2l-clocks.dtsi"
 
 		uart2: serial@02348400 {
-			compatible = "ns16550a";
+			compatible = "ti,da830-uart", "ns16550a";
 			current-speed = <115200>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
@@ -45,7 +45,7 @@
 		};
 
 		uart3:	serial@02348800 {
-			compatible = "ns16550a";
+			compatible = "ti,da830-uart", "ns16550a";
 			current-speed = <115200>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 02708ba..9152610 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -98,7 +98,7 @@
 		/include/ "keystone-clocks.dtsi"
 
 		uart0: serial@02530c00 {
-			compatible = "ns16550a";
+			compatible = "ti,da830-uart", "ns16550a";
 			current-speed = <115200>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
@@ -108,7 +108,7 @@
 		};
 
 		uart1:	serial@02531000 {
-			compatible = "ns16550a";
+			compatible = "ti,da830-uart", "ns16550a";
 			current-speed = <115200>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-- 
2.7.4
