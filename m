Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885EE36CA8A
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846934; cv=none; b=lfBB0sHJTo3Gyu1UBGZnRhHERWQ6sCfYTmjWrE/Ug7nwwmHxSnFnh6g6cX/4s8QaZ2+lWxOyTcUD2/orRQZpoIpPf++3oScIxvFldkDKz48uhDRQtVy2XfvhNhoKTeKT6mcSZRwrgyL4sxusOUwsxFvyunDzhQekos5LRoIMpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846934; c=relaxed/simple;
	bh=3z2mhzRxyfQNv1R0hi7ZTnOWImB9S2k6FugjQXRhwUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc9oUiElHKkNQH7sy6ZFmRIqc127UtSvW6w4U5rjA3/9/rlwgYYbOOUwpRHgr4ZE2nwgvqw7xs4OpC/nUeeXFeEiqnavygrDM3vi/FOVesH42W5MKqWI2EXBxte6PdOECxtPWuh5tpw/doBJhBHqUiQP8PguUe4vMTDxBakNjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idMs0XJD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idMs0XJD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-421851bca51so1210604f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846930; x=1762451730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8YnOhLYa4+B1Ekt7MbimeIIDg/J8LnZDYbx9DRe05Y=;
        b=idMs0XJDfBxf72c0ArwvwbhuGo/avWtFawSg+50NosGdBTO8xLjkEHaJE/i51+7aax
         vTesM0W3QilOZ+LO0VRhRDQKph8PwNMh8rEFZEjW+vLDL6yKo/U3F+zP8KncZeYF4/fI
         NmnWXYkGyNWWoWNtYhZCLgoKkmk9GIkm12Q/MLOe4ZXK8GOTeRe6hu9EuvdV2zEkiNHx
         M2maA/B+OLPfLunPKmo3uHYrbcNTjD0Qq/qa/+4jg9rrCtwfnPdMyR2JTDW0ftHk3AZR
         5kjwO5lgqksEJQojB6n+sOvnf2LQYdeBv853LshrkBMq+dOfydcvAkXVdN0INBvUSJm5
         CWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846930; x=1762451730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8YnOhLYa4+B1Ekt7MbimeIIDg/J8LnZDYbx9DRe05Y=;
        b=YP78ve1NzD0sqcxEcpE2lU2BXj4uEHkVjpGlATGpa539OZ+mn1FHs14bx2yZzNEqEU
         hvDcLThV0yShQuP+YfJte4cNzY75XIfxJE8+AZ+gIz72rUGqyartKLMJiNlYBleD+K9B
         teTb2hKGl8RkMPsW3u9mozz4xj606JmNIybXTgOq0B6z7TrIUAefPuVCV2LWskXC34iL
         eapkQByBbIc27zJdKoMCW27H/Vw/NyePhIEfDjyDlGrL9RHjNg3HvYfGQBHDxLbml8yJ
         K/AMfWxTKwGTehM5dYht+Ndxl6uaHyHbn3D7LnII6cB+q19Hjjv1I+xVtlD1nuiRHpga
         8xkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQOzl2G5XYL9iiKisToEkUg2G+JKT2DxlzBhCbUeJTkyRIAH1dmAuuTaOif5yacnlooD20JfNi9G1puGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5d+/H2juziHiIJ5R5VFB74PfEwVJSiy9U9IEVl4eR9ZsgMYl
	lIdErNpw5BQ5YvYaack07fSWibASybIuzoS6peLOfNJbZ4j62mYFe75r
X-Gm-Gg: ASbGncujsYnRRWoboqecVXyf5SKI6dIgD2YiAB4tUWqO35zNBCz1sCUJbK/7pvmUSyh
	Na90OzxqR+sD1hkhhKZfq/OiAjKuWt8xhXBPu9AzXclGg76SiZiY09ZddrehGEskfMb+PcmicQQ
	jjBQiMlNG9lPzAFNXd74dVYM+jIKyp2Hzc16ZwYBuKOVLNbMDhzLU/imKMjS6uIeBPgtUdijzpu
	fYutnr6UsYLwdpMJqkfE/aPgCIG5B55kGgxj547jnveKgzS5Kdd/grUIRERa7pmUj62Dq+VzDJ8
	beE8CmSO64KJRQOb4KOD61BVRkPkChgFx3c83ZCU16Z1EmVx3msgxD4xCCyCpzg/Kbfuof+cB8+
	nLO1U6v3Eid29V87OJCohzXU8CYr42y32LdLaXnDo6mGb9ARC24MbXJeKPQL0+J8WKUY/mnRcXW
	sIG1y+cTNYMJybw9jTAqxPEYhK0PgD4QuSJ2fG6qO7WXRmEf/1ylY6XzlvcBUY
X-Google-Smtp-Source: AGHT+IFwc9rIFO7apqC3XmXhkXUpx2h1S3c6wGBMHk4QlRiJ5KyIleWF8cbqLDTxKoIV//tw2zW3AQ==
X-Received: by 2002:a5d:5846:0:b0:3fb:9950:b9eb with SMTP id ffacd0b85a97d-429bd683f6cmr459520f8f.28.1761846929243;
        Thu, 30 Oct 2025 10:55:29 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:29 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:55:05 +0000
Message-ID: <20251030175526.607006-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
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

