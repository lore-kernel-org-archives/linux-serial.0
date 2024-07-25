Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810116E895
	for <linux-serial@vger.kernel.org>; Thu, 25 Jul 2024 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891164; cv=none; b=cuS7J9qBHbBM4cnhEUcyG5clSY3zaEgMaLsci4ytesJN6nu2QpZA56wxJsVetdzsq1yTcQ64xhec34RNSEZ2813fqpBvVnAFHrlenowlrGUzG9Z80wF1q5fK08fLghI7221sF4gll3KUhFEtYEkmeXuOzm1bKTNHOx7VNAjq3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891164; c=relaxed/simple;
	bh=CHlJmucPNbTooY/cIPar6d813VxryIVawWhVxhMioHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLmvcQvW13i45mf/j+ltqYD5DXHviCOQ28tJMaFq+dXNriGGGeB715FumpYPgIe3RCSnsN2N1vRwZKGbS3NHbhhINYcxnJgFruBZVTJjcny8qxZ7xq7OSeXDQ5XzQYjXHy6RkPeD7dGdOU+HSrOmzfleOetVS+f6HseQdMjuCt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KipCyvzh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KipCyvzh"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so28940666b.2
        for <linux-serial@vger.kernel.org>; Thu, 25 Jul 2024 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721891161; x=1722495961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOTZHYO/lqNhZCm7gTaweDmBGXw1jkQtgojTqIvh5FM=;
        b=KipCyvzhHjeF5gTK9FHpVIPlzpU3joWg8oJ1/S0gJfKVpC9Yen0eDQoXSHm6oyNvm+
         Sde7mW0ob81Sg34MRcJURj8je8RW0cBsTBin4f7K53zlm/QfQDrR4t3VVXR1koNXXYV1
         8+oi0RZ4P5+E/yt2hyt3+MGsNS7gjNa26Wz3tqsJIl000rnjWVUKf6609HcUN7JfzT6y
         dBlJ5osw08hBHFEFvmtp3S4kmmvYqMWCcfyfBUA7+ETXEea8wv5nr8hqzfzZKGL7W8Bl
         BdgMjOl0O+gug4fIxKnbeHB6wmcXjVdTvnnTchjRlE3M9vVGdCjVOzftlygoXvYAZzZj
         kzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721891161; x=1722495961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOTZHYO/lqNhZCm7gTaweDmBGXw1jkQtgojTqIvh5FM=;
        b=PA3xFkX+AHDeSgax8IaKBqXrjLIYuXNGQaJI4+i+fwnGarX8WPfEXBxWbPU0Xg1W1v
         62vB5SjLarW0rCEeXvCeqfxuaoAKH2tekwSVOKbSd9QWgQUfljO5pSoHgf0S7v0i6oqP
         9S3kKvBX6mo0QnvB0TQAB5/CnqoRR1Vn97IjRAhWou142Xr8Z2TqN7uMgEYcxr5auGB8
         vGGpYWoQl2ItrHAl9S2d78wGPbLcWb52nTOzSLQZjZYWJw/+V8X9S9xib4YlTeFGiRgp
         e/kZrngByPCRzqs0lvF2wC9woC777OMyYYN4dyMX+AxZzdhTqaP4t5aeZJnyk3zfxKqe
         j3OA==
X-Forwarded-Encrypted: i=1; AJvYcCVFVQMXGwNiomsjV86G6LUf1ZD3yWivfWY3TASqeytilsd5Iax2/sTcfNh72xURjbtG4gWze+dNHp4lNHT0v7P1/B9XJjqWTjdVdorr
X-Gm-Message-State: AOJu0YyQsl7AEFz3SQdhq2looic9R+g7T/XFdVG8nYnlbx+2vLBIMbYP
	Y8xX3Ky3RUsJuhM0GJjO9no5fnaTLU+2RHcp3bEtLIyW+5G5iwiavDbTHF1bxmU=
X-Google-Smtp-Source: AGHT+IFuRqsE0mF4On1rhIHc90IENgUcCINfM+JKK9IIHDmswQAsCtVg1p/AaW75wX2cHabxNqAOuw==
X-Received: by 2002:a17:907:d17:b0:a7a:ba59:3164 with SMTP id a640c23a62f3a-a7acb821251mr79754466b.53.1721891161055;
        Thu, 25 Jul 2024 00:06:01 -0700 (PDT)
