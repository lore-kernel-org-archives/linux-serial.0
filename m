From: Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v5 02/11] dt-bindings: mediatek: Add smi dts binding for Mediatek MT6765 SoC
Date: Tue, 17 Jul 2018 16:52:23 +0800
Message-ID: <1531817552-17221-3-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Stephen Boyd <sboyd@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Mars Cheng <mars.cheng@mediatek.com>, Owen Chen <owen.chen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

This patch adds MT6765 smi binding document

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 .../memory-controllers/mediatek,smi-common.txt     |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index aa614b2..0bf64f5 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -15,6 +15,7 @@ not needed for SMI generation 2.
 Required properties:
 - compatible : must be one of :
 	"mediatek,mt2701-smi-common"
+	"mediatek,mt6765-smi-common", "syscon"
 	"mediatek,mt8173-smi-common"
 - reg : the register and size of the SMI block.
 - power-domains : a phandle to the power domain of this local arbiter.
-- 
1.7.9.5
