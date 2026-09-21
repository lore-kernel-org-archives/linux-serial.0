Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249FC349CF0;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964612; cv=none; b=NQwPXE79lGD1126bT4MsLGGbVHqSAqtQJU7KfNZXfn83ngqiqiwCvtaTbUX345qLPGE2Quj2xdY0Itye6MI4A5EfSRaU5sae7epFWi8YlAD9Wyn8nGVL5o8ptLAOuc0rMnqi+L33sktW6OeIRYblDdLIBQhe12yAPRJ7FosV/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964612; c=relaxed/simple;
	bh=/EqyzhFKjVT1Spu2ADyKiMSyXx4yZn96DdPYCnXHJf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHJmFg05sDzFdym98+mH/szQOgc7IBupzfheyCLUKwEGUl+dAAGmzDSufIxxGYwfHjaXDUxRUq3UQ2WdBREG52fyWZ9Ak7RcYn1CjHnc2+wyG7WZIo0VVjkF/jF6aBMs/g2MPbaEGr2P+927zd3LY4fA5uRmlZlW++hod1oR6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDcQGHZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDcQGHZa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B22FFC2BCFA;
	Mon, 21 Sep 2026 04:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789964611;
	bh=/EqyzhFKjVT1Spu2ADyKiMSyXx4yZn96DdPYCnXHJf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cDcQGHZaWO/kbpRvK/YPi0kUc2Z1tA0GpJTlLbRuZmXYhGIC7dKrO2fgVLNww/Spd
	 r52VnBvTAe2nPGPhaEie9Zs7Ob84hjV/RQqUzR9YM/kM4IWJjX83iJHqgcX/EMCiJi
	 e7Lt+XFuGoF77mK/isUsg2JeXqPE+T5sgNRMsc/nc9iLD2e789Sw/Be22VGgtilkHC
	 rProapQbCQQZnJ+Me+z2i/3CQSZT+gReeE4BluLmLr9FjJ6ijub9gfmMpDWzGsi4mB
	 4JJEecx8iTpSdgnVaZr0LpBl8zGDc43h1RuYOIZ0lP1gH/DiNR0LcGbQsi+6h+n/W4
	 xiZhL2Z25P6XA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A63BC982F1;
	Mon, 21 Sep 2026 04:23:31 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 21 Sep 2026 12:23:20 +0800
Subject: [PATCH v8 01/18] dt-bindings: arm: add Ambarella CV75 platforms
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-cv75-v5-v8-1-282ff5d98dda@ambarella.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789964608; l=1876;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=a3UsADFSuMY/QlkptOgZJzk4a6/aFRhf9dYNkAufvC4=;
 b=tdS3O/vAb/JGuglKe/bQoaZsCa/BpNt1njxdIRQtN1ZyVZPrSBqoBqKDX8Ilr9mKyyxo7a1iB
 P6qsn4+mfU3Dda0EhQELXRXv0glfv6jTiNX58GhlJtXFkf/t/SdVjbp
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add the Ambarella vendor prefix and CV75 EVK board compatible for the
initial SoC bring-up.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../devicetree/bindings/arm/ambarella.yaml         | 24 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ambarella.yaml b/Documentation/devicetree/bindings/arm/ambarella.yaml
new file mode 100644
index 000000000000..72946e94fa76
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ambarella.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ambarella.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella SoC platforms
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+properties:
+  $nodename:
+    const: "/"
+
+  compatible:
+    oneOf:
+      - description: Ambarella CV75 boards
+        items:
+          - enum:
+              - ambarella,cv75-evk
+          - const: ambarella,cv75
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 85a27937832e..f48aa6dabbe9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -112,6 +112,8 @@ patternProperties:
     description: Amarula Solutions
   "^amazon,.*":
     description: Amazon.com, Inc.
+  "^ambarella,.*":
+    description: Ambarella, Inc.
   "^amcc,.*":
     description: Applied Micro Circuits Corporation (APM, formally AMCC)
   "^amd,.*":

-- 
2.34.1


