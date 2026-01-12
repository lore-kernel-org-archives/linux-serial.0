Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4F334C1F
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249791; cv=none; b=asJzGtT+qcrJgx7Tm95BLFNbt1L3AUDlI3C2zSa6fIVV1T6P32IGoJmKEDZUzy8rICkT00okKmZyCPjnhjXaxBng7HlZPa2LuI4S8iweCoWuFL1KdtxzheYKVUHGpFYprBcZSIGEgr8munU79xYDX4tofYCR3JFuDy3ftGwqBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249791; c=relaxed/simple;
	bh=ymB4O87Tj8cdyAQ2Mbv88kf7il5FRPCeihIKxEZnuSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjB7oWNO+SasXp6wVhymkdwgli6NL66YG2JLjVPsHun62S4jPWdWJvO/I+Dobc+HTAmds06KdE0WQHH0wIc4o4VAmpQpBfJBy9pJvmSMbavZkp1YtmdhdJyQIjrCh1UICI1XY1L+GM4NIUTtbOjIo23DdPZFlmelZW+C4D3IQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOOT6JAS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOOT6JAS"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2a4b6876fso1046901285a.3
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 12:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768249789; x=1768854589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IpW9E256hAdb5Kp0Yw/WkAtwWAPi3uXbVhccnFIi6E=;
        b=YOOT6JASYxEnzLjD9z3rldgwhShTg0tj5Mo3daH7WBC8xPWDOFj4ohhpFl+u2netiX
         V3CMONtcExEmB0dCIor8YvYJkOlIAZuPGgCfZvCkl3DwxodYYqjpqqRiB6GdH5yJ1s5O
         Pn6iUfCgNAYkDaVWohvaPbiLYeecU3RJYrYa3F5cvZvrU2jow6yo5shhrTP+RoXux1uM
         EOEkPi7WlJt1t9oHXQRJSV6tjd4kYgdxlbsKxmr69tFb2kSZK+uhcCvEdEwILhn8DZKc
         gICqTtkdkY1h5HNdW7Gfh9s8Lo7dmOXei9Iki5sZiCeOLyQ6qtK9DFHIkVoh8x06I1fm
         rqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249789; x=1768854589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9IpW9E256hAdb5Kp0Yw/WkAtwWAPi3uXbVhccnFIi6E=;
        b=bTP48X50kMme27iBpilcW5VsqeGGlFCCS0xmmBeoWi53FnYxboassgwqiiw/uILJr1
         j8CWJN3aGA5Mp5QExWtAxubid0gO4oo8JGz/hTwtNgnYmE05v41X7+zLUdGv+At7TIj6
         enn7YaNMwvr2BxK2IBwQMfegW6xsPoEv6MNWY460XDhCrjR2fXdsDKTmHnKZuLYkbpLr
         /CHMaMF0A3fAieKSC1mlSN3Btyt52Uhb40+WH4wYwQpNmME42SGHGmd6WckacnN9HW+g
         M5mHAY7G0GXtO1NSFNfbSUlhY+iX9A0fxnMPZ+ZOkY77odAaO02T2aVD4nMVn//zE6tx
         /LZA==
X-Forwarded-Encrypted: i=1; AJvYcCUWc6uKOCT0H4uDopRLYeFsZ3aewW3yQ2qV+a7fQkI/rMJUv/TgYh9Er0K/eZyugC8DZc/yySZ2Ha+P+jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBV+9EDSAOSA6FTP09UJzRfL3Bf6l0qamncf2kyLw2DRJ1fH84
	4O/scijYBUpC4zKFOqqj1eh5njfZ/wE9KFA5Rjkfz6BkTeBPwo+FvvTsLn+flw==
X-Gm-Gg: AY/fxX794h4erqY2ixe56Xc4EWOp6vQFJ9CNDm7vjE1FM54FZV9LoEuat6gDWAUCp56
	WIo1RkYQYlrlDfFDjtaw7dEYq6p2rv/YUOxTQMmcfoKzOzHgFj7jlIMRrlHAzE8Z90Ts7eOMa90
	T5zTMOOqR2F/lymyYM1aRKBq1GHkysiXlUFJk3VSrDR71lCJjktg6Zfi874iIxNm2J1IisDSVIJ
	qvQ/PFx0ihuexP//J3aaw1fIZJcQWJqnrtTOxCMqr3v0fssIWmAMZbH8tmORZn/apP8rd57FCzM
	a6Pe68jIslMz+URIB4l9bayiBqJcJk5UrZePS8Xyd88/JeNFcYAZt/u6OHjSqHRTD0qYokY7PSt
	3Yoq7QajrRX5ayvn+FOKoHgGE/7oIulJFQG8usdepl4YwUFAhVaqjW7Dj04ar9ZT0n46LrJdICp
	DVIMPHAUmh9PaAc3NmAR6P+BR+r6UHuJe6slZReeMsmjrUGMgNWOqAsbkrH10eSOOl7rsllp7Qp
	GyJ13AdfiQ7FgszlcA2Eg==
X-Google-Smtp-Source: AGHT+IE0iF957v0dhX+oh2JuRctvQjKaodi99ci7bX97j30HxAiXsxhGrr+rNQNYdsy9DMkXs0FDHQ==
X-Received: by 2002:a05:6a20:4322:b0:366:19fd:dbe4 with SMTP id adf61e73a8af0-3898f88eb3emr18090615637.4.1768243916723;
        Mon, 12 Jan 2026 10:51:56 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:51:56 -0800 (PST)
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
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 2/6] dt-bindings: misc: google,android-pipe: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:40 +0000
Message-ID: <20260112185044.1865605-3-visitorckw@gmail.com>
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

Convert the Android Goldfish QEMU Pipe binding to DT schema format.
Move the file to the misc directory as it represents a miscellaneous
communication device.
Update the example node name to 'pipe' to comply with generic node
naming standards and fix the mismatch between unit address and reg
property in the original example.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v3:
- None.

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
2.52.0.457.g6b5491de43-goog

