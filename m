Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827DC374AC0
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847099; cv=none; b=dBXNzuBnGkh7kUoIh+vrE7rMM1nUgYw7B/ozn2J+SQa/DKH5ygiTGznLxRKCfoFrjQNdApRT56cfyhRPvRVThQo6/TQFXWO/SM2qXzFgtIcPfXi06qRiywK85n78oH3OThw6M8vm4MU0HQLLgIXd/DvlXsgTEspv1yytL9vk04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847099; c=relaxed/simple;
	bh=3z2mhzRxyfQNv1R0hi7ZTnOWImB9S2k6FugjQXRhwUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYxz9lDQD5RnvXBk/ekS0xI+449wmL0X3uogMh4T6XZYTAJQAJNGhTaFd9DdShbk0gWeqyzfoxHbNDB4TGXKRykkoUlRoEoEi72dDOfhgc0mhSXdRtdlG8gFlhMedFprufViBoTYCxw0VhwXC/5qXZaGbyDzb3dTCgrx3LGutjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIinMekw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIinMekw"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711b95226dso17769885e9.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847095; x=1762451895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8YnOhLYa4+B1Ekt7MbimeIIDg/J8LnZDYbx9DRe05Y=;
        b=CIinMekwGQ3fN31rSkF4qOfK52HPYRwt8CU5EA//fipNZ25F0qTS/ogihBvQHpi2Xg
         ogC6qWoYf8qJQPG4bWrJpF3LQ4l9V8gy02CKSP+uKPefN3Q/kj574XDlk9mAXMT09Cf1
         VhTDXeDMjZfbkiBoLvZmxua+UsxJzasre4Sm0CFTF8Sgjg+269lpIMT5kaqhLco9PcaF
         I6I+7ds6M5xQ+3JsIF4znCkEdYaBlRw/gAGFxWTu7GEgMp1fIURhSTqewERiKDtozjuN
         VpsYmasRGwzAlZYeUxEdVqGiuZtf2JNmZn4oeW4M+J7E4O6nogZKbTdf+8CxFxlRlsHq
         EsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847095; x=1762451895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8YnOhLYa4+B1Ekt7MbimeIIDg/J8LnZDYbx9DRe05Y=;
        b=tTa/N/+k5FOqPfUZSBzU/qEG7VWe5gY2MUS0c0OLxVf4FTZLa5AxDJqUHthZ4CLEx1
         nV9h32uqh0etAIAtYnXe2/jq9e1ishKX9ndHLhKOmaNHVelIVxcU79ZXvW4h9OQ0YNCh
         jhOZQRY7cRojIG8agh7G7apAhT49ENi3KIw2EDCs6UwheKC275f4c9dwjQ3q93ztB1rX
         w7kAMekngK0RufUhdTP/6/wRb6bM9obLCAwGMbK8QLiwjbobIjUnSu0U6CV16NUOvu3T
         3lYer7HZoweKB0YIeI9A3pyt88trlEZ0eCxOMISz3NTmzlm/qm7A+hnv1CODjyYEbBXQ
         hA2g==
X-Forwarded-Encrypted: i=1; AJvYcCVXQf2HGYW3TtGUsJjiUiYbbAmHwUPS+6yMVRvbekZESotmm99+Vup1suFL7qd1Zf0nW7mKIt1HLJcIw4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YkQBVkCu0SAMDoKd7dNOYyNng3UkgGo2lsSRxFPcx0CLsq8D
	Wur+UR1B3B345kZJGXTH02frEM8vNCZtQAPh7I85xPM+vw5f5aywal9Q
