From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: stm32: add RS485 optional
 properties
Date: Mon, 12 Mar 2018 09:50:04 +0000
Message-ID: <1520848188-7343-2-git-send-email-bich.hemon@st.com>
References: <1520848188-7343-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1520848188-7343-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>, Yves COPPEAUX <Yves.COPPEAUX@st.com>
List-Id: linux-serial@vger.kernel.org

Add options for enabling RS485 hardware control and configuring
Driver Enable signal:
- rs485-rts-delay
- rs485-rx-during-tx
- rs485-rts-active-low
- linux,rs485-enabled-at-boot-time

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index d150b04..9d3efed 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -15,6 +15,8 @@ Required properties:
 Optional properties:
 - pinctrl: The reference on the pins configuration
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
+- rs485-rts-delay, rs485-rx-during-tx, rs485-rts-active-low,
+  linux,rs485-enabled-at-boot-time: see rs485.txt.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
 
-- 
1.9.1
