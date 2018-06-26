From: Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for mediatek MT6765 Platform
Date: Tue, 26 Jun 2018 10:04:05 +0800
Message-ID: <1529978646-28976-2-git-send-email-mars.cheng@mediatek.com>
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Cc: CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, Miles Chen <miles.chen@mediatek.com>, Jades Shih <jades.shih@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, My Chuang <my.chuang@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mars Cheng <mars.cheng@mediatek.com>
List-Id: linux-serial@vger.kernel.org

This adds dt-binding documentation for Mediatek MT6765. Only
include very basic items, gic, uart timer and cpu.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
 .../interrupt-controller/mediatek,sysirq.txt       |    1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab3..48fac4e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -11,6 +11,7 @@ compatible: Must contain one of
    "mediatek,mt6589"
    "mediatek,mt6592"
    "mediatek,mt6755"
+   "mediatek,mt6765"
    "mediatek,mt6795"
    "mediatek,mt6797"
    "mediatek,mt7622"
@@ -41,6 +42,9 @@ Supported boards:
 - Evaluation phone for MT6755(Helio P10):
     Required root node properties:
       - compatible = "mediatek,mt6755-evb", "mediatek,mt6755";
+- Evaluation board for MT6765(Helio P22):
+    Required root node properties:
+      - compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
 - Evaluation board for MT6795(Helio X10):
     Required root node properties:
       - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 07bf0b9..c8eda80 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -11,6 +11,7 @@ Required properties:
 	"mediatek,mt7622-sysirq", "mediatek,mt6577-sysirq": for MT7622
 	"mediatek,mt6795-sysirq", "mediatek,mt6577-sysirq": for MT6795
 	"mediatek,mt6797-sysirq", "mediatek,mt6577-sysirq": for MT6797
+	"mediatek,mt6765-sysirq", "mediatek,mt6577-sysirq": for MT6765
 	"mediatek,mt6755-sysirq", "mediatek,mt6577-sysirq": for MT6755
 	"mediatek,mt6592-sysirq", "mediatek,mt6577-sysirq": for MT6592
 	"mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq": for MT6589
diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index f73abff..742cb47 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -8,6 +8,7 @@ Required properties:
   * "mediatek,mt6582-uart" for MT6582 compatible UARTS
   * "mediatek,mt6589-uart" for MT6589 compatible UARTS
   * "mediatek,mt6755-uart" for MT6755 compatible UARTS
+  * "mediatek,mt6765-uart" for MT6765 compatible UARTS
   * "mediatek,mt6795-uart" for MT6795 compatible UARTS
   * "mediatek,mt6797-uart" for MT6797 compatible UARTS
   * "mediatek,mt7622-uart" for MT7622 compatible UARTS
-- 
1.7.9.5
