Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85A21ABAC
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124230; cv=none; b=udQWjNt6FoafP0qgJKtvyE5bROyuytZBbumGgt/tmvTfKCMrBC7AV46Ysa1PNlGQQWDy976Tu+gbpG1sk2ER7bauKWsqVPhcixJhR5glBIThY6KxtnfLZNnTKxxF+hZsEw749VT3MYN6xNAH6ok7cd4YC8BIn39RL0tPi7jAzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124230; c=relaxed/simple;
	bh=wuouABNtno/my3xxB41xPlJVygP/E24Aj/Ddg3O+3RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAYW/15LCJLDXM43U5BukQhiswnZls9hLB6kyHrLdiAghqjagQwpFakQJH6/bUw6IHrHQ2v+eESBKLOsLj7Aj9cC7N5XFPWxp4nvOoM0VOhj4UZ23tojgHIdbGOgArRYx0vNXykV5CnAdGeWorLULXFMZpRh7LIyBvwHkl7MFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPHtbeLk; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPHtbeLk"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5dbde7f4341so8898849137.1
        for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767124228; x=1767729028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY9DKWu7ggurjBP9bHM5tPTMCGUI+TAaWzZpacbdf+Y=;
        b=gPHtbeLksC2Z07B2pjA/QQSmQbpgs0HqBprUo/6ibengkvhyF6KiNVZLDW7QG0ag/B
         UyPioSqxnnYcObNeTpAXRvCrZTFZEjoglkiHcLH84hcfKT95GIToAk8Koe80eweGV17P
         ZfXjJwN/iEpRJQV0ALHzDHzTaKinH+B8m7JhWrATdKGvgntokWHA4KkKtZIahtGf96Ag
         Lfnv+dbjSNJbTt34ve3lSy0ZkMU3Vm1AJ/o9vToYJ1O6swNw4yN+VmxmiieltC1KtYje
         s77O9ebUkd61wJniNa5QPPcZLVlPJjjNTcsnNWFBxrKC2AnSoRAvg9xYxgwjtYlfp437
         Zz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767124228; x=1767729028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY9DKWu7ggurjBP9bHM5tPTMCGUI+TAaWzZpacbdf+Y=;
        b=SAY22uLaguVXwTM+5r7dPRCi/iLqD73EitfJDx8J7uTYK3lBHxc470WYztGd/C0b6M
         5YF5FHmRmOev+fYS58elpfBmYk/sNIpjviJsbohlNfgfHNbRURmxRRnEt6bzJbA1f6Cg
         wW07s5s9B3tx3ErH5ZY1gSvu9gn8WXk2IZ8HihxBi1TjoTq+7PC/RZ9R4UTFxqxgj7MX
         2STpt3LOe8n1DmcMiX4/HsGVy6jv9oIJOK6SslXlpUP/6LCJP9O4LIb8oqKV8C7cZbrq
         P3zeaPtuZngDGeXA41/EtTSrHkbtqb2GiB0l47hLVcFzt7rcYAJb8iEH5FHCmyTvv/AY
         Ny4g==
X-Forwarded-Encrypted: i=1; AJvYcCX36LLsbngHVU2xAkqS2dHhabk7lryhIjyyBgr6HHAHwwjiIacoqM2+2VDn960JkVYpe3il3JQNrXK//QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvIoXaK9t6nLc3dhfHRzeH5giveAWEU0IIRNZ794/oKsOYq3b3
	Bmb1oW4XtkB/rGPezmbPMaRmlWFJPJI6dhDR1oEXrqyocI8o5bOR2FxhtvzPIA==
X-Gm-Gg: AY/fxX5thLpLHJMEH65PnAfowznECN1aO3MhBDRKPO4R64zcw/CahWGmPP881fnNqEO
	0qSmnLmipaanPy5C2GB15Qpb18YtHmhlYVwa3Uo1G+tg+cEU5fe+YxchbajiMT7Q66yZQoQhjWk
	j7XUmPJiyLcrPZV2/1KQK67Sffeie+5A4tl6iDes5XBH2Ja0VMrTVBEXF182l66T7PjY/eD9Q5e
	CUUbPfiv5w6whUIAWFeqVkXCdOM/KNDAK2PcYKKYlR4LujGIph7gChczGn5H4iXeXtZ0gPn3dea
	W1xYNTzHMbaJd/m2GtNAazondKE9cPV2/47BcSLhAAVwPpBkiEPmw66a+pSqasOz4zuV6eX56BA
	+KkqsoI4aGr+/x5jo4K5v45rKf7LYf7GbtXSV9KFnRu3wwMaqqv+wcawRIx9Rfet+qHilvydJKY
	YEdpHnDsO8e1FDfYFgEov+zqBLDlpVjy1TrDPzTWrJ9awGhQJ8o1RGynHCHZkDF2Udy10S0ugg0
	A0Y+CKMnCXMAFRZFFMhrMnn3Cm5cRDp
X-Google-Smtp-Source: AGHT+IHNSjL6XO/9GG+VQ4LJ4CyetXEzcsFuGnG9Kdw0+OI361O47497s5aMUrTFKuua6BqPpBWyVQ==
X-Received: by 2002:a05:6a20:549d:b0:35f:84c7:4012 with SMTP id adf61e73a8af0-3769f92fca1mr31561858637.29.1767118275492;
        Tue, 30 Dec 2025 10:11:15 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:11:15 -0800 (PST)
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
Subject: [PATCH 5/6] dt-bindings: sound: google,goldfish-audio: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:30 +0000
Message-ID: <20251230181031.3191565-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251230181031.3191565-1-visitorckw@gmail.com>
References: <20251230181031.3191565-1-visitorckw@gmail.com>
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
2.52.0.358.g0dd7633a29-goog

