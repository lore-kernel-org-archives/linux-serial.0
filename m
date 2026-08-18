Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F94519A7
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049106; cv=none; b=V7h0jfBzRx7RiZyveThLNOZAkzQ0HHYVBHBZMd1xOp+TQu+DQtq5AjaSfoRDaDYX87AqoZgArM2d5eWd+DtMByAIo3BaKMLHThaH4pwrNpBBZ2I40qpU8MlfZ96rq9Oxec+pXryHLXxAWfFfMAuj3aVLM+neyxh8J2jwDIXfWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049106; c=relaxed/simple;
	bh=Q7nj6LmwwpL1RbkA8x00LOMLutDmfvD1gklz47xTeTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bs5Pe7/20nR8jssPIaWMLD10MCYoCzYW/bN9OZwhb7UW9XwD+ugIKr0VWn7jPlXaFfcU3a3iPW0mFD+7ttde1QhyPy8AKUMQ5qWmwWTFhBi88NcBBKYsWEuF7lfkEZdDX/cbEKcUa/j9+ZVrtq1yPY2FN1tBxJ3zv5yvDbzE6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=fcbqPPil; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="fcbqPPil"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso5888845e9.0
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049103; x=1787653903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VXAR0pfuBaAQ9k+v1xXQaQosy7aMoQd3gplGbAsity0=;
        b=fcbqPPilYWGqN/sq4A7Y26pJ94mx+Rx1D7VeX6KWO8WZ0nHjJYi8u20YZ/HnIXynq9
         Q4FUZKogsYW5EmKBG4MpvFH+8TFfqp+tk8evmkxDUxNkDImpM8VDETp+jBGyMWS2MEzC
         Kx1qpjFTPXsXRwBGSv4yUR/6YkQ37Jgx+STGbCVY5zCxDktrQe1GbkGapKw5gpxibN9O
         XrWH50uJF4lCS9R7ZoRjFoyKPBhOaLez0V4RMrxShWCSC7m84NlIIMVMxT9VoqvtR+8s
         zORiCu0e+Vf6hEG9oQm5qBFzu4rJlempkk+j4Pp7Exp9Q5ragm9ljVoI7ok2cOPWywKv
         Wc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049103; x=1787653903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXAR0pfuBaAQ9k+v1xXQaQosy7aMoQd3gplGbAsity0=;
        b=dQN0XQlpFIAOmvVMf3CROi21HVfCzFLcLjR3wFfRu83t5HEsmZ+65ybCnCxTWnMV/p
         KVyXnydm8KJU9P5JzLMmSbOPJE3KWn7zcU+n3dmuSqZjzX/oNZG3Vn2BrCYGfvu7PWwM
         PXbpOUZxtsyCzUpbH8z5f8g3wodse357tKeH42EqCySpkWv4g2j7jeYf4P6sPlKGx+l6
         9ha5IGm8lbNOBFUcWFFELUhpwvPuMFqJQuL0NSHvXAA+VLLo8OeZ/KeeJGHbgOSCexIC
         RrqcAx5Ek55pGi86C48GTWdxmHSlvw+bswGx3PogDVf+q7VM0EmEnr1pZYHdhZDaMDd1
         +lnw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9AOi8RYbvrYIRQps9yUFB/8zRlTIdEn1WACUu0AqK1DT/HhEcUxKy7NVV/AskfPAQLB1e7oXgyB9yzVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYK8GAVWQK37cBGCOmg/nPXXdFyEsLAeBeG80gdTFhm399Vwh3
	xLD/TxF04S9lZp2B0SxYPNVVajKSkYTgvePEn5yfi8Lg5H1RRI9FN1GtAMCBpCIz/Lk=