Received: from puffmais.c.googlers.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2311asm40253566b.18.2024.07.25.00.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:06:00 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 25 Jul 2024 08:05:58 +0100
Subject: [PATCH v5 1/2] dt-bindings: serial: samsung: avoid duplicating
 permitted clock-names
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240725-gs101-uart-binding-v5-1-e237be8253a9@linaro.org>
References: <20240725-gs101-uart-binding-v5-0-e237be8253a9@linaro.org>
In-Reply-To: <20240725-gs101-uart-binding-v5-0-e237be8253a9@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

This binding currently duplicates the permitted clock-names in various
places, and when adding more compatibles, clock-names will have to be
duplicated even more.

The reason is:
1) subschemas (-if: ...), still have to match the top-level:
       pattern: '^clk_uart_baud[0-3]$'
2) there is one compatible that doesn't follow sequential numbering for
   the clock names (samsung,s3c6400-uart)
3) when limiting the number of clock-names, we also want to enforce
   sequential names
Because of 1) and 2), the patterns can not simply be changed to
constant strings, and later overridden in a different subschema (for
samsung,s3c6400-uart only).

Since we can't populate the top-level clock-names based on the
compatible, and because when limiting the number of items we generally
want sequential numbers and not a pattern, move the permitted strings
into a subschema of its own and populate it based on the compatible:
    * 'uart clk_uart_baud2 clk_uart_baud3' for the one outlier
    * 'uart clk_uart_baud0..3' for everything else

This way we can avoid having to duplicate the permitted names
everywhere.

While at it, add blank lines as per the universal style, which is to
have blank lines between properties, except where they are booleans.

Also add another example using a compatible that uses the default
clock-names scheme, as opposed to the existing example that uses
samsung,s3c6400-uart's non-default clock-names. This allows testing
both versions of the clock-names property when running
dt_binding_check.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v5:
* drop now-meaningless top level clock-names description (Rob)
* collect tags
---
 .../devicetree/bindings/serial/samsung_uart.yaml   | 64 +++++++++++++++++-----
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 0f0131026911..0075712e7be8 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -56,14 +56,8 @@ properties:
     maxItems: 5
 
   clock-names:
-    description: N = 0 is allowed for SoCs without internal baud clock mux.
     minItems: 2
-    items:
-      - const: uart
-      - pattern: '^clk_uart_baud[0-3]$'
-      - pattern: '^clk_uart_baud[0-3]$'
-      - pattern: '^clk_uart_baud[0-3]$'
-      - pattern: '^clk_uart_baud[0-3]$'
+    maxItems: 5
 
   dmas:
     items:
@@ -103,18 +97,45 @@ allOf:
         compatible:
           contains:
             enum:
-              - samsung,s5pv210-uart
+              - samsung,s3c6400-uart
     then:
       properties:
         clocks:
-          minItems: 2
+          minItems: 3
           maxItems: 3
+
+        clock-names:
+          items:
+            - const: uart
+            - const: clk_uart_baud2
+            - const: clk_uart_baud3
+
+    else:
+      properties:
         clock-names:
           minItems: 2
           items:
             - const: uart
-            - pattern: '^clk_uart_baud[0-1]$'
-            - pattern: '^clk_uart_baud[0-1]$'
+            - const: clk_uart_baud0
+            - const: clk_uart_baud1
+            - const: clk_uart_baud2
+            - const: clk_uart_baud3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s5pv210-uart
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+
+        clock-names:
+          minItems: 3
+          maxItems: 3
 
   - if:
       properties:
@@ -129,10 +150,9 @@ allOf:
       properties:
         clocks:
           maxItems: 2
+
         clock-names:
-          items:
-            - const: uart
-            - const: clk_uart_baud0
+          maxItems: 2
 
   - if:
       properties:
@@ -163,3 +183,19 @@ examples:
                  <&clocks SCLK_UART>;
         samsung,uart-fifosize = <16>;
     };
+  - |
+    #include <dt-bindings/clock/google,gs101.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    serial_0: serial@10a00000 {
+      compatible = "google,gs101-uart";
+      reg = <0x10a00000 0xc0>;
+      clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0>,
+               <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;
+      clock-names = "uart", "clk_uart_baud0";
+      interrupts = <GIC_SPI 634 IRQ_TYPE_LEVEL_HIGH 0>;
+      pinctrl-0 = <&uart0_bus>;
+      pinctrl-names = "default";
+      samsung,uart-fifosize = <256>;
+    };

-- 
2.45.2.1089.g2a221341d9-goog

