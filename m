Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE623D294
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250878; cv=none; b=L83zdiPli0w4bZaCmG6IA+JHR+Yr+LYmY54kqLQaaFGhe+vAyXZ48W2kUXdGWddvoKu9Ze+SIo9S9Eyw56t0RDlpsDezRpTs0tnXsGt5RcFoEBIvLmDRhOylR14gv5EFar4Wzes7ffwkPLllcLE4jGWPQHnfuBinAV+XKmHQpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250878; c=relaxed/simple;
	bh=FJzcSHDXluO4dUb76g2nKqIIglQO2UJtt5G2NIwIGRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krojOG84ecWKu/Jk/1BqFiLqH/OMmIAzUJhTAshURHr6vlXdjuy+Pe/EusSWgDu8irtRlbRrdclSKuUbwES2LUuhV4u/X0HNnkXnYxDa9zNtylW11a5rZPj4vZIGpJ+P3hjkvKSr+Wc+0M9U/rfSALQi3Dvh3QvxXG8I7+/Tw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF7sHc/S; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF7sHc/S"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65cf597a717so2888583eaf.2
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 12:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768250876; x=1768855676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcdvqbOz52LfBLxCMSffSYUjax3JQUZoLUuen8kKWUc=;
        b=aF7sHc/SbtR1c8Weron9ESYZVBmtS8UMe8z3HUCVBUPmMrNY4eTx5MHjYgjkwlCoKw
         cH1BEYm62UGM7BidO9FxAl9GsTiIOtZqw0ElC+mBuCrrhLvXDUZDpS14VkleTOPLtJL+
         8MRD96KxH3Kb97PaCbLEEHSJOzUjmwR2xaRU9p5jr0eIqhKF/Olkewemqyg9VrjBYor+
         cp3QC+KjKvthIRSaeSaH17O/u9IuHJaEfjIzVUsWf71GZNUiGQUpAWN1b+KMjtKB1ny9
         QiOacLAE7EpKOy7US9HIIYpyB5W2HSOX6T8azx1HMrDNLL1Hlpd3e3CLMxxZIY6ktTos
         JIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250876; x=1768855676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcdvqbOz52LfBLxCMSffSYUjax3JQUZoLUuen8kKWUc=;
        b=RGHgfSWztCJ1bxOvi56dfzInErAcEVR28gswReewMb5kb9O4TQzOq5B/7LEqmxZikY
         IPumWo4lRnYuFTSX0Vkuvh33sTmwZDVN1S4zxCefIWFv8umaEaJWxrm17wJNlZkO/8PO
         ZtaWrD60B7Dav0uOeeuiy8HsAtrlFUUhCnedL5jOX6yY0CjxZpoAFRsavgDN08tdERka
         sG0cwVKPbrSafrEa6Jw/Wqq/HhxHSc355pNchD46rY7X1OWV4uOWxAyPDyGLgMjtvxFw
         opAbSYE93zJMGXehWwPxDeaAzMJ6I+R3VYC+dE6LYJV+graybDWX0R5Os202syS8gALJ
         zXiA==
X-Forwarded-Encrypted: i=1; AJvYcCX7oPs5nXLCvBLxOYpDyQ15d2OQFkqFhCIWY7w4HTXHc7CrZtKfM2CJ11/3z/LP8xiatpRVp4Ff9oEiE64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDecP2LMR1U1S/Rfd6lqzI1e6CE+oz1Jj3XLXD4ptYlNxMn6gq
	xSTBxXhojqhLlU2QPzhDqUw3TCWrvZTMxa7f0KaAEjC9K2uGxdRq8IY+
X-Gm-Gg: AY/fxX4+vhB6ZuvZvVFHLD0dr4q3l+T7YIfkqJ+VI9PvFOT74wwbN63ljCyoqnIsEMd
	PfpCMHYYM1pRdT6K1L1yWaAh57ATY/RGlM4oo6JyCmR6nbpaT7g5OJootTmMlwynA71EV4bW5O4
	Ki3H7Nk02wUYej/062B6EMyTsYyTWaU/qefWnsZaRiO9orf7hsJ9R3UIUI7IxvvpoQUh1xYtTmw
	dDOSRAIsc86E7/VEnY/mms63F0wZD70RTwJloD2+WMRXuWaMRQ/+eWmxrB/mhJfz5qsA6KFc9Bd
	xE8T0etrZxue4cmTUfmq2xNHbqjYh2SOSqxKXoMYsnFu3m3EaoQffPaVLftd3d5PQ3mTLEkU0Y4
	Pkl+od+f9kxH/iAKdCv8seG8kUp2Avadh5ExtX6wPYVZG7KLAjDG0zp+kxF0UcizTz9tVQvYRvk
	CWAVaBGI6TQnZrFryL8xFKN+TtMu6K4I+IvY8/ac2/tAoJTgqMfsFL6svkDvumENLWUfGSBjrfL
	GEqx+0k67aaA4o38fkwKjAcj7XM4CGF
X-Google-Smtp-Source: AGHT+IFk1Dr6wslFyNgQa2xGPUDljm9kHZ7BOgUopSMDiNk3ke91/OiF9CCfER+TuAOFwDhwgffkQA==
X-Received: by 2002:a05:6a20:9389:b0:364:13ca:3702 with SMTP id adf61e73a8af0-3898f987e4dmr16296668637.42.1768243926226;
        Mon, 12 Jan 2026 10:52:06 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:52:05 -0800 (PST)
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
Subject: [PATCH v3 4/6] dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:42 +0000
Message-ID: <20260112185044.1865605-5-visitorckw@gmail.com>
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

Convert the Android Goldfish Battery binding to DT schema format.
Move the file to the power/supply directory to match the subsystem.
Update the example node name to 'battery' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Use decimal format for interrupts in the example.

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

