From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [PATCH v2 18/18] dt-bindings: serial: lantiq: Add optional properties for CCF
Date: Fri,  3 Aug 2018 11:02:37 +0800
Message-ID: <20180803030237.3366-19-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Songjun Wu <songjun.wu@linux.intel.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

Clocks and clock-names are updated in device tree binding.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/serial/lantiq_asc.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
index 3acbd309ab9d..40e81a5818f6 100644
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
+++ b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
@@ -6,8 +6,23 @@ Required properties:
 - interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
   depends on the interrupt-parent interrupt controller.
 
+Optional properties:
+- clocks: Should contain frequency clock and gate clock
+- clock-names: Should be "freq" and "asc"
+
 Example:
 
+asc0: serial@16600000 {
+	compatible = "lantiq,asc";
+	reg = <0x16600000 0x100000>;
+	interrupt-parent = <&gic>;
+	interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
+	clock-names = "freq", "asc";
+};
+
 asc1: serial@e100c00 {
 	compatible = "lantiq,asc";
 	reg = <0xE100C00 0x400>;
-- 
2.11.0
