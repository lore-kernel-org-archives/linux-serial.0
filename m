Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7C3064A0;
	Mon, 22 Sep 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545903; cv=pass; b=iPrmCVTqmP9r8n+3kqv5HZWQiX/e74jA/BkjGtUTPbf+LeKSu8c+Sl3PF6mBQ2Q2D45W9iD4XiJePb6TSsMt1qfdZwM9BsloozkKLoI5QH4bJE4h7K3A2uOiKC+5RPcx7q7VgpsV5gYrkPHbR9PIFDy7Qg86259137CJ0qaohXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545903; c=relaxed/simple;
	bh=iW7gXkGoJcl/OvIbTNWmuRZXm9pKofJihKVTmrAtFdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWwGr/rpnctZTq4SojFAImfow/2zhLvkIuTRi4hSgPriDs/ilYxU4lfnUDbAU6OZ9txu7HAfrnmfB+4GualbguExickAUGVCsB6cR6GUHMOcbO7QLAm07ZsQl8NFPDScHOgXoH4nElW9HEfvCV98xLi280AbKT4JXFBMmm65i78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=JDeqkanU; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="JDeqkanU"
ARC-Seal: i=1; a=rsa-sha256; t=1758545886; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hkSicmpPn8wpP31BKg6BQoBH/8O3IsuJTQNcA4Qgn6Zfbzl8u0XMg7x6sBdUN6WeMiDp9E+kfXa3LKb3AD98PaBhY5c769CkVWIaxXtVcpkFPwfg+od7SfLJ1BQNe/qciGvL86V/gVpyUznSXk+El4BJR2EsVvPLM74EEueIOqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758545886; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bycg5YSlkEOZb4YDt5Lmv0P1vYUNnjMlJvJjJ1sWGas=; 
	b=b82SSqj+1gyUV0gjPs7PGmH+hc1lB9hlRoVo6mmMBHN+lH8V0yNK4CVnPUOgT4m0cd10lEUFH4aD0E5Dd6jFTOXB4tWJUqAgWiVxc+3fMQi5cOz8IOmM1f3HZc+rXvE1BHrA3TRqPAYhMexAVrPmY+P9rTvMHUQlNsYk7l9728k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758545886;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=bycg5YSlkEOZb4YDt5Lmv0P1vYUNnjMlJvJjJ1sWGas=;
	b=JDeqkanU/ov9Jjeaq6AGK0BJQS3VRno8l9NkaeYRBfERwGhCUoCvzrsPy2OJRHzD
	sK7pWC0LF0lz8W+HfKx8GDgykD2RKzVpyST0X6hNzXSsHpkuOgfUgx7p8QqnK0ruC0+
	Ktq9r7d9OyhVbl/kVXvcyN5GY3L2WhMQ+DtwoUgY=
Received: by mx.zohomail.com with SMTPS id 175854588402588.30475663924358;
	Mon, 22 Sep 2025 05:58:04 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:39 +0800
Subject: [PATCH v2 09/11] riscv: dts: anlogic: Add Milianke MLKPAI FS01
 board
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-9-64d28500cb37@pigmoral.tech>
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
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=2276;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=iW7gXkGoJcl/OvIbTNWmuRZXm9pKofJihKVTmrAtFdQ=;
 b=A5+/kHTZhv9j319kbukR/hgf2th5VTbFImVsjF40NXnyUMTp7mX+sPKKEmt0fB7Z+w6ATvSe5
 PUqbwr2sm3YDEpmNimwO/XGBx79kN6nnVfSzxFoagWZH7BYKsJz2pCH
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add support for the Milianke MLKPAI FS01 board based on the Anlogic
DR1V90 SoC. The board features 512MB of onboard memory, USB-C UART, 1GbE
RJ45 Ethernet, USB-A 2.0 port, TF card slot, and 256Mbit Quad-SPI flash.

Currently, the board can boot to a console via UART1, which is connected
to the onboard serial chip and routed to the Type-C interface.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/boot/dts/Makefile                       |  1 +
 arch/riscv/boot/dts/anlogic/Makefile               |  2 ++
 arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts | 28 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 3b99e91efa25be2d6ca5bc173342c24a72f87187..3c0005ee037406ac3285ec4662102c68592387a3 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 subdir-y += allwinner
 subdir-y += andes
+subdir-y += anlogic
 subdir-y += canaan
 subdir-y += microchip
 subdir-y += renesas
diff --git a/arch/riscv/boot/dts/anlogic/Makefile b/arch/riscv/boot/dts/anlogic/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..87f3b2f418cfa32012df5ae82d17262a9610f90c
--- /dev/null
+++ b/arch/riscv/boot/dts/anlogic/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ANLOGIC) += dr1v90-mlkpai-fs01.dtb
diff --git a/arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts b/arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts
new file mode 100644
index 0000000000000000000000000000000000000000..597407655efd2e74608dabb4559ab1239662cf41
--- /dev/null
+++ b/arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include "dr1v90.dtsi"
+
+/ {
+	model = "Milianke MLKPAI-FS01";
+	compatible = "milianke,mlkpai-fs01", "anlogic,dr1v90";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x20000000>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};

-- 
2.51.0

