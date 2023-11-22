Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+E65So8"
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFF897;
	Wed, 22 Nov 2023 06:42:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so7581765a12.3;
        Wed, 22 Nov 2023 06:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700664144; x=1701268944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUFxX9SRRRyGDoDMgzIpg9Kj0aIkUdbV6wP95me/PNw=;
        b=F+E65So8EnLfusiHMdQAFbHsZmMI9Pv/fml6Xw/zZFp2d9cYxaVOqbgTBZ6qs7o+/t
         XAa/+b6yfUiU9XwUDD8lRf7WWC9C/dfGnLbYBjJPtVo+oMReBvNRJkbBOTAS52Ug2XOl
         fyOGMl67QjKoRZZifCdE7leh9s0JLJsFgbqt4UaYo57XefU4+1u7/7ht80pc5LB4FpuH
         ey0v5/Ng+a1RWNSVk73iCQXd+/0dfvWt5z+ahuapaxiBhVZHpD8fGL5+6F2pkcYSqx0v
         7pW/QMrrZ/chBZYYDhJIdLs3pZCcqoakaIdJ/zEiotzOWUt9iTqk1uZOIAY9618ITae6
         Lknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664144; x=1701268944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUFxX9SRRRyGDoDMgzIpg9Kj0aIkUdbV6wP95me/PNw=;
        b=lMSP/WRVbhKrL3z4QOCLQ6QNROZhENOYBKQ1LJDESapGJcVqhA8L8QHeWPWodhLueS
         eErYdoL71OdLy4pz6wj+WI4n39WYVxxs4qIWlyegkF84QlybDAX4nyoteEyo59o4p7Wg
         ep88nw25egyW0UA0U6Y3iQc7G6cZ7SJ9KovKIZ7X6JKril4EeEnnfbrdSyIGQ2vq5Thr
         6lfc+0sBqiXkIe6HfdS4uJZdVk3f1NjtBs7/LsNalzohn0pIVcEe3YeQAL+uzjpMB2aI
         yJUmM9P5iEh6nYuMjngq8cJkE9EIaOASGZpTFbVtuoX5CHDr5Ehu+4XmZzskaQLAa33d
         ToIg==
X-Gm-Message-State: AOJu0Yyt5rYuYge1ZrZELD6yLDGKUxVc0KnFi29KcBj7yi/zF3l31vO4
	cAwko9/hw6lL1mdzx+Rp7Qk=
X-Google-Smtp-Source: AGHT+IFK5dXEW4ujsGpPqd7dGdQoi8bAvwXl2MRkh2CAniFxYCzAEJ5gLklZnE2yuRUSqPvKJOBsIw==
X-Received: by 2002:a17:906:cb8d:b0:a00:7937:4460 with SMTP id mf13-20020a170906cb8d00b00a0079374460mr1511558ejb.25.1700664144080;
        Wed, 22 Nov 2023 06:42:24 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906349a00b00a0451802b3csm941221ejb.4.2023.11.22.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:42:23 -0800 (PST)
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
Subject: [PATCH V2 1/2] dt-bindings: serial: add Broadcom's BCMBCA family High Speed UART
Date: Wed, 22 Nov 2023 15:42:07 +0100
Message-Id: <20231122144208.21114-1-zajec5@gmail.com>
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
V2: Extend "compatible" and rename YAML file accordingly

Krzysztof: since I reworked "compatible" I didn't want to carry on your
Reviewed in case there is sth wrong with the updated schema.

 .../bindings/serial/brcm,bcmbca-hs-uart.yaml  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcmbca-hs-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcmbca-hs-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcmbca-hs-uart.yaml
new file mode 100644
index 000000000000..64ef9eee7be2
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcmbca-hs-uart.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/brcm,bcmbca-hs-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Broadband SoC High Speed UART
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
+    items:
+      - enum:
+          - brcm,bcm4908-hs-uart
+          - brcm,bcm4912-hs-uart
+          - brcm,bcm6756-hs-uart
+          - brcm,bcm6813-hs-uart
+          - brcm,bcm6846-hs-uart
+          - brcm,bcm6855-hs-uart
+          - brcm,bcm6856-hs-uart
+          - brcm,bcm6858-hs-uart
+          - brcm,bcm6878-hs-uart
+          - brcm,bcm47622-hs-uart
+          - brcm,bcm63138-hs-uart
+          - brcm,bcm63146-hs-uart
+          - brcm,bcm63158-hs-uart
+          - brcm,bcm63178-hs-uart
+      - const: brcm,bcmbca-hs-uart
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
+        compatible = "brcm,bcm63138-hs-uart", "brcm,bcmbca-hs-uart";
+        reg = <0xfffec400 0x1e0>;
+        interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.35.3

