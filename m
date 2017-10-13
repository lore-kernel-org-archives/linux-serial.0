From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v2 16/16] arm64: dts: marvell: armada-3720-espressobin: fill UART nodes
Date: Fri, 13 Oct 2017 11:02:00 +0200
Message-ID: <20171013090200.31034-17-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

Fill ESPRESSObin uart0 node with pinctrl information like in the
Armada-3720-DB device tree (which uses the same node).

Also explain how to enable the second UART port available on the
headers. This second port is not enabled by default because both
headers are dedicated to expose general purpose pins and remapping
some of them to use the second UART would break existing users.

Suggested-by: László ÁSHIN <laszlo@ashin.hu>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---

Changes since v1: comment about UART1 node.

 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 2ce52ba74f73..bdfb5553ddb5 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -98,9 +98,21 @@
 
 /* Exported on the micro USB connector J5 through an FTDI */
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
 	status = "okay";
 };
 
+/*
+ * Connector J17 and J18 expose a number of different features. Some pins are
+ * multiplexed. This is the case for instance for the following features:
+ * - UART1 (pin 24 = RX, pin 26 = TX). See armada-3720-db.dts for an example of
+ *   how to enable it. Beware that the signals are 1.8V TTL.
+ * - I2C
+ * - SPI
+ * - MMC
+ */
+
 /* J7 */
 &usb3 {
 	status = "okay";
-- 
2.11.0

