From: Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH v2 1/4] dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
Date: Mon, 14 May 2018 18:22:28 +0800
Message-ID: <1526293351-32794-2-git-send-email-erin.lo@mediatek.com>
References: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, erin.lo@mediatek.com, mars.cheng@mediatek.com
List-Id: linux-serial@vger.kernel.org

This adds dt-binding documentation of cpu for Mediatek MT8183.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab3..2754535 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -19,6 +19,7 @@ compatible: Must contain one of
    "mediatek,mt8127"
    "mediatek,mt8135"
    "mediatek,mt8173"
+   "mediatek,mt8183"
 
 
 Supported boards:
@@ -73,3 +74,6 @@ Supported boards:
 - MTK mt8173 tablet EVB:
     Required root node properties:
       - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
+- Evaluation board for MT8183:
+    Required root node properties:
+      - compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
-- 
1.9.1
