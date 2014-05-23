From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC v2 04/10] ARM: vexpress: Extend UART with FIQ support
Date: Fri, 23 May 2014 14:57:52 +0100
Message-ID: <1400853478-5824-5-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfou>
List-Id: linux-serial@vger.kernel.org

This patch provides the UART with a second interrupt resource that can
be used to route the UARTs interrupt to FIQ. The size of the interrupt
map is doubled and new mappings for the FIQ shadows added (demarked by
setting bit 7 in the final item in the tuple).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi     |  8 ++++----
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts | 10 ++++++++--
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  |  8 +++++++-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     | 10 ++++++++--
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index ac870fb..e86936c 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -140,7 +140,7 @@
 			v2m_serial0: uart@090000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x090000 0x1000>;
-				interrupts = <5>;
+				interrupts = <5>, <69>;
 				clocks = <&v2m_oscclk2>, <&smbclk>;
 				clock-names = "uartclk", "apb_pclk";
 			};
@@ -148,7 +148,7 @@
 			v2m_serial1: uart@0a0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0a0000 0x1000>;
-				interrupts = <6>;
+				interrupts = <6>, <70>;
 				clocks = <&v2m_oscclk2>, <&smbclk>;
 				clock-names = "uartclk", "apb_pclk";
 			};
@@ -156,7 +156,7 @@
 			v2m_serial2: uart@0b0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0b0000 0x1000>;
-				interrupts = <7>;
+				interrupts = <7>, <71>;
 				clocks = <&v2m_oscclk2>, <&smbclk>;
 				clock-names = "uartclk", "apb_pclk";
 			};
@@ -164,7 +164,7 @@
 			v2m_serial3: uart@0c0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0c0000 0x1000>;
-				interrupts = <8>;
+				interrupts = <8>, <72>;
 				clocks = <&v2m_oscclk2>, <&smbclk>;
 				clock-names = "uartclk", "apb_pclk";
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 9420053..9c489fa 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -233,7 +233,7 @@
 			 <5 0 0 0x10000000 0x04000000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 63>;
+		interrupt-map-mask = <0 0 127>;
 		interrupt-map = <0 0  0 &gic 0  0 4>,
 				<0 0  1 &gic 0  1 4>,
 				<0 0  2 &gic 0  2 4>,
@@ -276,7 +276,13 @@
 				<0 0 39 &gic 0 39 4>,
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
-				<0 0 42 &gic 0 42 4>;
+				<0 0 42 &gic 0 42 4>,
+
+				/* FIQ shadow routings */
+				<0 0 69 &gic 0 5 0x84>,
+				<0 0 70 &gic 0 6 0x84>,
+				<0 0 71 &gic 0 7 0x84>,
+				<0 0 72 &gic 0 8 0x84>;
 
 		/include/ "vexpress-v2m-rs1.dtsi"
 	};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 15f98cb..75821d2 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -390,7 +390,13 @@
 				<0 0 39 &gic 0 39 4>,
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
-				<0 0 42 &gic 0 42 4>;
+				<0 0 42 &gic 0 42 4>,
+
+				/* FIQ shadow routings */
+				<0 0 69 &gic 0 5 0x84>,
+				<0 0 70 &gic 0 6 0x84>,
+				<0 0 71 &gic 0 7 0x84>,
+				<0 0 72 &gic 0 8 0x84>;
 
 		/include/ "vexpress-v2m-rs1.dtsi"
 	};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index c544a55..930e2ef 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -195,7 +195,7 @@
 			 <5 0 0x10000000 0x04000000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 63>;
+		interrupt-map-mask = <0 0 127>;
 		interrupt-map = <0 0  0 &gic 0  0 4>,
 				<0 0  1 &gic 0  1 4>,
 				<0 0  2 &gic 0  2 4>,
@@ -238,7 +238,13 @@
 				<0 0 39 &gic 0 39 4>,
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
-				<0 0 42 &gic 0 42 4>;
+				<0 0 42 &gic 0 42 4>,
+
+				/* FIQ shadow routings */
+				<0 0 69 &gic 0 5 0x84>,
+				<0 0 70 &gic 0 6 0x84>,
+				<0 0 71 &gic 0 7 0x84>,
+				<0 0 72 &gic 0 8 0x84>;
 
 		/include/ "vexpress-v2m-rs1.dtsi"
 	};
-- 
1.9.0
