Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE2446066;
	Fri,  4 Sep 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514440; cv=none; b=bKgJjTd4xl4DOuTD9REdIGL7BJ1LV8Yph9Vemrj6ZPnuav8lnh1Cvlb0G/HzykY1ait7xIP7ynZS+Fwz1ilB66PVs3zaHRcQbWZjJIKwBRA/Z3ifbjhBWcRTYhDtPplrT22wAwMBqTHoiFbdSgucUGiE4N3r3POf6Jykp5AAyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514440; c=relaxed/simple;
	bh=mmVVkjaxQrPvd10pnXeKHLKojut6MW+VjQij8vMQ/F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2OJkH/5aoMOT8t8v7aZqNYxkqDYfhO5RnDqM0LNRqZkKvi34l+jeUC4kiBVAE5nRKjaKKuwmzJbFPzWC+p2lloxS/2+273+2q5NjHv37ClKxp9t6g4/tBCm3uZKW3WSM0Afl8qqnmUKKM26HcuUAh4WF0TDGKF6wqLT1tdgw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edatec.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07556923|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0321833-0.000742987-0.967074;FP=7620251922072146047|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.j5Rtev5_1788514426;
Received: from LAPTOP-VQRD5F43.hs.edatec.cn(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.j5Rtev5_1788514426 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 17:33:48 +0800
From: zjzhao@edatec.cn
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	zjzhao <zjzhao@edatec.cn>
Subject: [PATCH v2 2/2] dt-bindings: serial: Document WK2xxx SPI UART bindings
Date: Fri,  4 Sep 2026 17:33:40 +0800
Message-ID: <20260904093341.100826-3-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904093341.100826-1-zjzhao@edatec.cn>
References: <20260904072027.67473-1-zjzhao@edatec.cn>
 <20260904093341.100826-1-zjzhao@edatec.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zjzhao <zjzhao@edatec.cn>

Add a DT binding for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
WK2168, WK2202 and WK2204) from WKmic (Chengdu Weikai Microelectronics).
Each UART channel is described by a serial@N child node that carries its
own serial and RS-485 properties. Also register the wkmic vendor prefix.

Signed-off-by: zjzhao <zjzhao@edatec.cn>
---
 .../bindings/serial/wkmic,wk2xxx.yaml         | 115 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 2 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml

diff --git a/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml b/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
new file mode 100644
index 000000000000..c781482c0f2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/wkmic,wk2xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WKmic WK2xxx SPI to UART bridge
+
+maintainers:
+  - EDATEC Technology Co., Ltd. <zjzhao@edatec.cn>
+
+description:
+  The WK2xxx family (WK2124, WK2132, WK2168, WK2202 and WK2204) are SPI to
+  UART bridge ICs from WKmic (Chengdu Weikai Microelectronics). Each IC
+  exposes two or four full-duplex UART channels with 256-byte RX/TX FIFOs
+  through a single SPI slave interface and one interrupt line. Each channel
+  is described by a "serial@N" child node that carries its own serial and
+  RS-485 properties.
+
+properties:
+  compatible:
+    enum:
+      - wkmic,wk2124
+      - wkmic,wk2132
+      - wkmic,wk2168
+      - wkmic,wk2202
+      - wkmic,wk2204
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      When missing, the device driver uses polling instead.
+    maxItems: 1
+
+  clock-frequency:
+    description:
+      Crystal or external clock frequency for the IC in Hz. The WK2xxx has
+      no internal clock, so this must match the connected crystal.
+    default: 11059200
+    minimum: 1
+    maximum: 30000000
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^serial@[0-3]$":
+    type: object
+    description: A single UART channel of the chip.
+    allOf:
+      - $ref: /schemas/serial/serial.yaml#
+      - $ref: /schemas/serial/rs485.yaml#
+    properties:
+      reg:
+        description: UART channel number on the chip.
+        maximum: 3
+    required:
+      - reg
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - wkmic,wk2132
+              - wkmic,wk2202
+    then:
+      patternProperties:
+        "^serial@[23]$": false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        serial@0 {
+            compatible = "wkmic,wk2132";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            clock-frequency = <11059200>;
+            interrupt-parent = <&gpio>;
+            interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            serial@0 {
+                reg = <0>;
+            };
+
+            serial@1 {
+                reg = <1>;
+                rs485-rts-active-low;
+                linux,rs485-enabled-at-boot-time;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..654fc8525559 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1907,6 +1907,8 @@ patternProperties:
     description: Wireless Tag (qiming yunduan)
   "^wits,.*":
     description: Shenzhen Merrii Technology Co., Ltd. (WITS)
+  "^wkmic,.*":
+    description: Chengdu Weikai Microelectronics Co., Ltd.
   "^wlf,.*":
     description: Wolfson Microelectronics
   "^wm,.*":
-- 
2.43.0

