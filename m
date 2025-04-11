Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B020FA9C
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386268; cv=none; b=cbv1wbwse2SqOGTEqeESu77vYQJrEaoiLCUUKky98jakz4+SS7k1jcJHhP72bWIo2F1dC0LiOnE4hHpeA8CGvWlzmBswMqEhxrhSDeWIvV/3mZKNdBBHNN8tWSQCsvX8J06pfQL+B9wlZDSGw6wukRn9j94+VB0vkSwoPId5tgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386268; c=relaxed/simple;
	bh=7ZoS0xY5agHPaulRb3cD8XGDbf5Uto+nLhFfKAqokok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4J0nDU4l2IXwUCNThLTJGjcBdqg6Bm2SH849rACt1ySL3ojTeLB5LqDBv3Hips/huPrdzEH04Zrmj67cMsOwlYzmr9W8HxoFu68ZOKvksboHg5xak9ln0v0S0tobU9DnfP0g0BJPe4iTwNcSawR+Lpdno39Bn1hLCHBgmAkweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=A69/LT6O; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="A69/LT6O"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85da5a3667bso63018239f.1
        for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744386266; x=1744991066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNEtTIi2VK5ry0lwico5I+3DkBAdLoSFhiEvmP3qbmk=;
        b=A69/LT6OOQYLw6YgRDIh8Ai1DI8+jzG2Hc/PYn/2+PWrr2HKTGOp2dvELDPepwMkAD
         G0KT/qMjkHc4SINyIzbxdG7KVNGP2at4C+E3tllBE9xpASKBknB02KI9kXbEd9SikXcF
         3xvLvIZlsgbn80AQgpf/4OJIWLobGbfoFDQru8DkSPe/Gegn3hlhL8wGicZhEXzpfS+P
         ZGCWOkzmEIHiZ2oGJpRjCx3jot1UnyKERe13Ls6XUUVWrwpb0hgLkChOq5hsU17eW9H2
         imEc9t3nHytqu2oI7j7O+JS3u2moAoh7NFlslq8EUgylGz70ell9EVs+8GCaZDpL99RP
         uoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744386266; x=1744991066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNEtTIi2VK5ry0lwico5I+3DkBAdLoSFhiEvmP3qbmk=;
        b=KIXJBoWE4rFEo7/5tUlatBf8J9icvzgmWFYw5Z9YFDEmlRa/tyJGKLZbgDxVEOQXAT
         BER56DG8oTO2OQsiEMJJn8bmPon/KG7XHVJPcEudRl4reaZoQCYW1DXJisQLwnzMY3Qt
         HuUBmUYjjCDmwjIhVFE3aPfiHrfchG8M0z6LNad6FIiMb8Fz/Mc/Y/1IcMmoDOvuEBu4
         GDzjAwE2WybzWgg4Q3rYjIkigbiRl5iPgDID0pFa6LWjLTVU3vEdkszQPoU7RTpZjrVm
         qsxzUf1eGGFnLJ/RgL4vujIGJk8v6PP1moR8mjxTPLRqBE1APhYF8yIY8sTn/PlZ60hp
         UFEg==
X-Forwarded-Encrypted: i=1; AJvYcCUfwmSuG13XMsCkxf2xOpHNm5tibn3CyFBEPAdSTFkzmHT1pNZr1eQIJFatzmUInwe2HhTKN56Euo5RzGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrAci+DhOdquzKAiNaAWuxW73piOrCv4QzmoXIp6ibbRVIeZA/
	v7gF92JsAt+eFYyL/OI51zm144O3H0LMJ6r1RGUAWOR+Q1AOtnR9m9R2/Wgwwx4=
X-Gm-Gg: ASbGncv4Tpfj0172NJopx4omdgmelY1d5MrJhXHIdgtJsDiRg05F1CDukdsTgNvHMDp
	Rilyyv/DKcrihgmRqHOCLYCyCAhI2vbt00qT/AObsUrmmO5pVmIiP9znH4BnnIkiNb5+JmUfe8H
	yd5TNv0GB8o3XudC6jdBQdx597QvyEd+Qjec7Fz6x9/bxXej0ctkOem3ALXOj5wxqxOcsoZ0kS3
	dBrdvMN2iVeUSSL8PQZtofWIiUgabdyiqm5fqnbis8QfNMDsSJAj1OXsfeAQUlEtnZ553by8tSQ
	6pSkNM1W2ZowTbJQ9QQlvvoiu+2WMxAy2gMAlgfvs4NLbcU2KuMAPXikMDXLVb2jN2jqvxcaT3o
	1EPsc7MwmL64UNA==
X-Google-Smtp-Source: AGHT+IHmZJkLUp0ElYixFb0pqy12kzxcoZbzdEnj5SOiajP/nfCU4MY0cVdJxZEZG4e9zsnEIRAxIQ==
X-Received: by 2002:a05:6602:3789:b0:85e:2eba:20ad with SMTP id ca18e2360f4ac-8617cb4660cmr336071839f.2.1744386265918;
        Fri, 11 Apr 2025 08:44:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf812dsm1276326173.18.2025.04.11.08.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 08:44:25 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dlan@gentoo.org,
	benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: serial: 8250: support an optional second clock
Date: Fri, 11 Apr 2025 10:44:16 -0500
Message-ID: <20250411154419.1379529-2-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250411154419.1379529-1-elder@riscstar.com>
References: <20250411154419.1379529-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT UART driver requires a bus clock to be enabled in addition
to the primary function clock.  Add the option to specify two clocks
for an 8250-compatible UART, named "core" and "bus".  If both are needed,
require them to be named.

Signed-off-by: Alex Elder <elder@riscstar.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v3: Added Rob's Reviewed-by tag

 .../devicetree/bindings/serial/8250.yaml      | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index dc0d52920575f..33d2016b65090 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -135,7 +135,16 @@ properties:
   clock-frequency: true
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: The core function clock
+      - description: An optional bus clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: bus
 
   resets:
     maxItems: 1
@@ -224,6 +233,25 @@ required:
   - reg
   - interrupts
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: spacemit,k1-uart
+then:
+  required: [clock-names]
+  properties:
+    clocks:
+      minItems: 2
+    clock-names:
+      minItems: 2
+else:
+  properties:
+    clocks:
+      maxItems: 1
+    clock-names:
+      maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.45.2

