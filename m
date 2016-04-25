From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 1/3] dt-bindings: document the MPS2 UART bindings
Date: Mon, 25 Apr 2016 09:47:46 +0100
Message-ID: <1461574068-14641-2-git-send-email-vladimir.murzin@arm.com>
References: <1461574068-14641-1-git-send-email-vladimir.murzin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461574068-14641-1-git-send-email-vladimir.murzin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This adds documentation of device tree bindings for the
UART found on ARM MPS2 platform

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 .../devicetree/bindings/serial/arm,mps2-uart.txt   |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt b/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
new file mode 100644
index 0000000..128cc6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
@@ -0,0 +1,19 @@
+ARM MPS2 UART
+
+Required properties:
+- compatible	: Should be "arm,mps2-uart"
+- reg		: Address and length of the register set
+- interrupts	: Reference to the UART RX, TX and overrun interrupts
+
+Required clocking property:
+- clocks	  : The input clock of the UART
+
+
+Examples:
+
+uart0: serial@40004000 {
+	compatible = "arm,mps2-uart";
+	reg = <0x40004000 0x1000>;
+	interrupts = <0 1 12>;
+	clocks = <&sysclk>;
+};
-- 
1.7.9.5
