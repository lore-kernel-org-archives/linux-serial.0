Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370318622;
	Wed, 12 Jun 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206754; cv=none; b=FiZCnctm5RmClpzu0TXzpTSO+ctpwiJP2Nt6k30vvxzbsfvn8+peFLRzYIuVexbevGP0mUDT2FAIPct+iK0mF828kXoJdwKgSTgxj76VHxa2o7UtU0gK1pAb0fiIpN8auP2u1FShe6Xg2YyXY9ApRSiux+4f6QKYw4PtQ4l9TdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206754; c=relaxed/simple;
	bh=mz5ddMgSHBrMlN7KEn0jXPYKgE9bo2Re4KtL6Gnkk10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBGrrLrantAb4FtYAQGKhGzlNjYCqFnNBHDah+oginhyrLVhr5pUoaVPOpHWzPjgfm81+1PLSeCWCPPjr5TEiwx37Spe2020IxKpCAWI62lCZIrfRGloc1fSiQduM8nlYcFIzzytxwKE1776LiGbNoD4Kh/AbhTHdqaombKoZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsOpL0R9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsOpL0R9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7041053c0fdso3997764b3a.3;
        Wed, 12 Jun 2024 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718206753; x=1718811553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCn/xAaLJSjrwXEId/Eyiyy2QeSoCVHrnLmnaPWwjhc=;
        b=gsOpL0R9XPeB5HX0lp8OZ5j6Nl7f01/9MzXODdA45JyUQPyM7OR3sxFGf74zcZ5WcH
         xLS3wenlKHbbz7i+qiVi3pGdnogOD/k6cL4HJGHAFvoRZZLJ9V6cfiZ/PCjDKiQIsByC
         cFg2UltkWvyTiPNb6t2V+yGFBriadmk0CNuo5NRePZkVfswA4JwvfsdVW6y2LuOmI/v4
         4U0P945KLyZ3HvFQzzqX/88jeYRHpt4M1kqmCAVGT9LE1egVHndlv+AmjUuHYDWYWbBn
         tp7uM9YUVg2D1+VLEdAsiWT+//5bET0P5NMj6pjhBYU/Inqjdj6JDFV3c2+wZN5SqMRX
         Z5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718206753; x=1718811553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCn/xAaLJSjrwXEId/Eyiyy2QeSoCVHrnLmnaPWwjhc=;
        b=iTw6rTZKbkIfkFyaab5IDnsCPfHdtjj/8XnpiFYIVwhhGNWl5SfaWUsVzd3fjftRYh
         krlAkWg92Sd9plDT0zXvTQvcPuP/0xcMUUYWCavqYMJRqS/6F2ul37tu26W8SI6o9XsJ
         bgcYQbG7VLJzSfM3z5h3/PSaKciumep2BGqD9PXrDb4BPzywozZMj2v5FIl/3CIXQlTz
         U1TKKuZkQAos+zYhkZMJqI7lavWepZWaaV04EHZrCRwKrswBpxCMswlM6IsLlHIaN37t
         IwrB8hB31VOzfGAh8yb6UnYrNju9AMPkL5pXG3PG11iIZidiZaHPy5QFQmd7axHJCOdy
         pQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW09/ZIRBrQyIEH0lTiZDfE/BKF/IZODCoKZw00+UIIvtQl6ZNOyuPsUhePR5RPQhGUL+SBBE+Cl0TbzQ7O+d8IFyyOnqJK3P9tyoaC3rhw2qcQPzojkzMPEdO0GpPYGJtRTuVZQj9BbznAm34hB0fUJ6OKLOMODUVLgZ2dlEbt7p63G7E/ZA==
X-Gm-Message-State: AOJu0YzpLJ50L035DEzJw0jewkINI2/b5r/fGzdqGu5uC9dM8KDNhWIG
	BAYGxNiuu9dV4SSZ62WSFsAfcY4iBrx4mwgLrU7JIw9x396IsCw1
X-Google-Smtp-Source: AGHT+IF2wEvSHE4ImI+hkvi0c4Y7NXyqjd+90xTjAJT6rBbVNEb80wFQiX2er8Zw0Rbxhkky8odDtw==
X-Received: by 2002:a05:6a21:6d95:b0:1b7:175a:6756 with SMTP id adf61e73a8af0-1b8a9c8de91mr2956080637.50.1718206752555;
        Wed, 12 Jun 2024 08:39:12 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1c29:22a5:7130:4b49:9907:6f99])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-704338ca12fsm6726273b3a.173.2024.06.12.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:39:12 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: kanakshilledar111@protonmail.com,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexey Charkov <alchark@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3] dt-bindings: serial: vt8500-uart: convert to json-schema
Date: Wed, 12 Jun 2024 21:08:43 +0530
Message-ID: <20240612153847.52647-2-kanakshilledar@gmail.com>
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

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
Changes in v3:
- Removed Rob and myself from maintainers and added Alexey.
- Fixed commit message which mentioned "greg and jiri as maintainers".
- Elaborated changelog for v2.
Changes in v2:
- Rebased changes
- Changed maintainers to have Rob and remove Greg and Jiri. VT8500 is
orphaned according to the maintainers file.
- Replaced `compatible` property description with comments.
---
 .../bindings/serial/via,vt8500-uart.yaml      | 46 +++++++++++++++++++
 .../bindings/serial/vt8500-uart.txt           | 27 -----------
 2 files changed, 46 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/vt8500-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml b/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
new file mode 100644
index 000000000000..9c6819241a49
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
@@ -0,0 +1,46 @@
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
+  - Alexey Charkov <alchark@gmail.com>
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

