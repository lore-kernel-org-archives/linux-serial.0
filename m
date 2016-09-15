From: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 07/11] dt-bindings: Add DMA bindings for STM32 USART
Date: Thu, 15 Sep 2016 18:42:39 +0200
Message-ID: <1473957763-30629-8-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473957763-30629-1-git-send-email-alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gerald.baeza-qxv4g6HH51o@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 75b1400..85ec5f2 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -12,6 +12,8 @@ stm32(f4) or stm32f7.
 Optional properties:
 - pinctrl: The reference on the pins configuration
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
+- dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
+- dma-names: "rx" and/or "tx"
 
 Examples:
 usart4: serial@40004c00 {
@@ -32,3 +34,13 @@ usart2: serial@40004400 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rtscts>;
 };
+
+usart1: serial@40011000 {
+	compatible = "st,stm32-usart", "st,stm32-uart";
+	reg = <0x40011000 0x400>;
+	interrupts = <37>;
+	clocks = <&rcc 0 164>;
+	dmas = <&dma2 2 4 0x414 0x0>,
+	       <&dma2 7 4 0x414 0x0>;
+	dma-names = "rx", "tx";
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
