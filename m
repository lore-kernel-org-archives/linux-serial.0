From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 02/20] dt-bindings: serial: each stm32 usart needs an alias
Date: Mon, 26 Jun 2017 12:49:09 +0000
Message-ID: <1498481318-1894-3-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
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
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon@st.com>

Each usart controller should have an alias correctly
numbered in "aliases" node.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 85ec5f2..a229b14 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -15,14 +15,23 @@ Optional properties:
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
 
+Note: Each usart controller should have an alias correctly numbered
+in "aliases" node.
+
 Examples:
-usart4: serial@40004c00 {
+aliases {
+	serial0 = &usart1;
+	serial1 = &usart2;
+	serial3 = &uart4;
+};
+
+uart4: serial@40004c00 {
 	compatible = "st,stm32-uart";
 	reg = <0x40004c00 0x400>;
 	interrupts = <52>;
 	clocks = <&clk_pclk1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usart4>;
+	pinctrl-0 = <&pinctrl_uart4>;
 };
 
 usart2: serial@40004400 {
-- 
1.9.1
