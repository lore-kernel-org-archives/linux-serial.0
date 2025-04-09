Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B91E51F5
	for <linux-serial@vger.kernel.org>; Wed,  9 Apr 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226542; cv=none; b=uwD4GsQbLb6fv43u6q1IjXZnrDDMWsHbkaoeZq6yweXDRBSaPdWVr3QMbr/kcY6PquEqVHR0ku74YcDr5XoereellpkDuhVc6MtbVYeWcCOAaP3ga+ZOoUKfg4KIToveVOyFK/NAz9hZfdjaXv1VVfnAtPRCjfcjopxc6mstJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226542; c=relaxed/simple;
	bh=he9IA1+sEmtGpV+RfD/yvwaHIPJw7FZcA+CsPKHLNsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbdB5dRPf0enbUU66vKbKU4MwDKpkNMF3t9zFT22ijah+IJOgOrPxz/dtyFpx8CCdTy8ZP4f3JIRHQijeXNVLWEVxTZSm98bcqE9j8NiWBiSBG/brysOUwrCHpPKsgNaTbwNGN3s3y+qpPZgkDZLWM+ZR9usOW7h1c9rUjYPUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=lut8q8Ni; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="lut8q8Ni"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d589ed2b47so333115ab.2
        for <linux-serial@vger.kernel.org>; Wed, 09 Apr 2025 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744226539; x=1744831339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAZLFz1IGr5iGWJpnMiF/uKgFNwzC6PY6kuRk72SglQ=;
        b=lut8q8Ni1hbyZx9cevMEU3YqMOUhsQhPKqmJAgDc6cYYex6kdQ/QLfIU60sQNgD7g8
         JimgNl640PCTK+FpDRplBPvlvuKDdRe6DUfPxjQSM+hsymxq8POEfX7A2Jf0n5YkrxKn
         f2ybj/ajrmfvuGMqT49IAmXdrgFnKaf59WioJQUSS8Ps2mHdslboQOxOGOsLfx2ib2G4
         GVt2GgaIfyRLLfRPSkfyytr0BVe2WYI104UkkYW8TaVcTvJ2koBiG1++5uepyrKQeNvB
         7o9kqfqEWR5pfcB7Qu+7/dlXSkLuGLwauXtrcZ6AVTn3XRwcK6hI3E7fnIAQSLvRMEWC
         pKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226539; x=1744831339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAZLFz1IGr5iGWJpnMiF/uKgFNwzC6PY6kuRk72SglQ=;
        b=jDID5oam9+Ec2c+IsWJvp0slFzPf/e2J3b1F32ET37L7HC4NjN28ZjI1fqdlFfSQMZ
         2bjq7bWyG1QJHbn8pOrIwSkXshPqlywEbrHW5vd23eZedHgW6pB3tUgd1K2zMhDEeLw6
         NT52dsQelpbsAGNzJfXFhaU8GQv0LVBhtjE9RgRjGJYd5EoCD3Py2WzAk+jM/n7HpaHx
         PXfF1lDOiTDWu/oAMQYs0JTcNI3VfJMlTLrYgtKkPHhglLm47DFVz9Wx1MCdho5zxZ6+
         QPKDgwy0p6r5mTK/ROlG2fIbgIktS0G4xvcQ0slgB4TsxXGJuP7GeakewAI4m5ainoXE
         2N/w==
X-Forwarded-Encrypted: i=1; AJvYcCVMA2GE+5HQBSGOaVuHkoAVpOSIaKex/OrUsQHpZXZocMfOWC6O3VroRtRyOMHe1CN/v75u72VE2EDau78=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhk1v8wWHywg4M8AFmJ4IYeJzDJEsnxExNqNrNUp6KJFmM/Jgn
	2TLVa4lhtPINQrLsJkczoLcafz2kPBkVbPuLO28rnn55em4HDVzpa/LmbFsb7Gw=
X-Gm-Gg: ASbGncss/01usnlRwSYLRnJWZ0wHjXJXScQse6LjXhwqMSDIcLFtApCUnGm0G9ibjRP
	S3M3x2LvFiwZsGqMSSMHvm7OlQvPRGwcEDqC2/zLGvwrGVBlXnz9v7duKPRQ46C4exmAiTBHJtM
	+avu+r9eWRAwomexHLMAfhYxQ4ATzaj4zI66BPb0RU+Qqhhj/3VqfrfVIH4Qb8JIJnuwj+5pVET
	aSFht1ZifgA2itIGgwi8PLMyEqyydacdg+qKy1kgndT4RJkCTFsltOdrPpHneqm6cFNR6rv/tKP
	8AguIi4aTYxBnKlUFI07KP3TgBASxXraRH7xv8mDe4BviUwutOPd1a0YiUbIEAPxvVO1isgJwhi
	+wCyMtCB+uAwi5Q==
X-Google-Smtp-Source: AGHT+IEGuxmewmQbb75m5X7vBqHuIXERuCuTlAE6AMgAdiu3tfh0rm83MqrIv2yAApon5oQTbElRjA==
X-Received: by 2002:a05:6e02:1446:b0:3d0:4b3d:75ba with SMTP id e9e14a558f8ab-3d7e46e082cmr3195055ab.4.1744226539359;
        Wed, 09 Apr 2025 12:22:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf81bcsm373459173.10.2025.04.09.12.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:22:19 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: serial: 8250: support an optional second clock
Date: Wed,  9 Apr 2025 14:22:11 -0500
Message-ID: <20250409192213.1130181-2-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250409192213.1130181-1-elder@riscstar.com>
References: <20250409192213.1130181-1-elder@riscstar.com>
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
---
v2: Require both clocks to be specified with names for SpacemiT

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

