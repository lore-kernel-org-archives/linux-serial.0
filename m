Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519FD45DF6E;
	Tue, 18 Aug 2026 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049134; cv=none; b=GeAXdINSu4e8wxjFCTw6/wBvtMwJWfrcEYfTAqGAuFMm3nFIEHVEuLrZeCdwpWrUWbj0nYsrPpqGXd6RCffSjF9fhhyo+WzFl6sIN5NhyL1SiyB2+BdIfYgbOJ/W2UMMJj023T2Chsw6aFFKogZl4GqQdkCgphcKbgbiM9+531E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049134; c=relaxed/simple;
	bh=XE7Jze2pWOY+XLVEZ5GthHvKEoJMO8iLYBrsfeT5fUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFP0LyWoMdzZxrSCe9wdufi4riypdaitEPDkp06pHcJdEmt5PdjtGxnQs/hwKljLHwAFW8jjDvtJnFPFL+UvQ6qE8eXxzyPabWjnHRYhvl0/XUygVhV0JsxrsCzkrKGQsqioveTm8uLrDq5jbIs2KiNjCzLsUpoimecmmLePuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcmtxsBB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcmtxsBB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4727C32781;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787049134;
	bh=XE7Jze2pWOY+XLVEZ5GthHvKEoJMO8iLYBrsfeT5fUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kcmtxsBBiEst7E+Mh78eRH4cxVf0bQPPMYZyThjxUW0nSeltxVbnc4+fo2hsAE8l4
	 VW3JUjl8HSOWOdaG6rC6E8WnXABuUnZq57dgD3+HsLx7luEF7UHck477nIgQGbqv1b
	 6j91dqY0IZKYkV8KViC4moGmVAeVSKFc9olgoy3o8O/SYpI9oj7FpvhU+ZbvEfOmBL
	 zrLjO3MxxC4fjmThTvl5JmwHC9aPRVUsd72CVBG3DTJt6DAGDLp9ytH13PhNPZRlo/
	 KLxvvF/7GtUZMIOqwvqtH7Wqf3EkYbHlGqw8kvR6kUWJzhB7JGUVJhrNntcr/KeA6p
	 b2ZE5bz42KFYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB559C5DF7E;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 18 Aug 2026 18:31:20 +0800
Subject: [PATCH v5 06/12] dt-bindings: serial: add Ambarella CV75 UART
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-cv75-v5-v5-6-7bbb12f0360f@ambarella.com>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
In-Reply-To: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>, 
 Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 Long Zhao <zl020895@163.com>, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787049131; l=1828;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=5fvXIv4VkCf1t6ZAmNKnU3A6+aTT4MQ6fcD192SSaH0=;
 b=mUjLxTDt6GYIBD1VZ0ihH3mBXE05YBuVvYwKtwJk/oVtF8hBC5N1AYZD8QCXF8h3B/hzS3JiS
 x6XHFYANljODgynMMLC6EQ5Y8ffoS6SlvUxp4Q01qVPH85Nn14H0XGu
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Document the Ambarella CV75 on-chip UART controller binding for early
console bring-up. The binding requires a single RCT clock input and
fixed 32-bit register access via reg-shift and reg-io-width.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../bindings/serial/ambarella,cv75-uart.yaml       | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ambarella,cv75-uart.yaml b/Documentation/devicetree/bindings/serial/ambarella,cv75-uart.yaml
new file mode 100644
index 000000000000..223c84bf460d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ambarella,cv75-uart.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/ambarella,cv75-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella CV75 UART
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: ambarella,cv75-uart
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
+  reg-shift:
+    const: 2
+
+  reg-io-width:
+    const: 4
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - reg-shift
+  - reg-io-width
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ambarella,cv75-rct.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@e4000000 {
+        compatible = "ambarella,cv75-uart";
+        reg = <0xe4000000 0x1000>;
+        clocks = <&rct CV75_GCLK_UART0>;
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+        reg-shift = <2>;
+        reg-io-width = <4>;
+    };

-- 
2.34.1


