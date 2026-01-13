Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D012EFDBA
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303097; cv=none; b=awZezSnBYUmLXain7Zen62VA+jYrL7ye8rY4KfxZN5Sj7yVkyUZ8uE2UolKAtDhp1Xwf3Lp4gO1p1XARHg8+Pi5HdKG2qY9QIuppk1Rjl3M6JxaSaasp+81N/goNpe7q69Cc+csDpQJlkquGCXKyqBbMc7gk7my/VYrMtrN180w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303097; c=relaxed/simple;
	bh=zdNFAH0iTWr7CYfBHRXif+JE5op8kPFWmv5y6FI3muw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy2DNOus5I1Pi3s+hTCrThe9ZVhAocQTVgutlPdS2EgKVptTLohYlKtz5InzoSQvvSV+yjHpI1nnIzKbUiKAwENHCBwaXE2x/CGAde5eiVIBQO4Lfp3E2Ss0oid4nHuxdmx1Odt+QLNicNFP0sPS9pLlJVx4RpjUWGTVoMjvLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTBm6SFr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTBm6SFr"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81df6a302b1so3566305b3a.2
        for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 03:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768303095; x=1768907895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4hgjP3w88kDagdzWx8wSWq+XQR1e0+zfKSduukvDaU=;
        b=DTBm6SFre5KcTCN4IyhiYKJTi+1+DPZM882ANz+uWp9uDbtgVCp9FRl10YtjZOzxWC
         2M1jvaLfp5oqdqFhbbeFihoJfHR2cn8SrPXFwutmWKisi98tFWI5PF9FK+nORfVnFICH
         5xMLBFDRxXlhZeuNQL2fJIsnMuIHzwa7gV8MpknGYD3o3GPknXRJlB4otiLSgWZ0FbCC
         iFchidMT+bBTYFl4CcmgXdYmed4upaMdrm4NyWGvstmP33hHAnc6uAhDx1NOueRq2rYQ
         RNp2t9am+3mYA1mYQcOLsfLenq2WygK+f4qAo0tMdsLpcYP7UvziYj81YqfO99iueqb2
         i/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303095; x=1768907895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d4hgjP3w88kDagdzWx8wSWq+XQR1e0+zfKSduukvDaU=;
        b=YNGNxfxp8R/+NOxMOyH9OTvgw4+UcAs9RWhBpwyAGXvIHpoDoD/fv7JtZami3KRmpr
         F/K5MFQWotNxv4QHaF15koAAB2PyAck7I0z9FIy9sM/7L1+UwjsiEWZVf9Y/KUjD+35k
         TOtJHMm3OcnH6Y5vytFBW8ezszupcrBndGyuL7VZuxHDkm5ILK2WVPaJNM9J9TmA0tmj
         TJtcMDDMwwY8ZI1zss4PEH/uxG71oJftHnAbOqeP1D6cQfQ7BPpc7sST8ag5KlQiBDpq
         tqxbEJt9zy/JbEW4wWXcchKkSA0iUM5mbQyBbdJQ1VYGkxRFSIaemvMj7IlOw2vq4mBr
         6Llw==
X-Forwarded-Encrypted: i=1; AJvYcCWKE3GMC/g9rpDzTNbBjxT1XopkjePtWnwgNOskBN8ZhM619E2QAhw4lxSQX7egfmttNc57r4qZC+hxJuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1vEDcWiVgoySYyJ9KZSbvIbb7+UqSKpLY4+sgOjaEAFVFrvB
	ls/CSYsJvu0EUsh7IM2eSWtm43Ffu7nZsKnQgLCTdA6KRLZnk6kHm76zVFOQaw==
X-Gm-Gg: AY/fxX5C0ycuZKyCYZsmkcmVSB0M6TOgwqZia7SGJvvhOaBKUCOi0p4Y1V4FhHs8hL4
	LFT4Kj0e09JrkQvWhHQgqts/ADR10iXj8+9knsfcZKwgDUpAZ0Wh9okcYY3B7mgFjCv/oXViA3k
	CHD4503CD9VyePdQ+7t1MLYcXh2TWNAi6vItKSzjBmpLyIMbxPvZoWATwT2Rru0G3ucDqK6p9Hu
	UJ1CJQgUJ2kOuc8knbvFyyDpX9fCddoxsQFWaJyn2vBVZCp7um6JuDrBOnFu6UZfSvDfdLuTUeB
	bI3N0JZDGMOhdKAUpGEhuZkM4UnfjvMX1Pxu08ljlSbPZkiJfsLUQbkCelICQwZy72jA7VA6ynX
	JwGv6Hmc2h5Zws9A3TzyPF44DAH/VovVZdyZCNClLhXPEmOl1q+nlKmvs1mxSeYEBnBvWnkx6Fv
	k9QyAiO4GXFeg9jlgXk5Q1/rMpxtwUv+/5on29XPpOpMDne0ZwPe1daD0QjCs7tF74Thar96aHA
	GpvUpT7ubDnOsc2TGXmTA==
X-Google-Smtp-Source: AGHT+IERyXXRObriIfp3G5vGgqAQ938C3mDCOXYLyt4LrW1z/WW3eq0L+wGB0uC11elqp7ivzib0lQ==
X-Received: by 2002:a17:90b:38c4:b0:340:fb6a:cb4c with SMTP id 98e67ed59e1d1-34f68d231bamr19378825a91.30.1768296384398;
        Tue, 13 Jan 2026 01:26:24 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:24 -0800 (PST)
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
Subject: [PATCH v4 1/6] dt-bindings: serial: google,goldfish-tty: Convert to DT schema
Date: Tue, 13 Jan 2026 09:25:57 +0000
Message-ID: <20260113092602.3197681-2-visitorckw@gmail.com>
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

Convert the Google Goldfish TTY binding to DT schema format.
Move the file to the serial directory to match the subsystem.
Update the example node name to 'serial' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v4:
- Use decimal format for interrupts in the example.

 .../devicetree/bindings/goldfish/tty.txt      | 17 --------
 .../bindings/serial/google,goldfish-tty.yaml  | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/tty.txt
 create mode 100644 Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/tty.txt b/Documentation/devicetree/bindings/goldfish/tty.txt
deleted file mode 100644
index 82648278da77..000000000000
--- a/Documentation/devicetree/bindings/goldfish/tty.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish TTY
-
-Android goldfish tty device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-tty" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_tty@1f004000 {
-		compatible = "google,goldfish-tty";
-		reg = <0x1f004000 0x1000>;
-		interrupts = <0xc>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml b/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
new file mode 100644
index 000000000000..0626ce58740c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/google,goldfish-tty.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Goldfish TTY
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+description:
+  Android goldfish TTY device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-tty
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
+    serial@1f004000 {
+        compatible = "google,goldfish-tty";
+        reg = <0x1f004000 0x1000>;
+        interrupts = <12>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

