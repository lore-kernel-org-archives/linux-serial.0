Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663A31AF07
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249716; cv=none; b=UXJq4PJxSHZfQstLADx/tWE1T+hu8cTD86mgRWWmtXXJbXd+HmXmRDBwsTPZMGViH5vnueVblbXNj1v/B/3R90rsFpedWkckbjJSq2sekm7fLz7iCJGsZmlR2QASU1YKhKCEBKc0ax8deT7kDgEON2eFkvEksl+ilqO0s79a4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249716; c=relaxed/simple;
	bh=1cgc9CyPLdaamTqWSH/prcaGYr4QsO4nAqSVaUroafU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP2fG1fc1lWsIx/7YMCTUHzPRhTUJss3eWUJX6drpxG8rH3p28eU7i6E6sCj6500bQXNZe3Z4ndbHyb4tbBlT/ioU3CHKo5BoPVcmqHGdilZFks1EvnpLDQyfrvBXTTopakQ38VWmqeoGXk9ofs7UpvYEmRaAQE1LrrKvbLOr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihdeYOLc; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihdeYOLc"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso4946245fac.1
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 12:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768249714; x=1768854514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0PErH3A+TCXfgL5PR8asxXBIGBytLNSMzZeGmnD/jY=;
        b=ihdeYOLcHeC0Os2kD6DSdWPOtvN/INGKGbzPkfQeb/FI2foMOoeS9XnFG+lqEcWd5l
         GEH7AyGTdNwB08QgckYMO+xU/qMBPP+TYO6OjQ/4Fest4ZB45uxxMUtqSYwR2d5hI7Jh
         drnzBlqXFKMHVxG/xcO6rSW57kgslxLpe6fKnwMeeR0QomkDIbWPNBhoGRo9doAP0VeR
         /LswdCzDcBGRHjxNhF+rw4fLoGWeX3t3Cak5RiTrHJGWfTvSp4RBwJzZXY9gYGWX+Iwe
         GW4z5oAKvIP7ipinErIuZYDxhgwN14gU/VpQGl4wqEXxDeculZxZBQe9mXdskFSFwKt/
         YyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249714; x=1768854514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A0PErH3A+TCXfgL5PR8asxXBIGBytLNSMzZeGmnD/jY=;
        b=wMpK0cdtEWcs+6eDqGLfJGxpuzMk0P3hBwJI8y9IEOQ5A3yVPgjnnqd8evdoMIziE5
         joAJpXU4tQFmPDNUxGpl52dy3ACsi9LkAtiMktg/0v/yrYEix9WjQ/kzauGD0EpEh1II
         7Vd8YThs7BnYr/J1+rEvbgml5h6EvaC31a4OtRtUONONemLAhRQ7fmFYoec+OZwX9TaG
         gWhDcTLC7b6/3jbKTNulHg/lI2sGpNgvNJinEbScxgMt/OJ/UrMcvb0S10m7Rw6JLg5T
         fWZgLm/SrIavWpZEs1XZFtF3kIPH+7wMR8BegwYmdBcAL97IauPk8uonQXwaJXRq2T8G
         a6dg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ/49Gpo2Exsa6RLg7PGDHgmVr1ZPeTxagbIgU4CH9uG9itSk/5MzlDdfOFxkp+hh6p4ifWKZ7vadrlnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jpV7mhJiA2YSAXBY+KAfbHcpwlVCuGRWTov5wlX4QkK+z94v
	/tw/QCoKoeB8V0g5UgSlsibyBb5RWXuF9mNdR+4Ek7QSCseHeC0fH+1csGLmJA==
X-Gm-Gg: AY/fxX5UtCUN21WHi+HSRNqylZCchIWqbNAKa/6xfQtasB1+fKt1KZB7A+f/R/6wxdm
	/AycQWBpQ0yTEG1gVWSxWNDo4Jf5zMYve8q2jRqXclngXi3Qr3ri8XYKVuoxxoMp9S1PMCnP4Rf
	ANex6SKAs7yjNRNu0zL/GfIjIk9XlsADPcpwPhwbRFjtxULsFiq4aW9+byRAvbxTq4V6zXl2nKY
	Nsorl2MfANk8TOPcGNnelIqZmhUpEoJK0o/CH3V2bJYvFmR5GaA//X90spGomestMXybsTgy0Vh
	i3R8RbrDujN+lxUJnY1UARV1W73tH/86XbphoCiLbvyME8uOaa1PFcE8pdr3Gt6MVUpVPfdzCDk
	FbD98oxxoOb4JjZMjstz2lb+2bPtEicrF6NuR5fWGLdwhAelf+Ks5H3/EPJpwRj8mE7AZBfG6hF
	w1Ns3SfGSKpQYpY01I/+64GJkkF3pvfEUuv+T40BH12hH6W64lvp7MEkgNWkmrwV/nj5l4R/BHB
	NzwiTS8SrOsk0+dn8OX9g==
X-Google-Smtp-Source: AGHT+IGZVQoYbx2iilZrdLG2Ztf307Z50A6C9NTY1Qg4UTlyKWI05nICHsHwet4uo+a7zycAJ/JW+Q==
X-Received: by 2002:a05:6a21:3291:b0:35f:5fc4:d896 with SMTP id adf61e73a8af0-3898f906a35mr17214236637.20.1768243921460;
        Mon, 12 Jan 2026 10:52:01 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:52:01 -0800 (PST)
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
Subject: [PATCH v3 3/6] dt-bindings: input: google,goldfish-events-keypad: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:41 +0000
Message-ID: <20260112185044.1865605-4-visitorckw@gmail.com>
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

Convert the Android Goldfish Events Keypad binding to DT schema format.
Move the file to the input directory to match the subsystem.
Update the example node name to 'keypad' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Use decimal format for interrupts in the example.

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

