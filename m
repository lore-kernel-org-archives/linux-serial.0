From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 08/10] ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
Date: Wed,  1 Feb 2017 14:31:43 +0000
Message-ID: <20170201143145.31962-9-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170201143145.31962-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Each serial port which supports HW flow-control should have 2 Pinctrl
groups.  One for when HW flow-control is in progress, where the IP
will take over controlling the lines and another group which enables
the lines to be toggled using GPIO mechanisms.

Acked-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index daab16b..bd1a82e 100644
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
+				pinctrl_serial0_hw_flowctrl: serial0-0_hw_flowctrl {
+					st,pins {
+						tx =  <&pio17 0 ALT1 OUT>;
+						rx =  <&pio17 1 ALT1 IN>;
+						cts = <&pio17 2 ALT1 IN>;
+						rts = <&pio17 3 ALT1 OUT>;
 					};
 				};
 			};
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