X-Gm-Gg: AR+sD13kahiLc1ONlItrRra2en+AE3MaKQqSi1aAQ+yLdfKLIokzcyoyjeJiu6H94LM
	yBLLAZJDv31sc5soC9IB9DCnC2zS8E66CS5FnbJwOlpXnwBCoVp4zTzfq3OhA3c4CnnSmydDtW3
	8pmB7burbB248b18XaZQg7qY2PnSpPA4wEzLnjHELNnMnunlFiCFZ9yXqPnLyh0pr9wSuQoxKE/
	qsV7wgqJ7IoJKh2G0vqD9SDm4/3hnIgei8yA2HTGsDZtoET6L3CYcb5ZNfXeWM+GbKd3ee1YYoB
	bY+fBVru8VDsAM7chJdxDX+j2zLXu5y6MnGxqHLw0uaPqzOX1s0zgIja2MS1IMikgsTpZ+4JUda
	bPz5GyDZ+b4CrwpKx9bseTpl4Z0UB0926TFGHtUMtRkHmXOTsj0cJ6Mtn1M1sTf+Q3Hecz5BOck
	oBmZAHrCQN+m0VrbniscdZ64flm01EYXH4KrQ6s/M2R8MpjnOddVtAd80+vCHZUnXhVYfAbLQDt
	ASf18f+/CoXGqVTOz6b7I/MKz/QGNTG5h+rxJNpi0ct8pB3ik3lCvFyYVPv
X-Received: by 2002:a05:600c:8b77:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499a206a553mr70558395e9.6.1787049103159;
        Tue, 18 Aug 2026 03:31:43 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:42 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:14 +0000
Subject: [PATCH v6 1/6] dt-bindings: serial: 8250: aspeed: add ast2600 and
 aspeed,vuart-over-pci
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-1-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The ASPEED AST2600 can be used as a PCI device.
The ASPEED AST2600 has 2 Virtual UARTs accessible over PCI.
2 Virtual UART can be exposed to the host via this PCI device.
These are 8250-compatible register sets and can be used to have UART
communication between the PCI BMC and the host.

This boolean can be set to specify if a VUART is used over PCI. A VUART
over PCI needs access to the SCU syscon to set the enable bits of the
PCI device.
On the aspeed's chips, the clocks phandle already points at the SCU node.
But deriving the regmap from the clock provider would misuse the clocks
binding. An explicit scu-syscon phandle states the dependency directly.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 42 ++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..8dd4b7af0c0d 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -18,12 +18,34 @@ allOf:
             - aspeed,lpc-io-reg
         - required:
             - aspeed,lpc-interrupts
+    then:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - aspeed,ast2500-vuart
+              - aspeed,ast2600-vuart
+  - if:
+      anyOf:
         - required:
             - aspeed,sirq-polarity-sense
     then:
       properties:
         compatible:
           const: aspeed,ast2500-vuart
+  - if:
+      required:
+        - aspeed,vuart-over-pci
+    then:
+      required:
+        - aspeed,scu-syscon
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-vuart
+    else:
+      properties:
+        aspeed,scu-syscon: false
   - if:
       properties:
         compatible:
@@ -106,6 +128,9 @@ properties:
       - const: ns16850
       - const: aspeed,ast2400-vuart
       - const: aspeed,ast2500-vuart
+      - items:
+          - const: aspeed,ast2600-vuart
+          - const: aspeed,ast2500-vuart
       - const: intel,xscale-uart
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
@@ -297,7 +322,8 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     maxItems: 1
     description: |
-      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
+      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart and
+      aspeed,ast2600-vuart.
 
   aspeed,lpc-interrupts:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -306,7 +332,19 @@ properties:
     description: |
       A 2-cell property describing the VUART SIRQ number and SIRQ
       polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
-      applicable to aspeed,ast2500-vuart.
+      applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
+
+  aspeed,vuart-over-pci:
+    type: boolean
+    description:
+      Enable the VUART over the BMC PCI device. Only applicable to
+      aspeed,ast2600-vuart.
+
+  aspeed,scu-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU syscon, used to enable the VUART over the BMC PCI
+      device. Only applicable to aspeed,ast2600-vuart.
 
 required:
   - reg

-- 
2.54.0

