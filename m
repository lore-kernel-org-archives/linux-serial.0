From: Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH v4 04/10] dt-bindings: ARM: Mediatek: Document bindings for MT8183
Date: Tue, 31 Jul 2018 13:38:01 +0800
Message-ID: <1533015487-60189-5-git-send-email-erin.lo@mediatek.com>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, erin.lo@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

This patch adds the binding documentation for apmixedsys, audiosys,
camsys, imgsys, infracfg, mfgcfg, mmsys, topckgen, vdecsys, vencsys
and ipu for Mediatek MT8183.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
 .../bindings/arm/mediatek/mediatek,ipu.txt         | 43 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |  1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  1 +
 .../bindings/arm/mediatek/mediatek,vencsys.txt     |  1 +
 11 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index 44eaeac..fddcec8 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "mediatek,mt7622-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8173-apmixedsys"
+	- "mediatek,mt8183-apmixedsys", "syscon"
 - #clock-cells: Must be 1
 
 The apmixedsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 9a8672a..63dcc82 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2701-audsys", "syscon"
 	- "mediatek,mt6765-audsys", "syscon"
 	- "mediatek,mt7622-audsys", "syscon"
+	- "mediatek,mt8183-audiosys", "syscon"
 - #clock-cells: Must be 1
 
 The AUDSYS controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
index dc75783..918ccb6 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt6765-camsys", "syscon"
+	- "mediatek,mt8183-camsys", "syscon"
 - #clock-cells: Must be 1
 
 The AUDSYS controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
index c7057d0..aeee5c8 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6765-imgsys", "syscon"
 	- "mediatek,mt6797-imgsys", "syscon"
 	- "mediatek,mt8173-imgsys", "syscon"
+	- "mediatek,mt8183-imgsys", "syscon"
 - #clock-cells: Must be 1
 
 The imgsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index ac6aae5..1b292ec 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -14,6 +14,7 @@ Required Properties:
 	- "mediatek,mt7622-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
+	- "mediatek,mt8183-infracfg", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
new file mode 100644
index 0000000..aabc8c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
@@ -0,0 +1,43 @@
+Mediatek IPU controller
+============================
+
+The Mediatek ipu controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt8183-ipu_conn", "syscon"
+	- "mediatek,mt8183-ipu_adl", "syscon"
+	- "mediatek,mt8183-ipu_core0", "syscon"
+	- "mediatek,mt8183-ipu_core1", "syscon"
+- #clock-cells: Must be 1
+
+The ipu controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+ipu_conn: syscon@19000000 {
+	compatible = "mediatek,mt8183-ipu_conn", "syscon";
+	reg = <0 0x19000000 0 0x1000>;
+	#clock-cells = <1>;
+};
+
+ipu_adl: syscon@19010000 {
+	compatible = "mediatek,mt8183-ipu_adl", "syscon";
+	reg = <0 0x19010000 0 0x1000>;
+	#clock-cells = <1>;
+};
+
+ipu_core0: syscon@19180000 {
+	compatible = "mediatek,mt8183-ipu_core0", "syscon";
+	reg = <0 0x19180000 0 0x1000>;
+	#clock-cells = <1>;
+};
+
+ipu_core1: syscon@19280000 {
+	compatible = "mediatek,mt8183-ipu_core1", "syscon";
+	reg = <0 0x19280000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
index 859e67b..72787e7 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2712-mfgcfg", "syscon"
+	- "mediatek,mt8183-mfgcfg", "syscon"
 - #clock-cells: Must be 1
 
 The mfgcfg controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 184f159..061225e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6765-mmsys", "syscon"
 	- "mediatek,mt6797-mmsys", "syscon"
 	- "mediatek,mt8173-mmsys", "syscon"
+	- "mediatek,mt8183-mmsys", "syscon"
 - #clock-cells: Must be 1
 
 The mmsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index 3a5cad6..37485cb 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "mediatek,mt7622-topckgen"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8173-topckgen"
+	- "mediatek,mt8183-topckgen", "syscon"
 - #clock-cells: Must be 1
 
 The topckgen controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
index ea40d05..60f982d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
@@ -10,6 +10,7 @@ Required Properties:
 	- "mediatek,mt2712-vdecsys", "syscon"
 	- "mediatek,mt6797-vdecsys", "syscon"
 	- "mediatek,mt8173-vdecsys", "syscon"
+	- "mediatek,mt8183-vdecsys", "syscon"
 - #clock-cells: Must be 1
 
 The vdecsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
index 8515453..c9faa62 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2712-vencsys", "syscon"
 	- "mediatek,mt6797-vencsys", "syscon"
 	- "mediatek,mt8173-vencsys", "syscon"
+	- "mediatek,mt8183-vencsys", "syscon"
 - #clock-cells: Must be 1
 
 The vencsys controller uses the common clk binding from
-- 
1.9.1
