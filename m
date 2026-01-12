Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE72E7BDC
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249331; cv=none; b=T0ENwkS5a6zhRYQVOEPD+GplpPYAGobz2PNq1C13xo86qhcfwkCbz15FHlDjHCnYhDf5Ii8Zdi2DTIDhXxg+a1o8rtVHJA74PLNoLhPvfvyRerxtAioEKGhcRqGcwvPmoYXwNqXrSRtxKxVR8Yi0gCzOrWLt6myaBbHxP1jXSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249331; c=relaxed/simple;
	bh=R975+6cFhZbxfj7AcmB2qCDxz2fjGpYeQFlJNfAlsrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM+CTkIOhkwi2qJ0k4lCKquTnZZqumU/KPMfiZCqKNd4VBnuxLLACM1OQ9c5g3062qbWGAcv7urhw8scLRF9/aWdImt13i8fbr2Wze8mqOt+y9ExZSophiJxUO3qhD0QvPkv5wbydl3TzQlgWaYljRXraO7b0Xm7zKGTV+eG/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKenB2yK; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKenB2yK"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-65cf597a717so2877418eaf.2
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 12:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768249329; x=1768854129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcjtfYLr/hzQ7i+u9m84wCmIOhDfx7TiS5rWTLTDi7o=;
        b=TKenB2yKkT0NydrQYzrOw9k9cPc4klDPgXjI8FaMLN0IP2xkfha6ztAdcLQiL9V5yE
         SQjZujUL29cy2L1cL/HTa02yNB/11HNTS2ejlTR4WbmaECWZvGzucv28vvH2jroeiPX2
         LsQxxhZhQ8t1EbgOhGDC6nAvEOMucOBs8VSJBaqJRvV/BxL5KQF7e9NdGkVYkPtI4RYP
         qDv4oi/q569QvBUbPQ4E/PffJFvhBALcFZHbX4tvhimxEj2GNfC5Tul8Lwab6ZZsFDBU
         k7suACHjlSCbBSOqCFnVnFF9CYJgW2lyId4r1SuoSlZMbfAGNm+QEO/pVN3iMVCHGQFH
         g53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249329; x=1768854129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcjtfYLr/hzQ7i+u9m84wCmIOhDfx7TiS5rWTLTDi7o=;
        b=tNaXBQoCWiGWcHu3Exi/5k/5zZN6JjUJPpAbF3HaqYmWGIUDhFhPIilMmqdp5dWmS2
         0KdCRPfm7W8AO8Cev/WCSvFnqbmwHxoXGJcdvNQYY01DMtt225RzWis49FyemNENRT+s
         ycXNzTTzUrUx27wDXiHQT3W4rhEjZWnHFLrHgoDNRrwNzvSyIJTvqbBdDvCW6Rr5HmkU
         QWasdUEtpBoA7C8TJFicjKh1XfjmlEeggCsp8nvaJMqJ8P+9C/W+KDPPnMOMBXhodqpF
         4486re+nyhoMEgguVqmyFxut3hZjIsVSWdgL7lGMoHSncgrpLZZpDe3s1qmx0dAG1CzY
         cxFg==
X-Forwarded-Encrypted: i=1; AJvYcCU9EAPjT2jUdvtKpIWiYY/alBsd6nFVJHrl2LfI4OXWCH2D/ieEmjy8D7R92qH8J1Ae79PjddNY7kRZ/+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WYbCnZ0m4I1KLdFxOi/UkK7m+g6OBjQZH7yO2yFPz/4sQnWD
	mAAuymgGRMcONlXoN4mngCQMu8qrtUKIJoB66Rc2ztls3MsMFhlwav/Xas4jIw==
X-Gm-Gg: AY/fxX4+9cw7StGToXJ5p2s6fiyEvo6t5vUL1oXEN4X/Mr84fx2lnybTwjiJKpw16+y
	RYerHaWhEWzDM6YsegR6P/DYxOIRLNgLq4nJeYFmxj0feIYrkG9T1X71CijKySNTIV/2y85tAVL
	/SMu4iwl75mRZR52Y7j408YacioJB4qjn1bpPsD91MfIdIBJcfEGEs7k0cXdSn95h/Hf9rDGzOX
	qcqOcSkcoefsZxnw5KPfaKEPpMxSAyg4QJlhwrks9xxdntuBNh9lhVM/uuW24ibwxAid6Ceyqky
	ZraARCrOXLAPF6donaq4eWIJw/wYG/bgrYRgUGRUeX39/smXu/lpd5qGgkk9k5hrB+Y8w/k3iM2
	pJFvrFB+3gNGF+nWEDiAhnoQYu7+ZY99x8BpTtXq4xcFgdAp5nj4lT1RrsNa9tQvdCduHTD/f43
	QhuEEAdA1jsyDYQkH/HEsJ9nm0+H7OLwsuaQbynvyO11tvUSAhMGZHg0Cu5f9+TkeZX7Cop7hCd
	J0R8OB8Ay8CpRjaqL19iA==
X-Google-Smtp-Source: AGHT+IEhhjkMRhLtfe06HmVUiVLdJt4MdPUnRHhK5mx9O/EoN/yul2X9MrifSFUaAnpKZe76DRHW3A==
X-Received: by 2002:a05:6a20:430f:b0:366:14ac:8c72 with SMTP id adf61e73a8af0-3898f9db825mr17301674637.72.1768243931042;
        Mon, 12 Jan 2026 10:52:11 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:52:10 -0800 (PST)
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
Subject: [PATCH v3 5/6] dt-bindings: sound: google,goldfish-audio: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:43 +0000
Message-ID: <20260112185044.1865605-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260112185044.1865605-1-visitorckw@gmail.com>
References: <20260112185044.1865605-1-visitorckw@gmail.com>
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
Changes in v3:
- Use decimal format for interrupts in the example.

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
index 000000000000..d395a5cbc945
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
+        interrupts = <4>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

