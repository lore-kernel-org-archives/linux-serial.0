Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F741F7F2;
	Thu,  6 Aug 2026 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008867; cv=none; b=Nnsmend+5fn1AsPgEq2jPLMo5wX+DXs3yFVXDQaepNMALtthYk+1oNU4jgrZtH0V4D0mGBdzdAF1PnAMrsZU1b2G9QQnxWKs9Sc3cIRUkQUiyNLEyHjIRsl8IMs2qbp1V7C3DWr6XyItHoxlBq0XOi+yrV7jW/h/YgC0Da/4bDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008867; c=relaxed/simple;
	bh=xUgMhJisYvLuqDZcdPp4HG6wSEX/KHSUvHPVx8bBVro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBrLmYWaE9qGHy6TRJ+OxS8Q+zzHyPcT8zVrq2jYLF7A6EiU/jMSEH7FgqkWKVoKoSYEHuGwkdqXBCBV/Ah7yuqQrKeFiaA0TrzB3oO6qtGMV3taKcC6p1EezehvuiXxysfDa4tTgsdhYfhuQ92DyTTYXhV8OgZDqrdv38Rr9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIIDQ00j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIIDQ00j"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88BE3C2BCFF;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786008866;
	bh=xUgMhJisYvLuqDZcdPp4HG6wSEX/KHSUvHPVx8bBVro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mIIDQ00j1xrM959FClKDZK5VJnm8wwPwNCrONSyIdy7SeLn7N+cY4rmiEQaYx3MqG
	 ecVHbeUJhniU6XDfuH+9REe6U/nwfQ2EpCEfy6Vq25HL/P2ZfEedKyoDf8gCsyj7LH
	 BFSXFHfCdAJFaLlF0KSGz7Dvr7fjx47h/1eRBu+TjxyIzc+IhIhMkg4CGPppqbWlA4
	 I0CjM45+gDasdmGfoHkv9KrF5d7OncEaFTB/8fFM/QCqtC+F6bDHfBg8wyKkbd3/4V
	 khbQDLrevVGF3EfcAMQ+qbDWqkBKA3dXj1anqrjKFnhE+tj/pTTbRqOjhROsJR+ryK
	 BYNDY9x/vM7BQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72765C55838;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 06 Aug 2026 17:34:13 +0800
Subject: [PATCH v2 05/10] dt-bindings: serial: add Ambarella UART
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-longzhao-upstream-cv75-v2-v2-5-6b09707c5fe9@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786008863; l=1437;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=3IBRZ3r8aIVqSKUt911TKSBxsBmqjCi8qDWSpR60+wA=;
 b=M6+0z8dDfmpElcLgzbEbUfUoySjemhkkbs6T71oYsaDIRGkmIvWuGiAI40PfLWa3hP6Qi0wI0
 0li8Y/TnBYSCa1X2yPoCMk2J9YWaf1jHSF9yoqV/fpNFTwIayiYcOkg
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Document the Ambarella UART controller.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../bindings/serial/ambarella,cv75-uart.yaml       | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ambarella,cv75-uart.yaml b/Documentation/devicetree/bindings/serial/ambarella,cv75-uart.yaml
new file mode 100644
index 000000000000..86d6d8a61ace
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ambarella,cv75-uart.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
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
+    serial@e4000000 {
+        compatible = "ambarella,cv75-uart";
+        reg = <0xe4000000 0x1000>;
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&uart_clk>;
+    };

-- 
2.34.1


