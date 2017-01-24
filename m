From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 6/8] ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
Date: Tue, 24 Jan 2017 13:43:08 +0000
Message-ID: <20170124134310.27512-7-lee.jones@linaro.org>
References: <20170124134310.27512-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170124134310.27512-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

Each serial port which supports HW flow-control should have 2 Pinctrl
groups.  Once for when HW flow-control is in progress, where the IP
will take over controlling the lines and another group which enables
the lines to be toggled using GPIO mechanisms.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index daab16b..fbb7f86 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -465,8 +465,16 @@
 			serial0 {
 				pinctrl_serial0: serial0-0 {
 					st,pins {
-						tx = <&pio17 0 ALT1 OUT>;
-						rx = <&pio17 1 ALT1 IN>;
+						tx =  <&pio17 0 ALT1 OUT>;
+						rx =  <&pio17 1 ALT1 IN>;
+					};
+				};
+				pinctrl_serial0_flowctrl: serial0-0_flowctrl {
+					st,pins {
+						tx =  <&pio17 0 ALT1 OUT>;
+						rx =  <&pio17 1 ALT1 IN>;
+						cts = <&pio17 2 ALT1 IN>;
+						rts = <&pio17 3 ALT1 OUT>;
 					};
 				};
 			};
-- 
2.10.2
