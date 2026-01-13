Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279C34A775
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302685; cv=none; b=fjiALmwmMzN0cNkd4CrQSitOSGW8MOcTZAGwN1r35GUo526/b7AjlTB9eluqz0xZZv5x/ISHRyNSaC44QuNCkxzIvf4f4TplgUTHeKoMfVcsBXLgs3LV7Y4VadsABQ9aFnWJu/kWXJh0x7s3RlkDakL3oz0byZWIsUV11oHIY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302685; c=relaxed/simple;
	bh=6pLYfVuIQXu+6i9yGbsc8JllWJct6Sa1co6E2UbDaRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQMHTBfjS/6Cn95J5bnzLM7AzVdPY3R6MFr5QWSP2PltaHQlScMmbS3G5tEH/X0AyS+06VK+8P7CjDJwTnuJHFRf3IqFIJ9YUA5aPyWBdUcq2wZJpLgL3g+8bjXAQWX9OS63+yleTVnqLlxvXqMhdMfD4J/77oZncPzBYvihcgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzyaI4FZ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzyaI4FZ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c0f15e8247so1043259785a.3
        for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 03:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768302683; x=1768907483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyUyxp8wAgf/XnChDYwKqc2QzM4UH8wRrO9JxGpfnDE=;
        b=hzyaI4FZ5vqGqJuCkG1AQTxFrN7hAxUHxTiISwUgge5iGs+ySHKCjYizdAglTt084a
         PGFsYmIYg/GfcvhDmA5aL3YHO8Ir2fhYtYg7bXh6gpiCJaSNHeAUzfqDCNOax9qXaY29
         sgQSO5GytcvUnIs5mnCwWJhpkXI9P8TWPrPLsaPY4j7skKMufDvoDTOCgi2AtnAe2JVw
         vT3qqE2XLKTLYmgFkdGZiISA8FDuFPYQV8ppla8rJNKbNFOTm5G5eY2oRkJQbZo94T7k
         IFWa6sSdY8bl5zmIsFTNANMy+U8OXfKfr0XmHPVUoIAxVa8911bCn+ehksflzVi/ErLu
         PcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768302683; x=1768907483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyUyxp8wAgf/XnChDYwKqc2QzM4UH8wRrO9JxGpfnDE=;
        b=WD2GkRicflaKNn9q/wctCWSsO90A2l4iUJm76x62N86Lc4pucJR71reMCXIExNc+1q
         mJfoBoo+9A3qo/p4AiFUeq47//IsLJhtaFqKlRFmvdM/0YB/BYHRf2EksehP8CG5U/RA
         ms8qDP5RYGyjVxBZvSxZaRdtxD1f2WBuA2V3X7S9Frq/o0tZxrOg+KvvJQQ9D35gzNhH
         okPYhG+SwQd7cfrKAOSNBItYw9hijmD4o4ABfe9WhkSNbwgy3U+enp21g6Ok73bQJdhO
         zuLKGyCT+o9JY4nB7SUezexzvE4jGymXLw7P2CXN9CkjETkxa11uHNkUnxud0Aa3oiL4
         c2ig==
X-Forwarded-Encrypted: i=1; AJvYcCWs01m0+hiTf94eI//KJQHZKYWS+fAdcEkpzpXrE0i1huYbSpBjefjKzRTVAQgv8xFWCge22X4TRwueKDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuFP7eu84U8HjF3bAOYEZq+PBGdNoEQv0JhoAIZ6HSt+SZv7mI
	edDSiWj6Xj8upA9XMGld8CCoCLQg+MwnwzFkOerJ4imhLpbTnnr+4/m1h5ULJg==
X-Gm-Gg: AY/fxX4O8BWqvt9YyU4dQluW270VJF9Oh9oJQ+tj/Dr0pDDndXPDFE3S14b85jVkFw9
	DZXeqSnOIHi9kWx9lSqlX8LVu+VEHJar0j1TzYWS7Bmyd+N8P7RZpUgw49r9QMMyzjxmgWe/pmb
	X6LTwjD8REvMpFVDXKs6rgx/DZlFO7/9HvYYwAy92Ji6Qf5FjvOOTeZrHeFMu3h7eR7/KKoF5gy
	IxhZ5F7F72LxnxwOwZclAwzyj3shM7Xvn/6MRPZep/Plt1x4zMeeelpLZLD7DKC7TNRaPZ6fSi9
	GKD8RCZvAwCk2sJJmVbwQ88NoZgmzrNDwShZZ/+17NPnpvYjdRWPySuR6/TtiPVdJLPbjapqE0J
	ZDAaQGjvjDETJwKMKX3x53KrfDAckNxIdQEH42SjoGtANGnyWi7nDIa6XQJ7RE9bE5wJN2Cy9SI
	f6zbB6f9ZzBgv37QAWlaU9HnZNzty+r8NdgsBJ7QrjYiHHyXf8UVcHt5zDBQmUIeCACM3Tup86Z
	5nehpouGWAZOAIBpsygVw==
X-Google-Smtp-Source: AGHT+IEQYBKDIx5Gyb5nb9QDIlP5wjHoYpr1ATatTX3/LBRfDVJ6GHb1+HOoMcW7bBTYInLSSSdvlw==
X-Received: by 2002:a17:90b:1c07:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-34f68cdda94mr20382740a91.26.1768296395660;
        Tue, 13 Jan 2026 01:26:35 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:35 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	sre@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 3/6] dt-bindings: input: google,goldfish-events-keypad: Convert to DT schema
Date: Tue, 13 Jan 2026 09:25:59 +0000
Message-ID: <20260113092602.3197681-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260113092602.3197681-1-visitorckw@gmail.com>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Android Goldfish Events Keypad binding to DT schema format.
Move the file to the input directory to match the subsystem.
Update the example node name to 'keypad' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../devicetree/bindings/goldfish/events.txt   | 17 --------
 .../input/google,goldfish-events-keypad.yaml  | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/events.txt
 create mode 100644 Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/events.txt b/Documentation/devicetree/bindings/goldfish/events.txt
deleted file mode 100644
index 5babf46317a4..000000000000
--- a/Documentation/devicetree/bindings/goldfish/events.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish Events Keypad
-
-Android goldfish events keypad device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-events-keypad" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish-events@9040000 {
-		compatible = "google,goldfish-events-keypad";
-		reg = <0x9040000 0x1000>;
-		interrupts = <0x5>;
-	};
diff --git a/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml b/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
new file mode 100644
index 000000000000..4e3a010a70c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/google,goldfish-events-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Events Keypad
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+allOf:
+  - $ref: input.yaml#
+
+description:
+  Android goldfish events keypad device generated by android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-events-keypad
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    keypad@9040000 {
+        compatible = "google,goldfish-events-keypad";
+        reg = <0x9040000 0x1000>;
+        interrupts = <5>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

