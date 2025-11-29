Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEE30E84A
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434613; cv=none; b=oEaYyx1LN3sPIxvviKip20HNsmwtiu//uJ305C8A8c8pe4fxgRBM6DQyQw+IzVS2ZPnkvTJ1CS/iw4Ygky3x8f5GNI7yF9FsR/OcKVA2jfCPK1QM4zvzRRw1pBozh8QwbXK1WkR/rUS/X1OHH0hTyYkP2u1JLTbzikRQnTrQtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434613; c=relaxed/simple;
	bh=uZXDBvor7KJbjJB3HqPkR1cyp5kCgXnT/h7VJJSW3WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjXZi+F9oKk9BI8hhAChWFjw9t3NhoDRuNZhekqX0LIYRU1EN/Pfm/nqGBoKaOPhl5++Q1mEigD8i+r3oqIF/4ngiQ29Gw2SuTfKaRLzGlTdymS0Qi32oarEnZw/6WyhslR0yUT91TnQhqNDtj1UEqu5nhIsnfyGYPppRUo8iVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBQYs7wx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBQYs7wx"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso1706205f8f.0
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434610; x=1765039410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3z8nMxAsgoZutlTwNmY4UEjKK/Ut41tih0onvR3o+8=;
        b=JBQYs7wxcgZdnlSBY/JbwnkfHy+XiSEA61egyJEW6DS2X5cpYnDNYBSLxh+nRwvV6R
         gfMdo5ucC+WBK0abKZpfCYTq3DJzdMHfVIQbhcdshsIEi5Bh5XnHGOnFtJnu4Rab5gkV
         qDFG7BQ6WAIoGlQzdI1TnHe9pj/Eu8zx0MkIQdEW+oB7dq86detBU7DwOXkBohRw0lZS
         izt/bslTZHAL1I246DTvScBm7e5bysG0kIYml0tuvGfpCKZFYWHc3LUInqAG6F+lJFJd
         pPU1ciAVHdZ+2ik4tXWPC+fbvx0dl7TCK+CJt5l7AxVtJGDV1Gpubni0gW/l8FU0+h67
         j1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434610; x=1765039410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3z8nMxAsgoZutlTwNmY4UEjKK/Ut41tih0onvR3o+8=;
        b=Zjn2K+3JqkSzRri/u3ESEqlrBA8dv/D/v7cUwb/ywLEGUcncF6zUWUMjde7QtL4QGL
         Cgt+s7v1r1/gg8/JyHqw02j9wqc4ehWe6MR3NowA4tG6p971Sab92UDIR+Z0bBJtrBPm
         GvMhd3VKQl3zSfmJOa1S5PYE+QcGwE4AkypIpVh6/bExFFkBO8JhZHtUPNvgbK+kenUW
         hBYhyqBIPg3wehwm7UvknlSEAvbOOLL5iL5U69fnAeK6riIViY6qv87g0iJqMFpPk3+5
         Jy+wHJVvNv+tgq1++Tg5MHmX2+6W8S4QlikHsZPVkEQj/lXOTtjY6xhRlsqGSNuvfurB
         wfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Aw/E0Szj+6Lkm28v/b1OmC7458lHztA8EI0y1/5sLtciYtQEk7Zx+QHPOpM3URlorKi7SsCPWZr8LTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNvZhYYbdOECaqnC0MXgGObYGNHSv2h3ydFlrEUZR4hiDwNde2
	3hzBH/UM3zzgeMoxQEK/4UXL99/oOuveT4nr/HD+QGxurs/cKKcV0DdeFGM1QA==
X-Gm-Gg: ASbGncvZqO7Z6OGlI3bmELbmeYhO95pMsnkhQjqIoMe5yfSt30xfvH95xCNWV6Svmtf
	xJRpBmEFAQSzMeAMtAvNc+z8MOwnMh4mmDvH/pMbQ7LyUcScr44jGB1g2iFH95koW2Ul8u4kzkw
	E95f+ZmJVQqC+v2w5E4xxQVAHI4yElvf/ojAowGegI1cGuQKyUf5y2II98zz9xfVtoVGqr3MHfu
	mYNTI96GEUhX29okMTMZMf/groHI23FcMpvA9lV/mDjzItCxudetNnrbFctmKBtRMoukw+CzDBJ
	XDdAc8TlVSKtBa24XL4elDqDEvbMiuUu4B6JZSi78l54s+7NjOymQkurvnpTANwy8AzzGbgztEg
	B+FC30xrrU3/1ljvfGSfH+cnDRcWr+47D2P0x21ukzAGKOZVhNO3xh9cQLbS55LkgWB+lkRsuPZ
	Gv1H2t37IDDeqJZFe1xRltCkxqsKic7Fm9LbaNV770Ng3ZwuhFeFmH1em90tpTxmJkCNax1UTw4
	hKi/DEGa5DLpbXAJmUspnEdLyI=
