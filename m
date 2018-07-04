From: Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v3 1/4] dt-bindings: mediatek: add support for mt6765 reference board
Date: Wed, 4 Jul 2018 09:52:51 +0800
Message-ID: <1530669174-17623-2-git-send-email-mars.cheng@mediatek.com>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mars Cheng <mars.cheng@mediatek.com>
List-Id: linux-serial@vger.kernel.org

Update binding document for mt6765 reference board

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
 1 file changed, 4 insertions(+)

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
-- 
1.7.9.5