X-Gm-Gg: ASbGncu8uyEhNpDh2WTOLS/ybyE7zOU1D67/+EqMiru8QZTwLBqR+qzqIMQi2qrhINP
	G2qhufgdz9VNX8Ggaqibkry+bZKwuWKJq+7T8lnYTu75xjXWqnLHHg4e1jfieWatK0FjUfnLqpy
	zL6WdqI1RQ3UTYuZ1hR6Q+YNikmyArMQJFD1M9XHg1GWgziqCtf6Tlo0YfLiCfEjPyey0oPv2P5
	PAdHW1U4YRbR2YK/ydPEMfr5oD9QeHODbFrJsm6r1RGQ0cPEn4szmnung6Gm74+/UX6XmcIdoVb
	Ew+kOTir0mCWzs4MWJU0zZuuXwEZJ4wGiZsTKaF7xnAVld5nvCGckJyRaJ4sZ/7Q9HpnBZ10D5h
	xF5kcfNv2Yr1DqmynTphHKFYD5Qat43kjfR25Px46EujXXl1rsCbkyFqDxGThB8VflHepja4rbZ
	K45IGyIF69SPfR/Moess+7x5YaJ8Ea5BpO4o2wkhGD9UCisPm5rB4G8fQUmHJXpukMlvd/p1g=
X-Google-Smtp-Source: AGHT+IE1FuZnnp5NmXH6wKHeFVq3jsmIh/MUmdAqP8BqCay4i4c5dgPUHmDX609AIkhZuUJDO3bVbw==
X-Received: by 2002:a05:600c:820b:b0:471:c72:c807 with SMTP id 5b1f17b1804b1-4773087af79mr5773565e9.22.1761847094521;
        Thu, 30 Oct 2025 10:58:14 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:14 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 01/13] dt-bindings: serial: renesas,rsci: Document RZ/G3E support
Date: Thu, 30 Oct 2025 17:57:49 +0000
Message-ID: <20251030175811.607137-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add documentation for the serial communication interface (RSCI) found on
the Renesas RZ/G3E (R9A09G047) SoC. The RSCI IP on this SoC is identical
to that on the RZ/T2H (R9A09G077) SoC, but it has a 32-stage FIFO compared
to 16 on RZ/T2H. It supports both FIFO and non-FIFO mode operation. RZ/G3E
has 6 clocks(5 module clocks + 1 external clock) compared to 3 clocks
(2 module clocks + 1 external clock) on RZ/T2H, and it has multiple resets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit message
 * Added resets:false for non RZ/G3E SoCs.
---
 .../bindings/serial/renesas,rsci.yaml         | 85 ++++++++++++++++---
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index 6b1f827a335b..1c2ed4cd58fd 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -10,17 +10,16 @@ maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: renesas,r9a09g087-rsci # RZ/N2H
-          - const: renesas,r9a09g077-rsci # RZ/T2H
+      - enum:
+          - renesas,r9a09g047-rsci # RZ/G3E non FIFO mode
+          - renesas,r9a09g047-rscif # RZ/G3E FIFO mode
+          - renesas,r9a09g077-rsci # RZ/T2H
 
       - items:
+          - const: renesas,r9a09g087-rsci # RZ/N2H
           - const: renesas,r9a09g077-rsci # RZ/T2H
 
   reg:
@@ -42,14 +41,40 @@ properties:
 
   clocks:
     minItems: 2
-    maxItems: 3
+    maxItems: 6
 
   clock-names:
-    minItems: 2
+    oneOf:
+      - items:
+          - const: operation
+          - const: bus
+      - items:
+          - const: operation
+          - const: bus
+          - const: sck # optional external clock input
+      - items:
+          - const: bus
+          - const: tclk
+          - const: tclk_div64
+          - const: tclk_div16
+          - const: tclk_div4
+      - items:
+          - const: bus
+          - const: tclk
+          - const: tclk_div64
+          - const: tclk_div16
+          - const: tclk_div4
+          - const: sck # optional external clock input
+
+  resets:
+    items:
+      - description: Input for resetting the APB clock
+      - description: Input for resetting TCLK
+
+  reset-names:
     items:
-      - const: operation
-      - const: bus
-      - const: sck # optional external clock input
+      - const: presetn
+      - const: tresetn
 
   power-domains:
     maxItems: 1
@@ -62,6 +87,44 @@ required:
   - clock-names
   - power-domains
 
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-rsci
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+
+        clock-names:
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g047-rsci
+              - renesas,r9a09g047-rscif
+    then:
+      properties:
+        clocks:
+          minItems: 5
+
+        clock-names:
+          minItems: 5
+
+      required:
+        - resets
+        - reset-names
+    else:
+      properties:
+        resets: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0

