Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BE3D79FB
	for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090947; cv=none; b=geyBrhOQJDStf8F01AzOqEINAg0nQXL6zuMC9aibMiEj/J+TXYMIzoVBDxXVPpCxkdJ7m+pLHVpGBYB7h2eAAZbytB90g6izl+T+UzpQo+gcj4A7lcJl9faXC3vir336XoKd+iASr6sYMTbvTeJgXEK+K4gePBsvO4DdCuktRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090947; c=relaxed/simple;
	bh=fJ/X2iMoUiRd4gZpRf8wNUnMn9HbcgDtYX8aA5wPIMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kllElKH7dCiOUngFoBL/uFRTmefpahW5Cd8zFddrKS4UuM4kBSpcBziC6wOqAL7PXt3649X8JFqTcjQwDdS5jOJUw/77ekqEztc09XXJevNiHjB/JiKx4JtabU3M7YNmzhplXGnD+DHH66DnZ77bvQgp2LeVyhYkIPPOc5U4+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bibuHV0U; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bibuHV0U"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b903567fdso6675881a91.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781090944; x=1781695744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA6ihoM1lqsXloyq8orrS5aE2lQH5FPEqZNihMpid8o=;
        b=bibuHV0UsfcXyutMNZyHkGE6QOYfC0gxv23qr2wK2QQeZxiqneFsq6YagsrHeMAPJ6
         OG+JSI9pNtHKXhdHHoWyM3SDAzX6YdNkjMACYPYMxJCVuXy4gYpzCzJdFe3w0mh8ETEp
         FPwpruzS1znb5hVBfN8HTwvk0ymqv9jJfBeph6Z0fTDp1I0WIxno0SouY3pJ74aAgNJO
         OZiOhg39QbqXC/Sd8OZpeZdEz4X4eVmeIU8fHfg8+mqIkrpFX5MzKI531IKdlDL1R/lg
         DW460hVv9rvxJNW4yTL64Oz/fbA8fm3JVbneqUMVVfSEYYbO0IJRfHkaWLatb2cc9BLk
         5jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090944; x=1781695744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WA6ihoM1lqsXloyq8orrS5aE2lQH5FPEqZNihMpid8o=;
        b=sOdReNagVjumIhRESoWQ3uGMmtzuWi7TzVyN5ys+RDFWP+oD6vAXZM5l6QDE+zOc9V
         kP9gXQ7mXMhh7dA32tkJhrJujXX2pCyrk98Iq1MfkJQfQK5yplYbhoLejpBZ6kX2Ow/b
         mlOFazdK6szByJ7n3cWwFdEyRdsB/rDYsvLlKqHDQamo4EE/Fj+pCH3hmHMFvXne2j9D
         MBzD+H8p96GjJEI5v6Gxtb4ERjhYQcw4SiQ++Sl0JZ2Hh/XeijSA/OY09bxvXozu51DZ
         lhypBHI5MPBAqawfipkucGNf9E6/4o+CSKrGFuGiQNFZezGgZo865mgQEuKOcC15Lhb3
         4ZLA==
X-Forwarded-Encrypted: i=1; AFNElJ8CnHiEKAN7zSl7rIb8sDbkNLac6/0d9ChPosImvNqN+vz+EnPbd8+fXKgLXePX1Htyn89bBkwdC1gEcag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJu4+zE/aO6TIIQ5+oVqC61acPsVvs2MqpXEDj7F8lnqqMhBP
	Ti6D84Xm8NX6VHsrgbxugXM6qe3BUCEow736rTwK2sb8eSV1M8BvSYDA
X-Gm-Gg: Acq92OGvgLiVUlzI4hChb+Uc06gNA1ncLi0LmvgxgumcPugeXh18lYsqLusQeyAynoP
	U6a6LCRPSDLAsdwj4DgE+Uth2Gy7en7Hl1G8J5oS5PpAIp9CfJo3IWiifNqYaNC0JyGBZcgXOCm
	YNhZ6LHpc/r8g9HesqzyWDydEeE5tCtMrOodz5x/oknNlspa9bUfDCEpBeU420AYfRPcj6vpxq1
	HKB5O1Oc29OIzJjBnFJRPgg0wa3/sXFoNAtCrYKy9npnRpb8T63ISdMQr8uDNXOaN4c2muWDpPN
	8ba0lnvclwflYXp79ffmXFNbeBJnJ1BJBVZq5359xvd7heLJkkzxGmJF6aoG2aeKcR2sOoIL5xE
	q9Oq94LzNh7nxCEDfB/BZjO6IZw3HuwG4jztqXpaHXgpaT9eTzvl9tof9OFYN+eoPkT7lX+5bmV
	oMfJbEpY2/CBwP9gmkDKz97HLNRKKupgbPBbO8rQfN/xTQOEFJJjBPDA==
