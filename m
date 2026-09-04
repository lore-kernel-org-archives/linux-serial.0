Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D333ADB1;
	Fri,  4 Sep 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506445; cv=none; b=HQARXXYl2Nri+0ofG2uu1v/hI8tNCSAI+D/KYqCjkpqMYep0Drfq0LfA7jjoH5ZhP8uJZAf6oJBqvEfN5//roC/he3C4qMxFNsWs2zo7J1lxi8rfMt5LNYOgY8lxiZBcm7HcNgUc2fzA1q45K60/YMlfs1+k8RD5sLR2GYi2PM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506445; c=relaxed/simple;
	bh=4rkIqhiFZ+ckd5oYz8vYuz3Be33jfMutifDJIifJ1RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qywk7zzMBEA9TIQAZ0TcLmVWDHIJeL5VBrEJ+c05qC5rwK3uLIhvKd7m8l1xbfG67FWk3ykk1b9u59EQIiXZejOk5FJah1YiCtwu06KB5jsyWPVeG8UT9H++BGqSlcdL4cfvrIguaHZIT2OIYWtHZta5PqxXKCvOgO3JCM4MDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=115.124.28.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edatec.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07520165|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0558124-0.000237189-0.94395;FP=2433230913876478079|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.j5G7ho4_1788506430;
Received: from LAPTOP-VQRD5F43.hs.edatec.cn(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.j5G7ho4_1788506430 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 15:20:30 +0800
From: zjzhao <zjzhao@edatec.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: serial: Document WK2xxx SPI UART bindings
Date: Fri,  4 Sep 2026 15:20:27 +0800
Message-ID: <20260904072027.67473-3-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904072027.67473-1-zjzhao@edatec.cn>
References: <20260904072027.67473-1-zjzhao@edatec.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DT binding for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
WK2168, WK2202 and WK2204) from WKmic (Chengdu Weikai Microelectronics),
covering the compatible strings, SPI properties, the optional interrupt
line and the crystal clock frequency. Also register the wkmic vendor
prefix.

Signed-off-by: zjzhao <zjzhao@edatec.cn>
---
 .../bindings/serial/wkmic,wk2xxx.yaml         | 69 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml

diff --git a/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml b/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
new file mode 100644
index 000000000000..0ef76957d73f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
@@ -0,0 +1,69 @@
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
+  through a single SPI slave interface and one interrupt line.
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
+      no internal clock, so this must match the connected crystal. Defaults
+      to 11059200 Hz when the property is absent.
+    minimum: 1
+    maximum: 30000000
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/serial/serial.yaml#
+  - $ref: /schemas/serial/rs485.yaml#
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
+        };
+    };
\ No newline at end of file
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

