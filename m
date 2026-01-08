Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C43D7277
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865767; cv=none; b=ZOE+WLbevmmB7xmZ6TMFN60+bzJH5TT0X9VGaRbSnV+zVv5zi++to71iek97Yl3zaDGdqD5MxxrVx/RkUE/Za+RGHqDPVoOdJ2i6VtFAeKiLdc4p5zRHBVpOzb85wM0AuTRc7P8kdrT0klep6McVwdlJjP/4CZ6NFEwhQJvUZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865767; c=relaxed/simple;
	bh=3n90BbXpZmo7/97SyvwdOM2dgbMwLekUvvzKLPzma1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWtkpDgxwKtDibYfHe8eV+pAeUPOE1o/AD+CwDcHYPAxT36N9VTI0ks7r4v0kLZVRbef6fUOvVfOno1hg/PHMOUhZ84Uwpgq0XIwR41Y+5Rkwhxar1n1qva20vwdf1hQTQQz+a8ZovOEGz1dR5KVEV9YWT/k9WV3J1gHR0ZWvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn1GmCax; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn1GmCax"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a2f2e5445so35082756d6.1
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767865755; x=1768470555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jVrer7foxeDXiFbFRi4WTYBqb7mxG96n3TZ489PhHs=;
        b=Zn1GmCaxVq1YRCYHDiPE24hweCtW8mkaMBaGnag45yDYQQ7ualPuQXXUw8zq3JahJ0
         gDBWjMikcIcNod4zrMWvKntDc13zayT07Nco214ZpPOvczpS3UeszPZZ9EAD0kgDePxz
         aw7XV47lGxKzjixVeVtsHmLZ1ipvyUOPCcRJ9M8ZWVDqVA5U209GzPKo/Q70DGzsMHUG
         YEK4ElDy/ekWO83L6e486ZfxBNELv60As+RS2c+tmhUy3P8Xxl63N02xGVc0LDOzMkc5
         gy0N1u8+TEZvi9T1Y70NYl+EdXntc8xgPpYxG5DC0VW/MtQ0OOiKgxE75xZjgUNi5/VC
         /Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865755; x=1768470555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3jVrer7foxeDXiFbFRi4WTYBqb7mxG96n3TZ489PhHs=;
        b=e/bH1NYOsslCe5QgxO5PTIwADNh0/gBP9xDkFSe4ZK8NYhRrhYU31akdlKbJroOdtY
         HdGuoo9a1aja+0qa4fEMzYjgLz/YmAzwEhaPOyjz04x4NFfSolmWt+17pv4zgYcnwG4m
         MYidZfrQQlxU7l1EVj5JREM4LFdutPyuHSLhhIorlqP7FB+LBPpYf96wZXcUhSdTrdBe
         UJDelH3s5fOYUGRiPrXMWcLaRJrR5DuTULzYtglw6GMhovfTCEtUN1gOe9R4i7Ryb/2G
         oydXRe2NolZptI6SSZu2A9oYVpw6PH4kEHandLO8bke8V+nlBzOV111TOB6fUys1wpnQ
         GEkw==
X-Forwarded-Encrypted: i=1; AJvYcCUHydZLLfcOPViZVV7jkW5Fvd0zHH+XlEftXTFB0xgC6Fhidn+CN7P8UuA28cvYngBkuMqEuFDkyBSEyQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DP6mbcHdtjfJR9K301/Knm5jG9e+PJwK4rEKG959HnvCKyd4
	4IqGTkgT6w8E6KNvMtROtRcLs5HVsPETu/bYEi67unTWHCu9S8SL8VgPacm1dQ==
X-Gm-Gg: AY/fxX73KlusCFaj7+USnNQtmkfoi9NQ4AoAqvm6NzA5Bh7D+c1ADXzKQ5eCQ2QoDkF
	2w+ACRFajOjbnj9k6Lc1KbKuOfVYbexovUwHP3L99KZDTNKyY+wPFO1f7Rgnu4bD9HyLVUxJUxb
	eg0859BAwGRK3eYNJpnMBT3B/5N7cKR2VZkehu0kQ6WTgjJzlRo7KnQlWPXGVOepqbM1BEhzKm8
	OcPb94a5KY7i6QnD7Ca0N/UnZjjxnWBEpJ/D1PUK0R2xJhtRAlH1ETvRgpgCh1NSAbEWMnAPBUM
	s3YFH1Gln//Mb4oYrBWY8wnu/Hx46vTWwyLyXGS5Z5U0xjs05eHWfILNkiNa52PY9IRnV7XWgti
	mDNZmCecGd7pP3e8tDWBHcGYiYE4krICFqvAKYW69513pe+/CrOrnJP/TpdIZyOVFGWobm1zjDT
	I7Y5wr3MKlXGb4ZIgKZ1AQjE2hrfRfgvAnNBQXcJG1vpgvTuJ3HmrBzamzL4jiOM0bGlpeeNRdx
	GcNaAMh1v+oNheNMAwKAw==
X-Google-Smtp-Source: AGHT+IHrWmrWZovQhYEcCj3OW2qe/OMr35yE9xC18wSEU8hxPlfPFqonbAeAYlH/zyT0y2ccrqO9lw==
X-Received: by 2002:a05:6a00:9085:b0:7e8:4471:8de with SMTP id d2e1a72fcca58-81b7fbc91b7mr5136728b3a.63.1767859762235;
        Thu, 08 Jan 2026 00:09:22 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:21 -0800 (PST)
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
Subject: [PATCH v2 3/6] dt-bindings: input: google,goldfish-events-keypad: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:33 +0000
Message-ID: <20260108080836.3777829-4-visitorckw@gmail.com>
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

Convert the Android Goldfish Events Keypad binding to DT schema format.
Move the file to the input directory to match the subsystem.
Update the example node name to 'keypad' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Add reference to input.yaml schema.
- Change additionalProperties to unevaluatedProperties: false.

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
index 000000000000..4d359c9be600
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
+        interrupts = <0x5>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

