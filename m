Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A64FDE6D;
	Tue, 13 Oct 2026 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893465; cv=none; b=hy9Ci9jrvs58Ku+BSh9jjYmOm+hpqJqhNY6YQiisP+fMwkUthQtY0GOIp4koE3SzSEla7fDiGNDO7GzH9ZjmZtoTZdzU/mad7Po7Yub8fmGnYxJdXty92T02IujFykkdavN/oG7fQoDSmpyEExkoWFMsEWSaBsIYzf32xQjEOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893465; c=relaxed/simple;
	bh=xmKW265b6860R1wcClFYRHw4xte3scoJd/t7EdfSBew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRGd/iol2MfndGctOvYmlBWnWMViwX+SUr13MNmSDUfapG8RxcY7DVSpbBYqSVFA1/be6sToFmTCvzXmXShAk2KnLTKVGm8q5yG6l10aZj6gDg9Hn3qweyDChFjBLcvIf6G8R06xfYClmHRJIYcnNSinacjt8p+vWkDrTlR9AIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99A41F00893;
	Tue, 13 Oct 2026 12:11:02 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org,
	linux-serial@vger.kernel.org
Cc: Greg Ungerer <gerg@linux-m68k.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
Date: Tue, 13 Oct 2026 22:07:02 +1000
Message-ID: <20261013120831.1046590-5-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013120831.1046590-1-gerg@linux-m68k.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create documentation for a new binding to support the Freescale ColdFire
UART hardware block. This is found on pretty much all variants of the
M68K derived Freescale ColdFire family of System-on-Chip devices.

It is not compatible with any other known UARTs.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 .../bindings/serial/fsl,mcf-uart.yaml         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
new file mode 100644
index 000000000000..d1dba518f67a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/fsl-mcf-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale ColdFire UART
+
+maintainers:
+  - Greg Ungerer <gerg@linux-m68k.org>
+
+allof:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: fsl,mcf-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    uart0: serial@fc060000 {
+        compatible = "fsl,mcf-uart";
+        reg = <0xfc060000 0x80>;
+        interrupts = <90>;
+        clocks = <&coreclk>;
+    };
-- 
2.55.0

