From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [RESEND PATCH v3 8/9] tty: cadence: Document DT binding
Date: Fri,  4 Apr 2014 17:23:44 -0700
Message-ID: <1396657425-31029-8-git-send-email-soren.brinkmann@xilinx.com>
References: <1396657425-31029-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1396657425-31029-1-git-send-email-soren.brinkmann@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Add binding documentation for the Cadence UART.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Acked-by: Rob Herring <robh@kernel.org>
Tested-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/serial/cdns,uart.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
new file mode 100644
index 000000000000..a3eb154c32ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
@@ -0,0 +1,20 @@
+Binding for Cadence UART Controller
+
+Required properties:
+- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
+- reg: Should contain UART controller registers location and length.
+- interrupts: Should contain UART controller interrupts.
+- clocks: Must contain phandles to the UART clocks
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Tuple to identify input clocks, must contain "uart_clk" and "pclk"
+  See ../clocks/clock-bindings.txt for details.
+
+
+Example:
+	uart@e0000000 {
+		compatible = "cdns,uart-r1p8";
+		clocks = <&clkc 23>, <&clkc 40>;
+		clock-names = "uart_clk", "pclk";
+		reg = <0xE0000000 0x1000>;
+		interrupts = <0 27 4>;
+	};
-- 
1.9.1.1.gbb9f595
