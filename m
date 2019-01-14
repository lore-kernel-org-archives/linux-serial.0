From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: serial: Move renesas,rzn1-uart into the snps-dw-apb-uart binding
Date: Mon, 14 Jan 2019 11:29:30 -0600
Message-ID: <20190114172930.7508-2-robh@kernel.org>
References: <20190114172930.7508-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114172930.7508-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Phil Edworthy <phil.edworthy@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The renesas,rzn1-uart binding only differs in compatible string from the
snps-dw-apb-uart binding. Move it there, converting it to json-schema in
the process.

Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Move Renesas compatible strings to this patch

 .../devicetree/bindings/serial/renesas,rzn1-uart.txt   | 10 ----------
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml   |  5 +++++
 2 files changed, 5 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt b/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
deleted file mode 100644
index 8b9e0d4dc2e4..000000000000
--- a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Renesas RZ/N1 UART
-
-This controller is based on the Synopsys DesignWare ABP UART and inherits all
-properties defined in snps-dw-apb-uart.txt except for the compatible property.
-
-Required properties:
-- compatible : The device specific string followed by the generic RZ/N1 string.
-   Therefore it must be one of:
-   "renesas,r9a06g032-uart", "renesas,rzn1-uart"
-   "renesas,r9a06g033-uart", "renesas,rzn1-uart"
diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 3e90c790d720..b42002542690 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -15,6 +15,11 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - renesas,r9a06g032-uart
+              - renesas,r9a06g033-uart
+          - const: renesas,rzn1-uart
       - items:
           - enum:
               - rockchip,px30-uart
-- 
2.19.1
