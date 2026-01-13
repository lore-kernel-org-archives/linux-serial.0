Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34B38FEEB
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296422; cv=none; b=VZpeVHT7AM555irxndqJS3qOyRkHQ1OaM+gNBi0/O6vyY3QUJduc47z/Ed7lewbGEEDOEX+nPPEgxWvVFs5ewoRk9wB6iHqwp/q+PaIhMQnbWgs1iTlZ9LNjSQr0dJqbDtTZVRFNInmfc2U4s2ubw6jfhz20tG6PrRgmNyKEvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296422; c=relaxed/simple;
	bh=+L8oRv6c4uzxGnAOgO1ncLSet2u2lLn2QoYO/8E8mV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTXd8RX91nlhc9NsOZfW0dTcFroW1YgKt/F++GbTQDKASEU0AqBZWqne9fJ4O3RKhY+lf1VHh8Dkyjd4bkdbk5v9rOqqML59NgQ03NBkMMzO2ST4z47EqlTeHyPnSbkZmcJNA1wx+g+JlvMBPvOcFiWPTu+vwDeA+Wy02DCRDF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kySEflIu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kySEflIu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so5302994a91.2
        for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 01:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768296409; x=1768901209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq61suyXUukebztJUE3K7EWOiO6kPR6U4DExpN7jb1o=;
        b=kySEflIuUilN0f+EMaydKBA+7sgyMwOtjXgaAgqis3XYlF8IEIrAIyWTXjmQ9vPspd
         qEfbh4uf7kSUOL45OkXUhCBp316mYLdJOJM3q4Q6o/sGcJ35XMyytep6RHqisQ7Whjo2
         4wqLZma26ll0xwmeRdVR1RzDW1aBP3twbXfbReM4SSW1lnyVrf1q1Rl9bhiPhF/Ltz56
         2FMco47ydttcGqeJLFTNQVcn021tvufj/XJbkJ8MJNsaW34/kGyz4M8jLma+wFDhfBxr
         wmlFndAULJe3xYfMhZDJS2jdxrhyWZVz6qU7cD5bT3PUVzAOiRkWL6a+2HKk3iU78oRC
         CtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296409; x=1768901209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aq61suyXUukebztJUE3K7EWOiO6kPR6U4DExpN7jb1o=;
        b=MGpTfXen7WBzwxuT/EYHwGtLLlKNsmqeQHBUNSg4epubiLkH/lWxVcQ0AGAZoUvJnZ
         PXp9gmOJQ5G2f6BnAfmeTpQ/VFIwy8nKUCSx7dcNgyP12iptX0+Kd/c+9ZhsmBzhucu8
         p78uYPiyOnrlfaXqW3rb8TT8EdowFgrRb6v9kA2aKyVrBMFxiGkHy14ZQ/3ZltDye/iT
         VdZoxqh3YgMyp1HTNYHloKWkebma3970VJMp5wKM9lOzU2uZ4G0MzTlipJZsF3XSWzYA
         nxmKwX7S8wMPAgI0wkC+896S7uK0BdP1fwUq6QsPea/86K06HE+KL/z/JoR3xjPlvuIR
         z45A==
X-Forwarded-Encrypted: i=1; AJvYcCUFsXT5lN3zarwK08kc6X6Pd/PATdrc0Xq5MlCxyIraZZAm0YsZ7a6vuAKri216eLFXgtRkceKfvjbJY8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6cpQoxrO1gCIZi0Ahg07rn8k67NXrHVAwRje+/eo6whM9vD8
	L/ap5y/QcsSoBpnjdoOxMJ/63pbRe//e/NvIqjNP24asEiG0aVh1Oaq/
X-Gm-Gg: AY/fxX4Yt1Qna+HbqAGoEWdc2Ua1JAQNe+QCDZi3IC4pXJqivTZgLuTa55h7rCLjyRL
	fbht7qhGT2OMNZYba/xvYvEsbtmpC1wWjf5Yx3KW96rRlv/dZ5e3B6lwdb4i0tYSSNbU0tcoKLw
	DSC4p/D+Yg7mIKqgcXUXHk7WvMOBVlMLhvvgth+vgo6wMwAhruM9ApRPFjVtemu1h0vg+0Ajtyo
	is+xRNB9YT10kN9H4mX7TyM4WPlmjMJHdtCUWq4YTPaKkp28NAZedYc6938LK0tE5up9tNSquZA
	VWFlmfhZnKJWpKY5P0X+1sC1E2g1yk9zxTZ1kPJP4e3qc0O+U4CzGb3jwA9QqSXGyxeieFJp3C5
	XGshaDU6Gf+3mL8J3Yuu3/h7KYRRQ1NUfd645I8I++82HIcVU7lz27Ij/+jR+Jr6HCuYos0w2aH
	pHGaQ0Cpj45MqJrOL3ZxBi4eHC3ncz6YtmmL7F1524/jCCGJ+VkLOK5lQoFk/k9g68fDIobnCtZ
	g4bAuhQPbpHXJlG4DrCag==
X-Google-Smtp-Source: AGHT+IFysOWrChXhSoJPQJFZ+6qYg/6GiILncbhIBk3UgY6IvdbI61uVn8gPqLHEqaP0DqKTMcvR7g==
X-Received: by 2002:a17:90b:2647:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-34f68c30870mr18506943a91.3.1768296409472;
        Tue, 13 Jan 2026 01:26:49 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:49 -0800 (PST)
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
Subject: [PATCH v4 6/6] dt-bindings: display: google,goldfish-fb: Convert to DT schema
Date: Tue, 13 Jan 2026 09:26:02 +0000
Message-ID: <20260113092602.3197681-7-visitorckw@gmail.com>
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

Convert the Android Goldfish Framebuffer binding to DT schema format.
Update the example node name to 'display' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
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
index 000000000000..36ed77cbbcd7
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
+        interrupts = <16>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

