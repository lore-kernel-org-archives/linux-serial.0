From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH 15/16] arm64: dts: marvell: armada-3720-db: enable second UART port
Date: Fri,  6 Oct 2017 12:13:43 +0200
Message-ID: <20171006101344.15590-16-miquel.raynal@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

Enable Armada-3720-DB second UART port by adding the corresponding
device tree node in the board DTS and enabling it.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 9df0f06ce607..15713c19b3d0 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -216,7 +216,7 @@
 
 /*
  * Exported on the micro USB connector CON30(V2.0)/CON32(V1.4) through
- * an FTDI
+ * an FTDI (also on CON24(V2.0)/CON26(V1.4)).
  */
 &uart0 {
 	pinctrl-names = "default";
@@ -224,6 +224,13 @@
 	status = "okay";
 };
 
+/* CON26(V2.0)/CON28(V1.4) */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
 /* CON27(V2.0)/CON29(V1.4) */
 &usb2 {
 	status = "okay";
-- 
2.11.0

