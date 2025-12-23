Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11FE34C838
	for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521200; cv=none; b=dWU7oIqOm08/1Sw7XtskCiZWq0vpAtXpY88HM+turBwS0Mv4VJLUhVqDMGN8QipUiHGq9Eap1Qdi5LIW8t+DfsWxhUDaywJeqARwhY6qBx7RUTRi2qMxG2jIkWgzxDDi1wl2ALaYgYJZziTSNvzX+n07Q7qDSm9R8IZw0hwROxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521200; c=relaxed/simple;
	bh=YtDrhz214maGpV2hZoz5P9MBOOxn5+fyXOlqcl1OMZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3XyGnlxTEJIminAD3YaQthe0ulXGPCKuV206kMxHFlSGU8+Aq9bSFo5Wq7rklg8PNmPwoSMnZsredMH2/s04Vyapyjr8lb1jajN08DoFdHeBiM4Ici9qOjueh/gGR04t+cJghLB6jxyALSjBSApslm7XZUXogFAO32dDiJPMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Itpb3JsL; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Itpb3JsL"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7b9387df58cso8586341b3a.3
        for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 12:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521197; x=1767125997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOr56XFFvJYItbaYZCF01MB/OVR35Ya4WEl16UdXyiE=;
        b=Itpb3JsLEKrwXU7kw7Dt/7ASbLZ2yWR8oobjE6bPXQIqq9EhR3K46S+Jd9qgF1iZnX
         M8MwRyf7+/VloXbvxwQdqI/eTwDvLyUFkuhyP1+8Uu+pTqt5agyp0hSqQeQtPdYuI4+J
         vGk8rhBDC3rmSjddEsJWEWWyid1FwzSewDHgjFkbyKylAjrPWXyXBQtNzpMyvaQVctIK
         4EnhuaoBNXK5F3hqvYKe/Uz9NXdVSywebgvzt7pzux4Q16SG9pLQEzcwKX825//VAgJQ
         tV+Ox13CxdCy3hhSw0eAyPUj1VKUsud3aHOI6GeAhdmnvfcg0/24TS0s9NLGlRfGB7Gc
         /d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521197; x=1767125997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOr56XFFvJYItbaYZCF01MB/OVR35Ya4WEl16UdXyiE=;
        b=StXef+mYYInI3B/QWg75AZ1PAj0Ljdlww0vQ865JOqIwvp0q4eluR931L8hyI/1LBE
         WBCD70TX769FBJDSCH+TuXG8b0bgmvXDahs/b3wzO7F88M7P/YMq53Is6bJSSQwAGr+R
         PgBmjiBcBDddyNL6xDtj5eqvGmEv+FE5ioPTsJKEsNmVDTFRE5tmbTq+K632F5geCPJ4
         e8JZSh/FC8ueD8UjZKU7RkpdPYaFYgwKCclbcCQP61v1JUn/sQxnd+P+GDfFkP1jId0L
         kNh4Gbm/XuwBIugKNzH4n8d1zreDhpbCPc+r6KY3rxbE6ekZQ+WXjGFFeTfslIjxoaV6
         8h0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSa85TGPweJlutn01bLXYrhZf18d6rV87EBxheHIaq6nNqbb9YUNKk4NOMOP/1ZHsaEH5tujdVZjdF94c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbjQA60X2MAgye7y0wTR1QAvB//hKruT3Dkr5GVs3/EV7vLzX
	TK1esJC7ZnKFBFJsf8pvrB5qR/BPSiQ4dErXUaZ8XeRESzVBFz9oqNdxGin3X3Agdtk=
X-Gm-Gg: AY/fxX5BDgwyjz0l3itNTmSuWOfvSH+YIKNi0qbYw64JMs8f8Sy2eOrOBjO8oj4Vw/h
	MaKYGh4ae3ioNkVaSpjOj8cSJ/mXbWKQDgG7M4SxSVKpmMpQbFHghGhULdz8TUidDRLsiydbSUP
	lmRLDE77ZzMOoTvJ43+ym7ziXO5WKM/+9aLdJO2X6EkiAQUgCYgwa2W6pDx6c7ud4ClQHqW8JVL
	taJZdyLSq5YBI0ATRFKQ+tvoXRFByUluuaj7nFQgLfztB3sU5BqQsfcJ5626vWG+7aj9wJkXT87
	sVbW2PiFA8kh8I4S4LYPDmWYEifcYJKsITR0ghUAjhLGtJ04Dg23E9s0ZAYZGKBrfhfSQcWTSik
	b1mxXBO8M0awrl5HQ9x+9JT75rAnkexIae2X0HD1B2lnXTPcnrDY/xUYc+0BNaDFMbOH/5xTMgU
	qcQfTo5BxSjgNTozxbcC6zz6cdwfDv1wV0vzHgOx7SNMCHMbMfXn2In9HiuzbZd7atFD8TBYEAN
	3SPZcyU
X-Google-Smtp-Source: AGHT+IEPFyQyinZIGZrAoM6IvYr08l7wEvqvRLZX8wkQv3+jdTfbwpmbaxqGPLI1nIRPqBYzainggQ==
X-Received: by 2002:a05:6a20:430f:b0:350:8066:6ebd with SMTP id adf61e73a8af0-376a81dcc63mr16097918637.13.1766521196919;
        Tue, 23 Dec 2025 12:19:56 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:19:56 -0800 (PST)
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
	mturquette@baylibre.com,
	sboyd@kernel.org,
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
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 02/15] dt-bindings: usb: Add Microchip LAN969x support
Date: Tue, 23 Dec 2025 21:16:13 +0100
Message-ID: <20251223201921.1332786-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
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

 .../bindings/usb/microchip,lan9691-dwc3.yaml  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
new file mode 100644
index 000000000000..6b49ef0a6bdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
@@ -0,0 +1,68 @@
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
+    #include <dt-bindings/clock/microchip,lan9691.h>
+
+    usb@300000 {
+        compatible = "microchip,lan9691-dwc3", "snps,dwc3";
+        reg = <0x300000 0x80000>;
+        interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks GCK_GATE_USB_DRD>,
+                 <&clks GCK_ID_USB_REFCLK>;
+        clock-names = "bus_early", "ref";
+    };
-- 
2.52.0

