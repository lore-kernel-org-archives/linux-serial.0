Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9FA2EBDDC;
	Tue, 21 Oct 2025 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039918; cv=pass; b=UNXaow1Ygl6mkHYSUH1G4n8JrT2gvhh3RfblhtqRyLKLrXGQkc0AQzT96EN7xw5biAqX9x2gXaMBiWe0BPsiSvJ4IJ+fYvHKoFAjpqUGAhgT9NKw8MgvA1+PdhbzyzR0LbuGJ/FTgpymO2wPUK9FbSnc6Q4P545Xg0M7LkD8Rks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039918; c=relaxed/simple;
	bh=kMjp/kMNwAzs4+SvkT7OReYTebC9hxzfdjMFblWEIw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Akda9f4gatOCXGNQZ8N24dyTVNTa6Uc7h5zWWJN7G0TEN8eWr23UzOpPoPP+OCoMARquajZFUOuJ8IxxPM0JmA09z7PkBTO5bHQ6Qf8x0YfRvM5HoeR7Fq197umFDLjkjGxl1qqMYgU6Q3MtWx69arpcBqUulczIx6Ni+Cz7pTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=aw1KgOYv; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="aw1KgOYv"
ARC-Seal: i=1; a=rsa-sha256; t=1761039888; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WwdNE0A1RP2GNDOoiFxcsLVwdk8CoXbfkPoACP2eI/j8LEHHkNVe/73phFb7tTzdTHU1zNxhtY0JWT0b7Ac0LtwyvrieKmB4D49M2Rk8BSxgVss3hjv6h6Fg5JOF2sY2NnIROlqNNTX516ih/mpFLGTsqXqSYo6IIRTjVa7ViEo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039888; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rtsskF6c5DC86jEekt9nZlFyfhaYJsIni6zqONkPHYY=; 
	b=OZM89R0uBREEjEcyUJthr4nszqg/uANypoBjNmvDYlM3W6IYASPfWy9MgN/DH1/XFxp55ePvw8SBDLEss5HThgOqE4SMf8wxylGRgjEN40AspLpOUaenCLpQdVs0RQp2Nj+wW4u6CDsJoVeFAWQV/0zCCEQI4LyfUcLwLuNjW3c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039888;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=rtsskF6c5DC86jEekt9nZlFyfhaYJsIni6zqONkPHYY=;
	b=aw1KgOYv/r7kXcjZUvKCj20Dhva7nyRepmiCk1pxgHqRuzNglr6SyqyIVUX09N1I
	cQLXjGUVjLZ7tgQ1k41HaQ4lqj2ZzQAupXg1sBvyIvtrb101JuwM5lYHGFMjNPZ4srg
	CcpGRYt/d2XGW57VULAnLoJbev40Wj6vcnf6PjeM=
Received: by mx.zohomail.com with SMTPS id 1761039886235640.5853675555333;
	Tue, 21 Oct 2025 02:44:46 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:38 +0800
Subject: [PATCH v3 03/13] dt-bindings: riscv: Add Anlogic DR1V90
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-3-5478db4f664a@pigmoral.tech>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
In-Reply-To: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, Inochi Amaoto <inochiama@outlook.com>, 
 sophgo@lists.linux.dev, linux-serial@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=1464;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=kMjp/kMNwAzs4+SvkT7OReYTebC9hxzfdjMFblWEIw4=;
 b=bYRbzYnEHFe6MhjyoY/eNClq/fC+GEaiJd/B4YhB4CqHk+v2/Aft/8UUtqtA0lsN4xlCfT9jb
 Z+VRO1KgjDeCWWUdk3M03On13pX7k8U6TKKAloiz7xaLZe4HF59kuS6
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
2.51.1

