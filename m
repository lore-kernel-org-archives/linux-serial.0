From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 7/9] dt-bindings: serial: add compatible for stm32h7
Date: Thu, 13 Jul 2017 15:08:29 +0000
Message-ID: <1499958494-19354-8-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Introduce new compatibles for "st,stm32h7-usart" and "st,stm32h7-uart".
This new compatible allow to use optional wake-up interrupt.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 .../devicetree/bindings/serial/st,stm32-usart.txt       | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 85ec5f2..3657f9f 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -1,12 +1,19 @@
 * STMicroelectronics STM32 USART
 
 Required properties:
-- compatible: Can be either "st,stm32-usart", "st,stm32-uart",
-"st,stm32f7-usart" or "st,stm32f7-uart" depending on whether
-the device supports synchronous mode and is compatible with
-stm32(f4) or stm32f7.
+- compatible: can be either:
+  - "st,stm32-usart",
+  - "st,stm32-uart",
+  - "st,stm32f7-usart",
+  - "st,stm32f7-uart",
+  - "st,stm32h7-usart"
+  - "st,stm32h7-uart".
+  depending on whether the device supports synchronous mode
+  and is compatible with stm32(f4), stm32f7 or stm32h7.
 - reg: The address and length of the peripheral registers space
-- interrupts: The interrupt line of the USART instance
+- interrupts:
+  - The interrupt line for the USART instance,
+  - An optional wake-up interrupt.
 - clocks: The input clock of the USART instance
 
 Optional properties:
-- 
1.9.1