X-Received: by 2002:a17:90b:5783:b0:36d:ae6a:22ed with SMTP id 98e67ed59e1d1-370f0f43e72mr27042985a91.22.1781090944288;
        Wed, 10 Jun 2026 04:29:04 -0700 (PDT)
Received: from hc-pb-01.realtek.com ([123.51.179.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-376460ee14fsm2027651a91.1.2026.06.10.04.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:29:03 -0700 (PDT)
From: Jason Li <jason.lee651024@gmail.com>
X-Google-Original-From: Jason Li <jason.li@cortina-access.com>
To: jason.li@cortina-access.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: serial: Add binding for Cortina-Access UART
Date: Wed, 10 Jun 2026 19:28:19 +0800
Message-Id: <20260610112821.3030099-3-jason.li@cortina-access.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260610112821.3030099-1-jason.li@cortina-access.com>
References: <20260610112821.3030099-1-jason.li@cortina-access.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT binding schema for the Cortina-Access UART controller.
This IP is integrated into most CAXXXX SoC family members.

Also add the vendor prefix for Cortina Access, Inc. and the
top-level ARM board binding document for the CA8289 (Venus) SoC.

Signed-off-by: Jason Li <jason.li@cortina-access.com>
Assisted-by: Claude:claude-opus-4-8
---
 .../bindings/arm/cortina-access.yaml          | 29 ++++++++++++
 .../serial/cortina-access,serial.yaml         | 46 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  7 +++
 4 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cortina-access.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/cortina-access,serial.yaml

diff --git a/Documentation/devicetree/bindings/arm/cortina-access.yaml b/Documentation/devicetree/bindings/arm/cortina-access.yaml
new file mode 100644
index 000000000000..ec0320ed0c0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cortina-access.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cortina-access.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina-Access SoC boards
+
+maintainers:
+  - Jason Li <jason.li@cortina-access.com>
+
+description:
+  Boards based on Cortina-Access ARMv8 SoCs targeting networking and
+  access applications.
+
+properties:
+  $nodename:
+    const: /
+  compatible:
+    oneOf:
+      - description: Cortina-Access CA8289 (Venus) engineering board
+        const: cortina-access,ca8289-engboard
+
+      - description: Cortina-Access CA8289 (Venus) reference board
+        const: cortina-access,ca8289-refboard
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/serial/cortina-access,serial.yaml b/Documentation/devicetree/bindings/serial/cortina-access,serial.yaml
new file mode 100644
index 000000000000..5d7fdd954491
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cortina-access,serial.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/cortina-access,serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina-Access UART controller
+
+maintainers:
+  - Jason Li <jason.li@cortina-access.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: cortina-access,serial
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@f4329188 {
+        compatible = "cortina-access,serial";
+        reg = <0 0xf4329188 0 0x30>;
+        interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&apb_pclk>;
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index dd94c50e97f9..837e2a92e7e8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -367,6 +367,8 @@ patternProperties:
     description: Chengdu Corpro Technology Co., Ltd.
   "^corechips,.*":
     description: Shenzhen Corechips Microelectronics Co., Ltd.
+  "^cortina-access,.*":
+    description: Cortina Access, Inc.
   "^cortina,.*":
     description: Cortina Systems, Inc.
   "^cosmic,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 20bd55913b2d..cc261888fae0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2820,6 +2820,13 @@ F:	tools/perf/tests/shell/lib/*coresight*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
+ARM/CORTINA-ACCESS VENUS ARM ARCHITECTURE
+M:	Jason Li <jason.li@cortina-access.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/cortina-access.yaml
+F:	Documentation/devicetree/bindings/serial/cortina-access,serial.yaml
+
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linusw@kernel.org>
-- 
2.39.5

