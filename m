Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CAB399A6A
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859777; cv=none; b=oLCcAK2l1unvI2TvJVFufejMjjl+Z6g3qDWuXWMbkzYzgFkZt8uu8hFyec8amTC5af1M23DiW3+PO1nsSw7RmfN+uzNTbfzVBdNXvtanZogHrrPwYF1SPqo4LyStHcj53MtqO1gbLQeoGjshJwSEh/L0JaRNEH3BZs9H/SzrWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859777; c=relaxed/simple;
	bh=BkuzIM+xJSw6D9gd0ClP6IeKUS3iAxeuX1yHGi4chXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHrEWiwOa6iCgmD/ggXskw7sEJzQIQaVkB43f2Qc7Ds5kghwH/5NRZ2WdLxwIoGG1PO+cd9wodD5bpbCj4VmgzlSSHk7qP29OblelKjOxzF0u4N+O7FIZpmfeY7ji90GxLL2ycMlILfRiwMEwC4DX5xCHbtEltFXjRJBJ+nt8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbMtxix7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbMtxix7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so1979401b3a.2
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 00:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767859767; x=1768464567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM8S9Nf7P6gRpX7oKCBS4znehPOLHvbNE32ZCa5tCAA=;
        b=WbMtxix77iyRiMu/v6TL6S3OE4lOZf0DwNv0JOtIuj0UWdibRbv7EvHx/rC4SrGzEI
         j8FIUcuUbWNqf3OHvvwnjp16n/ZVsN3Zqqo2u/sPVCPcDY7KRQCIPkCfqBx+MSCgeNrj
         FhglvRwKieoa43KClvFE1X8AXiHAqWN1u2qcBtrQyxADPdHHAp5J7G0PeJ+VGcmzc16H
         Qr6mlPaoK+3KHnALV+6lbtMfVlf8sNcOAUz9K0VWPh1zGndJCuKoGfn46pYcTUej8gWW
         wn3jYiiY6+sQPI/3ufuLrH77ZZvcplgWmNlX601WCLYmsP8NVyDteo8AjjAUd5uAhraR
         OnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767859767; x=1768464567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cM8S9Nf7P6gRpX7oKCBS4znehPOLHvbNE32ZCa5tCAA=;
        b=TRBiV3Tt8cGSYvmVnOwTGvtkdttsQSdgS186PdG5Lx25YYH6nXeQo/59xCeqwBXXk3
         HESKaCFWb28+SGiJ7Aw9EB/39pCy/0x7PSDtapZdU//ehiay6YGScK0Nmt/HNoArZ1Mc
         7qjIS+0q29MB7qoj4IG35r0fpTX7up3RMN8LZ+s7eBEGMirOWFnFM1mu+B1PKaWflB32
         Hrsv0pjl1dXVZFlj8F2sO4ujQwjc/mk4autvI32vvFeebg8mbL3QkGWkYFe6mT5Tv0Tl
         lHrH6uQffXJQJB7gVscOR1Ts+nMCXckNzNhAaTI/oDwm6LzlmnQ7eM6/Em6YzzVcLmiV
         ivNw==
X-Forwarded-Encrypted: i=1; AJvYcCWIIWEOWtYlzh1dpddX79HjWH3/UJiajHd6Q1WLGMRbgtKDDccNrb3AfJj4qRxqB5dsEdYDyjrOnw5Pdpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRoi9Fo8Sul9ukkrRaDx4YuDJrdJZ7a5sPmGE6lH6EoR8Ib67
	uq2w3TrS7BY9ZWiFF6ZhjiPjXvEfcO0huXNFmn5GggdbvJXMwKPZMa9z
X-Gm-Gg: AY/fxX7MbSCAwI0+0L4kksOipSZqi1o/jQAf67aoIZVE6/u5hRe9SiKGQ0v07clXtRD
	JD/BcMzPAS7WQAm+zTStgZiKE1ea1gt4WF8s+ciJTCdALyrPChzVH+m5qmX10HkKyZI1L+aZofK
	Aog9mysZP3GB0ejhcrmfXtDM+6ytFfDnqa8h5IF7GnRQ2L1aVsOu9a/pmJxkK4RbgINKComnmMF
	MKDcKL8pb56IdUGSJCrvhqjzZCg1lflU2EMRaG6ORAPIiLLA0H/nJfL5OZglzQdOYdPRX/C5zrS
	kxT5VyNl7sse19c6XhWWHThW12gv9M2Su4+/JNrCwbByZ7l39j1hAmRw7KcJKGdzb66Ny4JOYg4
	py0tHiIiev1pLdpA0PF67Pp5Tzr+/tnyM4xiIi8VcspzrbXHO7H7x2kPMwRNN4qfXul4Qxl09Zq
	6UTVrmbdOF43CHRWDT67V+diSxj6Tla2hjDXrevfEGkrtkE++VXlYCdNwtZ0dy5CP6v54Ne3aH/
	tiz0zANN0QcYCuVzD278668miFy0I6j
X-Google-Smtp-Source: AGHT+IHkLLcdy5t5w8lcYwpa7aN5PM2YSQikFaFZHwIq35VG+97ooL0I8Sxc+NQu2jzK08rf+aGvdA==
X-Received: by 2002:a05:6a00:1f09:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-81b806c7544mr4661904b3a.32.1767859766947;
        Thu, 08 Jan 2026 00:09:26 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:26 -0800 (PST)
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
Subject: [PATCH v2 4/6] dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:34 +0000
Message-ID: <20260108080836.3777829-5-visitorckw@gmail.com>
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

Convert the Android Goldfish Battery binding to DT schema format.
Move the file to the power/supply directory to match the subsystem.
Update the example node name to 'battery' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Add reference to power-supply.yaml schema.
- Change additionalProperties to unevaluatedProperties: false.

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
index 000000000000..909252d91c16
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
+        interrupts = <0x3>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

