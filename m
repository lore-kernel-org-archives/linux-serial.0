Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D1309EF4;
	Mon, 22 Sep 2025 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545387; cv=pass; b=JUdPmOtYlqD7umCw2wZwtgoW9moYXJBovXpNapkbwsZX2TVFAOs+stbF++oXWBjiGlYqiHNOKt8WGyMLc6GEAj3IvzaVUzX3iO+AwHAeCkwbtL1TnxggmVPl5z2gdeSeIR8BVwPgyltG2wP0lrAgdabGJbkPAwiRvvdv90CdW6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545387; c=relaxed/simple;
	bh=eej46v3VY93/jaGVN6rjK4WaNsafUbyFHJXdCK5YHsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Piyf9MeaPO69vD9b15W4nXTW8167ZMeg1Y4VZjFmS5VBOlsGytaC426tsIDrbLAQykgEVGJUAeFCHcbGN9MlUrM8GBTCtx3hhPpuVw+mcpLvmnlPvb5rgJrgrU3qnaneqJrrdSJ9+Yg8qxgk3TtZqpFm3tbxgMgItebv4xZXYhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=b4tmmYCz; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="b4tmmYCz"
ARC-Seal: i=1; a=rsa-sha256; t=1758545363; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gBfKp/CNK725rwZIX+IL8xPk9oE0Z/uR43yulufoYEAZUSDgSUNJMYnrn4pmRnz+E49KA//csbWEao+JJ4NHQxjDFoEekyJdvIbIACqVCNftumqTH96hSbEcppwBUY5PYVhdViddTttLCL72pxGcr1x7C6ET1lBh1bbpQt1N5SA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758545363; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IUHDgCRXW0IqDg0DNbopl6mwgcRTun+qATQ3IyBlDak=; 
	b=IiMI8pUUqGRr/WcgsO94/fsTBwe4/5S3FWKpQJVmUsU+qTT7JVYdQiz2X410ySLnLifl7E92+Gd7lv65RmEmmOOf9UgFSwn+jpjvd1m5mYExkYep9SApe70Sh6OyP1TN4iyWiU2EPAYr3IBK0hhf9/1DOYfIhTKOd0tWr0JzpQ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758545363;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=IUHDgCRXW0IqDg0DNbopl6mwgcRTun+qATQ3IyBlDak=;
	b=b4tmmYCz6NawXiuk4kc8aR5ESqc79PthCk09ov/GRbl+C/bu0XfiHvnQDCjaI8Jk
	TirnZ5dSjL5YuJuX3e/PviYKRXer4V8AU7HX/mbpIyiQxTDt3elqGMXdyf7xOpO0y5B
	TNpyHJJM5uc0xBCIvqjYRi2bDtWISNx62glwQF3U=
Received: by mx.zohomail.com with SMTPS id 1758545360378219.78509476798922;
	Mon, 22 Sep 2025 05:49:20 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:33 +0800
Subject: [PATCH v2 03/11] dt-bindings: riscv: Add Anlogic DR1V90
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-3-64d28500cb37@pigmoral.tech>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
In-Reply-To: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=1464;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=eej46v3VY93/jaGVN6rjK4WaNsafUbyFHJXdCK5YHsk=;
 b=H59QMB9055wZSaLsKmAcClP/c1LYRAX5b/c+0yNMndSdnE1lmzzdZQ1ciR/mv7BT8FGwCcXql
 39iJymsVtXgAcFfumYPtvUcxYBy9f33JUXbFvJD4GchPJ9ZCLIEkxoO
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add Anlogic DR1V90 FPSoC, featuring a UX900 RISC-V core as the
processing system (PS) and 94,464 LUTs programmable logic (PL). It is
used by the Milianke MLKPAI-FS01 board, a SBC equipped with 512MB DDR3
memory, USB-C UART, 1GbE RJ45 Ethernet, USB-A 2.0 port, TF card slot,
and 256Mbit Quad-SPI flash.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 .../devicetree/bindings/riscv/anlogic.yaml         | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/anlogic.yaml b/Documentation/devicetree/bindings/riscv/anlogic.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..91b1526c99aa3ca9cc7b0e7978861408bd017049
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/anlogic.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/anlogic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anlogic SoC-based boards
+
+maintainers:
+  - Junhui Liu <junhui.liu@pigmoral.tech>
+
+description:
+  Anlogic SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - milianke,mlkpai-fs01
+          - const: anlogic,dr1v90
+
+additionalProperties: true
+
+...

-- 
2.51.0

