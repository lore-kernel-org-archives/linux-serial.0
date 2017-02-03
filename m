From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 10/10] ARM: dts: STiH410-b2260: Enable HW flow-control
Date: Fri,  3 Feb 2017 10:23:19 +0000
Message-ID: <20170203102319.23489-11-lee.jones@linaro.org>
References: <20170203102319.23489-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170203102319.23489-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hardware flow-control capability must be specified at a platform
level in order to inform the ASC driver that the platform is capable
(i.e. are the lines wired up, etc).  STiH4{07,10} devices are indeed
capable, so let's provide the property.

Acked-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih410-b2260.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index cbcbcb4..93c14d1 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -66,6 +66,7 @@
 			pinctrl-0 = <&pinctrl_serial0_hw_flowctrl>;
 			pinctrl-1 = <&pinctrl_serial0>;
 			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
+			uart-has-rtscts;
 			status = "okay";
 		};
 
-- 
2.9.3
