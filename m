Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2429DB6A
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302964; cv=none; b=HEDGxxH2F6hYAwsLw0ivjN6DooAZGE9oDyXTuImB+PTFz3Yp5JIoZGlvZZcCEXwdP2CScs8mccNqUJAzQVgeFpIYO7fq/MDajS9RXyheLZGs95q/gcDTNZ69GKUDG3azpERcZQymgfN0tyHbimj1X4G/gMQn1G4AZkxZ+z76TgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302964; c=relaxed/simple;
	bh=HDUKH+I7Fa+PmeSfYZXj+pEr7M14pExXySUjkX85juE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gc6KPrAvC2N+JaxKWyptsvL1fWSULdYCxzI3T1LFok8x+KU7WLiptRgmoH2n8oDK75tQYY1eT/fdFOhq39dwq0953J8v78FWsa4BsNi7AatQpM1vbXHUcqX4LztmyFcB4RDfwvb0mYH90KcpzlGGj620JsBN9rUxmXYF6hH3k/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wuhigjan; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wuhigjan"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a367a1dbbso125415816d6.0
        for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 03:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768302962; x=1768907762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DtPGFQHFju1IO/Degf1/ys2a0tv707U6qKEmBe4+A8=;
        b=Wuhigjanx4M9yyniMEtQdOX7JUwi9jRcU3RXgLfx2nV+5HLBO+66E7ea57o0DCcKv/
         VOCRvccx+lphf2ewNaxzovF7DpmLhI3/ZrZdp2MUEJKHVtnmwMhbDEsHMmNYutp9OwKL
         GW3a5bp6LRyFDKwcuSlZu6NLpix1XKV5KgkwiINHzR/vHTNcDE4/Fm/tCapVRXNtUWEh
         8QpDuRrle4gkoUTiG1Ylyctab+vxJyOOLUyGTPy+tVIrrHVkKV5dHZiBzZv/p9Ob05tM
         a4OxABw3iD/fm8mrfdCdo/zVJ9e7uC7Xd1BcvCsExRA2zupTWmrytxdqo6MCMO4QAVz+
         pT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768302962; x=1768907762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DtPGFQHFju1IO/Degf1/ys2a0tv707U6qKEmBe4+A8=;
        b=MhbtJOs8szT3sxAQOXVGx17Dpz9CXq5dfvapC97qQkYDPgBSlbdbH9ibfXvnAa4l4t
         v4VjSABS6cwIlrRS58nPXBv8Kb2MFPO9+lBuFrNdnWYF5DlK7ELnqWWmAVQErvDCbEaL
         4qllGgmuiFWgiw4SWw3Pncmi/w8LRdJWTzEUqG4wgBY423rTZA5AisM1IgMv45FgsFS1
         Mrvn4p4vGkrkEdxxMV66FvlQTs9PCjR27USf+b0sfii8sIDawc1H44kYElJv7fG8PaDm
         tsl7vFWGHqh7MFzP7YJu5wlE/RHHDLdkkr9LtXX+8TynfwppHB/HiPl6buJBwnBs5JZ+
         iL7g==
X-Forwarded-Encrypted: i=1; AJvYcCXY3GTBe/lr57YGq4J210lHBbL1gJBh3UEBKPUeCTydrCJOk1+hwfzAPrp+mGW1ikGdeJ82jsDkw3GlTR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykdm+EKmZLgNZIywZ+MngH2I3dA3xjVtOA5qMTO2q9AEMcLUO/
	OAtzwlvqlJPwVoc1WuW1jquwxfTJnIqkUWLISbKpVYui32LoXNmw2p1o
X-Gm-Gg: AY/fxX4SjKpzzuTut7+6mk7ZAYj9wIMjtK6iU/CQqurgLuCIwlYOusGgl+5I3Apq5PX
	Tgz3dPAFl1oCDo+VK0DY5K8ZQhoiplI9h625mq59Hwsw3mTXP0Z7BB3W7u64tgMIZLAtFG8hb+x
	7hOkGQZkpOvMRW+R5sMOLi6izXvtyjImAb8tCnE+Fcc1sPEyGvuDITxKvR2+OlHRuQF+roGmOlx
	L3ZCtSlk01Ts6WboXMvygzYoIlBOjRNGfvz+1UlVs+V1/lZ4JAw6IkwmcDZ/AJhRukUOr0C7X/V
	Kjm41vSsWiboMsGVvGr7kGKBH1PsPebEXv3ToQtiDBT51/mREpKck6x45AN9qjMt+3vmY4knAMx
	YSvuysFV7w+k1GDXqVZarkCLY1jrraVfwCzc8OpZJizbhEkfPu05Sp/LH7C6rhTEAlOr4dhRihs
	APlYEE4SfVHI80IzNGyN7T2jHa4X+MOR7J+A0T+EYY2BO1Oe2voiPNzAbzxSDI6bpM1eiqhyF9R
	nzDJEbuUEPg3mTDcQK2QQ==
X-Google-Smtp-Source: AGHT+IGN7YtptJAvyBxGsryFp/ZVQ3AtqkPm+d6Uo/gUGIm0zr03kGaJ57Syx71qzIqCdd6goycVuA==
X-Received: by 2002:a17:90b:4b0b:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-34f68d0bc5fmr21176395a91.20.1768296400127;
        Tue, 13 Jan 2026 01:26:40 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:39 -0800 (PST)
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
Subject: [PATCH v4 4/6] dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema
Date: Tue, 13 Jan 2026 09:26:00 +0000
Message-ID: <20260113092602.3197681-5-visitorckw@gmail.com>
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

Convert the Android Goldfish Battery binding to DT schema format.
Move the file to the power/supply directory to match the subsystem.
Update the example node name to 'battery' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../devicetree/bindings/goldfish/battery.txt  | 17 --------
 .../power/supply/google,goldfish-battery.yaml | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/battery.txt b/Documentation/devicetree/bindings/goldfish/battery.txt
deleted file mode 100644
index 4fb613933214..000000000000
--- a/Documentation/devicetree/bindings/goldfish/battery.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish Battery
-
-Android goldfish battery device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-battery" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_battery@9020000 {
-		compatible = "google,goldfish-battery";
-		reg = <0x9020000 0x1000>;
-		interrupts = <0x3>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml b/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
new file mode 100644
index 000000000000..634327c89c88
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/google,goldfish-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Battery
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+description:
+  Android goldfish battery device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-battery
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
+    battery@9020000 {
+        compatible = "google,goldfish-battery";
+        reg = <0x9020000 0x1000>;
+        interrupts = <3>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

