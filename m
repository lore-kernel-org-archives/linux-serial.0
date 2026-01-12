Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7C2F25F9
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250979; cv=none; b=DL+lvjWEPlC6GKtJmvDtexYah8h32mSY9o8AU9AHlmmOZ7u1jwXTtiJ0WkbslQB2yjW1m8CPSdBZenf1FQzWaQfGQfMqpat8p8SZ5PMhlEE5lfecHP0dFrBIiu898halxbUwoUlglXXJIp/EXccD2b9mv5hwyL9WOD/YoNeJcj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250979; c=relaxed/simple;
	bh=GTLyrTF/q6Eyc9fZ3Fa8bSl/4UWeB/Vses9dYwQVfyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPVCwOdKx48VEY/N8R7Ws3G6xXVOWkVodXM5Xi2ZzYQLks0wxDO6XY2figInoKTkT3HoHZoEWySkaPtxu89tSiHM9fK4I6lxRcr0glub5I+R/5JqUIvaQOmicBMpdLzgMsk0gAVl0V2m1DiJJqsZoyfZrwe5dpAg0A3urHxne3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjqHFodM; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjqHFodM"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3fa11ba9ed5so4847474fac.0
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 12:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768250977; x=1768855777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL3a/4UaA+a8Zff5y8gdtJeilEUr13wkA6OARJeIofo=;
        b=QjqHFodMyYV3hTpn0X0JF31e6NnD23KGjs0xdN0OJlrvcWJjWRilO/2BR3kjIUxDaU
         lP9c1V7PH1GQDmTZZoOlMgl524QrFWyRHIOQ2+36CRtpkxb28HlNbCWO5gU41+q6rDtz
         hD/RukQtzfUN1KOSc+Mr5bTtgc8zRALfiUqkoEjf5qdpBTl6nQneTChWFnUlUSRVwRpk
         2WLKToYTMDohDS+waIT/ZjAX7/7ZDeMm0vImQiHPzs/AvTQmMZScVfBi7zGF27sfwcHf
         2rBLBf72A30v98XI3ObQWBD2023vqxf4Uh2ReolfqUTbmHQMcC56P7Rqk1AgYa/k3ozL
         g+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250977; x=1768855777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oL3a/4UaA+a8Zff5y8gdtJeilEUr13wkA6OARJeIofo=;
        b=KUf/H5JaK34H3oFdS0NGFLN4Dx2teUQWrlx51JJruhGizjBvIk50I4Ouac8BMe7fcJ
         oYjzdPGXI+LZoj/fwGOrSl3BmlJWsFKaZdlP+ZWaJweZHrj4eVWaxEFarvBSjo86CcBi
         Pv4aoXfoNeD8nUlkdL5sW4RALwyaqc0J8qW/fh0x3nlX9EJME2JVhyHfSOSRGgTtn24p
         8IPKGw878z0LzG/ahnt+aa7Y18uybLXHSCsvyHkX9OyzY8cXpDoYgh9erLadZv2Z6tfu
         JfPFRYNnlrhr/Pgsfbx55zXnWzgAA40nN+Vr7rL6ra508nSC+ENgUHt1+gRRo/WPjzLG
         yyjw==
X-Forwarded-Encrypted: i=1; AJvYcCWpG5SYj+J3jw87QaYC7V5SjNPl9/3eOgAl6QeJPWN0LVyhl9vsp8dWjdK93rcRKytorDXFHHF21AQk3ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+aqj4HsxkTStOzDnZmJPFIEbnsJMoFWPMfud1bUMhHZzpLJ8
	Gq5CP7O22zMTAsDty++/qQ6Qu2mdoH5kPhbrkZdiDyeZmmi/R3O0QKC1lKOCiQ==
X-Gm-Gg: AY/fxX4uFQ0xGvWGAgHjtX6esw8v+bzRy0PrvT+ST3GID6KULmc/dV2dur9fMktF9xr
	cHurAZna8GcF2g0MKsXvWc4v5IHgNEejzCIx1vilV4ZrvqRbCaAQudIT2QVzChLKUoPe8uQOeix
	Auv8MpfFkOZCgUT2WDVedr4SQNIt9iwZ8qBXkwRtD0+Sx0O867FrisJSUdfWk4n/s9lccfMumql
	5aUGxPWsk+z40ZiqOAu/lECscgFCPNRed8VYfYBD/BYULAb5oPllocx85Nuz9T8A0B++OKHRUcj
	3G3P01RYVAd2mWm02qA0lvXFAVxfRcFhLmtSJbrZ3tWQlaGUjDJArS7Hqw+FrlfWJHOYTzQ27Og
	k1rYMNBmdgUVc5ZRrH7eC+c36k/vAw3VwaWTUluZoubptPuoJ5ZK34bL41Ui6uG2lTidWHRuRg5
	BudI09bxmSgynjtOjpixMk8+TLC21ZnLJi7GkzX+uyzzDE/wfxIX0M0X8rzNKkJIadPciJNrWxu
	9nOXUpMqmrDBhFesK7ErQ==
X-Google-Smtp-Source: AGHT+IFAodgf1HCpii8yqntRagZFeymJlZlYuy8XB+cGQHdG7vRM/mtdZt981BYzjdhg5eNahHLaYQ==
X-Received: by 2002:a05:6a21:6d8c:b0:35f:6e12:1862 with SMTP id adf61e73a8af0-3898f94c400mr17035763637.19.1768243912001;
        Mon, 12 Jan 2026 10:51:52 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:51:51 -0800 (PST)
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
Subject: [PATCH v3 1/6] dt-bindings: serial: google,goldfish-tty: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:39 +0000
Message-ID: <20260112185044.1865605-2-visitorckw@gmail.com>
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

Convert the Google Goldfish TTY binding to DT schema format.
Move the file to the serial directory to match the subsystem.
Update the example node name to 'serial' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v3:
- None.

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

