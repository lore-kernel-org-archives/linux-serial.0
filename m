Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760363F12ED
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525113; cv=none; b=dwMacZ0NpHOYHM8MwNGNvFYrkLBuyfeu6xB4FBQpZpTzaStUYdD78zMATgzG1salPbUtG0AbtekqbGi/ZQEa8x7NF/+sULeePhHUF5yJgg1cucGmy6gpmZq2KUVWCWBeDC9uyX6a1DfngW6TiA8rVHobbUc8cLtgSzC5qjVaTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525113; c=relaxed/simple;
	bh=jp/3N5Agf7eCCJsJNwDYCLTyVl2tbpreHebJX8abW1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAclUqw23DtlTMS29Po1DpkIp3Cb33u8Rp5kesc/6Fuda3eZvQ9/N974XvVXPIvLVznpx0nCFbQkSFuuE4mI61PNysyhT23V1Oyn2CMeuzwkK6Z0ft4pUCclTZpVnf89VVLbT1JWSnvBByMrx5AHEJ8m9Buok56tfsRP5M980WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=UeFvW53Q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="UeFvW53Q"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47d6c634f45so643117f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525110; x=1784129910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aX3VKusEpXR9oPYMG8wA1f/3Abd5fn9FdmFI4yazez0=;
        b=UeFvW53QO/fKzqaHfcpUhAgiXcoP4oiuensEDtKUJu2dQecoWTE+nzYI3rL6nWAs3/
         O+uaHNtVc98gsXoJFZ4Ntbm3jMedsBQBHNbDyFxPcPS0ypKQDSSuvI5bj69XoNvaceiq
         rBs9WpI8EZpa/UULVz/9iCrX/BYYCTtsW9wiKl36ULWhVIFqUzDc8HPw0/IzMDDiWwpB
         EaK7GOV0/nGHNIRqemYaUuQSuuZSW6wtuEShGtOiZYRxDjtIJHg8S/xanb4YJm8mQOjN
         9b42yy8S7fMrcZjRdcn+f0mCsVn5gGGwJE7RbNKC459mpxJ51l3gMITXyYR3q+AS0lJR
         rDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525110; x=1784129910;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aX3VKusEpXR9oPYMG8wA1f/3Abd5fn9FdmFI4yazez0=;
        b=ODZLIr09/WdFcle73lUaOXpy7HvhXcmxPz382afU5+/DnAvrj9Vb3BO7b1T5gIkCBC
         XoW2xN5q5zJsJITRC0BDWcE2Kq5XjS2TVF2R8ME/eN7P+AC3zMFLGyxGmywv/h9Q+nSN
         AVWXqZY4nvXzFMV9YOD9+NTEiVKiMe6f/dBuFq9DTofkYWkrZ43EfzKM0ktsOvLscChD
         qkcDtqMAA77eGanuUqTldeiyJQmOFZ6UavjVzx3koCXyMoKTRV4bg08lTA369vpy6OQA
         BH+ecGN0Vm8Bfp2sC6d2vRC1KnXxh6abMe4plrNbyfonqZW/dRcFhjlyacDBpdWWmMT7
         Q4lw==
X-Forwarded-Encrypted: i=1; AHgh+RoRzGJF6QBjsR1INpqfaUpVv3hMmOaZxFAg5+xapcMmMAaOIBZWukhj0/cZ8LXxXjpjIARS6xPbqRLjZ9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgVbcC1kGLl8HVPdpuIO2Elhd40SmWC4Gj2lhbxp+EhnGDqqK3
	sdsXzEfs+Da8J6TlQtTywSAysG95PPx0l+a47wwPwret/8EY9VX6fgkf2c6316q7AAc=
X-Gm-Gg: AfdE7clFxUMWRuiQMAXgNGYDBXwfKH1/Wh1b5nb00hD95eg089L5Dr7KQwPqogrQdDh
	VOWJT3cVSbvCle+bUXOtAelZ4swwO/gYaxIqFUmni7PU4Bzdldm20S2WKm8tlmKVVGEkAEUTrI4
	Pv6ZzFhwXF9h/GKzAsvzGwwDyc6+vRjBP30YAyx3BmHPBwRIGRnF+SEmuUy/P/1LhTYgZyafsiG
	ohNrweXxuIEWJqX8U0qrid93Z76iQHOS8irNFxt/HUPfbGsSArA6ovhHUj2dUwJEn1sYa6VI1IJ
	4dw+M0VOGrwa+kRRHQmhw3yHLSJB1so08Jb82nPMn+ARAeruzDHk6vIVOuIe9Q44plAVSmf2w2k
	I4NyKLQSPbn/Xk+n078cw+D8O6OeA99nuen1td1NOteJEdd2ndgr/MQf+KytkAHfrCofgwEN2Iw
	eyvRaRw15BP2JcaWebg2Ig6cvI5SduYvGi5aCEiz1bXGo4BL59oN1CDCP+uuufdiR83Aoj1pF7r
	BipkdP5i15Fl/incvT3O7Q3Vw5B5dzci7yKg4U=
X-Received: by 2002:a05:6000:25c8:b0:474:9dd3:981 with SMTP id ffacd0b85a97d-47df07314bbmr3555871f8f.26.1783525110073;
        Wed, 08 Jul 2026 08:38:30 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:29 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v4 1/7] dt-bindings: serial: 8250: aspeed: add compatible string for ast2600
Date: Wed,  8 Jul 2026 15:35:53 +0000
Message-ID: <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ast2600 was using the ast2500 vuart compatible string.
Make it possible to have ast2600-specific properties.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..8f22121381fc 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -23,7 +23,10 @@ allOf:
     then:
       properties:
         compatible:
-          const: aspeed,ast2500-vuart
+          contains:
+            enum:
+              - aspeed,ast2500-vuart
+              - aspeed,ast2600-vuart
   - if:
       properties:
         compatible:
@@ -106,6 +109,9 @@ properties:
       - const: ns16850
       - const: aspeed,ast2400-vuart
       - const: aspeed,ast2500-vuart
+      - items:
+          - const: aspeed,ast2600-vuart
+          - const: aspeed,ast2500-vuart
       - const: intel,xscale-uart
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
@@ -287,17 +293,19 @@ properties:
   aspeed,sirq-polarity-sense:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: |
-      Phandle to aspeed,ast2500-scu compatible syscon alongside register
-      offset and bit number to identify how the SIRQ polarity should be
-      configured. One possible data source is the LPC/eSPI mode bit. Only
-      applicable to aspeed,ast2500-vuart.
+      Phandle to aspeed,ast2500-scu or aspeed,ast2600-scu compatible syscon
+      alongside register offset and bit number to identify how the SIRQ
+      polarity should be configured. One possible data source is the LPC/eSPI
+      mode bit. Only applicable to aspeed,ast2500-vuart and
+      aspeed,ast2600-vuart.
     deprecated: true
 
   aspeed,lpc-io-reg:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     maxItems: 1
     description: |
-      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
+      The VUART LPC address. Only applicable to aspeed,ast2500-vuart and
+      aspeed,ast2600-vuart.
 
   aspeed,lpc-interrupts:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -305,8 +313,8 @@ properties:
     maxItems: 2
     description: |
       A 2-cell property describing the VUART SIRQ number and SIRQ
-      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
-      applicable to aspeed,ast2500-vuart.
+      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
+      applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
 
 required:
   - reg
-- 
2.54.0

