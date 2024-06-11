Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03B481B4;
	Tue, 11 Jun 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107859; cv=none; b=vC2bPhRcGQ4VEj0Pg5kUmejF6vtAdsakva2gB9Up/MhBGwHaRDWP6L265hbPLmxe+Y/9o+Ft9BHo5z9/s1fuxlwn5UVePhxwzQXhdv+2/X67cYersQ4L7g/dsKTnI1romiXKnbhcLPtuTmDdFNOzC2/dpGrw0x5U9eGFvAM0YX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107859; c=relaxed/simple;
	bh=4sJF+qZgkff6mhxsiuML1SPXQa2f0RAQarao62dDJoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngI2Pqf4btVkCquSGezhfqf+4Zsc3RV/fHrmXw9MASIy91+U9I9bWiO/v3N7r0MwyBonygUVEPeLEmy9YhWfDgTegltjSkXnXqBnMoQTONKsxIWY+/ILLfBcT3kH+aNGPA84LsjiwBIFsKWbWBmuufn2BWYqvZKj366UDKXqcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWT8Oc4g; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWT8Oc4g"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-701b0b0be38so5159451b3a.0;
        Tue, 11 Jun 2024 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718107857; x=1718712657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5Ql3E99ts31vP7gjuJD0BPHmyWgl0tnb3i3qEJrOeA=;
        b=iWT8Oc4gXWERTH6W/lDw8u0nMHSeVy701nGNxacukSRd8KwbYUGYeWA+cBjwtk+Rr7
         hn9OjidCCkY4v6bVSrAX38mFiNlWhp+yyJ3CXqyRzdMjFzf4ch3aA0SytBf0iOfyD7N8
         H58B+oqUFJV68NVa2YpHwZq7sP6oTnROvPEny++j4idAmYUW9XEKXQj29gRLgPkOlnU1
         h31E/Krsa6U2WH8CBQNcrYwSZ+RpEr9X3nD4fBWn1OjpzpjJgWlmX3CpntLMvZIFS4EV
         Zjvhkq25rz2BwAO0539jqsQzgVR8xtt8g8tmi1kOs+hk/YsBO1urwCk/VHSj7TPTKyJ0
         cXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107857; x=1718712657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5Ql3E99ts31vP7gjuJD0BPHmyWgl0tnb3i3qEJrOeA=;
        b=GSPcKo4WkNKko1+dvkjXIf6Bd5cBUsifUuJ50ak0muqCfi8mdDELu3GCXW3dVQnPmU
         hpo0FNqgoYAN1oyqSnpmAmmekCTbWPraUE4Xfhkeihmt0+zYMM3oJ1KJJOlPcrPAKcGv
         w5QmVUrXa/FOm5U1Qvz+RtQ58bRgrSzSVrk1mCfSI7YzxU9GOIyvez4aJ6Mjd3lNIAC8
         VveKtSKn0W6+POG5jgANOKROhmhQh+r8Y/2luuCcPliJ6nlEUKqeE+olwcWlWjFXdm1q
         cUE4/W/+iGFbGeZeXBURgczjX/CRFIflhgsd9YIYoi6iXoVUN8lLHJO71MqzzZpTlwXZ
         TUXw==
X-Forwarded-Encrypted: i=1; AJvYcCVqbktOpWe7ueVV3gge2S/wpyB3X0lP6MQN5xqtiZHYpeU/z4R2x98+FJXPu2hQrr99KogrYuTnm2yT8vILG2w53piwM690EZQRi2sQzxIjR+MbpXH1BKLfF7pA1Yv9tYJRl61nWjRj1jCVPVtlai8cQBlmLwG8K4I+z4oEatetJ334qB8SnA==
X-Gm-Message-State: AOJu0YyHAH50RysSbdCLKmqtGsPTAUMI/Pzii5ceQ2oMABziET7BIQE1
	AZMid5bmfzYsNDORF/E7egiK8to6Xr4p2CbJ0mefH3x+v439swref5OTicZJ
X-Google-Smtp-Source: AGHT+IH3JgY4FxwCV8ogCWJcpmZesJGwCMt7JXMZ93/eOIkxKQav/aW2bwneP0DCcrHgK1NtfQQdeQ==
X-Received: by 2002:a05:6a20:3d91:b0:1b2:b104:594 with SMTP id adf61e73a8af0-1b2f9a0cb23mr14517494637.21.1718107857161;
        Tue, 11 Jun 2024 05:10:57 -0700 (PDT)
Received: from ga401ii.. ([223.178.82.151])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70594077c64sm3644955b3a.6.2024.06.11.05.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:10:56 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: vt8500-uart: convert to json-schema
Date: Tue, 11 Jun 2024 17:40:43 +0530
Message-ID: <20240611121048.225887-1-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the VIA VT8500 and WonderMedia WM8xxx UART Controller to
newer DT schema. Created DT schema based on the .txt file which had
`compatible`, `reg`, `interrupts` and `clocks` as required properties.

Additions to the original binding
- changed the file name from vt8500-uart to via,vt8500-uart.yaml
- removed unnecessary alias from the example.
- added Greg and Jiri as maintainers (referred MAINTAINERS file).

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
 .../bindings/serial/via,vt8500-uart.yaml      | 52 +++++++++++++++++++
 .../bindings/serial/vt8500-uart.txt           | 27 ----------
 2 files changed, 52 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/vt8500-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml b/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
new file mode 100644
index 000000000000..b38925ab23a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/via,vt8500-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIA VT8500 and WonderMedia WM8xxx UART Controller
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+  - Jiri Slaby <jirislaby@kernel.org>
+  - Kanak Shilledar <kanakshilledar111@protonmail.com>
+
+allOf:
+  - $ref: serial.yaml
+
+properties:
+  compatible:
+    enum:
+      - via,vt8500-uart
+      - wm,wm8880-uart
+
+    description: |
+      Should be "via,vt8500-uart" (for VIA/WonderMedia chips up to and
+      including WM8850/WM8950), or "wm,wm8880-uart" (for WM8880 and later)
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - interrupts
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@d8200000 {
+        compatible = "via,vt8500-uart";
+        reg = <0xd8200000 0x1040>;
+        interrupts = <32>;
+        clocks = <&clkuart0>;
+    };
diff --git a/Documentation/devicetree/bindings/serial/vt8500-uart.txt b/Documentation/devicetree/bindings/serial/vt8500-uart.txt
deleted file mode 100644
index 2b64e6107fb3..000000000000
--- a/Documentation/devicetree/bindings/serial/vt8500-uart.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* VIA VT8500 and WonderMedia WM8xxx UART Controller
-
-Required properties:
-- compatible: should be "via,vt8500-uart" (for VIA/WonderMedia chips up to and
-	including WM8850/WM8950), or "wm,wm8880-uart" (for WM8880 and later)
-
-- reg: base physical address of the controller and length of memory mapped
-	region.
-
-- interrupts: hardware interrupt number
-
-- clocks: shall be the input parent clock phandle for the clock. This should
-	be the 24Mhz reference clock.
-
-Aliases may be defined to ensure the correct ordering of the uarts.
-
-Example:
-	aliases {
-		serial0 = &uart0;
-	};
-
-	uart0: serial@d8200000 {
-		compatible = "via,vt8500-uart";
-		reg = <0xd8200000 0x1040>;
-		interrupts = <32>;
-		clocks = <&clkuart0>;
-	};
-- 
2.45.2

