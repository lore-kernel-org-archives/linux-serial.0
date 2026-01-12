Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778433067C
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250086; cv=none; b=PfKlMdnn2R/vsYlnU1OoTtBEmwx1Jh1dAlsGIaozX9pBllNd7fgfMBsGXF79X0QBgu6Ht4ypO/LNSV5emBzb8Db9L/6jgAWxoj5uGYyqzhkMDZ8HVqkvfGXRQ/LAEA3EZPAtLfp7BVuEuMi/fquzDYZgOCjVGfausZLla0394ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250086; c=relaxed/simple;
	bh=x1koErt0KZrKg7lQQJMxHMUYCfWzQV0KokubZfs0FJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS3rgEg09pZRvfAGLO0CwSbkuNgJole/T35mOkrRky19wWz+fmzlr83IzAOsvGnrjVIaf4cT5Xo9dcgXOllZWexoWw4+kU655nHcQbMGqB3QAnBMbP5YG2tF/ZmZY8Hbfqu1SbZlbfazXPkD3S8ZBD7pYA4wFyA/BD9K7WB90zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGGQ7f3c; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGGQ7f3c"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4eda26a04bfso82999761cf.2
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 12:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768250084; x=1768854884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnJl4mjA928H7c6+CxPcUynMWnjGzO8z//ft5AvFLSQ=;
        b=TGGQ7f3cjIhgly7dMg0aJMD2QjwguXinp8dYwkuSXZ8taXsCrZWBw0pMRi3ODeff9b
         lipjlisYc6HaPRXdr/Ju6OhHmtBUG06HT/JrG03bVzzcnh3uggxKc0B2FmxxYpKdzZIx
         j9b5TJTxTx/pKeaYNMI+cvwPnsjzQLZoxSpLXHQAa7bP71Q9U3qEcpINV89DtWcApd9M
         7E6wUVn8YvCtHCb2YA8JS+Fed1Q8sRK/RvuSIP0V55XtY6fXR9dAxb5EmYKkhMoP41Of
         SAPx0/zR1CBhip7LN5XqwaiixP7f7rbPSqbx0OtM2b5YDKn3B8LpuzQaM37eIHCFaHOV
         2Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250084; x=1768854884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MnJl4mjA928H7c6+CxPcUynMWnjGzO8z//ft5AvFLSQ=;
        b=Ke5PKjrCBNPFNBd3eoqf54qF6k32e23UH3bXRGF5ymaylGcpUNNFEjmo6Yc/dSPjSR
         z7gzQ+wd2ZTQ34qzgF4uv5WZ5Y/iPLmSmgfsJ7XqKpKBbRT5O4MlsYPVgqDYeZCpltKk
         Dal21rWHk3G9RrbCJ7yg3y6f4m0ehbZpyjrfCHFku3ZrraOBCN0ZIeXNxtCzI04FvSQ1
         kUrmiXULb8Om/ZtPse5ExQ4l3W7oV9+LDFapETPNVb34E7XZzYgHe9RWquEd3BHZDiFd
         wHr6l2NItwt7Qo4AxT5K4xCfU8JQBgA1Lp4aMKwurW78jpuYNBUzLLXgp875vNlfHbd3
         Ti0g==
X-Forwarded-Encrypted: i=1; AJvYcCVbMtOi6L7ajSpQ8B2c4jxie8Xc0xbOQ/nyvTMPNFe/CZTWGhdSfnRaqgf3gvDwxqWYq/dgVEGoneMWvSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJ7BODkaVbakjXe7S+R4QaHSZYcLjLv7UsQyA20LcZt1JW7dS
	pDO21y1lgyHEpB+MnFssDRDQq0NlK9szD1ux8+uUcZsp6JleNFaGcc+6
X-Gm-Gg: AY/fxX4bTka6EfZ5ZrAWZF13tO7BR72iDQ6MkEI6p60iOfuZNlwSW3yuG7W6VehikMb
	klTie3K40CeNVGRS7k3lBbaDxmQiMFcnVHgAWUTH4xM3NSVCfWAlwvjKvcwpwjCq2eAt3JGMdNZ
	ltPG61b1pGePfEHV/E3sFjnIVmobtuUZyD9Nw1h8Q87NRnBT9+edzB2Dp8cpgrtWl3xvaRvsgi2
	Nbyi5mMubBuTjA4uZ7WnscIicY1RIoGX+0LlwPbqOWQsChyc4R40aP5T8bpb2E3Msh3qQTpL1My
	mlvZpKGi4w0TwwaSqZOsdqnLf9eag8QSZ89Wtp3UExpD+QbJsseJzqrguugOr/xYhiVRAQA6bKi
	tJiR3cSeB0ia1jbSiq+vU7evVxfpM8Aur5oq2aeM+7J94JIXKuewHgEUem6/2gvN1gseD67b8IB
	O686KXv3N1qKwcqNZCPlXjcbpUKTZm96Q6bj5mg+3YOykmx6IMNK9bVu/QCsjkrQ/s7nyXmhiXH
	mJWb8SxlkctyWJuXlqrNA==
X-Google-Smtp-Source: AGHT+IFEOJtKiZOekw3QKky7cg+SUdsdDlCfIy6gQ1Y92OIF6fv5PXYBPdHBg9wlGXMZd4H/lsyNmg==
X-Received: by 2002:a05:6a20:3952:b0:366:584c:62fa with SMTP id adf61e73a8af0-3898f9053f9mr18835078637.21.1768243935601;
        Mon, 12 Jan 2026 10:52:15 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:52:15 -0800 (PST)
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
Subject: [PATCH v3 6/6] dt-bindings: display: google,goldfish-fb: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:44 +0000
Message-ID: <20260112185044.1865605-7-visitorckw@gmail.com>
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

Convert the Android Goldfish Framebuffer binding to DT schema format.
Update the example node name to 'display' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Use decimal format for interrupts in the example.

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

