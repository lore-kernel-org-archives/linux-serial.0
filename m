From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 1/1] dt-bindings: stm32: serial: Add optional reset
Date: Fri, 24 May 2019 17:30:38 +0200
Message-ID: <1558711838-21174-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>, Erwan Le Ray <erwan.leray@st.com>
List-Id: linux-serial@vger.kernel.org

STM32 serial can be reset via reset controller.
Add an optional reset property to stm32 usart bindings.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 9d3efed..a6b1948 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -13,6 +13,7 @@ Required properties:
 - clocks: The input clock of the USART instance
 
 Optional properties:
+- resets: Must contain the phandle to the reset controller.
 - pinctrl: The reference on the pins configuration
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
 - rs485-rts-delay, rs485-rx-during-tx, rs485-rts-active-low,
-- 
1.9.1
