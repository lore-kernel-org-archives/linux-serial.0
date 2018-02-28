From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 1/2] dt-bindings: serial: stm32: add wakeup option using note
Date: Wed, 28 Feb 2018 10:51:17 +0000
Message-ID: <1519815044-22669-2-git-send-email-bich.hemon@st.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

Update bindings with interrupt-names and wakeup-source information

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index d150b04..aaeb564 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -10,6 +10,7 @@ Required properties:
 - interrupts:
   - The interrupt line for the USART instance,
   - An optional wake-up interrupt.
+- interrupt-names: Contains "event" for the USART interrupt line.
 - clocks: The input clock of the USART instance
 
 Optional properties:
@@ -17,6 +18,9 @@ Optional properties:
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
+- wakeup-source: bool flag to indicate this device has wakeup capabilities
+- interrupt-names : Should contain "wakeup" if optional wake-up interrupt is
+  used.
 
 Examples:
 usart4: serial@40004c00 {
-- 
1.9.1
