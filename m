Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4635965
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124991; cv=none; b=E+7anXdcKJVr8EPzMqQUEwLpLRI64bX5sQToDoBb9GoYhyzrlPjUO3/IxoWBVtGi9WB+e8TFvDgNMACd/HBB6dJYh3i+kXrVAmM8g6yyeGM6cB7iGsrmdQwXSPo86itysSlJS4zzpWfwvldAIa8zROdxopIR7Clj3U4NayZis1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124991; c=relaxed/simple;
	bh=4Uq/LuMFJ/bKwMeSTNcN1XmhonxlOFuHeuhk/6pGReA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVmBSAL6IhJ1Y54Xap43E+btFbL9/9TBTNzIevQrIa0lZjoWZuTzVA8puesZZthuI38XpP76UkLTkJ/8gjACmssZq/cpy0ahpyqbXzkGlGhypiwmHf6Miy5G0VxtLOm/q9MoJRVXgqz7ZzRtZzFAsiJHu9uivL3R2tOM+C1Dr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW7dwjgh; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW7dwjgh"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-459a6261428so3224652b6e.1
        for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 12:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767124988; x=1767729788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ2qeV8/CMzii4Cc7pVXwWXbCg7/CDjibpfP3lPkew8=;
        b=hW7dwjghwO29zLEF+fh/q9PPlfXdYHx/9i3WDaYLHXi8CSV1JdoZ+rrXj+sEYM3bqz
         /2UYWXIBP/pwAnLP3lrpoAO7e0qEDWrk2gzvD8PaPlcVO1B3DqnYUkCne2tLZ0Yifg2g
         xrE7QMeao6pTrJ7AL+MTItFtzY7cptlhf9eZa4FkU+bshsJ08KFXjO7Mz/8+oGh5eu2U
         BDwhBoORBlpr5LqFIhNfyQCLgCRjE+VSHLvQtEUoVR2dYMusF/pk1XglgclV8uBJ6w/Q
         xGf6lFqOxboxxLAcmWcolBvk2H2+y9c58dYxmDpvIZ3dC089dcdBFzf9h/X9SuHS0deo
         B7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767124988; x=1767729788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SQ2qeV8/CMzii4Cc7pVXwWXbCg7/CDjibpfP3lPkew8=;
        b=hLlz4zg2Nq4Oiw9nlaXL2JgfpOHcAyjclCF5ZfRhLgewgxCIUFOlFNZgZRZzZB2cko
         bkEm43qlyyu5x90f/BbI8evseu+hlFaJT+dttU2XBW/QNuDJGV/u0MhZHm+dLtn/zxDk
         +XeQrXLVyH4141BBesEge99L1ouOBXJWmsoFJyiOpi92CzSQd3Zh2PL2qgo+rn7Jv/pu
         kJ71UIx+inTnc9qx6lQCpDJ5iPoTV2iRL8R8waYrVOs7sQ+PnAIArVmggWAz0vnfLAip
         zJIoaPhSafU8OuxZYyF3uJO1mLJv4dtQ7eIkpW7qKM1VSjIHvP+5QVXoFEfjg6a8BpwN
         Zhqg==
X-Forwarded-Encrypted: i=1; AJvYcCWg3W5ZNNEHmI5e3oVRj5+5ln76i4IMgayL58K0U3hNWta5TXKY7W39Pqp+QkyXXPTfO18ZTcSzRngu0WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/jpwCrYELZQgNi5nW4dF+RVVFS+0ixWhFsh8Kakv5xEf9+Uk
	HCTD4iuhzSVfOe0SsMvVrqSleRZoOK8WROnSeMa119qGeFfzEn8RvDYQ
X-Gm-Gg: AY/fxX4Xz4HKJ1ye40mb+h9LQTU/zw7lXFM0WyIKl7h5ey0EMprMPkLflp6uHZoqIO5
	fOpj9pAQ64dCGuRa+rtDk7/V2XCxxZ48FRRlHYQY773RundrY0KOVsdZrT0c1QvfZxxg6tLi0IN
	0Ldst2TMkcXrlvw/Za+BB9LdcPo1c8j9ajnaORWI2clBSFgNLz2cEd4ncy7XNunc3vexiSAfv7H
	UFzWNc9ZMFvGH0agrXr/lIIbuyOg4zVMLsapVNIN/CrOPzlWXo8x9TZHYPVSAKXAckyHLWjyZX4
	tZBduTwScsGMPISnMLqlHtbJInMwQlwtSTr7lWXaenCQmTeS5q7TfT9DVbPzX7DWblqBrfxU0I5
	qmXfZtUuhWSSXmQtmkt7+psK+t66ijesWUnQnTtHuhT5lZ7cINITqpfK8sKCq4EAwPeU1ozo43n
	hjuOx5eMl7Ra7FxLlQpnHvOsjxzUjHy3pQm/ghq3gEaFVXSjF9s5tL/BJ0xtczhZN6EXIdL8ZLx
	xBl1zYy5roUmWv3d+2rFA==
X-Google-Smtp-Source: AGHT+IESyaAQ5T3YAYk5oG3HpiGG3dgsPGYC0NsIxOY31vJ9VG1hZq4KkWvGFlOWl7CULDPAileC8w==
X-Received: by 2002:a17:90b:3843:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-34e90d6a42cmr29651001a91.6.1767118281443;
        Tue, 30 Dec 2025 10:11:21 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:11:21 -0800 (PST)
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
Subject: [PATCH 6/6] dt-bindings: display: google,goldfish-fb: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:31 +0000
Message-ID: <20251230181031.3191565-7-visitorckw@gmail.com>
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
2.52.0.358.g0dd7633a29-goog

