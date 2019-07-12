From: Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v6 3/8] dt-bindings: mediatek: add MT6765 power dt-bindings
Date: Fri, 12 Jul 2019 17:43:39 +0800
Message-ID: <1562924653-10056-4-git-send-email-macpaul.lin@mediatek.com>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Stephen Boyd <sboyd@kernel.org>, Sean Wang <sean.wang@mediatek.com>, Mars Cheng <mars.cheng@mediatek.com>, Owen Chen <owen.chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, Macpaul Lin <macpaul.lin@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Mars Cheng <mars.cheng@mediatek.com>

This adds power dt-bindings for MT6765

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  6 ++++++
 include/dt-bindings/power/mt6765-power.h           | 14 ++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/power/mt6765-power.h

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index 00eab7e6ff22..6109b4992522 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -10,6 +10,7 @@ domain control.
 The driver implements the Generic PM domain bindings described in
 power/power_domain.txt. It provides the power domains defined in
 - include/dt-bindings/power/mt8173-power.h
+- include/dt-bindings/power/mt6765-power.h
 - include/dt-bindings/power/mt6797-power.h
 - include/dt-bindings/power/mt2701-power.h
 - include/dt-bindings/power/mt2712-power.h
@@ -20,6 +21,7 @@ Required properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-scpsys"
 	- "mediatek,mt2712-scpsys"
+	- "mediatek,mt6765-scpsys"
 	- "mediatek,mt6797-scpsys"
 	- "mediatek,mt7622-scpsys"
 	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
@@ -38,6 +40,10 @@ Required properties:
                       enabled before releasing bus protection.
 	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
 	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
+	Required clocks for MT6765: MUX: "mm", "mfg"
+				    CG: "mm-0", "mm-1", "mm-2", "mm-3", "isp-0",
+					"isp-1", "cam-0", "cam-1", "cam-2",
+					"cam-3","cam-4"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
 	Required clocks for MT7622 or MT7629: "hif_sel"
 	Required clocks for MT7623A: "ethif"
diff --git a/include/dt-bindings/power/mt6765-power.h b/include/dt-bindings/power/mt6765-power.h
new file mode 100644
index 000000000000..d347b4ee9eed
--- /dev/null
+++ b/include/dt-bindings/power/mt6765-power.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_POWER_MT6765_POWER_H
+#define _DT_BINDINGS_POWER_MT6765_POWER_H
+
+#define MT6765_POWER_DOMAIN_CONN		0
+#define MT6765_POWER_DOMAIN_MM			1
+#define MT6765_POWER_DOMAIN_MFG_ASYNC		2
+#define MT6765_POWER_DOMAIN_ISP			3
+#define MT6765_POWER_DOMAIN_MFG			4
+#define MT6765_POWER_DOMAIN_MFG_CORE0		5
+#define MT6765_POWER_DOMAIN_CAM			6
+#define MT6765_POWER_DOMAIN_VCODEC		7
+
+#endif /* _DT_BINDINGS_POWER_MT6765_POWER_H */
-- 
2.18.0
