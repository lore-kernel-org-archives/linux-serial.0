Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0443F4108;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008866; cv=none; b=lkSaAKB1IjIAWGz4nHIldtcw7L0hTJcc6GSSlkFz34aEsmHJViCQ9Wa5bBHJtTugn2uCIwBjHhvfodxJXLssihSAO2Tm5BWhs+d5RltsdpW32usquMgQMU/F0jfEg2ANEQo8TXVkfe8Itro+sgAD39IPYi81okqDhAtpS6LunLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008866; c=relaxed/simple;
	bh=xksXNR3RIxdAAWa4ZhBc1ec5Me5J0Ftc6OOeqFa8oRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtXfHYFScxZFxa+DDiw/pT8k58F2KgnTP6+PSq9KDGk3n2bISeWys2acJn70WvDnlBm9pNsjhejZLczNTZKC84SqQm0SbqlobZBWKV7NqVZbigPyTqjVEJfK/sFu5eUE8EnMmwgthiZMBo/wsn4WvmwUSPK6Wj+bPzLyI+QBKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+t+ygdU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+t+ygdU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 506F1C2BCF7;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786008866;
	bh=xksXNR3RIxdAAWa4ZhBc1ec5Me5J0Ftc6OOeqFa8oRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r+t+ygdUF8iAuJnJfsPUYCXVRoWcg8xWExj72eAjkTdVqixYikWlnvx3aQx6hkGeN
	 Z3gSL3+r7X8+MTZEm4vPxjL/tBa388Vw1D7PgUM+RHJMtaWx1QjcFyPbihV2ePTeub
	 hxyRdn3kj4WBlm0mSpnmtM9QnxXpYwY5GMQ84sV2aHHP0jlbGlr7xHDeiVEQ22wzdU
	 ZwTWF+EaftOF6m56yQfOd/TN42wyiLTzTxK/fo2vN2O8tdO3UEjnsjx7gPd4lr9jIL
	 4bFckpT7+IARfxqhVf0wDdIU0QVCVrPtaVKDEwE/TAI4w/3co+HnzYKHMJRz0NlGmi
	 m77BIKwbYMMoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA4C56208;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 06 Aug 2026 17:34:10 +0800
Subject: [PATCH v2 02/10] dt-bindings: soc: add Ambarella secure scratchpad
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-longzhao-upstream-cv75-v2-v2-2-6b09707c5fe9@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786008863; l=1545;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=1vmye3CK0HpbkUmTNeoU7Oscgo8VwkmeZd901TWonnk=;
 b=f3oS0meErI2j00TKtSZ8nQ8sMS+wTYXOy+doYgvXLIsQdTWSBNPan7rytIrwLIoZznhElBAee
 KuyY6KX+IeZBHkpzWLPBo4zGKFpEpuqUX2LsFzPBeafjNNlDGKeEVi7
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Document the Ambarella secure scratchpad syscon used by CV75.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../ambarella/ambarella,cv75-sec-scratchpad.yaml   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ambarella/ambarella,cv75-sec-scratchpad.yaml b/Documentation/devicetree/bindings/soc/ambarella/ambarella,cv75-sec-scratchpad.yaml
new file mode 100644
index 000000000000..4bfeca0ac3da
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ambarella/ambarella,cv75-sec-scratchpad.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ambarella/ambarella,cv75-sec-scratchpad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella CV75 Secure Scratchpad Registers
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+description:
+  The secure scratchpad block contains shared system registers used by
+  other Ambarella SoC blocks through syscon regmap lookups.
+
+allOf:
+  - $ref: /schemas/mfd/syscon-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: ambarella,cv75-sec-scratchpad
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    scratchpad@e002e000 {
+        compatible = "ambarella,cv75-sec-scratchpad", "syscon";
+        reg = <0xe002e000 0x1000>;
+    };

-- 
2.34.1