X-Google-Smtp-Source: AGHT+IF1mYzBqICj6377qH8sbdY4XYTz9m3Paly6b9HFbclMkCmkWW7IznHUPIWSZOcxI+lLBdh5vA==
X-Received: by 2002:a05:6000:1841:b0:42b:3ab7:b8a4 with SMTP id ffacd0b85a97d-42e0f3446d7mr20648308f8f.33.1764434609396;
        Sat, 29 Nov 2025 08:43:29 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:43:29 -0800 (PST)
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v5 01/17] dt-bindings: serial: renesas,rsci: Document RZ/G3E support
Date: Sat, 29 Nov 2025 16:42:57 +0000
Message-ID: <20251129164325.209213-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
References: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
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
It has 6 interrupts compared to 4 on RZ/T2H.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Updated commit description related to IRQ difference
 * Added aed and bfd irqs for RZ/G3E.
 * Moved reset: false to RZ/T2H SoC and dropped the else part for RZ/G3E.
 * Updated conditional schema with interrupts and interrupts-names.
 * Dropped the tag as there are new changes.
v3->v4:
 * Dropped separate compatible for non-FIFO mode and instead using single
   compatible "renesas,r9a09g047-rsci" as non-FIFO mode can be achieved
   by software configuration.
 * Renamed clock-names bus->pclk
 * Rearranged clock-names tclk{4, 16, 64}
 * Retained the tag as the changes are trivial.
v2->v3:
 * Dropped 1st and 3rd items from clk-names and added minItems for the
   range.
 * Added minItems for clk and clk-names for RZ/T2H as the range is 2-3
 * Added maxItems for clk and clk-names for RZ/G3E as the range is 5-6
 * Retained the tag as it is trivial change.
v1->v2:
 * Updated commit message
 * Added resets:false for non RZ/G3E SoCs.
---
 .../bindings/serial/renesas,rsci.yaml         | 99 ++++++++++++++++---
 1 file changed, 88 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index 6b1f827a335b..1f8cee8171de 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -10,46 +10,72 @@ maintainers:
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
+          - renesas,r9a09g047-rsci # RZ/G3E
+          - renesas,r9a09g077-rsci # RZ/T2H
 
       - items:
+          - const: renesas,r9a09g087-rsci # RZ/N2H
           - const: renesas,r9a09g077-rsci # RZ/T2H
 
   reg:
     maxItems: 1
 
   interrupts:
+    minItems: 4
     items:
       - description: Error interrupt
       - description: Receive buffer full interrupt
       - description: Transmit buffer empty interrupt
       - description: Transmit end interrupt
+      - description: Active edge detection interrupt
+      - description: Break field detection interrupt
 
   interrupt-names:
+    minItems: 4
     items:
       - const: eri
       - const: rxi
       - const: txi
       - const: tei
+      - const: aed
+      - const: bfd
 
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
+          - const: sck # optional external clock input
+
+        minItems: 2
+
+      - items:
+          - const: pclk
+          - const: tclk
+          - const: tclk_div4
+          - const: tclk_div16
+          - const: tclk_div64
+          - const: sck # optional external clock input
+
+        minItems: 5
+
+  resets:
     items:
-      - const: operation
-      - const: bus
-      - const: sck # optional external clock input
+      - description: Input for resetting the APB clock
+      - description: Input for resetting TCLK
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: tresetn
 
   power-domains:
     maxItems: 1
@@ -62,6 +88,57 @@ required:
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
+        interrupts:
+          maxItems: 4
+
+        interrupt-names:
+          maxItems: 4
+
+        clocks:
+          minItems: 2
+          maxItems: 3
+
+        clock-names:
+          minItems: 2
+          maxItems: 3
+
+        resets: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-rsci
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+
+        interrupt-names:
+          minItems: 6
+
+        clocks:
+          minItems: 5
+          maxItems: 6
+
+        clock-names:
+          minItems: 5
+          maxItems: 6
+
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0

