From: Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v6 2/8] dt-bindings: mediatek: Add smi dts binding for Mediatek MT6765 SoC
Date: Fri, 12 Jul 2019 17:43:38 +0800
Message-ID: <1562924653-10056-3-git-send-email-macpaul.lin@mediatek.com>
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

This patch adds MT6765 smi binding document

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/mediatek,smi-common.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index 01744ec6a75b..f7122d88a885 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -18,6 +18,7 @@ Required properties:
 - compatible : must be one of :
 	"mediatek,mt2701-smi-common"
 	"mediatek,mt2712-smi-common"
+	"mediatek,mt6765-smi-common", "syscon"
 	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
 	"mediatek,mt8173-smi-common"
 	"mediatek,mt8183-smi-common", "syscon"
-- 
2.18.0
