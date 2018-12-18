From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 02/11] dt-bindings: arm: Document RDA8810PL and reference boards
Date: Tue, 18 Dec 2018 13:35:18 +0530
Message-ID: <20181218080527.10801-3-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-unisoc@lists.infradead.org, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-serial@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add bindings for RDA Micro RDA8810PL SoC and below reference boards:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

Cc: zhao_steven@263.net
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/rda.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt

diff --git a/Documentation/devicetree/bindings/arm/rda.txt b/Documentation/devicetree/bindings/arm/rda.txt
new file mode 100644
index 000000000000..43c80762c428
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rda.txt
@@ -0,0 +1,17 @@
+RDA Micro platforms device tree bindings
+----------------------------------------
+
+RDA8810PL SoC
+=============
+
+Required root node properties:
+
+ - compatible :  must contain "rda,8810pl"
+
+
+Boards:
+
+Root node property compatible must contain, depending on board:
+
+ - Orange Pi 2G-IoT: "xunlong,orangepi-2g-iot"
+ - Orange Pi i96: "xunlong,orangepi-i96"
-- 
2.17.1
