Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC733556A
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033619; cv=none; b=fgyjMYrt1WeOePtrN/6uGT6awbwLlA823iIPVGj3N39x7IU/pb2i/lHQEJ/VhADc/34fI6JtZzNG5GTHMtMDTTM2QtDmZD5WyrnRGn705JLFmGIOzAwkudMIm4D5Zn7MQ5KPT5PbCb4UqaEnNyHLHkuWePBXTGPCH91HoPWbqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033619; c=relaxed/simple;
	bh=dZfEjbKU/ouuTZTqPmjhpmJn3Qj+z3eYR6Bl3lD/xyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXQaD7RNubFoKb+tadGzPtKG7O6AFI4gpmbcRX45MGFuJa69qJgbJIry3XCEz/ISm+dQ4aIeJelOXn1J5HZazILmcHIbZMYPFVOZ1SXIhb8GhE/CK3BlB0z7HxibagBXAbOZz641AsYkkwSlifoYPa9mg9f3Smm/luBpsObY1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=IyrgbF6F; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="IyrgbF6F"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so98479025e9.2
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 10:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033615; x=1767638415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11UWr6vQeMvr9imUXUNdMnB+gxpMnYAq1afoJQH8nw8=;
        b=IyrgbF6F0u28a5QzqGi50ibLI5sXMnrNs9w2nKZbHvTdLOMtT7fV5tB3XSXxbBin+z
         +F7iemGAgQcoJ9Flf47KNjfQBnI/iqSFjhlwBxAY1TytmO/7e4JOQPrNinsFzbE1kobm
         iwp1El2nfozKqd0uOOOIZy4E7W7vs7yG0bwPi2nR/PX0eYqAfLaqKeMcAVOr1MSg30k8
         YcRIl3dZsgbyi6YROamI3AWybGB52crReQbGZAHW/Wz+ded6FK7NZnz6cmqe3OQd5D4p
         FxFHbwh7lCbyarJxYMPPv6EjTjI0yKAlsapfEw6F7Nul42Yk6T7qVGvrs+Mor4Cok3iG
         uIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033615; x=1767638415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11UWr6vQeMvr9imUXUNdMnB+gxpMnYAq1afoJQH8nw8=;
        b=KNkRc6Vlcv34jF7ZOl4NhNbCYm5dK/3Cicn16z9MlwgKuayx0k4yT2On4Fqc9gW7iy
         N7W3qbZsUcQcdsrL8SAgdVPN0CzCCmFM3di2chEk8SGy8zpedrzOy2bM0m4742IhDe/j
         /2a6P43OxJ9jrullijVUWiFpzdniACmhtbvkwgoXyEn0EPbhBhzkWULUtPhi5gx1qZNe
         xXkWS/qmVFY9lDM73OmpLWc4qQg3PIi39G4HUjRI0v/CmEB1eszPsoVAq23tqPWIYrH2
         ipf8uFvh0SMxRY873gREtvOZ8214dpcRU2hcovUGMJ24wn4ko3ECTx4KUW7kcHXBPRHC
         Dugw==
X-Forwarded-Encrypted: i=1; AJvYcCXboPmYrkmS/6TYTIl0S5ZjwHwLXjs0MDYosESZVbS0/GCq8/X264xvoJqZAJExeWHBl+UVcdg2sS2sN9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTpf4kiaH5+/6Sy85UsAViMiSahVvpCWCt4bippNASYaBo/YP
	AKxg/vt11nda8qnAh5alv7DGn4Op1dyXzEG+ssjEr+gJQ7if10xo7j44vaFOUUrnuTE=
X-Gm-Gg: AY/fxX7bpl/W4l2fEMX6C3G7KkAQQTstLsEmiSixtBTQETGyz8UFuoi61jApNE7DGXS
	nipGz6wmoJaTQ3KvKj6VkYOD8K4/pVtWjSxzxzjpZnaM7cr7a9AojcfaEIpCySzD5hjkoaBZrLs
	v2Ui9GuYEQQ20hdP/rJKtIa1GMnCcZ0mq8Lo24x9cvrfYnV9XHiEjIj3yFxU96TlrRW7vohgC5f
	db+f33zSTPRlKm19QO77CBnhD3f8mQeiZqeTAZWxmItdOdZBos6SfcrPExx7aCnUu/RV2WSVO6P
	u56ZAPl+TE8OsqTDUthKGqb+jfQHyGrVg93cDRPYqOgFHiJSogQ0QPgMxpzPesGANL9SefI2Wmq
	8KBw1X7ky6IZgl8p1wwN9ANdpEPxGbEZpt0yYtSaRTkvNfcrv6nAVOW107fK8xQTYI+2f9sx2Tc
	ZasP7qpPLXj2D6rZe9SXHj3fTsFvh+Z2AJKHfUYL9iGgwtXNcoR0m+9IRBbmle7bfM7OsEbiv5o
	3VquJtgl1EkdvsBjFxqtj8sgkO69E1etqy6wrE=
X-Google-Smtp-Source: AGHT+IHLaRW54exoV7d2gj+gL+Rt0y3shCu9zPoBut21wi+sGprCRHwNncaVYYsnvBzR7kb1R2Xvfw==
X-Received: by 2002:a05:600c:1f84:b0:479:3a87:2093 with SMTP id 5b1f17b1804b1-47d338a6109mr230056155e9.37.1767033615044;
        Mon, 29 Dec 2025 10:40:15 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:14 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 01/15] dt-bindings: usb: Add Microchip LAN969x support
Date: Mon, 29 Dec 2025 19:37:42 +0100
Message-ID: <20251229184004.571837-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip LAN969x has DWC3 compatible controller, though limited to 2.0(HS)
speed, so document it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Fix example indentation

 .../bindings/usb/microchip,lan9691-dwc3.yaml  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
new file mode 100644
index 000000000000..08113eac74b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/microchip,lan9691-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN969x SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - microchip,lan9691-dwc3
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - microchip,lan9691-dwc3
+      - const: snps,dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Gated USB DRD clock
+      - description: Controller reference clock
+
+  clock-names:
+    items:
+      - const: bus_early
+      - const: ref
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@300000 {
+        compatible = "microchip,lan9691-dwc3", "snps,dwc3";
+        reg = <0x300000 0x80000>;
+        interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 12>, <&clks 11>;
+        clock-names = "bus_early", "ref";
+    };
-- 
2.52.0

