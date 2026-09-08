Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022F35674F;
	Tue,  8 Sep 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863543; cv=none; b=PPBJ3HHcY+8zJpvuCqlEHcpwvhZRckM0suygSCY4/h9XFaUyyuf6X5tZZ1ZbIJk9YFz0pnxisLFAZOR6jfl9LMqeO9VyuSaxeh2uw/TlAcjPyfzAE/0cIorcXyvGZmKO+x2ON3vaNlOhwjvnJe525BLdFxKcTRDepy6nKsARnpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863543; c=relaxed/simple;
	bh=Zi91LqRkuVLQXvH11hWAxwghl7xwyTyO/8NDs+wrHX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzY9TYMrv6OmmrDPzoOGbtMrdJYrAam4xISGBR2Dd/GlFMNYT+vj3zOOvElSEbzjTTPPBvm9+/e4ETuxSnJK6zUZuzoc6gVN9UQTK2C4vpoBpxKAfwUfvSQW5qRz8C+Rt6R6E4q+6r3CUHQHQtQOtQ02tLuCJTZP3Tlr/X4BdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edatec.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07447642|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0904501-0.000260663-0.909289;FP=6971777417682294847|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.j8fKT.D_1788863528;
Received: from LAPTOP-VQRD5F43.hs.edatec.cn(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.j8fKT.D_1788863528 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 18:32:09 +0800
From: zjzhao@edatec.cn
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	Zi Jie Zhao <zjzhao@edatec.cn>
Subject: [PATCH v4 1/2] dt-bindings: serial: Document WK2xxx SPI UART
Date: Tue,  8 Sep 2026 18:31:28 +0800
Message-ID: <20260908103129.58085-2-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908103129.58085-1-zjzhao@edatec.cn>
References: <20260908103129.58085-1-zjzhao@edatec.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Jie Zhao <zjzhao@edatec.cn>

Add a DT binding for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
WK2168, WK2202 and WK2204) from Chengdu Weikai Microelectronics (WKmic).
Describe each UART channel with a serial@N child node carrying its serial
and RS-485 properties. Register the wkmic vendor prefix based on the vendor
website http://www.wkmic.com/.

Differentiate compatible strings by channel count and
register availability. Account for missing hardware flow-control and
RS-485 registers on WK2132 and WK2202. Reject serial@2 and serial@3 on the
two-channel members.

Require the standard clocks property for the single external reference
clock used by the chips.

Signed-off-by: Zi Jie Zhao <zjzhao@edatec.cn>
---
 .../bindings/serial/wkmic,wk2124.yaml         | 119 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml

diff --git a/Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml b/Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml
new file mode 100644
index 000000000000..0f6ba8755e1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/wkmic,wk2124.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WKmic WK2xxx SPI to UART bridge
+
+maintainers:
+  - Zi Jie Zhao <zjzhao@edatec.cn>
+
+description:
+  The WK2xxx family (WK2124, WK2132, WK2168, WK2202 and WK2204) are SPI to
+  UART bridge ICs from WKmic (Chengdu Weikai Microelectronics). Each IC
+  exposes two or four full-duplex UART channels with 256-byte RX/TX FIFOs
+  through a single SPI slave interface and one interrupt line, and is
+  clocked from a single external reference clock. Each channel is
+  described by a "serial@N" child node that carries its own serial and
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
+  clocks:
+    maxItems: 1
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
+  - clocks
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
+
+    xtal: clock-11059200 {
+        compatible = "fixed-clock";
+        clock-frequency = <11059200>;
+        #clock-cells = <0>;
+    };
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        serial@0 {
+            compatible = "wkmic,wk2132";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            clocks = <&xtal>;
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
index ba2002969373..cdc04229d642 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1907,6 +1907,8 @@ patternProperties:
     description: Wireless Tag (qiming yunduan)
   "^wits,.*":
     description: Shenzhen Merrii Technology Co., Ltd. (WITS)
+  "^wkmic,.*":
+    description: Chengdu Weikai Microelectronics Co., Ltd. (http://www.wkmic.com/)
   "^wlf,.*":
     description: Wolfson Microelectronics
   "^wm,.*":
-- 
2.43.0

