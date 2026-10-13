Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E947F3AF;
	Tue, 13 Oct 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863166; cv=none; b=icTujpgVLwZHP5+tYO6+uiPgQfIb00pavd1zIthQ1KeKtLP6dS+9rbJkOnp7gqLKEoDblCj7iZvRgbSDaAuPitojlQGqVMy7+7zwvIKaIJYWzFMpXOXIgulgF0RnpswOypYSk3WswtPgt+6PgLT9DIWUBKwW0AN0OrGcpQ1RY/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863166; c=relaxed/simple;
	bh=8gR7BhNXPoHr5C+6JPztbmGwaJrI/VU6fS5GUB1Vw7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZHO/0gYN0+fzbFsHHsngDwU6fuhDeJRURpK0A/m5hIbKW0xqWNyGm3aZXpZuakqkKIJtzsZsxV3siQOMaUIrY3kQwJE7XPVsmaV7mCkBFQpcZKrVOh4SOk9m1+Y8nJ4XtuzAM+r8qx+JtFZVLStee+dbfqBVgXUoE4jILTto68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT8TgpPS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT8TgpPS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE136C4DDE9;
	Tue, 13 Oct 2026 03:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791863166;
	bh=8gR7BhNXPoHr5C+6JPztbmGwaJrI/VU6fS5GUB1Vw7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UT8TgpPSKGwNM8yj/rvWbYVxaFED30yBnH52KgvTHDCzB3prK6gdD1tQ6ebhxVRQX
	 bwDf7ixbxFcZjSGt5CbZmGbPJDgbm9rtgJuhnwdUiVHeahKUTFa7+LrAvq98LCT8VS
	 RNqJifoowOh2t0kxFldlWSkQRrWvvwPbKEVb+TYiNhPIlv+d00aFsONOk3+SLz24Pd
	 RaIaInwZtLI9hDB42WirEIHKpY0eYBRxcCneqWqKew9CStcX2Z435MCILV+HE5KXKE
	 Z4efs+qwcLc/jhSqq+5tag5tP5ZaPvcRVNX0mSYMRc0goGXH4r6fW56+08zRTnbYYt
	 XSoGyziKwk+mQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9562CA9ED0;
	Tue, 13 Oct 2026 03:46:05 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 06:46:09 +0300
Subject: [PATCH v5 06/10] dt-bindings: serial: Add Cortina Systems CS7542
 UART
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-v5-6-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
In-Reply-To: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jason Li <jason.li@cortina-access.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791863163; l=1934;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=DBYjTP1f13Z8VgqM2RKT5FXuSk8m/3+wuQ5DQ1oXB5o=;
 b=7L0wt+3xmgjQtTNdPSmKzDxji8tKUaLGD3t0doz7lmcLEdkR+DgmJ7r01GgTmBGcptbi/Xnwy
 2+92vXS+2eUBUmkJaHcY4qyb/D9bT69u4Ve0KR2vcRqHooCRZ/svUxk
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add the binding for the UART found in the Cortina Systems CS75xx
(Goldengate G2) SoCs such as the CS7542.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../bindings/serial/cortina,cs7542-uart.yaml       | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml b/Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
new file mode 100644
index 000000000..2879a7188
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/cortina,cs7542-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina UART
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+description:
+  The UART found in the Cortina Systems CS7542 (Goldengate G2) SoC. It has
+  transmit and receive FIFOs and a 24-bit baud rate divider running from the
+  peripheral (APB) clock. Other SoCs with the same block, the rest of the
+  CS75xx family and the Cortina Access parts, are to be added with their own
+  compatible string and "cortina,cs7542-uart" as the fallback.
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: cortina,cs7542-uart
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@f0070110 {
+        compatible = "cortina,cs7542-uart";
+        reg = <0xf0070110 0x30>;
+        interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&apb_clk>;
+    };

-- 
2.53.0


