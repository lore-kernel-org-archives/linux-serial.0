Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873358;
	b=IAGU8Jk7aRE/o4M45QmnM3lVVet9rvHj6VS+ZznbmSq35Vt/Nvd5xFt7uHKHXUe0ts4K
	 eeZisZk8KFm/4wLEouFZXQjFIFfEFZPnRIqZT5LYQB9ZZSAxwiic+pUNmK16ozmU7wqGB
	 /xjVb6ZI+reeVPC2nj0oqJEBhfxd85cPIua/tWGQN8rai3KywDmPP4YB0kVltxtkh6aXG
	 6f969sRtirWOZ3AW1mteyCqKZFcfVj1Pkhy2sshsiFdgmXrAGLuGYf5Bb7yc1URjJ1Ym/
	 zV0yC582D22mRjubFMNxXmq0lUDXRLPeF/faeaCMke5O9wNMzN8Mh2lLHvW3a5raeiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vrSlKbe3j7go2XMIzF6jdkgisHGXRGalcYQ6D57kGdM=;
	b=FQxPF4lkd1TLmzMnYDJVo254SX9yeavAJuXd9daBq/+3Sn+088O3ntfJdzGtWZ26koGI
	 HwhWTTCL3utddrq1DtfalvUPIxTpIUK+KFQHr038RkIXlXuzit1egBJcUKKMDkntyxDHZ
	 dsZDe+igQRxgx5GDEcQqAaZH+gddgEsnBqHeqnUFjADbdWSAYC2ZoNYH47bfBswmPbwF0
	 b0CpyPNnzkhBKShuHFLfk4bej4CloXxQe/XLhSyvFPG269Byoji47TEELhn6wVqjcypT4
	 iqa8Ouo3aEwWHzaLnRD6Eeb7GWtXNVYg6etMD1UArJMZ7+kfdwLSkD0WfcKk619Mt9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LYinJJ9O;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06EB60A2603
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E06EB60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LYinJJ9O
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4c5d8c7f326so779112b6e.1
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792873357; x=1793478157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vrSlKbe3j7go2XMIzF6jdkgisHGXRGalcYQ6D57kGdM=;
        b=LYinJJ9OhXaxF8nzrRZaZGfcRFHV6ojEbInxF9zFDfV7aLGdG13HR3sTV8U37eCrCs
         9D/caXOr1rohavrMjioauA72Q2ZFYMAW71f+MQ3RS0xHmR6VgJ29k2E+lzMP6ZgyhMGk
         L1Jz1uR/DVBt+8D6GqKdxfy9Jiga30QFLM9Mm6FM5fg8Id0vt/YWh5xJRAee+UfUXqCB
         KDcCCYlckUHboX1NdISqh9E/cxZMA6CZlamQB9regu5+TY3Jci7HwPgWrdixLtsr0wmr
         9JLsb6anBOsihnmpOuFkivWHcc1Gm9enyuMR33YdWIy1YCP4JiIcD4xXWpAlK4SYsapG
         SjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792873357; x=1793478157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vrSlKbe3j7go2XMIzF6jdkgisHGXRGalcYQ6D57kGdM=;
        b=B06l7nlwz94thmUE+32CWcIpmzQKg9AV22SkX4R0WeWvfzBp8JcXZ8sID/vphUIbSr
         ecpP4vCH/bbSHPUgt8ka0HvK2O4BKFkCke2QrdhASK2zrpsfonKlC0ddxVyP1iR9RV5q
         Gh9Oe1gW2tnzyTbH/TuavH26/uAIcE77DiONhWduuUiPyT1wNDjavesvIUinjJXv10rx
         ogIW0dYAzKLGhCoakzip0qGVkrARXzga5tdAO+hiIK+5hEI4yQwX/Unu1Mb4EcszRln4
         r6Z4nJy6hfLm8GqSyL50/vuWuFDg5owi03q5Nnf4UY8W1ldgXNA01ie5TYevsjeQ0OS9
         7MhA==
