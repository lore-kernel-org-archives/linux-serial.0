Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3443F4125;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008866; cv=none; b=Jrxghi3gKNVLwMilknCzGVQchOAhXxdYfbmUaCT+ElN05W4qO/e1SdLM2dasEbE5mJ3sjKyxbJDgZja27gxwH4Fdl2iAglnwvZB6jzBq3pIR9B6GeCZ96K2kqIkHP84gH8Q6SVh99dbNEZqGKSEqq4UB7zI/ZDRG0GM83A/RY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008866; c=relaxed/simple;
	bh=cYPUiIG3WZWc0vigCV8eiQKRpmmNx1zWV9ouQXuS/WA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3YqfnOPwakaQHVEbAMQorAuLiVhHE6DdVyfIGoQrkCLGtqTd1Q0YY/bhZZyDNNjOegYOmgFvbLlLKrDco/0FWWIvLwlu/tFJCaeGkps3upwTXAgtPSTjus9PAAe3HlBk7bi+4YdIVqiR5XYQrQnN9t3YTQxbhak/9q6WaFjXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDenrtRN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDenrtRN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63AE3C2BCFA;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786008866;
	bh=cYPUiIG3WZWc0vigCV8eiQKRpmmNx1zWV9ouQXuS/WA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hDenrtRNO4HIiFS1TA7HWICQN8rL+9XKi6FrcZMPjS+T+aW1SMINJNUYMWl+bLkDQ
	 nnb8/6ebOAXkMDZoFM4EGBy+l27I9OJ+3jpyEmzCBxUlb4Nrpgc2tzALtKWXK1YR7U
	 QTt/ru7NdZWm/hVv3FuAapYkQuw1UH5gvL5cFzo64ZWRGFVkCaOsNT03Hy4haKJSGL
	 RBHHW2cWSHelzEZkSYnXm5Cb4QvAB5hvtBoOdAV7dDit7kmoOsvnz8pnRJ1dp38aSO
	 SsoGYeUU3CW1dsprzk1OvcE4QIhjf2OXxykrmZ29mXF0pdzW5Ddy7wh9m/u5JnVjKx
	 6PuTr5kq4Gt1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44722C5620A;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 06 Aug 2026 17:34:11 +0800
Subject: [PATCH v2 03/10] dt-bindings: clock: add Ambarella CV75 RCT clock
 controller
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-longzhao-upstream-cv75-v2-v2-3-6b09707c5fe9@ambarella.com>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 soc@lists.linux.dev, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786008863; l=2901;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=DFTGZ4uvV0RkAC0IaZusCfnS/KQPHA8JTNal3McD4Z4=;
 b=Ah0cJCSIxUfLesXH+5wJqawUNYqeT3CHVWMhVZ3L9xjHidofApA7nryJBlzdK0oeAKN8oDxl6
 4jX8eBz5WTTAlazq5AfOS+U4V6k8iQeARuAXWgCN2XNKZ8drYBFZ7qA
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add the CV75 RCT clock controller binding and clock ID header.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../bindings/clock/ambarella,cv75-rct.yaml         | 66 ++++++++++++++++++++++
 include/dt-bindings/clock/ambarella,cv75-clock.h   | 17 ++++++
 2 files changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml b/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
new file mode 100644
index 000000000000..aa96533bab9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ambarella,cv75-rct.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella CV75 RCT Clock Controller
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+description: |
+  The RCT (Reset and Clock Tree) block on the Ambarella CV75 SoC provides
+  PLLs, clock muxes and dividers for on-chip peripherals.
+
+  The same register region is also exposed as a syscon for other SoC
+  blocks (e.g. pin drive-strength), hence the "syscon" compatible.
+
+  Clock indices are defined in
+  include/dt-bindings/clock/ambarella,cv75-clock.h:
+
+  - CV75_GCLK_UART0: UART0 mux/div clock
+  - CV75_GCLK_CORE: Core PLL (gclk_core)
+  - CV75_GCLK_AHB: AHB bus clock (core / 2)
+  - CV75_GCLK_APB: APB bus clock (core / 4)
+
+properties:
+  $nodename:
+    pattern: "^clock-controller@"
+
+  compatible:
+    items:
+      - const: ambarella,cv75-rct
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: Reference crystal oscillator (typically 24 MHz)
+    maxItems: 1
+
+  clock-names:
+    const: osc
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@ed080000 {
+        compatible = "ambarella,cv75-rct", "syscon";
+        reg = <0xed080000 0x1000>;
+        clocks = <&osc>;
+        clock-names = "osc";
+        #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/ambarella,cv75-clock.h b/include/dt-bindings/clock/ambarella,cv75-clock.h
new file mode 100644
index 000000000000..3d3314446e75
--- /dev/null
+++ b/include/dt-bindings/clock/ambarella,cv75-clock.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (C) 2026 Ambarella, Inc.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMBARELLA_CV75_CLOCK_H
+#define _DT_BINDINGS_CLOCK_AMBARELLA_CV75_CLOCK_H
+
+/* Boot / bus clocks */
+#define CV75_GCLK_UART0		0
+#define CV75_GCLK_CORE		1
+#define CV75_GCLK_AHB		2
+#define CV75_GCLK_APB		3
+
+#define CV75_CLK_NUM		4
+
+#endif

-- 
2.34.1


