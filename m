Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0C322B94
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767118263; cv=none; b=RxHgXVZi2J5DhRPGX0+ZEcw1HVSWBsfjDwzEyEmT/6rKWWPUhORsr2DtrkULrlLyuUqIxFNCb29GG5ZMn1DtohdQwDiLXhvsvg95WPHmK14i2O/OsSNS1oimyZJA1gNoCQXvMOorysCNnaTp2uTfdOtNglLMar9xswK9hFr0Hig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767118263; c=relaxed/simple;
	bh=TPtWoE4C3jRebC+9Hd/fYSLNQqRY65T1NXTeH1DCygs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZDo/ZRHVnRCB7/E77RvUmZ/i+gj0xN0dD1p/jIHdfobTWzLuXfICIVLjb30QA1u8exxll3YWb/Mea22BsUCfSFE+x73AHTnZFdPXUJYjrU+FxsS6RRw+ZUD3XV0vMQ6BxQxg46wDvk7P5qTmU6u4hcl6E3PiQ89Uw42YI1g6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp2ahs32; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp2ahs32"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso11567071a91.2
        for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 10:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767118260; x=1767723060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiqtyI0E+EZ2TXt7IOrDDwvPaZp+SknY+Ea1unU062o=;
        b=gp2ahs32IzCjIw06uLOX9joppinreo8/MHeGq9gZVuKQRB/I+Fj878pzYjDSt3i+ik
         YCqR7uD6CGX1Bfy4tf08jeU+I2ypnyitJ0i4ZH8LK0dpch6MaZEGlDfcQwMMGPFCfH8Y
         lTeJdXxwj1Yj9AICIC+Uptv5n24FzSF6ddlQ9DO48Z40D0BHYwHZSztTnxeqmlVA2g0q
         0Im0LYIXx+32K7MGuICESO/hHYLr48/5kxBZCFdZZoLMEC4Cp9XIo8wT+tRhtQ5ozEp/
         Iu1+Z/rXlu9PVNnauD7QEt9P62uWJFlSZrYH10QrRSA9CRBs+R6feTaTFSL+xUyUf48X
         W/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767118260; x=1767723060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wiqtyI0E+EZ2TXt7IOrDDwvPaZp+SknY+Ea1unU062o=;
        b=HHoJeNgUFjHQIhla20ip0ZZVVhyh+XI6LbynJmRReWS3aQhi+1Fgn4b9oqmvB2Ln33
         mr8ELmtqV19jQY230tEoRNBzZwTh7AgVh4ZtNm8pXH1w40eRVnzqLZg0AUFQoxuOW2Dz
         oa6ypuWHry0V0H7QpuIpo37tbx9um2lmSWvC4I7g8+AqhVBYtVhoHoa5kh2ePplVEcf0
         ijTIT9dlAPPK8x1SYNgvQcxcFiAMYmdICtxFfNfzOnaiBlcJXH62W3Q4/KHaQT0J2nxN
         mUSGPkZHap/7VaQufqDZRNr/Yjbk+Xh3vlU9gydyezI61OUxaan2TtCFLJiHK1gVtthw
         Wz2w==
X-Forwarded-Encrypted: i=1; AJvYcCWvLHXRWuzvD5OZ+4TzxmhRhiOnvyeorLboyVVnNTrlAH6UxL3p4wxmLKFCfZO/3sVO774Ez2byumFp6a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjvK7Ff4ozxVH+bRTcknwcXiCsiGYPccWpKkNJVIZasKcT1Ibe
	VTIPgNET6rDLcAy1Gd9QEAqaQHE/gkkxqAOTeYGppOAas9cFEY5Drmz2
X-Gm-Gg: AY/fxX4Z/27QIeNbyGb+6kGVJb4ZCUeuzXlmxrI8jg6fhHWH+jIRjRThmQkgFDM8gaq
	UpsF+5xLijsjppOyxRX6Hkq8cwxuJnTivJk2DbByCPIOS05tLznEuwgckyhNhIhZaMXOCFL23Xz
	Ojl/MVRY9PL2yfkP5owV+J4Z0FoGhBJsQcZr6wdqMCqn+uDjEsAOiqep582N3+5ML6s6t03uI8O
	dq3M3L1H1Kdpt4ZG4GeaDBX2ddz9Wg2H77oZrtThRKdMld1f9WJVs/mK0yoQLK47sweq3i12Xld
	/S9FnbqHbrRoKrK4+iBF5QMJriwYv93avamU/9oPL8H8bLCaqxeL/fclZKxa4xCrpjyPnBh8eG1
	FEaYievNwEbi3T29pJMPKo7Sc+tm09NUX0T1HkRiaGY6YGauc3OoYcLted7azMJXjIEky7lhErc
	Mr+xJT1+xLofS3zSJQkHvQZOcQeP5o5ds4qo+6n9mowi8k3hQrKq1t96J5EfR5TE0EzCQ+9bi7w
	I8RduJbVsDKVLBd5viyOg==
X-Google-Smtp-Source: AGHT+IFysb5O/IJUVTITdM4KylhE1TplZEdTk/XkUcd/+h52MkW7iQODmWt+Z3OinYOcQ+IJmSy8Wg==
X-Received: by 2002:a17:90b:1f86:b0:340:2a16:94be with SMTP id 98e67ed59e1d1-34e921137c6mr25807297a91.4.1767118259879;
        Tue, 30 Dec 2025 10:10:59 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:10:59 -0800 (PST)
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
Subject: [PATCH 2/6] dt-bindings: misc: google,android-pipe: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:27 +0000
Message-ID: <20251230181031.3191565-3-visitorckw@gmail.com>
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

Convert the Android Goldfish QEMU Pipe binding to DT schema format.
Move the file to the misc directory as it represents a miscellaneous
communication device.
Update the example node name to 'pipe' to comply with generic node
naming standards and fix the mismatch between unit address and reg
property in the original example.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../devicetree/bindings/goldfish/pipe.txt     | 17 ---------
 .../bindings/misc/google,android-pipe.yaml    | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/pipe.txt
 create mode 100644 Documentation/devicetree/bindings/misc/google,android-pipe.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/pipe.txt b/Documentation/devicetree/bindings/goldfish/pipe.txt
deleted file mode 100644
index 5637ce701788..000000000000
--- a/Documentation/devicetree/bindings/goldfish/pipe.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish QEMU Pipe
-
-Android pipe virtual device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,android-pipe" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	android_pipe@a010000 {
-		compatible = "google,android-pipe";
-		reg = <ff018000 0x2000>;
-		interrupts = <0x12>;
-	};
diff --git a/Documentation/devicetree/bindings/misc/google,android-pipe.yaml b/Documentation/devicetree/bindings/misc/google,android-pipe.yaml
new file mode 100644
index 000000000000..12b0cfc815e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/google,android-pipe.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/google,android-pipe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish QEMU Pipe
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android QEMU pipe virtual device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,android-pipe
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
+    pipe@ff018000 {
+        compatible = "google,android-pipe";
+        reg = <0xff018000 0x2000>;
+        interrupts = <0x12>;
+    };
-- 
2.52.0.358.g0dd7633a29-goog

