Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CA43B836
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866439; cv=none; b=cFujtBXd8L3cs+URbEWOoKqS3P3nD70r4A1Sz5p+YghdvzHuKG0P239ljZi4opIV7VY2A4te7O5OfzTA0hBz5GzToTyRylmNX5EFmruq0WTBXPiHKgGPTjKZy86TCmclYr4kuhXUnr/M+qFT7qPDIF2V2glrWffG8Ni5wdlxU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866439; c=relaxed/simple;
	bh=+em6k554hiEdgZ3gCIS3vNjm0IbnUUOfSriX33xjyhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoCt23ZiwIuHljQZjtBB6MppqHRNeSiF+mbI3ba6qzVVdoJbYdpn+snj+fH5GnXkZHe51RUr2Ohu7Ll9nws3GyEZS9C4d9UFX6Mrj8FFLjwn3zsErutV1DzMBacEG7hpNIjtkfOe9QKW84O8qD30NikNRgLUPagjUqgTHHxM948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3pxdzN3; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3pxdzN3"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9413e5ee53eso1756696241.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 02:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866434; x=1768471234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9Cv7mdPPcZ8e/4RiioRb+FP1zONlTuWhguDLBncdBY=;
        b=D3pxdzN3cuvny5mLLjWYuIOIqniX5nqNKcQ45ShkMQeFqqCnYvNxybAEJ7dUJpe5EU
         fgP11S73jqYUmb/xB4NGRXUT/OtjJBU6RHEEL5zsrJAVa/aHU/R8zseuK1jh/pAb28xH
         ZAPix9uh4UoPRpWdXSbY7EKIRZ36SNpa8jrO4vfjZa05TZP+EFgIf60W0L+GciPcDGQ6
         /06SMvd8/Gv2F9f0eZbg4+SqFQqV+teqJcbSowwhIueLadi9ipRa3ONigX6vgTaqniBR
         aa9CkNQsi7jH8DMWNTb+jH6HUD/v0Yta6ChI1K6gZ5W9h7CwAn0+LFO91qu/T50BJVK7
         Qdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866434; x=1768471234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9Cv7mdPPcZ8e/4RiioRb+FP1zONlTuWhguDLBncdBY=;
        b=EkOXvyfiaKwLUU6XJ75mBYsLHMpR0EkJVE76I7lvqLDrADH95mnLoe8bkOdxPDH14C
         zYVpytWdOQRU6+CDx3fHA2AZg/P5b3k156p3YfKgUWf3M1bhc+6lzEsvoIsAtcQBLF0h
         nvsUGBOfyfiSdgr1Iu9QS6Ol65+GCwWx+ZhQV3+hgTF/peJFKws5knpqU4E2iggm8zTq
         oA8lDuMxfYy+mYLz1u+qv6daOdB5ORreyvicF5kARiy9PnWayfmbU9mVdoqAKoqgS2xe
         OlMQWk3dr9/Y0gCdkhMThUKDTMHKn/NSWa9JaDE3qMdhpvIrf9r7487c7/ThtsIdORru
         68cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEM/3y9qDLPRbzGgYmj6l64ZsmbcR+fDJwlOg1knmASFoRuJJvQ6bQswvuvZakN5z32PZL/HrppM978s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14hYjrVj2Bz3G53+1OPX5zBz5qDa3w329kWM8LtxLtioXZVsd
	uoCC32/5sstQItnbio9vOMqX4s6i/Dk12DUnkue9XNECfSI4wrKJbTz87qHI5w==
X-Gm-Gg: AY/fxX5aCKENh+7OZ1NzBWXehC82dnR7Wb0TrSXPHcZS6yovJunJFQbujBTdq5xPaFw
	Jl61MiaKcGQpzOL3tb4rAqdLzw/SH1PnDhGNDJ1ICunKEsM3jtzQyzplcpaX/mV1SEfxBw/NWFv
	kATEhRTktxf0oD4HXniqtCUZVT8ppbh3MwcfjGLiDZs4GZrpbXaoPGOlzAqMsiECVnEOGi+CmlA
	ESIjqukn3R9gArCk3Xd4WOs8TP2/au3CASt8ZRaBi7+R10O3Ce/9mzgw7ipSDHV8f1TobgqTIy7
	UrZcab9mdBCBBsBAnYptrlTOOTv1Dhw4OTqw3FOEPnEbQlSBUAWc4tGzEyT3Fgf9DsjGCUw8DtH
	2bZSGc3RU+w8DxE6OdjXuq6HvhQmV98/2UuyMfBMEvudJvPDuHmLFdnASppakjw+nMutjHI7oVN
	KrZIriJZVKvqBwhDX4qPsi6pu5/saYsfDhx19IZ5xxAX9sm2AejwieFyLjDA2L3PWvdabMtZp4I
	rx4AK/clertlfMl2MH0Dw==
X-Google-Smtp-Source: AGHT+IE5lf3uPbw8VErEKzhFGGbzHGx8u/fDHReHMHASFjL4yvedLS17Wjxspaaf5SF45aWguaeksQ==
X-Received: by 2002:a05:6a00:8c10:b0:7f7:497d:8118 with SMTP id d2e1a72fcca58-81b7eb26e99mr4452899b3a.7.1767859776927;
        Thu, 08 Jan 2026 00:09:36 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:36 -0800 (PST)
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
	krzysztof.kozlowski@oss.qualcomm.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 6/6] dt-bindings: display: google,goldfish-fb: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:36 +0000
Message-ID: <20260108080836.3777829-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260108080836.3777829-1-visitorckw@gmail.com>
References: <20260108080836.3777829-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Android Goldfish Framebuffer binding to DT schema format.
Update the example node name to 'display' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- None.

 .../bindings/display/google,goldfish-fb.txt   | 17 ---------
 .../bindings/display/google,goldfish-fb.yaml  | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.yaml

diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
deleted file mode 100644
index 751fa9f51e5d..000000000000
--- a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish framebuffer
-
-Android Goldfish framebuffer device used by Android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-fb"
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	display-controller@1f008000 {
-		compatible = "google,goldfish-fb";
-		interrupts = <0x10>;
-		reg = <0x1f008000 0x100>;
-	};
diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.yaml b/Documentation/devicetree/bindings/display/google,goldfish-fb.yaml
new file mode 100644
index 000000000000..48b9c056d9ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/google,goldfish-fb.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/google,goldfish-fb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Framebuffer
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android Goldfish framebuffer device used by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-fb
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
+    display@1f008000 {
+        compatible = "google,goldfish-fb";
+        reg = <0x1f008000 0x100>;
+        interrupts = <0x10>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