X-Forwarded-Encrypted: i=1; AKwUvBwu4Y42PvxkI9QOXfmmJCnEtyoA1demFJ1uT02/amZ8dPTfh88BZSC6CqoU9d3GrICEs0S1PlGWi3jqoxw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIktCpQcbItxHGi3k9Zppj/SO6Hv0nSVtO95tP4Il+bF3qnHSWH
	M5b59Siw4E4gj45t8VZGtemIawM9ho8fivNVAxcqIczQRsmwhcA/VeL1
X-Gm-Gg: AYBFou3XUpMZT5bM5+spITVVI3eetAg9lDtOP9IzVxN/8t3YVGlRqmXqysNdSOJ9jnE
	oF94wXvixWq31EQx8lkn5K75huVllvmb3NoiJdJDr11HTeag9PRbe8B5R3Cd4cv/gA7YrBJgoRX
	9MplkDR29llUnwF/sMcQ8eMcTkyqRTShn+SOPXhgD9ayfxwCwFyFKBpOUO+kOfIwaGaBTUiq6zS
	LVVQaIfytRF5vdB8cDZrNvS7SgAUpy/OQJ3HBLPCMjK2Lyk4ELetf9uBduJ04bLXucNUx91JSy4
	+3H1uj4oT+eZq99NgyYQ8i4CCDDvnZAxMqf4figJ/7Luo2MhxLuNEEBakdDw4Kgpj5QGcySvy3B
	xVkt/QsuGPtOvQs6pjcZml/glc39NYCDf1mB4QrldW8fHXOz9vhO9cjyV8xZLicKNYnHz7n94EY
	WKigE9tpuN8+A4ZB9G9HGCujSWDKWpHkXutpWE4NQKtrGuByGczu4TzUr2bF0qx9ssSbMDL/ZOU
	CYCV6Fz7i8zzJmObEJbM4NFvlQr33QaRFRaMv8SE/bGH9u1OvuA+PVNqNMiRv4GXeQkOan1AyDz
	opE9fZV2nCrYbJsu1SnWtx1JgqYiM/zbw8IYezjdKlCgtbA0HRCyiu8r+1MTdAw0j29TNCwijxV
	zC1/hbS+SLMoAW8dzhl8gfgN828qRYIFS8gleOtWvsMeWGvgx2ckrlVWUeMOv4SEsYd7JIsqr4H
	Q6/3B7
X-Received: by 2002:a05:6808:ec2:b0:53b:8f8f:ae87 with SMTP id 5614622812f47-55c003447bcmr1551104b6e.36.1792873356787;
        Sat, 24 Oct 2026 13:22:36 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0424775dsm1815063b6e.5.2026.10.24.13.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:22:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 14:22:24 -0600
Subject: [PATCH v3 2/4] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-h616-uart-fifo-v1-v3-2-286fc1b8c3c1@gmail.com>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
component parameter register does not report the FIFO depth. Its optional
register layout also differs from the generic DesignWare integration.

Add a specific compatible for the integration and allow the standard
fifo-size property to describe the capacity. Require the documented
256-byte size for H616, retaining snps,dw-apb-uart as a fallback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index e2ca126d58ba..0f8fd0485879 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -13,6 +13,18 @@ allOf:
   - $ref: serial.yaml#
   - $ref: rs485.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h616-uart
+    then:
+      properties:
+        fifo-size:
+          const: 256
+      required:
+        - fifo-size
+
   - if:
       properties:
         compatible:
@@ -60,6 +72,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - allwinner,sun50i-h616-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart
@@ -120,6 +133,10 @@ properties:
       - const: tx
       - const: rx
 
+  fifo-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Transmit and receive FIFO capacity in bytes.
+
   snps,uart-16550-compatible:
     description: reflects the value of UART_16550_COMPATIBLE configuration
       parameter. Define this if your UART does not implement the busy functionality.

-- 
2.53.0

