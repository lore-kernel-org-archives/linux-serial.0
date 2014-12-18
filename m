From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 3/3] serial: add device tree binding documentation for
 Conexant USART
Date: Thu, 18 Dec 2014 21:45:25 +0200
Message-ID: <71eb6f2f64c6965e38b29c7463b7edb4966142ad.1418930377.git.baruch@tkos.co.il>
References: <cover.1418930377.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1418930377.git.baruch@tkos.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/serial/digicolor-usart.txt | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/digicolor-usart.txt

diff --git a/Documentation/devicetree/bindings/serial/digicolor-usart.txt b/Documentation/devicetree/bindings/serial/digicolor-usart.txt
new file mode 100644
index 000000000000..2d3ede66889d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/digicolor-usart.txt
@@ -0,0 +1,27 @@
+Binding for Conexant Digicolor USART
+
+Note: this binding is only applicable for using the USART peripheral as
+UART. USART also support synchronous serial protocols like SPI and I2S. Use
+the binding that matches the wiring of your system.
+
+Required properties:
+- compatible : should be "cnxt,cx92755-usart".
+- reg: Should contain USART controller registers location and length.
+- interrupts: Should contain a single USART controller interrupt.
+- clocks: Must contain phandles to the USART clock
+  See ../clocks/clock-bindings.txt for details.
+
+Note: Each UART port should have an alias correctly numbered
+in "aliases" node.
+
+Example:
+	aliases {
+		serial0 = &uart0;
+	};
+
+	uart0: uart@f0000740 {
+		compatible = "cnxt,cx92755-usart";
+		reg = <0xf0000740 0x20>;
+		clocks = <&main_clk>;
+		interrupts = <44>;
+	};
-- 
2.1.3
