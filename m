Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F53D605E
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866931; cv=none; b=JclXKCin0x2cs6tAyaHRmnK+/yp/+zx1Xf4N0RSH7076NtVJ2VUDg/PR7kT27AqMNZNJPPIIzL3+dWqQxK9DjK88qd81OrcdmpsWad8Do0OYDaKUnKS2VHHOBHc5CSJ/JGfxpbGCHwY7jsA1n+yIBOQdMDEFJ0VuLgaW8vPDInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866931; c=relaxed/simple;
	bh=1t0rpAxQeLHUoXH9EqV6OjuM5gq46cEpA0JagdgwR9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERXHKcYW5OU1u95cyclCDQ+j7WwRBu0sz6h5izUWBsbMpAfUyHEQVsvwJ2Tyat/U3S1pnERi+fw8dew0pSFrMzMHaogD2s3O5Xb2Nn0S+NSbqyQmS0C5+QVaLDsmOdbYWjydcJF8NLRiRgM1uNBsLhJsQw0lgKuECwRoqTItGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/YiwKIo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/YiwKIo"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2ea2b9631so340505285a.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866927; x=1768471727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNDmxXp+I2DQQMGpjKHJPmnR6bZXLNX2CabD4SmBa4E=;
        b=Z/YiwKIo58evuPM6BsA2mmZ6l6Xle878X2XnLrlNHNsm4puEvoXO0rrrq0XgP0cRem
         FLhMIWjY2Zan9SA1Gu8lT7Rl0xpoMXVcE8Hi5+M8sg5BNZFHFyGctKDkUHeZ4/Pj7uq0
         eKFLvPXnhN8kGLBL5rK3RyrTv2TqPUMfqVUpoZyXegaqhki/ZZkX7ZoN6FhWUJHVgxDr
         sm7PQakVEK7SPPxOtfU9kD9tX/6hel5GOKElunwO2xnocVDtjEJDGYEb/jFAzNQxvIeG
         2BUMLISAyFO3VVsI9/koEwYGXGLsCWxH2++AD6UvwHamsBT31XQbtEdrQuCLrT6VUKrF
         94xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866927; x=1768471727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNDmxXp+I2DQQMGpjKHJPmnR6bZXLNX2CabD4SmBa4E=;
        b=E6293PWvT19gNLL34QAZqBjWAr2hxy3bTu2YktjQwP5j+YKH0SYlUXKAvNgu5ulkPW
         PykUWehcmkadEtP4Dqw9lVsb4aNrO6rwH8BO/RFDbY5C9bD2vSzOzFFdK3RmBMfpIBkt
         Eq1pVTVvdtzs/+I15yG4R/H4TzgdmoN8bXS+e5dI4SsOalCGZaXhFfRupmq1LaHOIHVQ
         vxkXrH96aMv4QhXgOkmAE2LWH8xlzWuaOowNgXmWsUkF7qDwKIJnDs81yKVVaPydxCzu
         S/Vh7wd3Oa9+NzDmBrMuA5WcBajs8dCC8iY7cKaZPKmvz9iuHHtYQtxP8r4ZeOMlOZPj
         P+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCULHbfwyZubpmzbT3QpZ1xJNmQ6aGsl/e9IjqzP3oyHw0kWt4sax+Vxy5wmFsnuamKX8WnrJtqSGy5nQdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdA2Ka0jonA//+gO9tivisE7H9N9ekLEzZz5BAF+PXEBeaTvb
	VWl6IAEVlL6zLvQBPpvv4wUoC+qLc20GV3F6LXgw3R1Yt929+rYsQDWNM0b+RQ==
X-Gm-Gg: AY/fxX78pHOsCFSd9L1T+oVT+Gpyh5EM3MKe6HKegLbI6YMBsDfb0MbTnlwlR/czgES
	WwTEUO7SojXLTh2pftll/5LRP1MtM9MSwrzwxdftoxsejHGWqGyOdEFpOHLAj0JTOpH6S4JdHN2
	1e/thGwKmFW85t4IFuz6jZzAdZxSDh9YVDK0XlANUcOKA0hts6PDxlPckMUNuK4X7ukaC81khY9
	uQz83kKYgaeumAfVDkmMD3xUXUO+XISBpn4ZTLH36NPfUTwEB4AclpynLr9+URakFtpj5kiB872
	UF5GHU1eOb6SZWVXkFkVjcsd1rez37Xh+RSubG12BQssJtIFiJL0Ru8XUoVoNciZURwtMh5rTpF
	6Cuwd0LnOW96AqoKGQi6fKhY+vk6OkbVipQKEsHbtrdglVttkxZzF8cVWTmxL+hVV8C+lFImOEe
	ZJicNLRYZKWgZEVK8pUy3v7xPhlo3woS8tF31yy4Zgj+FMUsBSZwKKesP0Aw+MxtR9qLrBWPDNi
	O2LK5sZiAI2bAdirTbDlDWwBApiZDqF
X-Google-Smtp-Source: AGHT+IEtkI6q/xm4mTDrq1zwIoRGWeEmLimQWTPdv0cxMzV+X4wwZ1AH39dUZF1XLibUlHDhrrF/7Q==
X-Received: by 2002:a17:90b:1d01:b0:34c:a35d:de1b with SMTP id 98e67ed59e1d1-34f68c48346mr5296424a91.37.1767859752118;
        Thu, 08 Jan 2026 00:09:12 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:11 -0800 (PST)
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
Subject: [PATCH v2 1/6] dt-bindings: serial: google,goldfish-tty: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:31 +0000
Message-ID: <20260108080836.3777829-2-visitorckw@gmail.com>
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

Convert the Google Goldfish TTY binding to DT schema format.
Move the file to the serial directory to match the subsystem.
Update the example node name to 'serial' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Add reference to serial.yaml schema.
- Change additionalProperties to unevaluatedProperties: false.

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
index 000000000000..0b702c8657c2
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
+        interrupts = <0xc>;
+    };
-- 
2.52.0.457.g6b5491de43-goog

