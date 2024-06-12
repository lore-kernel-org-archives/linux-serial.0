Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8617DE0F;
	Wed, 12 Jun 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202601; cv=none; b=nYJpFDTluSU70YTBmn5dTL22DbjZXglmvejVS6OuhtA7+YpQW89aRvKHbFCtx7AAu5XruG5jaoyCYOhYq3htdNJPyjuUQMl6zjFh3oa4fASrSPylOSJuZGQKk6wU7K17C0RjKbnSnyBZsF91nVVVMX3eG07a3TtHrfiLcYQGrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202601; c=relaxed/simple;
	bh=H+ew+u/dB7Kx3Fw8NBEn1vS4GH1kfq8mbPSxHE5xOsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/tMnLApAqWE0RfjRnJXC2SbsAOamzW2Au6x8ZGna5i3KCBcjvPqynyEDQHy81TKIrECzhgRjqefKCvkxAXnpI14Qj9bB6x+U3l+eAXAI1jh8IKckOaF4om7Ik6boUb2ZF8Gc4CJ9VflpgvDrP17O9zjyz/funh/2W0yMOzbfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw8AYd9c; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw8AYd9c"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f7028196f2so29147305ad.2;
        Wed, 12 Jun 2024 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718202599; x=1718807399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ekb5/oQl3Ab1gkHrfS5Ggmy6kBO6TAnXhkcaRjBbj4=;
        b=Zw8AYd9cOOh9qQ7QC0r6W5Ta3ll3e1FR63LXAF87b7DgqOkwdIZXOqSeAYDMvWV2Jg
         pBHBa1PikwGEtdIMH/7x9NKUHFrBeFeQA3izJ5d5sgalCL8k7UdvdHuC4xv+ZgutfD2p
         K+dPT3d7PwiHe/RORwJ729bOKPZNp0wCGIWojDrmsOmkJ/qUiBLwU3QIIUuiC3FV3Qw3
         N6VEOpfP033gJu49aOA4xpx0bnstNZc2IaTCfRVqqHqpAc9Ibhqe7WIMhm7Ten2FABwq
         iDupsQad2/7aSxQAZfa7O9IoVCan8vgxVAfac5jFElDYfju1/mCp25LB9kbQQDxZ0xaF
         oVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718202599; x=1718807399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ekb5/oQl3Ab1gkHrfS5Ggmy6kBO6TAnXhkcaRjBbj4=;
        b=Yc6ydWRVFAezXAYDjSrvOAxYjmN8IsJgj3kaBYFacWZaEJWxzCoba/w+1/dtDO/3M9
         kypLOIbNxBXWpkEJGOLwR5WoqDh++z/c9rzeiNZ4XA7RO2jC039sxAyJ+FI5AxNd59PY
         +RBmfCZWn6Ejl3fqFv++1E65Zy8h3ei8oB0J9Gz4DlEaB9tjPCql4gBFk0BdbzTsDWRQ
         wV4nQHlHmG13CFtE3C14Fo4HW6PA19sfeFcjwSqS3h49meNx4TW3qHi/lpSur5zw8u6m
         SLKvxjkD0bf7fqxESFD63gfypGwMwePcHHnQ5P11U7j/WBlyrHqFJT0vghSauJoKEzAT
         OZqA==
X-Forwarded-Encrypted: i=1; AJvYcCWMQiIhwayYxToO2XKpejVc/7xXiCz9deD333DjKO2YgLavZpANY0BftP1/Y2pyTJmB1MHwFeFDjzIACPscfKBP5pUQ+5E6Ky8DF1w9v2jEB6TrPdo5Sa1nLep0xMqmCAxPt8+LIwfWZ3APEXkArETeQArKPbVZEY1BfLn5Trri+erHmxPU4g==
X-Gm-Message-State: AOJu0YwSk0rfzgX/a3WPBTepKx4FkL9Nesyp53k2e/GkPsb7x+uTTwH3
	eP5G+Alm97jpNtyH80Z8XIfN3HfvmWSzTUw/pj0iav+IClQrfVfR
X-Google-Smtp-Source: AGHT+IGFsO2i9lFjUGahQzb301ylC7d2HFLMLcSGx/BMvp521Gppx/mUmV/nsp8erw2DazBrW/NQ6w==
X-Received: by 2002:a17:902:c105:b0:1f6:f5bc:51c5 with SMTP id d9443c01a7336-1f83b7a16c5mr17432425ad.47.1718202599377;
        Wed, 12 Jun 2024 07:29:59 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1c29:22a5:7130:4b49:9907:6f99])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6f298102bsm84937165ad.73.2024.06.12.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:29:58 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: serial: vt8500-uart: convert to json-schema
Date: Wed, 12 Jun 2024 19:59:45 +0530
Message-ID: <20240612142951.37259-1-kanakshilledar@gmail.com>
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
Changes in v2:
- Rebased changes
- Changed maintainers to have Rob. VT8500 is orphaned according
to the maintainers file.
- Replaced `compatible` property description with comments.
---
 .../bindings/serial/via,vt8500-uart.yaml      | 47 +++++++++++++++++++
 .../bindings/serial/vt8500-uart.txt           | 27 -----------
 2 files changed, 47 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/vt8500-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml b/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
new file mode 100644
index 000000000000..a81bdfaec2e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
@@ -0,0 +1,47 @@
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
+  - Rob Herring <robh@kernel.org>
+  - Kanak Shilledar <kanakshilledar111@protonmail.com>
+
+allOf:
+  - $ref: serial.yaml
+
+properties:
+  compatible:
+    enum:
+      - via,vt8500-uart # up to WM8850/WM8950
+      - wm,wm8880-uart  # for WM8880 and later
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

