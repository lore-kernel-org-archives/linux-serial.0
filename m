Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOe3qK+O"
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B28138;
	Tue, 21 Nov 2023 04:13:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso3495614e87.2;
        Tue, 21 Nov 2023 04:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700568816; x=1701173616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7UfF03aFW8pU9c+r1UvFEE/P/vOUgmToy8+7mpAO2k=;
        b=BOe3qK+OURUfxk+pG8tnVir81R1J/o93J0FngHdvhFPLTtzgOyS2FWIvqb1aotTqqh
         I/AAFuPv1wcaYP+1geiV97fkQooQMAHaaVA0Z3tj+gJ8AvM+a2ehj2/Q3wq9jaZqcXsy
         0fU0M7UWpxf/Bf/TxoKUbq6jP5B1g78lyOvdXlWMjhOHCykUZ6g+mz750oiGxfny9o6c
         6OL8z21APtVDY6fQ+Gqrx+wFQsnZvCnAqxLw70L2zbmF0ZGCtagbEMnVrv8ZX10TDqEU
         jVmmqt5SlcKELkdn14qlp7sfjSr0543Kn+/b6v0eFdtNpw8oZf019mFlb8B7TjTPob+U
         njzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700568816; x=1701173616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7UfF03aFW8pU9c+r1UvFEE/P/vOUgmToy8+7mpAO2k=;
        b=g9OYJSPclphWyccJ7X4DlU4Mhi1brV4s3U6qqH5rXs030ktzJfjjdFBnvRdNiQofAx
         jj9seHgMLOQKAuma2Ar6DSYvW2HFk6nHbDyPgLqS+3gibtjbT74mseea7AugyoDgSoYS
         W8+saU9EP2PfX8vsiiz83sBUwketPnJOh5hbNzuFlnyDln/ru3iv6kgfaruGzfq9MW90
         LBLwsG/sGi1xV3/20DbACIz3A0Xh6mn43KZ5jMD//ePPwq1zUP07XUMNnvEuMV4GxpR5
         qAscxOaa3kP9tFOo4+bC7TG2vfAz/7grqvId9B2cx/xtLMXIKd533pCS1WZ8bvw/cagj
         zpkg==
X-Gm-Message-State: AOJu0YxVMEMyCbl1N6m71cz4XDH0vmjv3CI04hqV315jhXSZkDikvTMv
	WBKFEt+0kx3XHgM0oOiS9hU=
X-Google-Smtp-Source: AGHT+IHnzRgG6T/vXqZ5Z5y+FyUQGY6HyIWa6ogjFbkYgNzu1OMiyW1eeI2ple/rNNjzvWioLFK1Tw==
X-Received: by 2002:ac2:4919:0:b0:50a:9652:31d4 with SMTP id n25-20020ac24919000000b0050a965231d4mr7301177lfi.22.1700568816393;
        Tue, 21 Nov 2023 04:13:36 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z15-20020ac2418f000000b005079ff02b36sm1491509lfh.131.2023.11.21.04.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 04:13:36 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: serial: add Broadcom's BCM63138 High Speed UART
Date: Tue, 21 Nov 2023 13:13:23 +0100
Message-Id: <20231121121324.23268-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

It's an UART controller that first appeared on BCM63138 SoC and then was
reused on other bcmbca familiy chipsets.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../serial/brcm,bcm63138-hs-uart.yaml         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm63138-hs-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm63138-hs-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm63138-hs-uart.yaml
new file mode 100644
index 000000000000..91a7e945be39
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm63138-hs-uart.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/brcm,bcm63138-hs-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom's BCM63138 High Speed UART
+
+description:
+  High speed serial port controller that was designed to handle Bluetooth
+  devices communication. It supports sending custom frames that need to be
+  processed by a host system.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm63138-hs-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@fffec400 {
+        compatible = "brcm,bcm63138-hs-uart";
+        reg = <0xfffec400 0x1e0>;
+        interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.35.3

