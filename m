Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CA26FA57
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124645; cv=none; b=bSJX0oE+uqjrRoh0lx6wKApsd+FidSHsIwOysRDPnKnIZgB0B5fU5NrBNR7IvVhkfm1VKfwVhB+TEVDG13Qo/XpJe3TWlN9twsY0qv7oyKilut23uvK2f8kWTJJyIX+BuJSYbHwkKgB2G2HBEH5FzxIzPVIzgID4s3RDtZcJ9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124645; c=relaxed/simple;
	bh=a9IYvFqlG/UaJElPMyJFzg5gch1C9rdzE80DQMDwPnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX0tlXLpvWaI3zJUprBNMQsq4ZubD8xdg2zK37DC4EsfPCXZKtFlrSKRWLDRKw7lITInzZNecv508biI97779LtWVvBleKLGc+T1CvR/s9PmiQAdmT8a+qoXb7hKX+p7QIkcPDDMA4z9CrtAEMacZM8nry0NXD2feaG19SDFSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nttWpOnL; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nttWpOnL"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f5761e09aso5969690241.1
        for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 11:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767124643; x=1767729443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqq42GMedrB/T6d7mRybr+4FEurk5kHOMzPka2Yicmo=;
        b=nttWpOnL0mQK1H8ZVMwGGXx1dgeSuYnNNHfqZf3X5nOKhT16Q6vM8ABxltfGp/DMyw
         h6MLOaQuMfm6XUcxplMSVu9LBOwqzNKXcuVYnMK8SQ8xEu0A/C4a2JZVBPJMAhboFF/B
         EApIgY4QcJGPXZirEf4/jg5qBqvP7zriDkUajzKFMLGiF9jYml5hiM2/Qjr+tJc+FPp8
         Kl3g2NAX9gfXJm5JIWJqQB2avcO1fQIHKxqz/p1cweLWrjWsSkWdL5C4U/vqiswKXVe9
         shFtetxkCleJxS8Ixgx7OKKk8jk0HrSgU8IZxpd5h81/whT57WhjOwgMBC427ppvj5d3
         LHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767124643; x=1767729443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vqq42GMedrB/T6d7mRybr+4FEurk5kHOMzPka2Yicmo=;
        b=Sn5Nynkl0kNvp1GB3aNMVWkgVQPRLR9sX+f8Dr+G+nEk+IjZEJZqZjZ5uOzt9FcnLM
         I/LMR+zVlKYFBeZB52Bo/HtX2eIGTgBGSGpAe33my30d70tzflP5PB8JJDvznptwJxNc
         aL2iJH+SaK1DTnb7Co0OEEIMSmaZHhNHh/zutdztPVNz9PRV/dptJHit03vwdK9Pfy6l
         i93AVncHt47RQKf46u1OtvV3S95/eer1JEkjLYEnQ0zF7s73nPovzcdoTvJ4e8pSNNVL
         pHnPKF/YTmZyYYHDmYI4PgBG5/HBKx8275ksIJNkRtR9sPF2SvjZXlBLfiQQRoRIL8p7
         hXsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWOq5HmHF+5DZKLfLMbV2mtKfcVLNruPKdcxlkC2ePTlpt1csCUKrsI32HCfgGtQBVU83gDhFrG00mKpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA/mXNx2kUuVi97ksXi9FqQZ4f4qrFwCGLd1AX1PYum8AjvphS
	7VGGnWGkg1GqHnJlYwShQRq6RXTDMqcgVh+bU+cv7JvdI/KUUTzcO8fD
X-Gm-Gg: AY/fxX5mQcJfjXcN8B5JFul05/IzuZfBmqQGwIRphFW8KH6CGnquccF5iDhB+YAIS53
	Gt6Fh+WvQ+Jgz6bGpQKw2dJJ1gFnVeheP7urfmyFiOBnr2Gsa8ZoOcQETYRTv6vetkkIyo7VVwE
	kVcvkHTWdWcocUXEjKzh38kP4RifLKqkjWQ83641S1Jb43en1+9P2DYJ0sDADa90XR6hq+4tjh7
	L+3Xka6eF9VpPrjvSlQzSSzYprHnlOrUtxMba0+4/xembKsQSaIUVTEqLKzLjNSA1OZNYCS27yH
	Pt6fosOigm7oIFOI7R0Y6kt02DYseLqI1/4E0mdm+DWDvKRulJZEb6XHhvgk5bj2Otg0JU3A4iV
	+hu87Xl+bfGMCasL6uj39LoYDtj9CZrdL4sNluK+6gWLcq08Dw7VqnPEA0qe8OhOYLAn9P4FZCC
	2ACo9UPJP0yRgjIvETacUUqnIuDGiRApRHDOZan4zMtHArJPeAs4xQoqmL1DVRx37O0mdIlPRTK
	E0qrZcBWjLqVVVUOoCnXw==
X-Google-Smtp-Source: AGHT+IGG4IvGkIealWBZgvBLq7nxU8BQLyVFrfwWxsNjASkIojjiGo3aO9o10cXPbEY9owzzFvEfpg==
X-Received: by 2002:a17:902:e748:b0:295:738f:73fe with SMTP id d9443c01a7336-2a2f2732287mr344445935ad.30.1767118253801;
        Tue, 30 Dec 2025 10:10:53 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:10:53 -0800 (PST)
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
Subject: [PATCH 1/6] dt-bindings: serial: google,goldfish-tty: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:26 +0000
Message-ID: <20251230181031.3191565-2-visitorckw@gmail.com>
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

Convert the Google Goldfish TTY binding to DT schema format.
Move the file to the serial directory to match the subsystem.
Update the example node name to 'serial' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../devicetree/bindings/goldfish/tty.txt      | 17 ---------
 .../bindings/serial/google,goldfish-tty.yaml  | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
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
index 000000000000..08fa12449a01
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
@@ -0,0 +1,38 @@
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
+additionalProperties: false
+
+examples:
+  - |
+    serial@1f004000 {
+        compatible = "google,goldfish-tty";
+        reg = <0x1f004000 0x1000>;
+        interrupts = <0xc>;
+    };
-- 
2.52.0.358.g0dd7633a29-goog

