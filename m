From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 09/10] ARM: dts: STiH407-family: Use new Pinctrl groups
Date: Fri, 27 Jan 2017 17:28:03 +0000
Message-ID: <20170127172804.23881-10-lee.jones@linaro.org>
References: <20170127172804.23881-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170127172804.23881-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

Having just defined some new Pinctrl groups for when when HW flow-
control is {en,dis}abled, let's reference them for use within the
driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 3 +--
 arch/arm/boot/dts/stih410-b2260.dts   | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c8b2944..e480e32 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -222,9 +222,8 @@
 			compatible = "st,asc";
 			reg = <0x9830000 0x2c>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_serial0>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			/* Pinctrl moved out to a per-board configuration */
 
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index fa16aba..8deecf6 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -62,8 +62,11 @@
 		/* Low speed expansion connector */
 		uart0: serial@9830000 {
 			label = "LS-UART0";
-			status = "okay";
+			pinctrl-names = "default", "manual-rts";
+			pinctrl-0 = <&pinctrl_serial0_flowctrl>;
+			pinctrl-1 = <&pinctrl_serial0>;
 			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
+			status = "okay";
 		};
 
 		/* Low speed expansion connector */
-- 
2.9.3
