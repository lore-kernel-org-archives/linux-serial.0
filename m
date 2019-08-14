From: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 2/2] dt-bindings: lantiq: Update for new SoC
Date: Wed, 14 Aug 2019 16:22:35 +0800
Message-ID: <f901ea1aaf6272b1e538772c3c6bb17adad5d003.1565770074.git.rahul.tanwar@linux.intel.com>
References: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
References: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Intel Lightning Mountain(LGM) SoC reuses Lantiq ASC serial controller IP.
This patch updates the dt bindings to support LGM as well.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/serial/lantiq_asc.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
index 9757f0a24232..d552fd31c16c 100644
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
+++ b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
@@ -17,6 +17,7 @@ properties:
     oneOf:
       items:
         - const: lantiq,asc
+        - const: intel,lgm-asc
 
   reg:
     maxItems: 1
@@ -28,6 +29,12 @@ properties:
       - description: tx or combined interrupt
       - description: rx interrupt
       - description: err interrupt
+    description:
+      For lantiq,asc compatible, it supports 3 separate
+      interrupts for tx rx & err. Whereas, for intel,lgm-asc
+      compatible, it supports combined single interrupt for 
+      all of tx, rx & err interrupts.
+
 
   clocks:
     description:
@@ -67,4 +74,14 @@ examples:
             interrupts = <112 113 114>;
     };
 
+  - |
+    asc0: serial@e0a00000 {
+            compatible = "intel,lgm-asc";
+            reg = <0xe0a00000 0x1000>;
+            interrupt-parent = <&ioapic1>;
+            interrupts = <128 1>;
+            clocks = <&cgu0 LGM_CLK_NOC4>, <&cgu0 LGM_GCLK_ASC0>;
+            clock-names = "freq", "asc";
+    };
+
 ...
-- 
2.11.0
