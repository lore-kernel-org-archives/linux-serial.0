From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/9] ARM: dts/at91: ensure UARTs used for rs485 specify rs485-rts-delay
Date: Wed, 21 Jun 2017 12:21:23 +0200
Message-ID: <20170621102130.21024-3-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170621102130.21024-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

According to Documentation/devicetree/bindings/serial/rs485.txt the
rs485-rts-delay parameter is required. To prepare making use of
of_get_rs485_mode which is strict here, add this property to all at91
compatible devices that make use of one of the optional properties.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Cc: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

 arch/arm/boot/dts/animeo_ip.dts  | 2 ++
 arch/arm/boot/dts/at91-vinco.dts | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 9cc372b9fb9b..26fea9d79f27 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -45,12 +45,14 @@
 		apb {
 			usart0: serial@fffb0000 {
 				pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts>;
+				rs485-rts-delay = <0 0>;
 				linux,rs485-enabled-at-boot-time;
 				status = "okay";
 			};
 
 			usart1: serial@fffb4000 {
 				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts>;
+				rs485-rts-delay = <0 0>;
 				linux,rs485-enabled-at-boot-time;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
index e0c0b2897a49..7bf8391bc7b3 100644
--- a/arch/arm/boot/dts/at91-vinco.dts
+++ b/arch/arm/boot/dts/at91-vinco.dts
@@ -147,6 +147,7 @@
 			usart4: serial@fc010000 {
 				/* LMN */
 				pinctrl-0 = <&pinctrl_usart4 &pinctrl_usart4_rts>;
+				rs485-rts-delay = <0 0>;
 				linux,rs485-enabled-at-boot-time;
 				status = "okay";
 			};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
