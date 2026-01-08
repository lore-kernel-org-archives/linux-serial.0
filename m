Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604913D3CFE
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866437; cv=none; b=W9UY7GdaJnfWhtW8z7mltSiHfDGc+ZSnn7WIfIByH4ys2oh2FwsYhUtViddRcTpF9FRUJ8NQkSXds/dmJ8Qjt0CfKhPjcEkOyrC1O6XtCSBUszGdg0NLoMPcvc+J0Xx4YnRuc4K4CCqonQN5r5ARx+u45moromivUi7ixvHijW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866437; c=relaxed/simple;
	bh=v6KD22Dyx3+5ck20H0pl2sYgGNxEEsrVPo7bCwCkiBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUu9NQxRmP+fhHRvGqx7PTt+egDWxWbx0sDfvUWTHW/N63SvoTkSRv3mFAfGfc/3CszZ1L++3trNu+6+mJiKPEdj5nWIpcxNruqTpyWwAeZHqZcGDaIQeo4xKxI/s0pYbh5bGMjx1tSEpaFTIzIJcWhcHisUKiT1wbv6f4CBJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChHzA5ry; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChHzA5ry"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-55fe7eb1ad1so2275354e0c.1
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 02:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866432; x=1768471232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHhAP8tHFGp6R15hZZObJ523oYtuLJJxIs+qZwxX3g0=;
        b=ChHzA5ryrQhEYFirv6U6cMaCHT8DHndzos7A2mmcbrS1tO9E3rokU+I2bt3gKCyLB/
         kl0hxnrTZGIdDqwI/mxYbYyjalI0ugo+nr6N9B+ps5GNTLdp3luG9GyqBIPLs9pMFQLg
         7TW1TEVgpgmteKf2E5Z+7AZlJ16vPCjNmpbtNGZISNSRt62yDSh1IBti5Ib75/unZHnF
         qm1YiFiem6PgkAEfN/tn31KkccS3a7P5fdUni6UTltTCeUbemK38h9wQjDlMLMF/ACTs
         wNXRqFTviJpn9bhSOq7cGFD7OaTU574/skObc8szDfkRXyBLeKfzfktxevv1LqSgw28i
         yH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866432; x=1768471232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHhAP8tHFGp6R15hZZObJ523oYtuLJJxIs+qZwxX3g0=;
        b=TrN27T4ZxbTiyM3Jo9SP8MblbDFDCz37RCmTORZqRsVApZKIH8knDVLymbE794FRYx
         0iyHKHkhL+hs6kWwHftObCepsq2RWPYG9Du+kIq/x8illHSFsf96G7nmzAyBctr4f4Mi
         EjmZ6jfg1cTM42jppAVbc/lK4fOkE6rBfK6a+t9j+W5oJIsgxGORhrQrNz2vmVucwkAY
         Bvy2u9GcoFNOM4q7QV0M1lWgJZVk/6b20bOR2bAVKAmIT0pytfGsHQl+c33Q72lMwV4V
         9Ug1FE8QaH+tFehE+XVHAdYh7W6WvpqeAGzylosjdLGsLR9nyaO1VFA8YETzs0OYr2Mz
         3lHA==
X-Forwarded-Encrypted: i=1; AJvYcCWNsKo5wcg3tsdCJYE33STckWk/b8N860tAQc37gsBB6aS7GkXhwgVW3qv2vt+9Tdh8ItA3H8fmu0Vj4IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3323EP5fDeERLHj43RR+0e8On/Zz/xZdl5nOvjKBvIjg1x1t
	xk6Teg8JBVDscjm0AX2jOuh5/T+5345mofOXeRyr2judmeocAmg9y3MuS1KMjA==
X-Gm-Gg: AY/fxX7VBL81+1D5duqXHPVGXkPnRO7pc9IUFEiBbycon9w0Uvic/X1Bh+DyNniBLe/
	2UM+cC6yyHCQKi6yHFVeMkSBU4cRmZAoqB9+FDZjEzssUFPWTeGl2z7kzHFudvO08R7D99RnCM5
	GVNICV6uegs2syj3ck3ifiOgWK/OkpgWChH5Tl8c7lZTm4+2DMTF8ynPcsRNX9Mfa4xKVmHUvw5
	IIu8q0/1yHagiUJD9KskKW7IUZ8wL2wQnaWRyj44lCfF1k9GQsNhFnIUvbLcD/tjX/skYzHPhaS
	1QedDu5ZFPlcVR9+bMb1DuUzaAMp0K+tziPd9+aeghDR4aa0FlAxkn98ED1tM5DNyYFi3IR7kjq
	N1IJQL73657KhEH8izUhVCrDRLMiwmaNsLk9d9NDTZP9pu3KSDxFx/lTB/eBZBqwoYli+6fcmcw
	Zm2WfQpBo7UaTb7NfrJ83jQeemw1S7IldcBaoSheQnrKq6mXpcQjMcrn9RRN+A4VbbJTs8MhrIi
	AVLGj6J/JVyJUzpM0XJnQ==
X-Google-Smtp-Source: AGHT+IExPvCC8KraIjBsVHGHYTjET3yJHc/BTBjFTEdV/VDXcghpuxPJ+uczZtlqCGmQQNa17ulZcQ==
X-Received: by 2002:a05:6a00:288f:b0:81c:9f57:3090 with SMTP id d2e1a72fcca58-81c9f5766a8mr2451909b3a.24.1767859757241;
        Thu, 08 Jan 2026 00:09:17 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:16 -0800 (PST)
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
Subject: [PATCH v2 2/6] dt-bindings: misc: google,android-pipe: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:32 +0000
Message-ID: <20260108080836.3777829-3-visitorckw@gmail.com>
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

Convert the Android Goldfish QEMU Pipe binding to DT schema format.
Move the file to the misc directory as it represents a miscellaneous
communication device.
Update the example node name to 'pipe' to comply with generic node
naming standards and fix the mismatch between unit address and reg
property in the original example.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v2:
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

