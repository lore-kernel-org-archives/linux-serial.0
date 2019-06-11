From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH v2 02/10] dt-bindings: serial: add optional pinctrl states
Date: Tue, 11 Jun 2019 14:25:22 +0200
Message-ID: <1560255930-22554-3-git-send-email-erwan.leray@st.com>
References: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, Bich Hemon <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon@st.com>

Add options for pinctrl states:
- "sleep" for low power
- "idle" for low power and wakeup capabilities enabled
- "no_console_suspend" for enabling console messages in low power

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 5ec80c1..64a5ea9 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -13,7 +13,14 @@ Required properties:
 - clocks: The input clock of the USART instance
 
 Optional properties:
-- pinctrl: The reference on the pins configuration
+- pinctrl-names: Set to "default". An additional "sleep" state can be defined
+  to set pins in sleep state when in low power. In case the device is used as
+  a wakeup source, "idle" state is defined in order to keep RX pin active.
+  For a console device, an optional state "no_console_suspend" can be defined
+  to enable console messages during suspend. Typically, "no_console_suspend" and
+  "default" states can refer to the same pin configuration.
+- pinctrl-n: Phandle(s) pointing to pin configuration nodes.
+  For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
 - rs485-rts-delay, rs485-rx-during-tx, rs485-rts-active-low,
   linux,rs485-enabled-at-boot-time: see rs485.txt.
@@ -31,8 +38,11 @@ usart4: serial@40004c00 {
 	reg = <0x40004c00 0x400>;
 	interrupts = <52>;
 	clocks = <&clk_pclk1>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep", "idle", "no_console_suspend";
 	pinctrl-0 = <&pinctrl_usart4>;
+	pinctrl-1 = <&pinctrl_usart4_sleep>;
+	pinctrl-2 = <&pinctrl_usart4_idle>;
+	pinctrl-3 = <&pinctrl_usart4>;
 };
 
 usart2: serial@40004400 {
-- 
1.9.1
