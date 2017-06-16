From: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: Add bindings for Mediatek MT2712 SoC Platform
Date: Fri, 16 Jun 2017 21:45:20 +0800
Message-ID: <1497620721-61444-2-git-send-email-yt.shen@mediatek.com>
References: <1497620721-61444-1-git-send-email-yt.shen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497620721-61444-1-git-send-email-yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This adds dt-binding documentation for Mediatek MT2712.
Only include very basic items: cpu, gic and uart.

Signed-off-by: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/mediatek.txt                    | 4 ++++
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt      | 1 +
 Documentation/devicetree/bindings/serial/mtk-uart.txt                 | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index c860b24..3161651 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -7,6 +7,7 @@ Required root node property:
 
 compatible: Must contain one of
    "mediatek,mt2701"
+   "mediatek,mt2712"
    "mediatek,mt6580"
    "mediatek,mt6589"
    "mediatek,mt6592"
@@ -23,6 +24,9 @@ Supported boards:
 - Evaluation board for MT2701:
     Required root node properties:
       - compatible = "mediatek,mt2701-evb", "mediatek,mt2701";
+- Evaluation board for MT2712:
+    Required root node properties:
+      - compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
 - Evaluation board for MT6580:
     Required root node properties:
       - compatible = "mediatek,mt6580-evbp1", "mediatek,mt6580";
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index a89c03b..653adb5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -16,6 +16,7 @@ Required properties:
 	"mediatek,mt6580-sysirq"
 	"mediatek,mt6577-sysirq"
 	"mediatek,mt2701-sysirq"
+	"mediatek,mt2712-sysirq"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
 - interrupt-parent: phandle of irq parent for sysirq. The parent must
diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index 0015c72..5f88e0d 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible should contain:
   * "mediatek,mt2701-uart" for MT2701 compatible UARTS
+  * "mediatek,mt2712-uart" for MT2712 compatible UARTS
   * "mediatek,mt6580-uart" for MT6580 compatible UARTS
   * "mediatek,mt6582-uart" for MT6582 compatible UARTS
   * "mediatek,mt6589-uart" for MT6589 compatible UARTS
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
