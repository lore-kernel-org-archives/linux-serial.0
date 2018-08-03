From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [PATCH v2 05/18] dt-binding: MIPS: Add documentation of Intel MIPS SoCs
Date: Fri,  3 Aug 2018 11:02:24 +0800
Message-ID: <20180803030237.3366-6-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Songjun Wu <songjun.wu@linux.intel.com>, James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

From: Hua Ma <hua.ma@linux.intel.com>

This patch adds binding documentation for the
compatible values of the Intel MIPS SoCs.

Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2:
- New patch split from previous patch
- Add the board and chip compatible in dt document

 Documentation/devicetree/bindings/mips/intel.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/intel.txt

diff --git a/Documentation/devicetree/bindings/mips/intel.txt b/Documentation/devicetree/bindings/mips/intel.txt
new file mode 100644
index 000000000000..ac594ef303b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/intel.txt
@@ -0,0 +1,17 @@
+Intel MIPS SoC device tree bindings
+
+1, SoCs
+
+Each device tree must specify a compatible value for the Intel SoC
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+  intel,xrx500
+
+2, Boards
+
+Each device tree must specify a compatible value for the Intel Board
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+  intel,easy350-anywan
-- 
2.11.0
