From: Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v3 2/4] dt-bindings: mtk-uart: add mt6765 uart bindings
Date: Wed, 4 Jul 2018 09:52:52 +0800
Message-ID: <1530669174-17623-3-git-send-email-mars.cheng@mediatek.com>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mars Cheng <mars.cheng@mediatek.com>
List-Id: linux-serial@vger.kernel.org

Add documentation for mt6765 uart dt-bindings

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 1 file changed, 1 insertion(+)

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
