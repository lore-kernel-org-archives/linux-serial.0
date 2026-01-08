Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30A4383A0
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866150; cv=none; b=uHUaVdy60TZoZ+wRGki1TSLMnR+NodVxBZYtkD9Nk8XXvcugXYzI93hptKTmHLrMpY0a/YDag34BEo5Yo2227aSraQTDmIcadAfVYKyqghYvxE5deV7CzNxE7lsUaVArs0GK5wNAmZOekyy3gxaMgps1vPAVouXtcFvT222Bzik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866150; c=relaxed/simple;
	bh=Hgv7QBj2VJ/Dph4tylg9AUwEbK+W2yWO3bKu+SnomLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cChmhseBoRbawHNM7ALluZ2JR5Iz541J5pY5j6pPCf+6q3xM/GKQsqv63UP7ESU9oOtaHBihyQ/SYPYXwaB6Tg8hs45v37NLpIPglq9V3AFj/HGnzbaSC9HbUhZBREv68V4d9aBLRUO2qnqxOwKkgjXKiv/KRpP2Gtt7W3rFZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCfFOyqR; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCfFOyqR"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5deb0b2f685so1246613137.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 01:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866137; x=1768470937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0UMQNQize8y0H61kPqmNx/nuhGzGL/JdEumTcbx0Oc=;
        b=NCfFOyqRx+XheJZ0i/FZJDVQ8PHJEr/B6JMS0q3vd77LpmgYIbx93vFwcmvnJxKnCR
         e4ggJJK4Rc9Th1UHG38EjWLw1JIGnOblFdux0LnHBTe18+J7h42yfkLGGkXCYDLvp2Z6
         d7FhTqZPEhZqvjIVDfjbbqphvaTHeC+UkEUHrl5P1EGsLg1QrC6pd699krB/IAFjGxf7
         b4YCcdqIMxk80NpsWxk9OGud8AB4rtW65cy0+ajAJcaUlmMo8kIAaUlAe6vj55ZpDCAX
         lwPGTyIBS9IhMgUHJmiBSG4EohL5cwY0z1BDxiPl+C0NnW516p7TkhDkr3QKj0OAwt+A
         vZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866137; x=1768470937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0UMQNQize8y0H61kPqmNx/nuhGzGL/JdEumTcbx0Oc=;
        b=kA/KDknFUaZc3Ua4S7wrADFLeuLdEjG0iMMTM0A0GRXeg1xYOHIriUwIjWbjrjDxbc
         ZFcqiKhIUbnp9ei0F8hYAIpOFNiMDRt6rLEVq15nMHlfFmQcAEFvF8ojNvmg90UYDzi3
         zf6dZ7l96q9Za3z7nUo5uCQ/R9LqcXaCzOjHa0OVbZrsJA3O/CVwN1o2csrKZa+kk1pD
         +e3gYYgNQ3OE0SQqzWhdQKPml7KFTvs+YhpDx7lNWQt6FPq4t+zC54JTl5vE1juFtAnV
         cCm8oHzJJXXC4XUggihILY8Y2cR9JNVdu3bv6pv+gXrh+QIllXgQPBZr9kEAU0odmzeS
         8a/g==
X-Forwarded-Encrypted: i=1; AJvYcCX4AP9lm4/6LETctS/WSpJgPnrNWgDxxJdOTN30coaI91Cqulm3kGhzcGfUBa8nZRROm2W41P1H/TDhcmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3mslJozFBrV4ozqWaDOcVmvoWTpIz2pD35EBcy5fcEqSWG7b
	5pwMcbzHcfhV9K/zjOySP7bmInk7czKDzfwAn/jslm0rOYobyN0QKwLwNv/BQw==
X-Gm-Gg: AY/fxX5hRjqc3nJGGafNer/dxE6AIS7SlUt5i04/UcIK8X4jVte4CGn/Kz9c8wj9ey0
	wYuINtT7GpL9X6IEzKU7tPjEli+vfOfeWhNaoNNSpdauIH/3duqn85oQFKlvGmvpbdk7YqLkTnW
	zNjAKF4rAtTZvD4FadhaNeeCyn/pakYt9f0HiExjZ9fMrztXcsVI397rfnxn+CM1mvtJqPR8eAS
	IQaOYlhjErdA8GpZFzTDGfAyZlvKKEkzbzneZ/FwPOUOGHzMgMCOzNC0WbRDVhn5dwdm9G6nxm0
	ohlyMYFZw4odyfQcMw+/LzpwnDiuZ0UeU/B1iWTFt2+CF2Ygwkpj+CU+bNLAjvOpLF+/2mTtrx8
	W/n5MMxJsgOOTGC3I8XBREp/i0P4yeqIZsyTpFDWvhNwt1BpEpz0tITpDvyFy6nAdPmKS3E3a03
	mu7AmVQYBD28n/kMrKeKHlF66Fv9JKMJr/3i/3iizPNKuxmfdmhJRnGdD0+V3Po8hXbXeJh4MdZ
	YLW+Rn4581GJ6YNGmwewQ==
X-Google-Smtp-Source: AGHT+IHZ2UUjx42RRlWVNMw3b1W04C9piTrC4WnPU6SDQCVTlKuzNskyckz41dtty4xhtSX8347Scw==
X-Received: by 2002:a17:90b:53d0:b0:34a:c671:50df with SMTP id 98e67ed59e1d1-34f5f95c745mr7519717a91.17.1767859772019;
        Thu, 08 Jan 2026 00:09:32 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:31 -0800 (PST)
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
Subject: [PATCH v2 5/6] dt-bindings: sound: google,goldfish-audio: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:35 +0000
Message-ID: <20260108080836.3777829-6-visitorckw@gmail.com>
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

Convert the Android Goldfish Audio binding to DT schema format.
Move the file to the sound directory to match the subsystem.
Update the example node name to 'sound' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- None.

 .../devicetree/bindings/goldfish/audio.txt    | 17 ---------
 .../bindings/sound/google,goldfish-audio.yaml | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/audio.txt b/Documentation/devicetree/bindings/goldfish/audio.txt
deleted file mode 100644
index d043fda433ba..000000000000
--- a/Documentation/devicetree/bindings/goldfish/audio.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish Audio
-
-Android goldfish audio device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-audio" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_audio@9030000 {
-		compatible = "google,goldfish-audio";
-		reg = <0x9030000 0x100>;
-		interrupts = <0x4>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml b/Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml
new file mode 100644
index 000000000000..e0b26c1f7b8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/google,goldfish-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Audio
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android goldfish audio device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-audio
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
+    sound@9030000 {
+        compatible = "google,goldfish-audio";
+        reg = <0x9030000 0x100>;
+        interrupts = <0x4>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

