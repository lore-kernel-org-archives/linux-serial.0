Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E9466B09
	for <linux-serial@vger.kernel.org>; Wed,  5 Aug 2026 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932435; cv=none; b=GfUWfG/KOXP7RNV8+P+UvndZToCCzc30f16DA1LXOcqcZ6KOvWVAgXyV+0xvETYPDPj2Q/vWP0T3jVlYvM9JXEPdzYLaUsP1UXVKDrEni/7Sn6ar0kV/8lOWrFVbJJlu5+Zfls5sTKmVW8MfDJMWLzMFPhObSOdrv6fOXr84Eb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932435; c=relaxed/simple;
	bh=3X7WL8xkq/xgDF1Yg+6dXU2AAPke6iAzEkoxOpEOTPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJeifXPkH477GYB2R9DQzzXzYCDpjH+32Pl0R+1/XPdLpE6sVwGC1YT51ux0pFcacI01sqt2M9+6TMPsVin8XDM2KJzV1+y3fxshxnhZK1z6x7DCJgWyEiuJXvs7yglRqXF3xL+Rea7hk15gAQw3uS5OfTK05w20JhmtFEAV21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=fCBwq3wj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="fCBwq3wj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4955158f26aso5636405e9.3
        for <linux-serial@vger.kernel.org>; Wed, 05 Aug 2026 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932432; x=1786537232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bz6C6stmStVMzEFUIQDnKapYsxwqb3V9iw0SJh4YNFs=;
        b=fCBwq3wj4guwNRBMmDZfWUE7Bj9psC5iB5Oi7PQe/nQNva27tSl9rKiEAyJbn4YKLA
         55lpxiuMlIpYfrN90FNge0oR4BaV/+sAbEppR3kX4b5tyLjzogJOvIhK4r6p1oLNWzEX
         6MvcIlnAPWRcFO4ss6/HdVE+cYxB0nlz9rCwtCsHmTWjaI8HHJn+1rvXdjYCl7X1g3ia
         75lZ739clNp7l3GK24noAho8uVxooNXj74MDAofZuSyLRk3a9d0ekeDcMDy1Zbr0NiLs
         KOgUITKL9BsTRlurbumXAfFil0rMZtKyW+BZFG0lP1rNjpFVSk2Phx1sR6D5WRIMDMnx
         pfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932432; x=1786537232;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bz6C6stmStVMzEFUIQDnKapYsxwqb3V9iw0SJh4YNFs=;
        b=cSqk5+i2YAOMWZeZPydWJWXoHMK7v4ijYvPBj8mTumCLK6zXGbvdHFjZcKnbELu4R1
         S3lMWcvR+KZcK8NLsvLGFxmnd1iRXy56GOjpr079kUL1C6iDxbF+aEaejhaBjU2NcjyK
         e+jr5y/w2pJbiECLccHQ93Xsy38PLeKzXIHVze13J4o62tr9H0MR7l1cG+McVN7KpMXF
         KxkSkPXWs+kKaqzNKGIps1WoJG2xbCw5suD/8tpMpAa63+i68NnZ/OdNPSje4gZRZeSi
         Y2EiociSJG0q5gy1ePjkxPflujkZupsacYcP8mAHv9VSQZcrD+qtMkGi6xDknwqIZTla
         PkQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqv1cgLD8XApmWVa9cQ4ji0w2FP4OnLLvxAfN/9DnaJPut8w4lsG9pCRXH2nhaPW1/d5l9rmQkIrRazCYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8OK+NVrs5J7Tb1HfVfPEK6idZGqN6rQ6XVgH6doexAn/1Zi6
	WeiNOb73aYzlxgGQFUt+sCBHhpxa8qvvU8SFH9sJ0O5c1BUE8FemWBR5TgNKOkvX9+4=
X-Gm-Gg: AR+sD10BeeR5c+ECzdXFtRk3kDEqfrZx12U09VxdfIybOASv+ddtPrb4+Q5lHk5Jl3r
	wR345+L+PSiDie3rMe3e1TQj67aHjcnCxFtmULy5I3eEefSot3/WzlUCW94kvmtt6ljaAxi7+hF
	AJynxcpU5uWttV2Kx+euWYrLD6xw85wjZZ5WLYOgEQdGA1/8Nl3cOXfQdnvKTbMihB8RpHS35MU
	fIQki8UFiR6xhTFgOmI9focdRcqOdcjmEi1jDSG8c9Pq3ESBGjYZrsa41ZMuqeKQWnpA8VRkZ7p
	A9ujxTOd8D6rtIA1QmJgsHvLjh2JSDSYzovZRupG/nH6FPIHE4faJJMwBjokHYOnPAMZk5zffer
	MU44UBI5VuD44CY39scqMlX0dHRx2udTk7GrjjP+XxX9yv7tV7SVJfx/gOMb/q/JMd4R3qGJkPL
	mmGDTOw7+Qn/SrSqlEqFYT7r1zVN38WKtqwknDFTP83JGsaOerKHvGWeC84La+ANfIkEqHRV+Hf
	U7VN3+BxRLWkVZDMjvBZGxJP6iSHxk0ol4ZSymsVDPAMcV7Vth0iL+gN6CZcJ3BitpLBbUJSPN2
X-Received: by 2002:a05:600c:198f:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4994e7cc5a4mr72969715e9.15.1785932431891;
        Wed, 05 Aug 2026 05:20:31 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:31 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 1/6] dt-bindings: serial: 8250: aspeed: add ast2600 and aspeed,vuart-over-pci
Date: Wed,  5 Aug 2026 14:19:48 +0200
Message-ID: <52d5bce1cf8ec3ff0b27e7313655cf7ffa2236b5.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ASPEED AST2600 has 2 Virtual UARTs accessible over PCI.
The ASPEED AST2600 can be used as a PCI device.
2 Virtual UART can be exposed to the host via this PCI device.
These are 8250-compatible register sets and can be used to have UART
communication between the PCI BMC and the host.

This boolean can be set to specify if a VUART is used over PCI. A VUART
over PCI needs a syscon phandle. The syscon gives a regmap to the SCU,
which is used to set the enable bits of the PCI device.
On the aspeed's chips, the clocks phandle already points at the SCU node.
But deriving the regmap from the clock provider would misuse the clocks
binding. An explicit syscon phandle states the dependency directly.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 42 ++++++++++++++++++-
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

