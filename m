Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE138A9DA
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302960; cv=none; b=R20dXxnCZEFrvU0fXjdCGgmuLfFd64TWwc7tcg5EgIefC3OMmr+WT/MJv6Jaqx2dd5YAZkGecoSWNRzMOzmNr51e7SzBmIwgkzmnr3zDeevl/mFujkmax0Rojl40Zski5ONvQZtnSrdzBXCSuajHZ1OUziY3bdhWPfiYfWgbiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302960; c=relaxed/simple;
	bh=H/DtsJ2E/56brWT90bF0TB1znfavml5P75EoVlijniE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raa3L5AO+xirj0CEwCxJl5xMqsaOiRgJ4iaX2lCQjGtLswzbiOHbns52K+h5h+hDl9aUXt5QfB4FXWGPWXwrEjfnLaV3B/zq/YOWYvW0v0slN8tYI7KVCK1IAbb/dBLanEG7ECU6RKh8q7UqLDvaHo28BWJL7JwcXH0UZu+yEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CreaasrA; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CreaasrA"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65cf050a5cdso3289553eaf.1
        for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 03:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768302957; x=1768907757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XLlcSDrZxQliY6Jsns4WsjKtz/A9etiQH4EFHPP5z8=;
        b=CreaasrA1F3z1Vb6wEScYVdy1+ubUEd2g/oKGpFYiQFIWQRFMKpn30P6OO1KmLgVuz
         q6bWVZ6sjnT3ZtCjd9UXT7FKkQ0sS4FNN25NUPZMUUowIXpAJR2tzH+HkVgTwirqf6qc
         NXgnT9fTwzr2zKjFFnSUvlkOM2oyL1CdJdIA7esgIqjUbhM0GcMIYkC0J23mmbY2dgU1
         6X1vPPT5I54ZpyHla/NywDTFdPtYUhhdwNUlsgyYQv1OguoEUyRoq0bTYPidzvJukt8w
         kN+5zHjognHRwD4cpRMdcUqw5AnZSk36a3S19p+c7OAAqiOyjaVfnljFyr6hX/wLQAEc
         78hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768302957; x=1768907757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4XLlcSDrZxQliY6Jsns4WsjKtz/A9etiQH4EFHPP5z8=;
        b=en/zoImkPSZBB1oBE/xU9Nr0rYXBT8Nak58l2EmhNZibcC01NoTsYUsOZ0iv+weEz3
         GGE2kHi5tBpWH9Vk30GJ7j1QaI8WKPbL8kRuPXBvWlkPl7Y8roQrow0QN7/I8YQsSqde
         ByqbATFtyE43vSFG/rbKMrySGQfD+BbuyZ+TyD7H8UyODXd6b2ZPlhPFtpk9oqmTezSj
         UxWBciwZ++3+JVrsgZypO5QzVDUFyRFmCQvBrMiIIXjBqv5fjUdw9b2fD07VRMgEc3yn
         PdGz9/voIGsKU+HEqfNdUjaAdZOaO8XTgHPVMlYCoNu/dffl5LmaIxMu9bAhPQCJsMR7
         CDkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF3TTI4vJlNcqBHYAGJbTktOKgyVHWjnQSRIVvExX3WABhhdPJyQQDAE4UPWKWQapfxpzPikSEBVpa6Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZD2rDfAlLoZRTyQoOCp8DWL/gZGFVmLOh6sONKcEnY/pUzfZn
	Djy6BjmQ54zvtU7ZVo/XiLp1nIC/1821/0hYQKhG4VdQtzUJ2ZCB/YtV03xvMg==
X-Gm-Gg: AY/fxX5yEIRtuthXqb1Fu7wksnmMue6L2xVkAyP7Zktx/jPHh99nH/79fWsY/hvhDk3
	9l0ZfTOM8c0q1zqP00qge8xutzOcXllzYtOZdx+4ar2e2KRF9xiJjyna8P5LVliEIY2M/ODNO2J
	DR3XqHS/+fmQweJTY3Fh4jDDhwC+EKsmp7EEF8nnBUdVyMHlovm9Wt3NKzGpSPim2OMprwnOLu3
	pHopS0e4XqtyPhuIMax2kOzOeVYpT7iu0JKjF1gSuRxqoZTSiHJ0ZAwI2eQ44MCErHHmForKIA2
	yyDss5KAnBHQwM9xWl0o6ldP+MWYIONTsZFwN8LCGG/XKGGjtY/XUIuAHG8tYdO9a1RWXCKcrH4
	o2JEc889LD3qK0LRmHSmjN0JfbCOaaBiOY2oaIz8Hy6ZQ5VflkaSK6ubzKdX07caR3uahhINydc
	8e/omxFgOSRfpQj8KYKz9q4YMCqonKNek9xGqyeV2N9Q8+Lo/N7OFUMAqZuqq2TSo8wCEMPxbey
	JYKy8e1Xv33vCkSTiSFsQ==
X-Google-Smtp-Source: AGHT+IHoetKCTy/pEDc32+prvwD2Q1RnoCrCBHHEv/M6mDpq1Oqnx5ryJch1QdsdD39c7PlRb7aCxQ==
X-Received: by 2002:a05:6a21:c154:10b0:38b:dd94:936a with SMTP id adf61e73a8af0-38bdd949736mr1217364637.24.1768296389614;
        Tue, 13 Jan 2026 01:26:29 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:29 -0800 (PST)
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
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 2/6] dt-bindings: misc: google,android-pipe: Convert to DT schema
Date: Tue, 13 Jan 2026 09:25:58 +0000
Message-ID: <20260113092602.3197681-3-visitorckw@gmail.com>
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

Convert the Android Goldfish QEMU Pipe binding to DT schema format.
Move the file to the misc directory as it represents a miscellaneous
communication device.
Update the example node name to 'pipe' to comply with generic node
naming standards and fix the mismatch between unit address and reg
property in the original example.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v4:
- Use decimal format for interrupts in the example.

 .../devicetree/bindings/goldfish/pipe.txt     | 17 ---------
 .../bindings/misc/google,android-pipe.yaml    | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/pipe.txt
 create mode 100644 Documentation/devicetree/bindings/misc/google,android-pipe.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/pipe.txt b/Documentation/devicetree/bindings/goldfish/pipe.txt
deleted file mode 100644
index 5637ce701788..000000000000
--- a/Documentation/devicetree/bindings/goldfish/pipe.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish QEMU Pipe
-
-Android pipe virtual device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,android-pipe" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	android_pipe@a010000 {
-		compatible = "google,android-pipe";
-		reg = <ff018000 0x2000>;
-		interrupts = <0x12>;
-	};
diff --git a/Documentation/devicetree/bindings/misc/google,android-pipe.yaml b/Documentation/devicetree/bindings/misc/google,android-pipe.yaml
new file mode 100644
index 000000000000..9e8046fd358d
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/google,android-pipe.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/google,android-pipe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish QEMU Pipe
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android QEMU pipe virtual device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,android-pipe
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
+additionalProperties: false
+
+examples:
+  - |
+    pipe@ff018000 {
+        compatible = "google,android-pipe";
+        reg = <0xff018000 0x2000>;
+        interrupts = <18>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

