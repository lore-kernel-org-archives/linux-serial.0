Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191229B239;
	Tue, 21 Oct 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040002; cv=pass; b=BXXsYjQRhepHwten9TwabdTtA+Fst8wYKlBr0DFLc4lapyOFXXEQi0U4ohxu21j80TKqwpGG9bOsM3lmgOeVjSkuDkCp257Bi3ZOLeB0lHDn6Sjzjum43NRCxdAphe0WBtTmcWJNDqHEz+UBe8H/6RyuhjFzI/8P6qDgfYbKlA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040002; c=relaxed/simple;
	bh=BPu7PZHsmHBUMlie/QnSS8N1/X8qLG491ihCDKtsmOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WP8WWDRFmy6XqsepazAwoNCxaf+YfDA9mGndUNefamylqAWdj72VRr9nZEDkBBGQNCD6UOoonF41WCdFf0C33W5vyIE0GyT+CtmB0sZklLrO6FyQPMaIvkuDxTcDfjF44wI3xVw0M7eitV32ScPFhTOtZZbVqd3Q/LoRhUgEL5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=nb+f+Ys2; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="nb+f+Ys2"
ARC-Seal: i=1; a=rsa-sha256; t=1761039969; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mbycA+vibwo/H4jDOO1v8bpFE+CYV9DeJuerE8ECgXSuIzZRqRHU/f0RFRNvstDwLUIrPmspycs0iqeqhmGffnq2yNIby5EsbYOIMQt2CVptSh8AlwUu/ZyfrCND4QidEEl8txRLTFpzWSGiBBaQ43MhNFmpJSVoEPEyqmqoFyo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039969; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H+eMBBkV2gpXvNgn8yFU/q7nZdubw5xRnI77G7gXhG4=; 
	b=AB4vJFURP7UhHGLXG3xjdWOCe9Uq94/91yD7QpHm/mrWkkxZlnjy+jWGR2uyarHmPzi9nS8SvEJP2RGeymiOpktkeeVap+t/DSQ4j4oO7nj5mP7VicXMfHU2vSF8lSQ8yN3gN/Brhf+Up7SmpWZ8nzP47qcMHCfMe6F6SS8ggo4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039969;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=H+eMBBkV2gpXvNgn8yFU/q7nZdubw5xRnI77G7gXhG4=;
	b=nb+f+Ys2uIC0fM1SMUWVlNvP47iOeuj14kSQBzpaockLbaV5Oc/kd/VwsmkmfNZq
	culKlyxfi8e7xdDEgpy7oLPgfa//2SQ5vQoTH1hk7WsqcWZJObRSsdbFqFTGmb7JIiu
	jGI9aDCFBEtAnj0GC71QAMxY1YnWnhgiwCcJxx6o=
Received: by mx.zohomail.com with SMTPS id 1761039968011168.45824276802966;
	Tue, 21 Oct 2025 02:46:08 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:47 +0800
Subject: [PATCH v3 12/13] riscv: dts: anlogic: Add Milianke MLKPAI FS01
 board
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-12-5478db4f664a@pigmoral.tech>
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
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=2327;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=BPu7PZHsmHBUMlie/QnSS8N1/X8qLG491ihCDKtsmOU=;
 b=7eR/LC6zMkMuMsDnYtWYrs2FTA9z8RVgINFgQaKWQS6fX4GyNI2yCGvrba/0PAwR2/FhS2PAI
 7lEielyiC88AayBkypc6Aavjw1189HglswXCopzj7+s/I3wqYr9Q1/5
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add support for the Milianke MLKPAI FS01 board based on the Anlogic
DR1V90 SoC. The board features 512MB of onboard memory, USB-C UART, 1GbE
RJ45 Ethernet, USB-A 2.0 port, TF card slot, and 256Mbit Quad-SPI flash.

Currently, the board can boot to a console via UART1, which is connected
to the onboard serial chip and routed to the Type-C interface.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/boot/dts/Makefile                       |  1 +
 arch/riscv/boot/dts/anlogic/Makefile               |  2 ++
 arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts | 28 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 3763d199c70ac659d00948241f4263dec62c548c..f99d38ee1aad255557ed6984f725f15df791690e 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 subdir-y += allwinner
 subdir-y += andes
+subdir-y += anlogic
 subdir-y += canaan
 subdir-y += eswin
 subdir-y += microchip
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
2.51.1

