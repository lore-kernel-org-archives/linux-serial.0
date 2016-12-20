From: David Lechner <david@lechnology.com>
Subject: [PATCH 3/3] ARM: da850: Add ti,da830-uart compatible for serial ports
Date: Tue, 20 Dec 2016 14:23:04 -0600
Message-ID: <1482265384-715-4-git-send-email-david@lechnology.com>
References: <1482265384-715-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482265384-715-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Axel Haslam <ahaslam@baylibre.com>, Alexandre Bailon <abailon@baylibre.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

TI DA8xx/OMAPL13x/AM17xx/AM18xx SoCs have extra UART registers beyond
the standard 8250 registers, so we need a new compatible string to
indicate this. Also, at least one of these registers uses the full 32
bits, so we need to specify reg-io-width in addition to reg-shift.

"ns16550a" is left in the compatible specification since it does work
as long as the bootloader configures the SoC UART power management
registers.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 104155d..f6cd212 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -266,22 +266,25 @@
 			interrupt-names = "edm3_tcerrint";
 		};
 		serial0: serial@42000 {
-			compatible = "ns16550a";
+			compatible = "ti,da830-uart", "ns16550a";
 			reg = <0x42000 0x100>;
+			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <25>;
 			status = "disabled";
 		};
 		serial1: serial@10c000 {
-			compatible = "ns16550a";
+			compatible = "ti,da830-uart", "ns16550a";
 			reg = <0x10c000 0x100>;
+			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <53>;
 			status = "disabled";
 		};
 		serial2: serial@10d000 {
-			compatible = "ns16550a";
+			compatible = "ti,da830-uart", "ns16550a";
 			reg = <0x10d000 0x100>;
+			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <61>;
 			status = "disabled";
-- 
2.7.4
